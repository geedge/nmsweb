package nis.nms.web.actions.sysManage;

import java.io.File;
import java.io.FileInputStream;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.apache.log4j.Logger;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.apache.struts2.config.Result;
import org.apache.struts2.config.Results;

import nis.nms.core.Resource;
import nis.nms.domains.GorupSystemTable;
import nis.nms.domains.SystemTable;
import nis.nms.domains.XtJsJbxx;
import nis.nms.service.CommonService;
import nis.nms.util.BaseAction;
import nis.nms.util.Constant;
import nis.nms.util.ExportUtils;
import nis.nms.util.Page;

@SuppressWarnings("unchecked")
@Results( { 
		@Result(name = "ok", value = "/page/system/usergroup/giveGrouppermission/geivegroupperm.jsp"),
		@Result(name = "viewdate", value = "/page/system/usergroup/giveGrouppermission/viewgrouppermission.jsp"),
		@Result(name = "viewdateForGuide", value = "/page/system/usergroup/giveGrouppermission/viewgrouppermissionForGuide.jsp"),
		@Result(name = "groupList", value = "/page/system/usergroup/giveGrouppermission/groupInfoList.jsp"),
		@Result(name = "showError", value = "/showImportError.jsp"),
		@Result(name = "addgroupinfo", value = "/page/system/usergroup/giveGrouppermission/addgroupinfo.jsp")
})
public class UserGroupPerssionAction extends BaseAction {
	private Logger logger = Logger.getLogger(UserGroupPerssionAction.class);
	public List<Resource> listresources;

	private Page page;

	private XtJsJbxx role;// 保存用户组信息

	private List allMkInfo = new ArrayList();// 保存所有系统信息

	private String mkid;// 系统id

	private XtJsJbxx userGroup;// 用户组信息

	private List listJsInfo = new ArrayList();// 用户组列表信息页面

	private List allJsInfo = new ArrayList();// 查询用户组信息

	private int pageNo = 1;

	private int pageSize = this.getDefaultPageSize(); // 每页显示的记录条数

	private String jsmc;// 角色名称

	private String jsbh;// 角色编号

	public List<XtJsJbxx> groupList;

	public String action = "";

	private String fromWhere;
	private String isComplete;
	
	private static final long serialVersionUID = 1L;

	private CommonService commonService;
	
	// 导入节点文件
	private File myFile;
	private String myFileFileName;

	public File getMyFile() {
		return myFile;
	}

	public void setMyFile(File myFile) {
		this.myFile = myFile;
	}

	public String getMyFileFileName() {
		return myFileFileName;
	}

	public void setMyFileFileName(String myFileFileName) {
		this.myFileFileName = myFileFileName;
	}

	public CommonService getCommonService() {
		return commonService;
	}

	public void setCommonService(CommonService commonService) {
		this.commonService = commonService;
	}

	public UserGroupPerssionAction() {
		// TODO Auto-generated constructor stub
	}

	public String executeAction() throws Exception {
		String resultpage = "";
		this.getRequest().setAttribute("fromWhere", fromWhere);
		if ("toupdate".equals(this.action)) {
			queryGroupByid();
			resultpage = preSentGroupPerssion();
		}
		if ("viewdate".equals(this.action)) {
			queryGroupByid();
			resultpage = preSentGroupPerssion();
		}
		if ("viewdateForGuide".equals(this.action)) {
			queryGroupByid();
			resultpage = preSentGroupPerssion();
		}
		if ("query".equals(this.action)) {
			resultpage = getGroupInfoList();
		}
		if ("update".equals(this.action)) {
			giveGroupPerssions();
			return "ok";
		}
		if ("addgroupInfo".equals(this.action)) {
			addgroupInfo();
			return null;
		}
		if ("openAddgroupPage".equals(this.action)) {
			this.getRequest().setAttribute("fromWhere", fromWhere);
			return this.queryMk();
		}
		if ("downloadExample".equals(this.action)) {
			resultpage = downloadExample();
		} 
		if ("importXls".equals(this.action)) {
			resultpage = importXls();
		} 
		if ("emportCurrentXls".equals(this.action)) {
			resultpage = emportCurrentXls();
		} 
		if ("emportAllXls".equals(this.action)) {
			resultpage = emportAllXls();
		}
		if("AjaxCheck".equals(this.action)){
			ajaxCheck();
			return null;
		}
		if("checkUpdate".equals(this.action)){
			checkUpdate();
			return null;
		}
		return resultpage;
	}

