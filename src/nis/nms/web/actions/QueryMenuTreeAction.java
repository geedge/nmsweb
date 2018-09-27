package nis.nms.web.actions;

import java.io.Reader;
import java.io.StringReader;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.jdom.Document;
import org.jdom.Element;
import org.jdom.input.SAXBuilder;

import nis.nms.domains.XtYhJbxx;
import nis.nms.service.CommonService;
import nis.nms.util.Common;
import nis.nms.util.Constant;

/**
 * 
 * 
 */
public class QueryMenuTreeAction {

	private static final long serialVersionUID = 1L;

	private List<XtYhJbxx> userInfoList = null;
	@SuppressWarnings("unchecked")
	private CommonService commonService;
	/** 拼接的xml字符串 */
	private StringBuffer xmlStr;

	/**
	 * 从数据库中查询出菜单拼接成xml字符串并存放到Session中
	 * @param menuIds某权限下的菜单Id的集合
	 * @return xmlStr 拼接成的字符串
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> queryMenuTree(String yhmc,String yhbh) {
		// 查询用户下的所以功能节点 
		List<Map<String, Object>> userfunctionList = null;
		try {
			StringBuffer hql = new StringBuffer();
			if (yhmc != null
					&& "admin".equals(yhmc.trim())) {
				hql
						.append("select n.Id,n.ZXBZ,n.PID,n.HANDLER,n.MKURL,"
								+ "n.MKMC,n.MKTYPE from xt_mk_jbxx n where ZXBZ=0");
				
			} else {
				if (yhbh != null) {  
					if(Constant.F_BUTTON_AUTHER){
						hql
						.append("select n.id,n.ZXBZ,n.PID,n.HANDLER,n.MKURL,"
								+ "n.MKMC,n.MKTYPE from xt_mk_jbxx n where ZXBZ=0  and  n.id in (select r.MKBH from xt_js_mk_index r"
								+ " where r.JSBH in (select ro.JSBH from xt_yh_js_index ro where ro.TYPE is null  and  ro.YHBH = '"
								+ yhbh
								+ "') and r.JSBH in(select js.JSBH from XT_JS_JBXX js where js.ZXBZ = 0)) or n.MKTYPE=4");
					}else{
						hql
						.append("select n.id,n.ZXBZ,n.PID,n.HANDLER,n.MKURL,"
								+ "n.MKMC,n.MKTYPE from xt_mk_jbxx n where   ZXBZ=0 and  n.id in (select r.MKBH from xt_js_mk_index r"
								+ " where r.JSBH in (select ro.JSBH from xt_yh_js_index ro where ro.TYPE is null  and  ro.YHBH = '"
								+ yhbh
								+ "') and r.JSBH in(select js.JSBH from XT_JS_JBXX js where js.ZXBZ = 0)) ");
					}
				}
			}
			hql.append( " order  by n.showlevel,n.showorder");
			userfunctionList = this.commonService.findByJdbcStrUp(hql.toString());				
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return userfunctionList;
	}
	/**
	 * 从数据库中查询出菜单拼接成xml字符串并存放到Session中
	 * @param menuIds某权限下的菜单Id的集合
	 * @return xmlStr 拼接成的字符串
	 */
	@SuppressWarnings("unchecked")
	public String makeMenuTree(List<Map<String, Object>> userfunctionList) {
		// 如果没有可用的菜单返回
		if (userfunctionList == null || userfunctionList.size() <= 0) {
			return null;
		}
		try {
			xmlStr = new StringBuffer();
			// 添加文件头
			xmlStr.append("<?xml version='1.0' encoding='UTF-8'?>");			
			// 如果没有可用的菜单返回
			if (userfunctionList == null || userfunctionList.size() <= 0) {
				return null;
			}
			// 添加root节点
			xmlStr.append("<" + Constant.XML_FILE_ROOT + ">");
			// 找到顶层菜单的集合，递归的入口
			List<Map<String, Object>> topMenuInfoList = new ArrayList<Map<String, Object>>();
			Map<String, Object> obj;
			for (int i = 0; i < userfunctionList.size(); i++) {
				//obj = new HashMap();
				obj = userfunctionList.get(i);
				String href = "";
				if (obj.get("MKURL") != null && !"".equals(obj.get("MKURL"))) {
					// 将数据库中查找到的所有菜单的链接格式化为XML格式字符串（main.jsp页面以XML格式读取菜单）
					href = Common.converseToXMLStr(obj.get("MKURL").toString());
					obj.put("MKURL",href);
				}
				if (obj.get("PID")!=null && !"".equals(obj.get("PID")) && 0 == Integer.parseInt(obj.get("PID").toString())) {
					topMenuInfoList.add(obj);
					userfunctionList.remove(i);
					i = -1;
				}
			}
			// 递归得到树形菜单
			for (int j = 0; j < topMenuInfoList.size(); j++) {
				obj = topMenuInfoList.get(j);
				getXmlByParentAndChild(obj, userfunctionList);
			}
			xmlStr.append("</" + Constant.XML_FILE_ROOT + ">");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return xmlStr.toString();
	}
	/**
	 * @description 递归父菜单及其相应子菜单返回一个Xml字符串
	 * @param parentMenu
	 *            Map<String, Object>类型的父菜单
	 * @param otherMenus
	 *            其余菜单集合
	 * 
	 * @return xmlStr 父菜单和相应子菜单拼接的xml字符串
	 */
	public void getXmlByParentAndChild(Map<String, Object> parentMenu,
			List<Map<String, Object>> otherMenus) {
		if(!"1".equals(parentMenu.get("MKTYPE"))){
			String parentMenuXml = getMenuXml(parentMenu);
			// 添加xml的子节点Constants.XML_FILE_NODE=resource
			xmlStr.append("<" + Constant.XML_FILE_NODE + parentMenuXml);
			List<Map<String, Object>> currentMenuChild = getChildMenusByParentMenu(
					parentMenu, otherMenus);
			if (currentMenuChild.size() > 0) {
				xmlStr.append(">");
				for (int i = 0; i < currentMenuChild.size(); i++) {
					Map<String, Object> menu = currentMenuChild.get(i);
					getXmlByParentAndChild(menu, otherMenus);
				}
				xmlStr.append("</" + Constant.XML_FILE_NODE + ">");
			} else {
				xmlStr.append("/>");
			}
		}
	}

	/**
	 * @description 根据父菜单找到其下的子菜单
	 * @param parentMenu
	 *            FunctionMenus类型的父菜单
	 * @param otherMenus
	 *            剩余的其他菜单集合
	 * 
	 * @return childMenuList 返回该父菜单的子菜单集合
	 */
	public List<Map<String, Object>> getChildMenusByParentMenu(
			Map<String, Object> parentMenu, List<Map<String, Object>> otherMenus) {
		List<Map<String, Object>> childMenuList = new ArrayList<Map<String, Object>>();
		int childNums = otherMenus.size();
		if (childNums > 0) {
			for (int i = 0; i < otherMenus.size(); i++) {
				Map<String, Object> childMenu = otherMenus.get(i);
				if(childMenu!=null){
					if(parentMenu.get("ID")!=null &&!"".equals(parentMenu.get("ID")) && childMenu.get("PID")!=null && !"".equals(childMenu.get("PID")) ){
						String parentMenuId = parentMenu.get("ID").toString();
						String childPId = childMenu.get("PID").toString();
						if (parentMenuId.equals(childPId)) {
							childMenuList.add(childMenu);
							otherMenus.remove(i);
							i = -1;
						}
					}
				}
			}
		}
		return childMenuList;
	}

	/**
	 * 将菜单信息拼接成一个字符串
	 */
	public String getMenuXml(Map<String, Object> menu) {
		StringBuffer menuXmlStr = new StringBuffer();
		// 添加资源标识rsid
		if (menu.get("ID") != null && !"".equals(menu.get("ID"))) {
			menuXmlStr.append(" " + Constant.XML_FILE_NODE_RSID + "='"
					+menu.get("ID").toString() + "'");
		}
		// 添加菜单名称rsname
		if (menu.get("MKMC") != null && !"".equals(menu.get("MKMC"))) {
			menuXmlStr.append(" " + Constant.XML_FILE_NODE_RSNAME + "='"
					+ menu.get("MKMC").toString() + "'");
		}
		// 添加链接rsaddress
		if (menu.get("MKURL") != null && !"".equals(menu.get("MKURL"))) {
			/*menuXmlStr.append(" " + Constant.XML_FILE_NODE_RSADDRESS + "='"
					+ menu.get("MKURL") + "'");*/
			/*menuXmlStr.append(" " + Constant.XML_FILE_NODE_RSADDRESS + "='"
					+ Common.converseToNomal(menu.get("MKURL").toString()) + "'");*/
			menuXmlStr.append(" " + Constant.XML_FILE_NODE_RSADDRESS + "='"
					+ Common.converseToXMLStr(menu.get("MKURL").toString()) + "'");
		}
		return menuXmlStr.toString();
	}
	
	
	public String getMenuHtml(String xmlStr){
		StringBuilder sb = new StringBuilder();
		SAXBuilder builder = new SAXBuilder();
		Element resources = null;
		try {
			// 将xml字符串序列化,生成一个树型枚举对象
			Reader read = new StringReader(xmlStr);
			Document read_doc = builder.build(read);
			resources = read_doc.getRootElement();
			List<Element> children = resources.getChildren(Constant.XML_FILE_NODE);
			
			
			/*<ul>
			<li class="nav-item">
				<a href="javascript:;"><span>System Configuration</span><i class="my-icon nav-more"></i></a>
				<ul>
					<li><a href="javascript:;" data-url='/nmsweb/detection/monitorData.do?action=query'><span>网站设置</span></a></li>
					<li><a href='/nmsweb/sysManage/sysErrorManage!execute.do?action=queryError' target='I3'><span>友情链接</span></a></li>
					<li><a href='/nmsweb/detection/monitorData.do?action=query' target='I3'><span>分类管理</span></a></li>
					<li><a href="javascript:;"><span>系统日志</span></a></li>
				</ul>
			</li>
		</ul>*/
			sb.append("<ul>");
			for(Element ele : children){
				sb.append("<li class='nav-item'>");
				List<Element> list = ele.getChildren();
				if(list != null && list.size()>0){
					sb.append("<a href='javascript:;'><span class='memuNameSpan' title='"+ele.getAttributeValue(Constant.XML_FILE_NODE_RSNAME)+"'>");
					sb.append(ele.getAttributeValue(Constant.XML_FILE_NODE_RSNAME));
					sb.append("</span><i class='my-icon nav-more'></i></a>");
					sb.append("<ul>");
					for(Element e : list){
						sb.append("<li><a href='");
						sb.append("/nmsweb");
						sb.append(e.getAttributeValue(Constant.XML_FILE_NODE_RSADDRESS));
						sb.append("' target='I3'><span class='memuNameSpan' title='"+e.getAttributeValue(Constant.XML_FILE_NODE_RSNAME)+"'>");
						sb.append(e.getAttributeValue(Constant.XML_FILE_NODE_RSNAME));
						sb.append("</span></a></li>");
					}
					sb.append("</ul>");
				}else{
					if(StringUtils.isNotBlank(ele.getAttributeValue(Constant.XML_FILE_NODE_RSADDRESS))){
						sb.append("<a target='I3' href='");
						sb.append("/nmsweb");
						sb.append(ele.getAttributeValue(Constant.XML_FILE_NODE_RSADDRESS));
						sb.append("'><span class='memuNameSpan' title='"+ele.getAttributeValue(Constant.XML_FILE_NODE_RSNAME)+"'>");
						sb.append(ele.getAttributeValue(Constant.XML_FILE_NODE_RSNAME));
						sb.append("</span><i class='my-icon nav-more'></i></a>");
					}
				}
				sb.append("</li>");
			}
			sb.append("<ul>");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return sb.toString();
	}
	
	
	@SuppressWarnings("unchecked")
	public CommonService getCommonService() {
		return commonService;
	}

	@SuppressWarnings("unchecked")
	public void setCommonService(CommonService commonService) {
		this.commonService = commonService;
	}

	@SuppressWarnings("unchecked")
	public QueryMenuTreeAction(CommonService commonService) {
		super();
		this.commonService = commonService;
	}

	public QueryMenuTreeAction() {

	}

}
