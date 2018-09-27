package nis.nms.util.tag.leftMenuTag;

import java.io.IOException;
import java.io.Reader;
import java.io.StringReader;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.BodyTagSupport;

import nis.nms.util.Constant;

import org.jdom.Document;
import org.jdom.Element;
import org.jdom.input.SAXBuilder;

/**
 * @author 
 * @description 将平面集合显示成树型结构,子菜单所在的tableId是，该子菜单所属的父菜单的rscode拼接的字符串加上“-”再加该子菜单的rscode
 * 
 * 
 * 
 * 
 */
public class TreeTag extends BodyTagSupport {

	private static final long serialVersionUID = 1819515872087708292L;

	/** xml字符串 */
	private String xmlStr;
	/** 菜单前面显示的图标 */
	private String imgSrc = "";
	/** 菜单前面显示的图标得宽度 */
	private String openAndCloseImgWidth = "";
	/** 顶级菜单前面显示的图标是否显示 */
	private String showParentOpenAndCloseImg = "";
	/** 菜单内容样式 */
	private String menuCss = "";
	/** 顶级菜单行的样式 */
	private String topTrCss = "";

	/** 父菜单样式 */
	private String parentMenuCss = "";
	/** 子菜单样式 */
	private String childMenuCss = "";
	/** 子菜单表的样式 */
	private String childMenuTableCss = "";
	/** 点击列时触发的事件 */
	private String onclick = "";
	/** 链接的样式 */
	private String hrefCss = "";
	/** 顶级父菜单的背景图片 */
	private String parentMenuBg = "";
	/** 站位图片 */
	private String spaceImage = "";
	/** 链接前的图片 */
	private String linkMenuImg = "";
	/** 子菜单的背景图片 */
	private String childMenuBg = "";
	/** 左树内容显示的面板目标 */
	private String target = "";
	/** 记录父级菜单id */
	private String parentTableId = "";
	// 鼠标事件
	private String onMouseOver = "";
	private String onMouseOut = "";
	// 点击链接触发的事件
	private String clickLinkEvent = "";
	// 点击父菜单触发的事件
	private String clickParentEvent = "";
	private int loop = 0;
	

	public int getLoop() {
		return loop;
	}

	public void setLoop(int loop) {
		this.loop = loop;
	}

	public String getClickLinkEvent() {
		return clickLinkEvent;
	}

	public void setClickLinkEvent(String clickLinkEvent) {
		this.clickLinkEvent = clickLinkEvent;
	}

	public String getOnMouseOver() {
		return onMouseOver;
	}

	public void setOnMouseOver(String onMouseOver) {
		this.onMouseOver = onMouseOver;
	}

	public String getOnMouseOut() {
		return onMouseOut;
	}

	public void setOnMouseOut(String onMouseOut) {
		this.onMouseOut = onMouseOut;
	}

	/** 标签开始时调用此方法 */
	@SuppressWarnings("unchecked")
	public int doStartTag() {

		// System.out.println("=========doStartTag===============");
		JspWriter out = pageContext.getOut();
		// 页面显示的内容
		StringBuffer outStr = new StringBuffer();
		StringBuffer topStr = new StringBuffer();
		Element element = getElement(xmlStr);
		List list = new ArrayList();
		//this.getElement(element, list, outStr);
		this.getElementTop(element, list, outStr,topStr);
		//System.out.println("outStr\t" + outStr);
		try {
			out.print(topStr);
			out.print("</ul></div>");
			out.print(outStr);
			out.print("</ul></div>");
		} catch (IOException e) {
			e.printStackTrace();
		}

		// 表示继续执行
		return EVAL_BODY_INCLUDE;
	}

