package nis.nms.web.actions.serverManager;

import java.io.File;
import java.io.FileInputStream;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.apache.struts2.config.Result;
import org.apache.struts2.config.Results;

import nis.nms.domains.ServerIpSegment;
import nis.nms.domains.ServerTable;
import nis.nms.service.CommonService;
import nis.nms.util.BaseAction;
import nis.nms.util.Constant;
import nis.nms.util.ExportUtils;
import nis.nms.util.IpCovert;
import nis.nms.util.Page;


@SuppressWarnings("unchecked")
@Results( { 
	@Result(name="queryServerInfo", value = "/page/systemManage/server/serverInfoList.jsp"),
	@Result(name="openAddServerInfo", value = "/page/systemManage/server/addServerInfo.jsp"),
	@Result(name="openUpdateServerInfo", value = "/page/systemManage/server/updateServerInfo.jsp"),
	@Result(name="showDetail", value = "/page/systemManage/server/detailServerInfo.jsp"),
	@Result(name="showError", value = "/showImportError.jsp")	
})
public class ServerManagerAction extends BaseAction {
	/**
	 * 
	 */
	private Logger logger = Logger.getLogger(ServerManagerAction.class);
	private static final long serialVersionUID = 1L;
	private CommonService commonService;
	
	private int pageNo = 1;
	private int pageSize = this.getDefaultPageSize(); // 每页显示的记录条数
	private Page page;
	
	private String action;// 系统操作
	private String position;
	private List<ServerTable> stList;
	private List<ServerIpSegment> sisList;
	private List objsList;
	private ServerTable serverTable;
	private String sn;
	private String si;
	private Long serverId;
	private Long[] ids;//业务系统id集合
	private String dids;
	
	// 导入节点文件
	private File myFile;
	private String myFileFileName;
	private File myFileUpdate;
	private String myFileUpdateFileName;
	private String operate;
	public String getOperate() {
		return operate;
	}

	public void setOperate(String operate) {
		this.operate = operate;
	}

	public File getMyFileUpdate() {
		return myFileUpdate;
	}

	public void setMyFileUpdate(File myFileUpdate) {
		this.myFileUpdate = myFileUpdate;
	}

	public String getMyFileUpdateFileName() {
		return myFileUpdateFileName;
	}

	public void setMyFileUpdateFileName(String myFileUpdateFileName) {
		this.myFileUpdateFileName = myFileUpdateFileName;
	}

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

	public String getDids() {
		return dids;
	}

	public void setDids(String dids) {
		this.dids = dids;
	}

	public Long[] getIds() {
		return ids;
	}

	public void setIds(Long[] ids) {
		this.ids = ids;
	}