	// 模板下载   程辉 2013-5-13新增
	public String downloadExample() {
		try {
			String sql = "select xjj.jsmc,xjj.jsms,st.system_name from xt_js_jbxx xjj join gorup_system_table gst on xjj.jsbh=gst.user_group_id"+
						 " join system_table st on gst.system_id=st.system_id ";
						// + "where rownum<4 order by xjj.jsmc";
			//@2018年4月10日18:45:00 fang 修改rownum 适配 mysql
			if(Constant.IS_MYSQL){
				sql = sql + " order by xjj.jsmc limit 3";
			}else{
				sql = sql + " where rownum<4 order by xjj.jsmc";
			}
			List st= this.commonService.executeSQL(sql);
			
			String[] title = { getI18nText("i18n_UserGroupPerssionAction.downloadExample.title.userGroup_n81i"),
								getI18nText("i18n_UserGroupPerssionAction.downloadExample.title.userGroupDesc_n81i"),
								getI18nText("i18n_UserGroupPerssionAction.downloadExample.title.system_n81i") };
	
			String[] colu = { "0", "1","2" };
			ExportUtils m = new ExportUtils();
			m.setAutoSizeColumn(true);
			m.exportExcel(getI18nText("i18n_UserGroupPerssionAction.downloadExample.usergroupTable_n81i"), st, title, colu,"downloadExample");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	// 导入 程辉 2013-5-8新增
	public String importXls() {
		String errorInfo = "";
		try {
			List<String> headerList = new ArrayList<String>();
			List<List<String>> rowList = new ArrayList<List<String>>();

			Workbook workbook = null;
			if (myFileFileName.endsWith(".xlsx")) {
				workbook = new XSSFWorkbook(new FileInputStream(myFile));
			} else {
				// 创建对Excel工作簿文件的引用
				workbook = new HSSFWorkbook(new FileInputStream(myFile));
			}

			// 创建对工作表的引用，得到表的第一页
			Sheet sheet = workbook.getSheetAt(0);
			// 读取左上端单元

			// 记录存储数据条数
			int count = 0;
			// 记录读入excel数据条数
			int sum = (sheet.getLastRowNum());
			for (short i = 1; i <= sheet.getLastRowNum(); i++) {
				String JSMC ="";
				String JSMS ="";
				String SYSTEMNAME ="";
				List<String> errorList = new ArrayList<String>();
				Row row = sheet.getRow(i);
				Cell cell_1 = row.getCell((short) 0);
				Cell cell_2 = row.getCell((short) 1);
				Cell cell_3 = row.getCell((short) 2);
				if ((null == cell_1 || 3 == cell_1.getCellType())
						&& (null == cell_2 || 3 == cell_2.getCellType())
						&& (null == cell_3 || 3 == cell_3.getCellType())) {
					sum--;
				}else {
					// 用户组名称
					if (null == cell_1) {
						errorInfo += getI18nText("i18n_UserGroupPerssionAction.downloadExample.errorInfo1_n81i",i+"");
					} else if (cell_1.getCellType() == Cell.CELL_TYPE_STRING) {
						if ("".equals(cell_1.getStringCellValue())) {
							errorInfo += i +getI18nText("i18n_UserGroupPerssionAction.downloadExample.errorInfo1_n81i",i+"");
						} else {
							JSMC = cell_1.getStringCellValue().trim();
						}
					} else {
						errorInfo +=  getI18nText("i18n_UserGroupPerssionAction.downloadExample.errorInfo2_n81i",i+"");
					}

					// 用户组描述
					if (null == cell_2) {
					} else if (cell_2.getCellType() == Cell.CELL_TYPE_STRING) {
						if ("".equals(cell_2.getStringCellValue())) {
						} else {
							JSMS = cell_2.getStringCellValue()
									.trim();
							if(JSMS.length()>100){
								errorInfo +=  getI18nText("i18n_UserGroupPerssionAction.downloadExample.errorInfo3_n81i",i+"");
							}
						}
					}
					// 可访问系统
					if(null == cell_3){
						errorInfo +=  getI18nText("i18n_UserGroupPerssionAction.downloadExample.errorInfo4_n81i",i+"");
					}else if (cell_3.getCellType() == Cell.CELL_TYPE_STRING) {
						if ("".equals(cell_3.getStringCellValue())) {
							errorInfo +=  getI18nText("i18n_UserGroupPerssionAction.downloadExample.errorInfo4_n81i",i+"");
						} else {
							SYSTEMNAME = cell_3.getStringCellValue().trim();
						}
					} else {
						errorInfo +=  getI18nText("i18n_UserGroupPerssionAction.downloadExample.errorInfo5_n81i",i+"");
					}
					if ("".equals(errorInfo)) {// 保存节点
						errorInfo = this.saveNode(JSMC,JSMS,SYSTEMNAME);
					}
					if ("".equals(errorInfo)) {
						count++;
					} else {
						errorList.add(JSMC);
						errorList.add(JSMS);
						errorList.add(SYSTEMNAME);
						errorList.add(errorInfo);
						rowList.add(errorList);
						errorInfo = "";

					}
				}
			}
			headerList.add(getI18nText("i18n_UserGroupPerssionAction.downloadExample.usergroupName_n81i"));
			headerList.add(getI18nText("i18n_UserGroupPerssionAction.downloadExample.usergroupDesc_n81i"));
			headerList.add(getI18nText("i18n_UserGroupPerssionAction.downloadExample.system_n81i"));
			headerList.add(getI18nText("i18n_UserGroupPerssionAction.downloadExample.errorInfo_n81i"));
			this.getRequest().setAttribute("rowList", rowList);
			this.getRequest().setAttribute("headerList", headerList);
			if (count == sum && sum > 0) {
				outHtmlString("<script type=\"text/javascript\">alert('i18n_UserGroupPerssionAction.downloadExample.success_n81i');this.location='userGroupPerssion.do?action=query'</script>");
				return null;
//				this.getRequest().setAttribute("MSG", 1);
//				return this.getGroupInfoList();
			} else if (sum == 0) {
				this
						.outHtmlString("<script>alert('i18n_UserGroupPerssionAction.downloadExample.selectFileIsNull_n81i');history.back();</script>");
				return null;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "showError";
	}

	private String saveNode(String JSMC,String JSMS,String SYSTEMNAME) {
		String desc = "";
		XtJsJbxx xtJsJbxx = new XtJsJbxx();
		String operate="save";
		try {
			// 保存节点信息
			xtJsJbxx.setCtime(new Date());
			xtJsJbxx.setJsmc(JSMC);
			xtJsJbxx.setJsms(JSMS);
			xtJsJbxx.setType(1L);
			xtJsJbxx.setZxbz("0");

			//判断用户组名称是否已存在
			List<XtJsJbxx> JSMCList = this.commonService.find(
					"from XtJsJbxx where JSMC=?", xtJsJbxx.getJsmc());
			if (JSMCList != null && JSMCList.size() > 0) {
				xtJsJbxx = JSMCList.get(0);
				operate="update";
			}
			//判断可访问系统是否存在
			List SYSTEMNAMEList = this.commonService.find(
					"select st.systemId from SystemTable st where st.systemName=?", SYSTEMNAME);
			if (null==SYSTEMNAMEList  || SYSTEMNAMEList.size() == 0) {
				return getI18nText("i18n_UserGroupPerssionAction.downloadExample.systemIsNull_n81i");
			}
			String SYSTEMID = SYSTEMNAMEList.get(0).toString();
			
			if(operate.equals("save")){
				this.commonService.save(xtJsJbxx);
			}
			//判断当前用户组是否具有当前可访问系统权限 如有 不可重复添加
			List quanxianList = this.commonService.find(
					"from GorupSystemTable where systemId=? and userGroupId=?", Long.parseLong(SYSTEMID),xtJsJbxx.getJsbh());
			if (quanxianList != null && quanxianList.size() > 0) {
				return getI18nText("i18n_UserGroupPerssionAction.downloadExample.hasPermission_n81i");
			}
			
			GorupSystemTable gorupSystemTable = new GorupSystemTable();
			gorupSystemTable.setSystemId(Long.parseLong(SYSTEMID));
			gorupSystemTable.setUserGroupId(xtJsJbxx.getJsbh());
			this.commonService.save(gorupSystemTable);
		} catch (Exception e) {
			e.printStackTrace();
			desc = getI18nText("i18n_UserGroupPerssionAction.downloadExample.nodeInfoImportErr_n81i");
		}
		return desc;
	}
	
	// 当前页导出   程辉 2013-5-8新增
	public String emportCurrentXls() {
		try {
			String sql = "from XtJsJbxx where 1=1 and type=1";
			String sqlCondition = "where zxbz<>2";// 将查询条件记录到操作日志中
			if (jsmc != null && !"".equals(jsmc)) {
				sql += " and jsmc like '%" + jsmc + "%'";
				sqlCondition += " and jsmc = '" + jsmc + "'";
			}
			sql += " order by ctime desc";
			page = this.commonService.findByPage(sql, pageNo, pageSize);
			List<XtJsJbxx> allJsInfo = (List<XtJsJbxx>) page.getResult();
			
			for (int i = 0; i < allJsInfo.size(); i++) {
				if(allJsInfo.get(i).getZxbz().equals("0")){
					allJsInfo.get(i).setZxbz(getI18nText("i18n_UserGroupPerssionAction.downloadExample.valid_n81i"));
				}
				if(allJsInfo.get(i).getZxbz().equals("1")){
					allJsInfo.get(i).setZxbz(getI18nText("i18n_UserGroupPerssionAction.downloadExample.invalid_n81i"));
				}
			}
			
			String[] title = { getI18nText("i18n_UserGroupPerssionAction.downloadExample.usergroupName_n81i"),
								getI18nText("i18n_UserGroupPerssionAction.downloadExample.usergroupDesc_n81i"),
								getI18nText("i18n_UserGroupPerssionAction.downloadExample.state_n81i") };
	
			String[] colu = { "jsmc", "jsms","zxbz" };
			String url = "userGroupPerssion.do?action=query&jsmc="+jsmc+"&pageSize="+pageSize+"&pageNo="+pageNo;
			ExportUtils m = new ExportUtils();
			m.setAutoSizeColumn(true);
			m.exportExcel(url,getI18nText("i18n_UserGroupPerssionAction.downloadExample.usergroupTable_n81i"), allJsInfo, title, colu);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	// 导出全部   程辉 2013-5-8新增
	public String emportAllXls() {
		try {
			String sql = "from XtJsJbxx where 1=1 and type=1";
			String sqlCondition = "where zxbz<>2";// 将查询条件记录到操作日志中
			if (jsmc != null && !"".equals(jsmc)) {
				sql += " and jsmc like '%" + jsmc + "%'";
				sqlCondition += " and jsmc = '" + jsmc + "'";
			}
			sql += " order by ctime desc";
			List<XtJsJbxx> allJsInfo = this.commonService.find(sql);
			
			for (int i = 0; i < allJsInfo.size(); i++) {
				if(allJsInfo.get(i).getZxbz().equals("0")){
					allJsInfo.get(i).setZxbz(getI18nText("i18n_UserGroupPerssionAction.downloadExample.valid_n81i"));
				}
				if(allJsInfo.get(i).getZxbz().equals("1")){
					allJsInfo.get(i).setZxbz(getI18nText("i18n_UserGroupPerssionAction.downloadExample.invalid_n81i"));
				}
			}
			
			String[] title = { getI18nText("i18n_UserGroupPerssionAction.downloadExample.usergroupName_n81i"),
					getI18nText("i18n_UserGroupPerssionAction.downloadExample.usergroupDesc_n81i"),
					getI18nText("i18n_UserGroupPerssionAction.downloadExample.state_n81i") };
	
			String[] colu = { "jsmc", "jsms","zxbz" };
			String url = "userGroupPerssion.do?action=query&jsmc="+jsmc+"&pageSize="+pageSize+"&pageNo="+pageNo;
			ExportUtils m = new ExportUtils();
			m.setAutoSizeColumn(true);
			m.exportExcel(url,getI18nText("i18n_UserGroupPerssionAction.downloadExample.usergroupTable_n81i"), allJsInfo, title, colu);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public void ajaxCheck(){
		List list;
		try {
			list = this.commonService.find("from XtJsJbxx where type=1 and jsmc=?", role.getJsmc());
			if(list!=null && list.size()>0){
				this.outString("error");
				return;
			}
		} catch (Exception e) {
			e.printStackTrace();
			logger.info("添加用户组配置校验失败", e);
			this.outString("exception");
		}
		this.outString("success");
	}
	
	// 新增用户组信息
	public void addgroupInfo() {
		try {
			/*List list = this.commonService.find("from XtJsJbxx where type=1 and jsmc=?", role.getJsmc());
			if(list!=null && list.size()>0){
				this.outHtmlString("<script>alert('用户组已存在，请重新输入！');history.back();</script>");
				return;
			}*/
			role.setZxbz("0");
			role.setType(1l);
			role.setCtime(new Date());
			this.commonService.save(role);
			// 将添加操作写到操作日志中
			this.addDBOperationRpt(commonService, "XT_JS_JBXX", "INSERT", role
					.getJsbh());
			String[] sMk = mkid.split(",");
			if (sMk != null) {
				for (int i = 0; i < sMk.length; i++) {
					GorupSystemTable groupsystemtable = new GorupSystemTable();
					groupsystemtable.setUserGroupId(role.getJsbh());
					groupsystemtable.setSystemId(Long.parseLong(sMk[i].trim()));
					this.commonService.save(groupsystemtable);
				}
				this.getRequest().setAttribute("MSG", 1);
			}
			
			//记录用户操作用于设置向导
			if(fromWhere!=null && !"".equals(fromWhere)){
				if(fromWhere.equals("formGuide")){
					outHtmlString("<script type=\"text/javascript\">alert('i18n_UserGroupPerssionAction.downloadExample.success_n81i');this.location='userGroupPerssion.do?action=query&isComplete=0'</script>");
				}
			}else{
				outHtmlString("<script type=\"text/javascript\">alert('i18n_UserGroupPerssionAction.downloadExample.success_n81i');this.location='userGroupPerssion.do?action=query'</script>");
			}
		} catch (Exception e) {
			outHtmlString("<script type=\"text/javascript\">alert('i18n_UserGroupPerssionAction.giveGroupPerssions.faild_n81i');this.location='userGroupPerssion.do?action=query'</script>");
			this.getRequest().setAttribute("MSG", 2);
			e.printStackTrace();
		}
	}

	// 查询系统信息
	public String queryMk() {
		try {
			List treeList = new ArrayList();
			List<SystemTable> menuList = this.commonService
					.find("from SystemTable where  systemState='0' ");
			for (int i = 0; i < menuList.size(); i++) {
				Resource resource = new Resource();
				resource.setParRsCode("0");
				resource.setRsCode(menuList.get(i).getSystemId().toString());
				resource.setRsid(menuList.get(i).getSystemId().toString());
				resource.setRsname(menuList.get(i).getSystemName().toString());
				treeList.add(resource);
			}
			this.getRequest().setAttribute("treeList", treeList);
			String sqlCondition = "where systemState=0";// 将查询条件记录到操作日志中
			// 将查询请求记入到操作日志表中
			this.addDBOperationRpt(commonService, sqlCondition, "system_table");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "addgroupinfo";
	}

	// 根据角色编号查询角色信息
	public void queryGroupByid() {
		try {
			listJsInfo = this.commonService.find(
					"from XtJsJbxx where type=1 and jsbh=?", Long
							.parseLong(jsbh));
			String sqlCondition = "where jsbh=" + jsbh;// 将查询条件记录到操作日志中
			// 将查询请求记入到操作日志表中
			this.addDBOperationRpt(commonService, sqlCondition, "xt_js_jbxx");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// 根据条件查询用户组
	public String getGroupInfoList() {
		try {
			String sql = "from XtJsJbxx where 1=1 and type=1";
			String sqlCondition = "where zxbz<>2";// 将查询条件记录到操作日志中
			if (jsmc != null && !"".equals(jsmc)) {
				sql += " and Upper(jsmc) like '%" + jsmc.toUpperCase() + "%'";
				sqlCondition += " and jsmc = '" + jsmc + "'";
			}
			sql += " order by ctime desc";
			page = this.commonService.findByPage(sql, pageNo, pageSize);
			allJsInfo = (List<XtJsJbxx>) page.getResult();
			// 将查询请求记入到操作日志表中
			this.addDBOperationRpt(commonService, sqlCondition, "xt_js_jbxx");
		} catch (Exception e) {
			e.printStackTrace();
			return "error";
		}
		return "groupList";
	}
	/*// 根据条件查询用户组
	public String getGroupInfoList() {
		try {
			String sql = "select xjj.JSBH , xjj.JSMC , xjj.JSMS , xjj.ZXBZ , xjj.CTIME , xjj.type from XT_JS_JBXX xjj left join gorup_system_table gst on gst.user_Group_Id = xjj.JSBH where 1=1 ";
			String sqlCondition = "where zxbz<>2";// 将查询条件记录到操作日志中
			if (jsmc != null && !"".equals(jsmc)) {
				sql += " and jsmc like '%" + jsmc + "%'";
				sqlCondition += " and jsmc = '" + jsmc + "'";
			}
			sql += " and xjj.type=1  and gst.system_id= "+getSystemID();
			sql += " order by jsbh";
			page = this.commonService.findByPageForSql(sql, pageNo, pageSize, XtJsJbxx.class);
			allJsInfo = (List<XtJsJbxx>) page.getResult();
			// 将查询请求记入到操作日志表中
			this.addDBOperationRpt(commonService, sqlCondition, "xt_js_jbxx");
		} catch (Exception e) {
			e.printStackTrace();
			return "error";
		}
		return "groupList";
	}*/
	// 跳转到给用户组分配权限
	public String preSentGroupPerssion() {
		try {
			listresources = new ArrayList<Resource>();
			List<SystemTable> listsystem = this.commonService.findByProperty(SystemTable.class, "systemState", "0");
			// 查询和角色关联的nms系统并选中
			List<GorupSystemTable> usergrouplist = null;
			if (!"".equals(jsbh)) {
				usergrouplist = this.commonService.findByProperty(
						GorupSystemTable.class, "userGroupId", Long
								.valueOf(jsbh));
			}
			// 查询用户组下面的nms系统
			for (SystemTable systable : listsystem) {
				Resource re = new Resource();
				// 如果本用户组有这个权限将其选中
				for (GorupSystemTable grouprefsys : usergrouplist) {
					if (systable.getSystemId()
							.equals(grouprefsys.getSystemId())) {
						re.setChecked("checked");
					}
				}
				re.setRsid(systable.getSystemId().toString().trim());
				re.setRsname(systable.getSystemName());
				re.setRsdesc(systable.getSystemDesc());
				// 系统的父id设为0
				re.setParRsCode("0");
				re.setRsCode(systable.getSystemId().toString());
				listresources.add(re);// 添加系统结束
			}

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		if("viewdate".equals(this.action)){
			return "viewdate";
		}else if("viewdateForGuide".equals(this.action)){
			return "viewdateForGuide";
		}
		return "ok";
	}
	
	public void checkUpdate(){
		List list;
		try {
			list = this.commonService.find("from XtJsJbxx where type=1 and jsbh<>? and jsmc=?", role.getJsbh(), role.getJsmc());
			if(list!=null && list.size()>0){
				this.outString("error");
				return;
			}
		} catch (Exception e) {
			e.printStackTrace();
			logger.info("修改用户组校验异常", e);
			this.outString("exception");
		}
		this.outString("success");
	}

	// 给用户组分配权限
	public void giveGroupPerssions() {
		// nms系统id
		String[] nmsSys = mkid.split(",");
		// 先删除跟这个用户组关联的所以nms系统
		try {
			commonService.beginTransaction();
			/*List list = this.commonService.find("from XtJsJbxx where type=1 and jsbh<>? and jsmc=?", role.getJsbh(), role.getJsmc());
			if(list!=null && list.size()>0){
				this.outHtmlString("<script>alert('用户组已存在，请重新输入！');history.back();</script>");
				return;
			}*/
			//保存用户组信息
			XtJsJbxx group = (XtJsJbxx) this.commonService.get(XtJsJbxx.class, role.getJsbh());
			if(role!=null&&!"".equals(role.getJsmc())){
				group.setJsmc(role.getJsmc());
			}
			if(role!=null){
				group.setJsms(role.getJsms());
			}
			if(role!=null&&!"".equals(role.getZxbz())){
				group.setZxbz(role.getZxbz());
			}
			//保存用户组信息修改
			this.commonService.update(group);			
			this.commonService.delete(GorupSystemTable.class, "userGroupId", userGroup.getJsbh());
			
			for (String systemId : nmsSys) {
				GorupSystemTable groupys = new GorupSystemTable();
				if (systemId != null && !"".equals(systemId)) {
					groupys.setSystemId(Long.valueOf(systemId.trim()));
				}
				groupys.setUserGroupId(userGroup.getJsbh());
				this.commonService.save(groupys);
			}
			commonService.commit();
			outHtmlString("<script type=\"text/javascript\">alert('i18n_UserGroupPerssionAction.downloadExample.success_n81i');this.location='userGroupPerssion.do?action=query&pageNo="+pageNo+"&pageSize="+pageSize+"'</script>");
		} catch (Exception e1) {
			commonService.rollback();
			e1.printStackTrace();
			outHtmlString("<script type=\"text/javascript\">alert('i18n_UserGroupPerssionAction.giveGroupPerssions.faild_n81i');this.location='userGroupPerssion.do?action=query&pageNo="+pageNo+"&pageSize="+pageSize+"'</script>");
		}
	}

	public List<Resource> getListresources() {
		return listresources;
	}

	public void setListresources(List<Resource> listresources) {
		this.listresources = listresources;
	}

	public String getAction() {
		return action;
	}

	public void setAction(String action) {
		this.action = action;
	}

	public List<XtJsJbxx> getGroupList() {
		return groupList;
	}

	public void setGroupList(List<XtJsJbxx> groupList) {
		this.groupList = groupList;
	}

	public Page getPage() {
		return page;
	}

	public void setPage(Page page) {
		this.page = page;
	}

	public List getAllJsInfo() {
		return allJsInfo;
	}

	public void setAllJsInfo(List allJsInfo) {
		this.allJsInfo = allJsInfo;
	}

	public int getPageNo() {
		return pageNo;
	}

	public void setPageNo(int pageNo) {
		this.pageNo = pageNo;
	}

	public int getPageSize() {
		return pageSize;
	}

	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}

	public String getJsmc() {
		return jsmc;
	}

	public void setJsmc(String jsmc) {
		this.jsmc = jsmc;
	}

	public List getListJsInfo() {
		return listJsInfo;
	}

	public void setListJsInfo(List listJsInfo) {
		this.listJsInfo = listJsInfo;
	}

	public String getJsbh() {
		return jsbh;
	}

	public void setJsbh(String jsbh) {
		this.jsbh = jsbh;
	}

	public String getMkid() {
		return mkid;
	}

	public void setMkid(String mkid) {
		this.mkid = mkid;
	}

	public XtJsJbxx getUserGroup() {
		return userGroup;
	}

	public void setUserGroup(XtJsJbxx userGroup) {
		this.userGroup = userGroup;
	}

	public List getAllMkInfo() {
		return allMkInfo;
	}

	public void setAllMkInfo(List allMkInfo) {
		this.allMkInfo = allMkInfo;
	}

	public XtJsJbxx getRole() {
		return role;
	}

	public void setRole(XtJsJbxx role) {
		this.role = role;
	}

	public String getFromWhere() {
		return fromWhere;
	}

	public void setFromWhere(String fromWhere) {
		this.fromWhere = fromWhere;
	}

	public String getIsComplete() {
		return isComplete;
	}

	public void setIsComplete(String isComplete) {
		this.isComplete = isComplete;
	}

}