	/** 标签结束时调用此方法 */
	public int doEndTag() {
		// System.out.println("=========doEndTag===============");
		try {
			parentTableId = "";
			if (bodyContent != null)
				bodyContent.writeOut(bodyContent.getEnclosingWriter());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return EVAL_PAGE;
	}

	/** 将字符串拼成Element */
	public static Element getElement(String str) {
		SAXBuilder builder = new SAXBuilder();
		Element resources = null;
		try {
			// 将xml字符串序列化,生成一个树型枚举对象
			Reader read = new StringReader(str);
			Document read_doc = builder.build(read);
			resources = read_doc.getRootElement();
		} catch (Exception e) {
			e.printStackTrace();
		}

		return resources;
	}
	
	/** 递归遍历,取出所有的值,排列成一个集合 同时拼接出jsp显示的内容 */
	@SuppressWarnings("unchecked")
	public Element getElementTop(Element resources, List list, StringBuffer outStr, StringBuffer topStr) {

		String href = pageContext.getServletContext().getContextPath();//"/nmsweb";
		// 判断节点是否有子节点
		Element resourcesElement = null;
		Resource resource = new Resource();
		List resourceList = resources.getChildren(Constant.XML_FILE_NODE);
		/*// 占位空格
		String spaceImageStr = "&nbsp;&nbsp;&nbsp;&nbsp;";
		// loop+=1;
		for (int t = 0; t < loop; t++) {
			spaceImageStr += "&nbsp;&nbsp;&nbsp;&nbsp;";
		}*/
		String widthStr = "";
		int loopTemp = loop;
		//按钮数超过5个小于等于10分两排，如果超过10个则平分到两排中
		int menuNum = 10;
		// 如果有节点
		if (resourceList != null && resourceList.size() > 0) {
			if(resourceList.size()>7){
				menuNum = resourceList.size()%2==0?(resourceList.size()/2):(resourceList.size()/2 + 1);
				//menuNum = resourceList.size()/2;
			}else{
				widthStr = "style='left:22px;width:122px;'";
			}
			boolean isFirstTop = true;
			for (int i = 0; i < resourceList.size(); i++) {
				resourcesElement = (Element) resourceList.get(i);
				resource = new Resource();
				getResourcePro(resourcesElement, resource);
				String menuName = resource.getRsname();

				if (resourcesElement
						.getAttributeValue(Constant.XML_FILE_NODE_RSID) != null) {
					list.add(resource);
				}
				// 如果有子菜单
				if (resourcesElement.getChildren(Constant.XML_FILE_NODE) != null
						&& resourcesElement
								.getChildren(Constant.XML_FILE_NODE).size() > 0) {
					// 如果是顶级菜单
					if (resource.getParRsCode().intValue() == -1) {
						loop = 0;
						//拼出标签页
						if(isFirstTop){
							outStr.append("<div class='menu_2' "+widthStr+" id='rightNodes");
							outStr.append(i);
							outStr.append("'>");
							outStr.append("<ul>");
							isFirstTop = false;
							
							topStr.append("<div class='menu_1'  id='dleft' >");
							topStr.append("	<ul>");
							topStr.append("<li class='nodeSelStyle' id='node");
							topStr.append(i);
							topStr.append("' menuLevel='1' num='"+i+"'><div class='m_1'>");
							topStr.append(menuName);
							topStr.append("</div></li>");
						}else{
							outStr.append("</ul>");
							outStr.append("</div>");
							outStr.append("<div class='menu_2'  "+widthStr+"  id='rightNodes");
							outStr.append(i);
							outStr.append("' style=\"display:none;\">");
							outStr.append("<ul>");

							//一级菜单标签5个一组
							if(i%menuNum==0){
								topStr.append("	</ul>");
								topStr.append("</div>");
								topStr.append("<div class='menu_0'  id='dright' >");
								topStr.append("	<ul>");

							}
								topStr.append("<li class='nodeStyle' id='node");
								topStr.append(i);
								topStr.append("' menuLevel='1' num='"+i+"'><div class='m_1'>");
								topStr.append(menuName);
								topStr.append("</div></li>");
						}
						// 有链接
						if (resource.getRsaddress() != null) {
						/*	outStr.append("<li ");
							outStr.append("onclick=\"submenu('"
									+ resource.getRsid() + "')\" >");
							if (showParentOpenAndCloseImg.equals("true")) {
								outStr.append("<img id='image" + resource.getRsid()
										+ "' src='" + imgSrc + "'/>&nbsp;&nbsp;");
							}
							href = href + resource.getRsaddress();
							outStr.append("<a href='" + href + "' target='"
									+ target + "' >" + menuName + "</a>");
							outStr.append("</li>");*/
						}
						// 没有链接
						else {//顶级节点不再显示
							//outStr.append(menuName);
						}
						//outStr.append("</td></tr>");
					} else {

						
					}/*
					outStr
						.append("<div id='"
								+ resource.getRsid()
								+ "' style='display:block;'");
					if (onMouseOver != null && !onMouseOver.equals("")) {
						outStr.append(" onmouseover='" + onMouseOver + "'");
					}
					if (onMouseOut != null && !onMouseOut.equals("")) {
						outStr.append(" onmouseout='" + onMouseOut + "'");
					}
					if (clickLinkEvent != null && !clickLinkEvent.equals("")) {
						outStr.append(" onclick='" + clickLinkEvent + "'");
					}
					outStr.append(">");*/
					getElement(resourcesElement, list, outStr,true);
					loop = loopTemp;
					/*outStr.append("</div>");*/
				}

				else {
					// 没有子菜单有链接
					// 如果是顶级菜单
					if (resource.getParRsCode().intValue() == -1) {
						//拼出标签页
						if(isFirstTop){
							outStr.append("<div class='menu_2' "+widthStr+" id='rightNodes");
							outStr.append(i);
							outStr.append("'>");
							outStr.append("<ul>");
							isFirstTop = false;
							topStr.append("<div class='menu_1'   id='dleft' >");
							topStr.append("	<ul>");
							topStr.append("<li class='nodeSelStyle' id='node");
							topStr.append(i);
							topStr.append("' menuLevel='1' num='"+i+"'><div class='m_1'>");
							/*if (resource.getRsaddress() != null) {
								topStr.append("<a href='" + href
										+ resource.getRsaddress() + "' target='"
										+ target + "' ");
								if (hrefCss != null && !hrefCss.equals("")) {
									topStr.append(" class='" + hrefCss + "'");
								}
								topStr.append(" >" + menuName + "</a>");
							}else{
								topStr.append(menuName);
							}*/topStr.append(menuName);
							topStr.append("</div></li>");
						}else{
							outStr.append("</ul>");
							outStr.append("</div>");
							outStr.append("<div class='menu_2' "+widthStr+" id='rightNodes");
							outStr.append(i);
							outStr.append("' style=\"display:none;\">");
							outStr.append("<ul>");
							
							//一级菜单标签5个一组
							if(i%menuNum==0){
								topStr.append("	</ul>");
								topStr.append("</div>");
								topStr.append("<div class='menu_0'  id='dright' >");
								topStr.append("	<ul>");

							}
								topStr.append("<li class='nodeStyle' id='node");
								topStr.append(i);
								topStr.append("' menuLevel='1' num='"+i+"'><div class='m_1'>");
								/*if (resource.getRsaddress() != null) {
									topStr.append("<a href='" + href
											+ resource.getRsaddress() + "' target='"
											+ target + "' ");
									if (hrefCss != null && !hrefCss.equals("")) {
										topStr.append(" class='" + hrefCss + "'");
									}
									topStr.append(" >" + menuName + "</a>");
								}else{
									topStr.append(menuName);
								}*/
								topStr.append(menuName);
								topStr.append("</div></li>");
						}
					} else {
					}
				}
			}
		}

		return resourcesElement;
	}
	/** 递归遍历,取出所有的值,排列成一个集合 同时拼接出jsp显示的内容 */
	@SuppressWarnings("unchecked")
	public Element getElement(Element resources, List list, StringBuffer outStr,boolean firstflag) {

		String href = "/nmsweb";//pageContext.getServletContext().getContextPath();
		// 判断节点是否有子节点
		Element resourcesElement = null;
		Resource resource = new Resource();
		List resourceList = resources.getChildren(Constant.XML_FILE_NODE);
		// 占位空格
		String spaceImageStr = "";//"&nbsp;&nbsp;&nbsp;&nbsp;";
		// loop+=1;
		for (int t = 0; t < loop; t++) {
			spaceImageStr +=  "";//"&nbsp;&nbsp;&nbsp;&nbsp;";
		}
		int loopTemp = loop;
		// 如果有节点
		if (resourceList != null && resourceList.size() > 0) {
			for (int i = 0; i < resourceList.size(); i++) {
				resourcesElement = (Element) resourceList.get(i);
				resource = new Resource();
				getResourcePro(resourcesElement, resource);
				String menuName = resource.getRsname();

				if (resourcesElement
						.getAttributeValue(Constant.XML_FILE_NODE_RSID) != null) {
					list.add(resource);
				}
				// 如果有子菜单
				if (resourcesElement.getChildren(Constant.XML_FILE_NODE) != null
						&& resourcesElement
								.getChildren(Constant.XML_FILE_NODE).size() > 0) {
					// 如果是顶级菜单
					//if (resource.getParRsCode().intValue() == -1) {
					//如果是一级菜
					if (firstflag) {
						loop = 0;
						outStr.append("<li class='mli' menuLevel='no1' ");
						outStr.append(" onclick=\"submenu('"
								+ resource.getRsid() + "') \">");
						if (showParentOpenAndCloseImg.equals("true")) {
							outStr.append("<img id='image" + resource.getRsid()
									+ "' src='" + imgSrc + "'/>&nbsp;&nbsp;");
						}
						// 有链接
						if (resource.getRsaddress() != null) {
							href = href + resource.getRsaddress();
							outStr.append("<a href='" + href + "' target='"
									+ target + "' id='aaa' >" + menuName + "</a>");
						}
						// 没有链接
						else {
							outStr.append(menuName);
						}
						outStr.append("</li>");
						
					} else {

						loop += 1;
						outStr.append("<li  class='mli' menuLevel='no1'");
						outStr.append(spaceImageStr);
						outStr.append(" onclick=\"submenu('"
								+ resource.getRsid() + "') \">");
						outStr.append("<img id='image" + resource.getRsid()
								+ "' src='" + imgSrc + "'/>&nbsp;&nbsp;");
						// 有链接
						if (resource.getRsaddress() != null) {
							href = href + resource.getRsaddress();
							outStr.append("<a href='" + href + "' target='"
									+ target + "' id = 'aaa'");
							if (hrefCss != null && !hrefCss.equals("")) {
								outStr.append(" class='" + hrefCss + "'");
							}
							outStr.append(" >" + menuName + "</a>");
						}
						// 没有链接
						else {
							outStr
									.append("<a href='javascript:void(0);' class='"
											+ hrefCss
											+ "'>"
											+ menuName
											+ "</a>");
						}
						outStr.append("</li>");
					}
					outStr
						.append("<span id='"
								+ resource.getRsid()
								+ "' style='display:none;'");
					if (onMouseOver != null && !onMouseOver.equals("")) {
						outStr.append(" onmouseover='" + onMouseOver + "'");
					}
					if (onMouseOut != null && !onMouseOut.equals("")) {
						outStr.append(" onmouseout='" + onMouseOut + "'");
					}
					if (clickLinkEvent != null && !clickLinkEvent.equals("")) {
						outStr.append(" onclick='" + clickLinkEvent + "'");
					}
					outStr.append(">");
					getElement(resourcesElement, list, outStr,false);
					loop = loopTemp;
					outStr.append("</span>");
				}

				else {
					// 没有子菜单有链接
					// 如果是顶级菜单
					//if (resource.getParRsCode().intValue() == -1) {
					//如果是一级菜
					if (firstflag) {
						outStr.append("<li  class='mli' menuLevel='no1'>");
						//outStr.append(spaceImageStr);
						if (resource.getRsaddress() != null) {
							outStr.append("<a href='" + href
									+ resource.getRsaddress() + "' target='"
									+ target + "' ");
							if (hrefCss != null && !hrefCss.equals("")) {
								outStr.append(" class='" + hrefCss + "'");
							}
							outStr.append(" >" + menuName + "</a></li>");
						}
						// 顶级菜单也没有链接
						else {
							outStr
									.append("<a href='javascript:void(0);' class='"
											+ hrefCss + "'>" + menuName);
							outStr.append("</li>");
						}
					} else {
						// loop+=1;
						outStr.append("<li  class='mli' menuLevel='no1'>");
						outStr.append(spaceImageStr);
						if (resource.getRsaddress() != null) {
							outStr
									.append(spaceImageStr
											+ "<img id='image"
											+ resource.getRsid()
											+ "' src='"
											+ linkMenuImg
											+ "' width='10' height='6'/>&nbsp;&nbsp;<a href='"
											+ href + resource.getRsaddress()
											+ "' target='" + target
											+ "' class='" + hrefCss + "'>"
											+ menuName + "</a></li>");
						}
						// 没有子菜单也没有链接
						else {
							outStr.append(spaceImageStr
									+ "<a href='javascript:void(0);' ");
							if (hrefCss != null && !hrefCss.equals("")) {
								outStr.append(" class='" + hrefCss + "'");
							}
							outStr.append(">" + menuName
									+ "</a></li>");
						}
					}
				}
			}
		}

		return resourcesElement;
	}
	private static void getResourcePro(Element resources, Resource resource) {
		// rsid
		if (resources.getAttributeValue(Constant.XML_FILE_NODE_RSID) != null
				&& !resources.getAttributeValue(Constant.XML_FILE_NODE_RSID)
						.equals("")) {
			resource.setRsid(new Long(resources
					.getAttributeValue(Constant.XML_FILE_NODE_RSID)));
		}
		// rsname
		if (resources.getAttributeValue(Constant.XML_FILE_NODE_RSNAME) != null
				&& !resources.getAttributeValue(Constant.XML_FILE_NODE_RSNAME)
						.equals("")) {
			resource.setRsname(resources
					.getAttributeValue(Constant.XML_FILE_NODE_RSNAME));
		}
		// number
		if (resources.getAttributeValue(Constant.XML_FILE_NODE_NUMBER) != null
				&& !resources.getAttributeValue(Constant.XML_FILE_NODE_NUMBER)
						.equals("")) {
			resource.setNumber(new Long(resources
					.getAttributeValue(Constant.XML_FILE_NODE_NUMBER)));
		}
		// rsdesc
		if (resources.getAttributeValue(Constant.XML_FILE_NODE_RSDESC) != null
				&& !resources.getAttributeValue(Constant.XML_FILE_NODE_RSDESC)
						.equals("")) {
			resource.setRsdesc(resources
					.getAttributeValue(Constant.XML_FILE_NODE_RSDESC));
		}
		// rsaddress
		if (resources.getAttributeValue(Constant.XML_FILE_NODE_RSADDRESS) != null
				&& !resources.getAttributeValue(
						Constant.XML_FILE_NODE_RSADDRESS).equals("")) {
			resource.setRsaddress(resources
					.getAttributeValue(Constant.XML_FILE_NODE_RSADDRESS));
		}
		// business
		if (resources.getAttributeValue(Constant.XML_FILE_NODE_BUSINESS) != null
				&& !resources.getAttributeValue(
						Constant.XML_FILE_NODE_BUSINESS).equals("")) {
			resource.setBusiness(resources
					.getAttributeValue(Constant.XML_FILE_NODE_BUSINESS));
		}
		// // rsCode
		// if (resources.getAttributeValue(Constants.XML_FILE_NODE_RSCODE) !=
		// null
		// && !resources.getAttributeValue(Constants.XML_FILE_NODE_RSCODE)
		// .equals("")
		// && !resources.getAttributeValue(Constants.XML_FILE_NODE_RSCODE)
		// .equals("999999")) {
		// resource.setRsCode(new Long(resources
		// .getAttributeValue(Constants.XML_FILE_NODE_RSCODE)));
		// } else {
		// resource.setRsCode(new Long(-1));
		// }
		// parRsCode
		if (resources.getParentElement().getAttributeValue(
				Constant.XML_FILE_NODE_RSID) != null
				&& !resources.getParentElement().getAttributeValue(
						Constant.XML_FILE_NODE_RSID).equals("")
				&& !resources.getParentElement().getAttributeValue(
						Constant.XML_FILE_NODE_RSID).equals("999999")) {
			resource.setParRsCode(new Long(resources.getParentElement()
					.getAttributeValue(Constant.XML_FILE_NODE_RSID)));
		} else {
			resource.setParRsCode(new Long(-1));
		}
		// cssClass
		if (resources.getAttributeValue(Constant.XML_FILE_NODE_CSSCLASS) != null
				&& !resources.getAttributeValue(
						Constant.XML_FILE_NODE_CSSCLASS).equals("")) {
			resource.setMenucss(resources
					.getAttributeValue(Constant.XML_FILE_NODE_CSSCLASS));
		}
	}

	public String getXmlStr() {
		return xmlStr;
	}

	public void setXmlStr(String xmlStr) {
		this.xmlStr = xmlStr;
	}

	public String getImgSrc() {
		return imgSrc;
	}

	public void setImgSrc(String imgSrc) {
		this.imgSrc = imgSrc;
	}

	public String getParentMenuCss() {
		return parentMenuCss;
	}

	public void setParentMenuCss(String parentMenuCss) {
		this.parentMenuCss = parentMenuCss;
	}

	public String getChildMenuCss() {
		return childMenuCss;
	}

	public void setChildMenuCss(String childMenuCss) {
		this.childMenuCss = childMenuCss;
	}

	public String getChildMenuTableCss() {
		return childMenuTableCss;
	}

	public void setChildMenuTableCss(String childMenuTableCss) {
		this.childMenuTableCss = childMenuTableCss;
	}

	public String getOnclick() {
		return onclick;
	}

	public void setOnclick(String onclick) {
		this.onclick = onclick;
	}

	public String getParentMenuBg() {
		return parentMenuBg;
	}

	public void setParentMenuBg(String parentMenuBg) {
		this.parentMenuBg = parentMenuBg;
	}

	public String getChildMenuBg() {
		return childMenuBg;
	}

	public void setChildMenuBg(String childMenuBg) {
		this.childMenuBg = childMenuBg;
	}

	public String getTarget() {
		return target;
	}

	public void setTarget(String target) {
		this.target = target;
	}

	public String getParentTableId() {
		return parentTableId;
	}

	public void setParentTableId(String parentTableId) {
		this.parentTableId = parentTableId;
	}

	public String getMenuCss() {
		return menuCss;
	}

	public void setMenuCss(String menuCss) {
		this.menuCss = menuCss;
	}

	public String getTopTrCss() {
		return topTrCss;
	}

	public void setTopTrCss(String topTrCss) {
		this.topTrCss = topTrCss;
	}

	public String getOpenAndCloseImgWidth() {
		return openAndCloseImgWidth;
	}

	public void setOpenAndCloseImgWidth(String openAndCloseImgWidth) {
		this.openAndCloseImgWidth = openAndCloseImgWidth;
	}

	public String getShowParentOpenAndCloseImg() {
		return showParentOpenAndCloseImg;
	}

	public void setShowParentOpenAndCloseImg(String showParentOpenAndCloseImg) {
		this.showParentOpenAndCloseImg = showParentOpenAndCloseImg;
	}

	public String getLinkMenuImg() {
		return linkMenuImg;
	}

	public void setLinkMenuImg(String linkMenuImg) {
		this.linkMenuImg = linkMenuImg;
	}

	public String getClickParentEvent() {
		return clickParentEvent;
	}

	public void setClickParentEvent(String clickParentEvent) {
		this.clickParentEvent = clickParentEvent;
	}

	public String getSpaceImage() {
		return spaceImage;
	}

	public void setSpaceImage(String spaceImage) {
		this.spaceImage = spaceImage;
	}

	public String getHrefCss() {
		return hrefCss;
	}

	public void setHrefCss(String hrefCss) {
		this.hrefCss = hrefCss;
	}
}