	@Override
	public String executeAction() throws Exception {
		String returnPage = "";
		try {
            // NMSServer管理
			if ("query".equals(this.action)) {// 查看NMSServer列表
				returnPage = queryServerInfo();
			}else 
			if ("openAdd".equals(this.action)) {//打开添加页面
				returnPage = openAdd();
			}else 
			if ("doAdd".equals(this.action)) {//保存添加信息
				returnPage = doAdd();
			}else 
			if ("openUpdate".equals(this.action)) {//打开修改页面
				returnPage = openUpdate();
			}else 
			if ("doUpdate".equals(this.action)) {//保存修改信息
				returnPage = doUpdate();
			}else 
			if ("start".equals(this.action)) {//保存修改信息
				returnPage = start();
			}else 
			if ("stop".equals(this.action)) {//保存修改信息
				returnPage = stop();
			}else 
			if ("detail".equals(this.action)) {//保存修改信息
				returnPage = showDetail();
			}else 
			if ("delete".equals(this.action)) {//保存修改信息
				//returnPage = deleteIpSegment();
			}else 
			if ("downloadExample".equals(this.action)) {
				returnPage = downloadExample();
			}else 
			if ("importXls".equals(this.action)) {
				returnPage = importXls();
			}else 
			if ("emportCurrentXls".equals(this.action)) {
				returnPage = emportCurrentXls();
			}else 
			if ("emportAllXls".equals(this.action)) {
				returnPage = emportAllXls();
			}else 
			if ("importXlsUpdate".equals(this.action)) {
				returnPage = importXlsUpdate();
			}else 
			if ("emportXlsUpdate".equals(this.action)) {
				returnPage = emportXlsUpdate();
			}else 
			if ("downloadExampleUpdate".equals(this.action)) {
				returnPage = downloadExampleUpdate();
			}else if("AjaxCheck".equals(this.action)){
				ajaxCheck();
				return null;
			}else if("checkUpdate".equals(this.action)){
				checkUpdate();
				return null;
			}else{
				returnPage = queryServerInfo();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return returnPage;
	}
	// 模板下载   程辉 2013-5-8新增
	public String downloadExample() {
		try {
			String hql = "select serverName,serverIp,serverDesc from ServerTable ";			
			page = this.commonService.findByPage(hql, 1,3);
			List<ServerTable> st = (List<ServerTable>)page.getResult();
			
			String[] title = { getI18nText("i18n_ServerManagerAction.downloadExample.title.serverName_n81i"),
								getI18nText("i18n_ServerManagerAction.downloadExample.title.serverIp_n81i"),
								getI18nText("i18n_ServerManagerAction.downloadExample.title.serverDesc_n81i") };
	
			String[] colu = { "0", "1","2" };
			ExportUtils m = new ExportUtils();
			m.setAutoSizeColumn(true);
			m.exportExcel(getI18nText("i18n_ServerManagerAction.downloadExample.serverInfoTable_n81i"), st, title, colu,"downloadExample");
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
				ServerTable serverTable = new ServerTable();
				List<String> errorList = new ArrayList<String>();
				Row row = sheet.getRow(i);
				Cell cell_1 = row.getCell((short) 0);
				Cell cell_2 = row.getCell((short) 1);
				Cell cell_3 = row.getCell((short) 2);
				if ((null == cell_1 || 3 == cell_1.getCellType())
						&& (null == cell_2 || 3 == cell_2.getCellType())
						&& (null == cell_3 || 3 == cell_3.getCellType())){
					sum--;
				}else {
					// 服务器名称
					if (null == cell_1) {
						errorInfo +=  getI18nText("i18n_ServerManagerAction.downloadExample.errorInfo1_n81i",i+"");
					} else if (cell_1.getCellType() == Cell.CELL_TYPE_STRING) {
						if ("".equals(cell_1.getStringCellValue())) {
							errorInfo +=  getI18nText("i18n_ServerManagerAction.downloadExample.errorInfo1_n81i",i+"");
						} else {
							String serverName = cell_1.getStringCellValue().trim();
							serverTable.setServerName(serverName);
						}
					} else {
						errorInfo +=  getI18nText("i18n_ServerManagerAction.downloadExample.errorInfo2_n81i",i+"");
					}

					// 服务器IP
					if (null == cell_2) {
						errorInfo +=  getI18nText("i18n_ServerManagerAction.downloadExample.errorInfo3_n81i",i+"");
					} else if (cell_2.getCellType() == Cell.CELL_TYPE_STRING) {
						if ("".equals(cell_2.getStringCellValue())) {
							errorInfo +=  getI18nText("i18n_ServerManagerAction.downloadExample.errorInfo3_n81i",i+"");
						} else {
							String serverIp = cell_2.getStringCellValue()
									.trim();
							serverTable.setServerIp(serverIp);
							
							Pattern patt = Pattern.compile("\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}");
							Matcher mat = patt.matcher(serverIp);
							if (!mat.matches()) {
								errorInfo +=  getI18nText("i18n_ServerManagerAction.downloadExample.errorInfo4_n81i",i+"");
							}
						}
					} else {
						errorInfo +=  getI18nText("i18n_ServerManagerAction.downloadExample.errorInfo5_n81i",i+"");
					}

					// 服务器描述
					if(null == cell_3){
						
					}else if (cell_3.getCellType() == Cell.CELL_TYPE_STRING) {
							String serverDesc = cell_3.getStringCellValue()
									.trim();
							if(serverDesc.length()>256){
								errorInfo +=  getI18nText("i18n_ServerManagerAction.downloadExample.errorInfo6_n81i",i+"");
							}else{
								serverTable.setServerDesc(serverDesc);
							}
					}
					if ("".equals(errorInfo)) {// 保存节点
						errorInfo = this.saveNode(serverTable);
					}
					if ("".equals(errorInfo)) {
						count++;
					} else {
						errorList.add(serverTable.getServerName());
						errorList.add(serverTable.getServerIp());
						errorList.add(serverTable.getServerDesc());
						errorList.add(errorInfo);
						rowList.add(errorList);
						errorInfo = "";

					}
				}
			}
			headerList.add(getI18nText("i18n_ServerManagerAction.downloadExample.serverName_n81i"));
			headerList.add(getI18nText("i18n_ServerManagerAction.downloadExample.serverIp_n81i"));
			headerList.add(getI18nText("i18n_ServerManagerAction.downloadExample.serverDesc_n81i"));
			headerList.add(getI18nText("i18n_ServerManagerAction.downloadExample.errorInfo_n81i"));
			this.getRequest().setAttribute("rowList", rowList);
			this.getRequest().setAttribute("headerList", headerList);
			if (count == sum && sum > 0) {
//				this.getRequest().setAttribute("MSG", 1);
//				return this.queryServerInfo();
				outHtmlString("<script type=\"text/javascript\">alert('i18n_ServerManagerAction.downloadExample.success_n81i');this.location='serverManager.do?action=query'</script>");
				return null;
			} else if (sum == 0) {
				this
						.outHtmlString("<script>alert('i18n_ServerManagerAction.downloadExample.selectFileIsNull_n81i');history.back();</script>");
				return null;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "showError";
	}

	private String saveNode(ServerTable serverTable) {
		String desc = "";
		try {
			// 保存节点信息
			serverTable.setCreateTime(new Date());
			serverTable.setServerState(0L);
			serverTable.setServerIpn(IpCovert.ipToLong(serverTable.getServerIp()));

			//判断服务器名称是否已存在
			List serverNameList = this.commonService.find(
					"from ServerTable where serverName=?", serverTable.getServerName());
			if (serverNameList != null && serverNameList.size() > 0) {
				return getI18nText("i18n_ServerManagerAction.downloadExample.serverNameExists_n81i");
			}
			List serverIpList = this.commonService.find(
					"from ServerTable where serverIp=?", serverTable.getServerIp());
			if (serverIpList != null && serverIpList.size() > 0) {
				return getI18nText("i18n_ServerManagerAction.downloadExample.serverIpExists_n81i");
			}
			this.commonService.save(serverTable);
		} catch (Exception e) {
			e.printStackTrace();
			desc = getI18nText("i18n_ServerManagerAction.downloadExample.nodeInfoImportErr_n81i");
		}
		return desc;
	}
	
	// 当前页导出   程辉 2013-5-8新增
	public String emportCurrentXls() {
		try {
			String hql = "from ServerTable where 1=1 ";
			String sqlCondition = "where 1=1";// 将查询条件记录到操作日志中
			if (StringUtils.isNotEmpty(sn)) {
				hql += " and Upper(serverName) like '%" + sn.toUpperCase() + "%'";
				sqlCondition += " and Upper(serverName) like '%" + sn.toUpperCase() + "%'";
			}
			if (StringUtils.isNotEmpty(si)) {
				hql += " and serverIp like '%" + si + "%'";
				sqlCondition += " and serverIp like '%" + si + "%'";
			}
			hql += "order by serverState";
			page = this.commonService.findByPage(hql, pageNo,pageSize);
			List<ServerTable> stList = (ArrayList<ServerTable>)page.getResult();
			
			for(int i=0;i<stList.size();i++){
				if(stList.get(i).getServerState()==0){
					stList.get(i).setServerDesc(getI18nText("i18n_ServerManagerAction.downloadExample.Y_n81i"));
				}
				if(stList.get(i).getServerState()==1){
					stList.get(i).setServerDesc(getI18nText("i18n_ServerManagerAction.downloadExample.N_n81i"));
				}
			}
			
			String[] title = { getI18nText("i18n_ServerManagerAction.downloadExample.serverName_n81i"),
								getI18nText("i18n_ServerManagerAction.downloadExample.serverIp_n81i"),
								getI18nText("i18n_ServerManagerAction.downloadExample.title1.createTime_n81i"),
								getI18nText("i18n_ServerManagerAction.downloadExample.title1.isOnline_n81i") };
	
			String[] colu = { "serverName", "serverIp","createTime","serverDesc"};
			String url = "serverManager.do?action=query&sn="+sn+"&si="+si+"&pageSize="+pageSize+"&pageNo="+pageNo;
			ExportUtils m = new ExportUtils();
			m.setAutoSizeColumn(true);
			m.exportExcel(url,getI18nText("i18n_ServerManagerAction.downloadExample.serverInfoTable_n81i"), stList, title, colu);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	// 导出全部   程辉 2013-5-8新增
	public String emportAllXls() {
		try {
			String hql = "from ServerTable where 1=1 ";
			String sqlCondition = "where 1=1";// 将查询条件记录到操作日志中
			if (StringUtils.isNotEmpty(sn)) {
				hql += " and Upper(serverName) like '%" + sn.toUpperCase() + "%'";
				sqlCondition += " and Upper(serverName) like '%" + sn.toUpperCase() + "%'";
			}
			if (StringUtils.isNotEmpty(si)) {
				hql += " and serverIp like '%" + si + "%'";
				sqlCondition += " and serverIp like '%" + si + "%'";
			}
			hql += "order by serverState";
			List<ServerTable> stList = this.commonService.find(hql);
			
			for(int i=0;i<stList.size();i++){
				if(stList.get(i).getServerState()==0){
					stList.get(i).setServerDesc(getI18nText("i18n_ServerManagerAction.downloadExample.Y_n81i"));
				}
				if(stList.get(i).getServerState()==1){
					stList.get(i).setServerDesc(getI18nText("i18n_ServerManagerAction.downloadExample.N_n81i"));
				}
			}
			
			String[] title = { getI18nText("i18n_ServerManagerAction.downloadExample.serverName_n81i"),
					getI18nText("i18n_ServerManagerAction.downloadExample.serverIp_n81i"),
					getI18nText("i18n_ServerManagerAction.downloadExample.title1.createTime_n81i"),
					getI18nText("i18n_ServerManagerAction.downloadExample.title1.isOnline_n81i") };
	
			String[] colu = { "serverName", "serverIp","createTime","serverDesc"};
			String url = "serverManager.do?action=query&sn="+sn+"&si="+si+"&pageSize="+pageSize+"&pageNo="+pageNo;
			ExportUtils m = new ExportUtils();
			m.setAutoSizeColumn(true);
			m.exportExcel(url,getI18nText("i18n_ServerManagerAction.downloadExample.serverInfoTable_n81i"), stList, title, colu);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	// 修改页面导入 程辉 2013-5-9新增
	public String importXlsUpdate() {
		String errorInfo = "";
		try {
			List<String> headerList = new ArrayList<String>();
			List<List<String>> rowList = new ArrayList<List<String>>();

			List iplist = this.commonService.executeSQL("select * from server_ip_segment where server_id="+serverId);
			if(null!=iplist&&iplist.size()>0&&operate.equals("all")){				
				this.commonService.executeSQLDelete("delete from server_ip_segment where server_id="+serverId);
			}
			
			Workbook workbook = null;
			if (myFileUpdateFileName.endsWith(".xlsx")) {
				workbook = new XSSFWorkbook(new FileInputStream(myFileUpdate));
			} else {
				// 创建对Excel工作簿文件的引用
				workbook = new HSSFWorkbook(new FileInputStream(myFileUpdate));
			}

			// 创建对工作表的引用，得到表的第一页
			Sheet sheet = workbook.getSheetAt(0);
			// 读取左上端单元

			// 记录存储数据条数
			int count = 0;
			// 记录读入excel数据条数
			int sum = (sheet.getLastRowNum());
			for (short i = 1; i <= sheet.getLastRowNum(); i++) {
				ServerIpSegment serverIpSegment = new ServerIpSegment();
				List<String> errorList = new ArrayList<String>();
				Row row = sheet.getRow(i);
				Cell cell_1 = row.getCell((short) 0);
				Cell cell_2 = row.getCell((short) 1);
				if ((null == cell_1 || 3 == cell_1.getCellType())
						&& (null == cell_2 || 3 == cell_2.getCellType())) {
					sum--;
				}else {					
					// 起始IP
					if (null == cell_1) {
						errorInfo +=  getI18nText("i18n_ServerManagerAction.downloadExample.errorInfo7_n81i",i+"");
					} else if (cell_1.getCellType() == Cell.CELL_TYPE_STRING) {
						if ("".equals(cell_1.getStringCellValue())) {
							errorInfo +=  getI18nText("i18n_ServerManagerAction.downloadExample.errorInfo7_n81i",i+"");
						} else {
							String startIp = cell_1.getStringCellValue()
									.trim();
							serverIpSegment.setStartIp(startIp);
							
							Pattern patt = Pattern.compile("\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}");
							Matcher mat = patt.matcher(startIp);
							if (!mat.matches()) {
								errorInfo +=  getI18nText("i18n_ServerManagerAction.downloadExample.errorInfo8_n81i",i+"");
							}
						}
					} else {
						errorInfo +=  getI18nText("i18n_ServerManagerAction.downloadExample.errorInfo9_n81i",i+"");
					}

					// 结束IP
					if (null == cell_2) {
						errorInfo += getI18nText("i18n_ServerManagerAction.downloadExample.errorInfo10_n81i",i+"");
					} else if (cell_2.getCellType() == Cell.CELL_TYPE_STRING) {
						if ("".equals(cell_2.getStringCellValue())) {
							errorInfo +=  getI18nText("i18n_ServerManagerAction.downloadExample.errorInfo10_n81i",i+"");
						} else {
							String endIp = cell_2.getStringCellValue()
									.trim();
							serverIpSegment.setEndIp(endIp);
							
							Pattern patt = Pattern.compile("\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}");
							Matcher mat = patt.matcher(endIp);
							if (!mat.matches()) {
								errorInfo += getI18nText("i18n_ServerManagerAction.downloadExample.errorInfo11_n81i",i+"");
							}
						}
					} else {
						errorInfo +=  getI18nText("i18n_ServerManagerAction.downloadExample.errorInfo12_n81i",i+"");
					}
					
					if ("".equals(errorInfo)) {// 保存节点
						errorInfo = this.saveNodeUpdate(serverIpSegment);
					}
					if ("".equals(errorInfo)) {
						count++;
					} else {
						errorList.add(serverIpSegment.getStartIp());
						errorList.add(serverIpSegment.getEndIp());
						errorList.add(errorInfo);
						rowList.add(errorList);
						errorInfo = "";

					}
				}
			}
			headerList.add(getI18nText("i18n_ServerManagerAction.downloadExample.startIp_n81i"));
			headerList.add(getI18nText("i18n_ServerManagerAction.downloadExample.endIp_n81i"));
			headerList.add(getI18nText("i18n_ServerManagerAction.downloadExample.errorInfo_n81i"));
			this.getRequest().setAttribute("rowList", rowList);
			this.getRequest().setAttribute("headerList", headerList);
			if (count == sum && sum > 0) {
//				this.getRequest().setAttribute("MSG", 1);
//				return this.queryServerInfo();
				outHtmlString("<script type=\"text/javascript\">alert('i18n_ServerManagerAction.downloadExample.success_n81i');this.location='serverManager.do?action=query'</script>");
				return null;
			} else if (sum == 0) {
				this
						.outHtmlString("<script>alert('i18n_ServerManagerAction.downloadExample.selectFileIsNull_n81i');history.back();</script>");
				return null;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "showError";
	}

	private String saveNodeUpdate(ServerIpSegment serverIpSegment) {
		String desc = "";
		try {
			// 保存节点信息
			serverIpSegment.setStartIpn(IpCovert.ipToLong(serverIpSegment.getStartIp()));
			serverIpSegment.setEndIpn(IpCovert.ipToLong(serverIpSegment.getEndIp()));
			ServerTable serverTable = new ServerTable();
			serverTable.setId(serverId);
			serverIpSegment.setServerTable(serverTable);
			
			if(serverIpSegment.getStartIpn()>serverIpSegment.getEndIpn()){
				return getI18nText("i18n_ServerManagerAction.downloadExample.inputIpErr_n81i");
			}
			List objsList = commonService.executeSQL("select st.server_name,sis.start_ipn,sis.end_ipn from server_ip_segment sis left join server_table st on st.id = sis.server_id");
			for(Object object : objsList){
				Object[] obj =(Object[])object;
				 if(serverIpSegment.getStartIpn()>Long.parseLong(obj[2].toString())||serverIpSegment.getEndIpn()<Long.parseLong(obj[1].toString())){
					 
				 }else{
					 return getI18nText("i18n_ServerManagerAction.downloadExample.serverIpRepeat_n81i")+":"+obj[0];
				 }
			}
			
			this.commonService.save(serverIpSegment);
		} catch (Exception e) {
			e.printStackTrace();
			desc = getI18nText("i18n_ServerManagerAction.downloadExample.nodeInfoImportErr_n81i");
		}
		return desc;
	}
	
	// 修改页面导出   程辉 2013-5-9新增
	public String emportXlsUpdate() {
		try {
			String sql = "select sis.start_ip,sis.end_ip from server_ip_segment sis left join server_table st on st.id = sis.server_id where st.server_state = 0 order by st.server_name desc";			
			List<ServerTable> st = this.commonService.executeSQL(sql);
			
			String[] title = { getI18nText("i18n_ServerManagerAction.downloadExample.startIp_n81i"),
								getI18nText("i18n_ServerManagerAction.downloadExample.endIp_n81i") };
	
			String[] colu = { "0", "1" };
			ExportUtils m = new ExportUtils();
			m.setAutoSizeColumn(true);
			m.exportExcel(getI18nText("i18n_ServerManagerAction.downloadExample.serverDetecateInfo_n81i"), st, title, colu);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	// 修改页面模板下载   程辉 2013-5-9新增
	public String downloadExampleUpdate() {
		try {
			/*String sql = "select sis.start_ip,sis.end_ip from server_ip_segment sis left join server_table st on st.id = sis.server_id where st.server_state = 0 and rownum<4 order by st.server_name desc";*/			
			String sql = "select sis.start_ip,sis.end_ip from server_ip_segment sis left join server_table st on st.id = sis.server_id where st.server_state = 0 ";			
			//@2018年4月10日18:45:00 fang 修改rownum 适配 mysql
			if(Constant.IS_MYSQL){
				sql = sql + " order by st.server_name desc limit 3";
			}else{
				sql = sql + " and rownum<4 order by st.server_name desc";
			}
			List<ServerTable> st = this.commonService.executeSQL(sql);
			
			String[] title = { getI18nText("i18n_ServerManagerAction.downloadExample.startIp_n81i"),
					getI18nText("i18n_ServerManagerAction.downloadExample.endIp_n81i") };
	
			String[] colu = { "0", "1"};
			ExportUtils m = new ExportUtils();
			m.setAutoSizeColumn(true);
			m.exportExcel(getI18nText("i18n_ServerManagerAction.downloadExample.serverDetecateInfo_n81i"), st, title, colu,"downloadExample");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}	
	
	public String stop(){
		try {
			commonService.beginTransaction();
			if(ids !=null && ids.length>0){
				for(int i= 0;i<ids.length;i++){
					List serverList = this.commonService.find(
							"from ServerTable where id=?", ids[i]);
					
					if(serverList!=null && serverList.size()>0){
						ServerTable st = (ServerTable)serverList.get(0);
						st.setServerState(1l);
						
						this.commonService.update(st);
						
						//将更新操作写到操作日志中
						this.addDBOperationRpt(commonService, "Server_Table", "UPDATE", st.getId());
						ServerTable serverTable = (ServerTable) commonService.get(ServerTable.class, ids[i]);
						
						//将DC变更发送到DC
						this.sendDataControllerReset(ids[i], serverTable.getServerIp(), commonService);
					}	
				}
			}
			commonService.commit();
		} catch (Exception e) {
			commonService.rollback();
			e.printStackTrace();
		}
		outHtmlString("<script type=\"text/javascript\">alert('i18n_ServerManagerAction.downloadExample.success_n81i');" +
				"this.location='serverManager.do?action=query&pageNo=" + pageNo +
				"&pageSize=" + pageSize + "'</script>");
		return null;
	}
	
	public String start(){
		try {
			commonService.beginTransaction();
			if(ids !=null && ids.length>0){
				for(int i= 0;i<ids.length;i++){
					List serverList = this.commonService.find(
							"from ServerTable where id=?", ids[i]);
					
					if(serverList!=null && serverList.size()>0){
						ServerTable st = (ServerTable)serverList.get(0);
						st.setServerState(0l);
						
						this.commonService.update(st);
						
						//将更新操作写到操作日志中
						this.addDBOperationRpt(commonService, "Server_Table", "UPDATE", st.getId());
						ServerTable serverTable = (ServerTable) commonService.get(ServerTable.class, ids[i]);
						
						//将DC变更发送到DC
						this.sendDataControllerReset(ids[i], serverTable.getServerIp(), commonService);
					}	
				}
			}
			commonService.commit();
		} catch (Exception e) {
			commonService.rollback();
			e.printStackTrace();
		}
		outHtmlString("<script type=\"text/javascript\">alert('i18n_ServerManagerAction.downloadExample.success_n81i');" +
				"this.location='serverManager.do?action=query&pageNo=" + pageNo +
				"&pageSize=" + pageSize + "'</script>");
		return null;
	}
	
	public String showDetail(){
		if(serverId ==null){
			if(ids!=null && ids.length>0){
				serverId = ids[0];
			}else{
				this.outHtmlString("<script>alert('i18n_ServerManagerAction.downloadExample.dataIdInvalid_n81i');history.back();</script>");
				return null;
			}
		}
		try {
//			objsList = commonService.executeSQL("select sis.id,sis.server_id,st.server_name,st.server_state,sis.start_ip,sis.start_ipn,sis.end_ip,sis.end_ipn from server_ip_segment sis left join server_table st on st.id = sis.server_id where sis.server_id <> "+serverId);
			objsList = commonService.executeSQL("select sis.id,sis.server_id,st.server_name,st.server_state,sis.start_ip,sis.start_ipn,sis.end_ip,sis.end_ipn from server_ip_segment sis left join server_table st on st.id = sis.server_id where sis.server_id = "+serverId);
//			getRequest().setAttribute("objsList1", objsList1);
			serverTable = (ServerTable) commonService.get(ServerTable.class, serverId);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "showDetail";
	}
	
	public String queryServerInfo(){
		try {
			String hql = "from ServerTable where 1=1 ";
			String sqlCondition = "where 1=1";// 将查询条件记录到操作日志中
			if (StringUtils.isNotEmpty(sn)) {
				hql += " and Upper(serverName) like '%" + sn.toUpperCase() + "%'";
				sqlCondition += " and Upper(serverName) like '%" + sn.toUpperCase() + "%'";
			}
			if (StringUtils.isNotEmpty(si)) {
				hql += " and serverIp like '%" + si + "%'";
				sqlCondition += " and serverIp like '%" + si + "%'";
			}
			hql += "order by serverState";
			page = this.commonService.findByPage(hql, pageNo,pageSize);
			stList = (ArrayList<ServerTable>)page.getResult();

			// 将查询请求记入到操作日志表中
			this.addDBOperationRpt(commonService, sqlCondition,	"ServerTable");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "queryServerInfo";
	}
	
	public String openAdd(){
		try {
			objsList = commonService.executeSQL("select sis.id,sis.server_id,st.server_name,st.server_state,sis.start_ip,sis.start_ipn,sis.end_ip,sis.end_ipn from server_ip_segment sis left join server_table st on st.id = sis.server_id");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "openAddServerInfo";
	}
	
	public void ajaxCheck(){
		List list;
		try {
			list = commonService.find("from ServerTable where serverIp = ? or serverName = ? ", serverTable.getServerIp(),serverTable.getServerName());
			if(list!=null && list.size()>0){
				this.outString("error");
				return ;
			}
		} catch (Exception e) {
			e.printStackTrace();
			logger.info("新增DC范围配置校验异常", e);
			this.outString("exception");
		}
		this.outString("success");
	}
	
	public String doAdd(){
		try {
			commonService.beginTransaction();
			/*List list =  commonService.find("from ServerTable where serverIp = ? or serverName = ? ", serverTable.getServerIp(),serverTable.getServerName());
			
			if(list!=null && list.size()>0){
				this.outHtmlString("<script>alert('服务器名称或IP已存在，不可重复，请修改');history.back();</script>");
				return null;
			}*/
			serverTable.setServerState(0l);
			serverTable.setCreateTime(new Date());
			serverTable.setServerIpn(IpCovert.ipToLong(serverTable.getServerIp()));
			commonService.save(serverTable);
			// 将新增操作写到操作日志中
			this.addDBOperationRpt(commonService,"server_table", "INSERT", serverTable.getId());
			
			if(sisList!=null){
				for(ServerIpSegment segment : sisList){
					if(segment!=null){
						System.out.println(segment.getStartIp()+"  "+segment.getEndIp());
						segment.setServerTable(serverTable);
						segment.setStartIpn(IpCovert.ipToLong(segment.getStartIp()));
						segment.setEndIpn(IpCovert.ipToLong(segment.getEndIp()));
						commonService.save(segment);
						// 将新增操作写到操作日志中
						this.addDBOperationRpt(commonService,"server_ip_segment", "INSERT", segment.getId());
					}
				}
			}
			
			//将DC变更发送到DC
			this.sendDataControllerReset(serverTable.getId(), serverTable.getServerIp(), commonService);
			commonService.commit();
		} catch (Exception e) {
			commonService.rollback();
			e.printStackTrace();
			logger.info("DC范围配置新增失败！", e);
			outHtmlString("<script type=\"text/javascript\">alert('i18n_ServerManagerAction.downloadExample.faild_n81i');" +
					"this.location='serverManager!executeAction.do?action=openAdd&pageNo=" + pageNo +
					"&pageSize=" + pageSize + "'</script>");
		}
		outHtmlString("<script type=\"text/javascript\">alert('i18n_ServerManagerAction.downloadExample.success_n81i');" +
				"this.location='serverManager.do?action=query&pageNo=" + pageNo +
				"&pageSize=" + pageSize + "'</script>");
		return null;
	}
	
	public String openUpdate(){
		if(serverId ==null){
			if(ids!=null && ids.length>0){
				serverId = ids[0];
			}else{
				this.outHtmlString("<script>alert('i18n_ServerManagerAction.downloadExample.dataIdInvalid_n81i');history.back();</script>");
				return null;
			}
		}
		try {
			objsList = commonService.executeSQL("select sis.id,sis.server_id,st.server_name,st.server_state,sis.start_ip,sis.start_ipn,sis.end_ip,sis.end_ipn from server_ip_segment sis left join server_table st on st.id = sis.server_id where sis.server_id <> "+serverId);
			List objsList1 = commonService.executeSQL("select sis.id,sis.server_id,st.server_name,st.server_state,sis.start_ip,sis.start_ipn,sis.end_ip,sis.end_ipn from server_ip_segment sis left join server_table st on st.id = sis.server_id where sis.server_id = "+serverId);
			getRequest().setAttribute("objsList1", objsList1);
			serverTable = (ServerTable) commonService.get(ServerTable.class, serverId);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "openUpdateServerInfo";
	}
	
//	public String deleteIpSegment(){
//		try {
//			String dids = getRequest().getParameter("dids");
//			String sid = getRequest().getParameter("sid");
//			List<ServerTable>  serverTableList =commonService.find("from ServerTable where id in (select sis.serverTable.id from ServerIpSegment sis where sis.id in("+dids+"))");
//			
//			if(StringUtils.isNotBlank(dids)){
//				commonService.delete("delete from ServerIpSegment sis where sis.id in ("+dids+")");
//			}
//
//			for(ServerTable table :serverTableList){
//				//将DC变更发送到DC
//				this.sendDataControllerReset(table.getId(), table.getServerIp(), commonService);
//			}
//		} catch (Exception e) {
//			e.printStackTrace();
//			outHtmlString("1");
//			return null;			
//		}
//		outHtmlString("0");
//		return null;
//	}
	
	public void checkUpdate(){
		List list;
		try {
			list = commonService.find("from ServerTable where (serverIp = ? or serverName = ?) and id <> ?", serverTable.getServerIp(),serverTable.getServerName(),serverTable.getId());
			if(list!=null && list.size()>0){
				this.outString("error");
				return ;
			}
		} catch (Exception e) {
			e.printStackTrace();
			logger.info("修改DC范围配置校验异常",e);
			this.outString("exception");
		}
		this.outString("success");
	}
	
	public String doUpdate(){
		
		try {
			commonService.beginTransaction();
			/*List list =  commonService.find("from ServerTable where (serverIp = ? or serverName = ?) and id <> ?", serverTable.getServerIp(),serverTable.getServerName(),serverTable.getId());
			
			if(list!=null && list.size()>0){
				this.outHtmlString("<script>alert('服务器名称或IP已存在，不可重复，请修改');history.back();</script>");
				return null;
			}*/
			
			//判断前台有无删除操作  若有在提交时删除数据
			if (null != dids && !dids.equals("")) {
				List<ServerTable> serverTableList = commonService
						.find("from ServerTable where id in (select sis.serverTable.id from ServerIpSegment sis where sis.id in("
								+ dids + "))");

				if (StringUtils.isNotBlank(dids)) {
					commonService
							.delete("delete from ServerIpSegment sis where sis.id in ("
									+ dids + ")");
					System.out
							.println("删除sql语句："
									+ "delete from ServerIpSegment sis where sis.id in ("
									+ dids + ")");
				}
				for (ServerTable table : serverTableList) {
					// 将DC变更发送到DC
					this.sendDataControllerReset(table.getId(), table
							.getServerIp(), commonService);
				}
			}
			ServerTable table = (ServerTable) commonService.get(ServerTable.class,serverTable.getId());
			table.setServerName(serverTable.getServerName());
			table.setServerDesc(serverTable.getServerDesc());
			table.setServerState(serverTable.getServerState());
			String oldIP = table.getServerIp();
			String newIP = serverTable.getServerIp();
			table.setServerIp(serverTable.getServerIp());
			table.setServerIpn(IpCovert.ipToLong(serverTable.getServerIp()));
			commonService.update(table);
			// 将更新操作写到操作日志中
			this.addDBOperationRpt(commonService,"server_table", "UPDATE", table.getId());
	//		System.out.println("sisList length is "+ sisList.size());
			if(sisList!=null){
				for(ServerIpSegment segment : sisList){
					if(segment!=null){
						System.out.println("新增元素："+segment.getStartIp()+"  "+segment.getEndIp());
						segment.setServerTable(serverTable);
						segment.setStartIpn(IpCovert.ipToLong(segment.getStartIp()));
						segment.setEndIpn(IpCovert.ipToLong(segment.getEndIp()));
						commonService.save(segment);
						// 将新增操作写到操作日志中
						this.addDBOperationRpt(commonService,"server_ip_segment", "INSERT", segment.getId());
					}
				}
			}
			//待完善web 控制DC的业务
			if(oldIP!= null && oldIP.equals(newIP)){
				//将DC变更发送到DC
				this.sendDataControllerReset(table.getId(), newIP, commonService);
			}else{
				//将DC变更发送到DC
				this.sendDataControllerReset(table.getId(), newIP, commonService);
				//将DC变更发送到DC
//				this.sendDataControllerReset(table.getId(), oldIP, commonService);
			}
			commonService.commit();
		} catch (Exception e) {
			commonService.rollback();
			e.printStackTrace();
			logger.info("DC范围配置修改失败",e);
			outHtmlString("<script type=\"text/javascript\">alert('i18n_ServerManagerAction.downloadExample.faild_n81i');" +
					"this.location='serverManager.do?action=query&pageNo=" + pageNo +
					"&pageSize=" + pageSize + "'</script>");
			return null;
		}
		
		outHtmlString("<script type=\"text/javascript\">alert('i18n_ServerManagerAction.downloadExample.success_n81i');" +
				"this.location='serverManager.do?action=query&pageNo=" + pageNo +
				"&pageSize=" + pageSize + "'</script>");
		return null;
	}
	
	public CommonService getCommonService() {
		return commonService;
	}

	public void setCommonService(CommonService commonService) {
		this.commonService = commonService;
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

	public Page getPage() {
		return page;
	}

	public void setPage(Page page) {
		this.page = page;
	}

	public String getAction() {
		return action;
	}

	public void setAction(String action) {
		this.action = action;
	}

	public String getPosition() {
		return position;
	}

	public void setPosition(String position) {
		this.position = position;
	}

	public ServerTable getServerTable() {
		return serverTable;
	}

	public void setServerTable(ServerTable serverTable) {
		this.serverTable = serverTable;
	}

	public String getSn() {
		return sn;
	}

	public void setSn(String sn) {
		this.sn = sn;
	}

	public String getSi() {
		return si;
	}

	public void setSi(String si) {
		this.si = si;
	}

	public List<ServerTable> getStList() {
		return stList;
	}

	public void setStList(List<ServerTable> stList) {
		this.stList = stList;
	}

	public List<ServerIpSegment> getSisList() {
		return sisList;
	}

	public void setSisList(List<ServerIpSegment> sisList) {
		this.sisList = sisList;
	}

	public Long getServerId() {
		return serverId;
	}

	public void setServerId(Long serverId) {
		this.serverId = serverId;
	}

	public List getObjsList() {
		return objsList;
	}

	public void setObjsList(List objsList) {
		this.objsList = objsList;
	}

}
