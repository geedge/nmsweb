package nis.nms.web.actions.detection;

import java.io.File;
import java.io.FileInputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Locale;

import org.apache.log4j.Logger;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.apache.struts2.config.Result;
import org.apache.struts2.config.Results;

import com.nms.objectSnmp.action.SnmpAction;
import com.nms.objectSnmp.util.EntityInfo;
import com.nms.objectSnmp.util.FileUtil;
import com.nms.objectSnmp.util.FormatUtil;

import nis.nms.domains.CheckTypeInfo;
import nis.nms.domains.GorupSystemTable;
import nis.nms.domains.Metadata;
import nis.nms.domains.SystemTable;
import nis.nms.domains.XtJsJbxx;
import nis.nms.domains.XtYhJsIndex;
import nis.nms.filter.I18n;
import nis.nms.service.CommonService;
import nis.nms.util.BaseAction;
import nis.nms.util.ExportUtils;
import nis.nms.util.Page;


@SuppressWarnings("unchecked")
@Results( { 	
	@Result(name="queryCheckTypeSetInfoChild", value = "/page/detection/checkType/checkTypeSetInfoListChild.jsp"),
	@Result(name="queryCheckTypeSetInfo", value = "/page/detection/checkType/checkTypeSetInfoList.jsp"),
	@Result(name="addCheckTypeSetInfo", value = "/page/detection/checkType/addCheckTypeSetInfo.jsp"),
	@Result(name="updateCheckTypeSetInfo", value = "/page/detection/checkType/updateCheckTypeSetInfo.jsp"),
	@Result(name="detailCheckTypeSetInfo", value = "/page/detection/checkType/detailPoliceSetInfo.jsp"),
	@Result(name="addCheckTypeSource", value = "/page/detection/checkType/addCheckTypeSource.jsp"),
	@Result(name="updCheckTypeSource", value = "/page/detection/checkType/updCheckTypeSource.jsp"),
	@Result(name = "showError", value = "/showImportError.jsp"),
	@Result(name="error", value ="/error.jsp")
})


public class CheckTypeSetAction extends BaseAction {
	private Logger logger = Logger.getLogger(CheckTypeSetAction.class);
	private static final long serialVersionUID = 1L;
	private CommonService commonService;
	private int pageNo = 1;
	private int pageSize =this.getDefaultPageSize();		//每页显示的记录条数
	private Page page;
	private String action;
	private List<CheckTypeInfo> checkTypeSetList;
	private CheckTypeInfo checkTypeInfo;
	private Long[] ids;
	private String ctn;
	private String isHaveTable;
	private SystemTable systemTable;
	private List<XtJsJbxx> usergroupLists = new ArrayList<XtJsJbxx>();
	private String isAdmin;
	private List<CheckTypeInfo> allCheckTypeInfo;
	private String replace;
	private FileUtil fileUtil = new FileUtil();
	private String checkTypeIden;
	
	private String fromWhere;
	private String isComplete;
	
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
	
	@Override
	public String executeAction() throws Exception {
		String resultpage = "";
		this.getRequest().setAttribute("ADMFlag", this.getAdminMark());
		this.getRequest().setAttribute("fromWhere", fromWhere);
		if("query".equals(this.action)){
			queryCheckTypeInfo();
			resultpage = this.queryCheckTypeSetInfo();
		}else if("queryChild".equals(this.action)){
			queryCheckTypeInfo();
			resultpage = this.queryCheckTypeSetInfoChild();
		}else if("openAdd".equals(this.action)){
			getNMSsystem();
			this.getRequest().setAttribute("fromWhere", fromWhere);
			checkTypeIden = getCheckTypeIden();
			resultpage = "addCheckTypeSetInfo";
		}else if("doAdd".equals(this.action)){
			addCheckTypeSetInfo();
			return null;
		}else if("openUpdate".equals(this.action)){
			getNMSsystem();
			resultpage = this.openUpdateCheckTypeSet();
		}else if("doUpdate".equals(this.action)){
			doUpdateCheckTypeSet();
			return null;
		}else if("del".equals(this.action)){
			delCheckTypeSetInfo();
			return null;
		}else if ("downloadExample".equals(this.action)) {
			resultpage = downloadExample();
		}else if ("importXls".equals(this.action)) {
			resultpage = importXls();
		}else if ("emportCurrentXls".equals(this.action)) {
			resultpage = emportCurrentXls();
		}else if ("emportAllXls".equals(this.action)) {
			resultpage = emportAllXls();
		}else if("updateCheck".equals(this.action)){
			updateCheck();
			return null;
		}else{
			queryCheckTypeInfo();
			resultpage = this.queryCheckTypeSetInfo();
		}
		return resultpage;
	}
	

	// 模板下载   程辉 2013-5-13新增
	public String downloadExample() {
		try {			
			StringBuffer hql = new StringBuffer();
			if(this.getAdminMark()){//如果是admin登陆则无限制
				hql.append("select checkTypeName,checkTypeName1,checkRemark,tableName,tableComments,viewLevel,groupId,isSnmp,snmpOID from CheckTypeInfo where isSchedule<>2 ");
				isAdmin ="true";
			}else{
				isAdmin="false";
				//权限控制--------begin
				hql.append("select checkTypeName,checkTypeName1,checkRemark,tableName,tableComments,viewLevel,groupId,isSnmp,snmpOID from CheckTypeInfo t where isSchedule<>2 and (( t.viewLevel=1 and t.userId=");
				hql.append(this.getUserID());
				hql.append(" and t.systemId ="+this.getSystemID()+")");
				hql.append(" or ( t.viewLevel=2 and t.groupId in (select  x.jsbh from  XtYhJsIndex  x  where x.yhbh='");
				hql.append(this.getUser().getYhbh());
				hql.append("' and x.type = 1) and t.systemId = "+this.getSystemID()+") or (t.viewLevel=3 and t.systemId = "+this.getSystemID()+")");
				hql.append(" or (t.viewLevel=4 )");
				hql.append(") ");
			}
			hql.append(" order by isSchedule asc , createTime desc");
			page = this.commonService.findByPage(hql.toString(), 1, 3);
			List st = (List) page.getResult();
			
			List<XtJsJbxx> grouplist = commonService.find("from XtJsJbxx");
			
		
			for (int i = 0; i < grouplist.size(); i++) {
				for (int j = 0; j < st.size(); j++) {
					if(grouplist.get(i).getJsbh().equals(((Object[])st.get(j))[6])){
						((Object[])st.get(j))[6] = grouplist.get(i).getJsmc();
					}
				}
			}
			
			String[] title = {getI18nText("i18n_CheckTypeSetAction.downloadExample.title.monitorType_n81i"), 
					getI18nText("i18n_CheckTypeSetAction.downloadExample.title.monitorTypeName_n81i"),
					getI18nText("i18n_CheckTypeSetAction.downloadExample.title.remark_n81i"),
					getI18nText("i18n_CheckTypeSetAction.downloadExample.title.mapTable_n81i"),
					getI18nText("i18n_CheckTypeSetAction.downloadExample.title.tableDesc_n81i"),
					getI18nText("i18n_CheckTypeSetAction.downloadExample.title.viewPrivilage_n81i"),
					getI18nText("i18n_CheckTypeSetAction.downloadExample.title.userGroup_n81i"),
					getI18nText("i18n_CheckTypeSetAction.downloadExample.title.snmpMonitor_n81i"),
								"OID"};
	
			String[] colu = { "0", "1","2","3","4","5","6","7","8"};
			ExportUtils m = new ExportUtils();
			m.setAutoSizeColumn(true);
			m.exportExcel2Sheet(getI18nText("i18n_CheckTypeSetAction.downloadExample.sheet_n81i"), st, title, colu);
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
			List<String> headerList1 = new ArrayList<String>();
			List<List<String>> rowList1 = new ArrayList<List<String>>();
			
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
				String checkTypeName = "";
				String checkTypeName1= "";
				String checkRemark= "";
				String tableName= "";
				String tableComments= "";
				long viewLevel=-25l;
				String groupName="";
				long isSnmp=-25l;
				String snmpOID= "";
				List<String> errorList = new ArrayList<String>();
				Row row = sheet.getRow(i);
				Cell cell_1 = row.getCell((short) 0);
				Cell cell_2 = row.getCell((short) 1);
				Cell cell_3 = row.getCell((short) 2);
				Cell cell_4 = row.getCell((short) 3);
				Cell cell_5 = row.getCell((short) 4);
				Cell cell_6 = row.getCell((short) 5);
				Cell cell_7 = row.getCell((short) 6);
				Cell cell_8 = row.getCell((short) 7);
				Cell cell_9 = row.getCell((short) 8);
				if ((null == cell_1 || 3 == cell_1.getCellType())
						&& (null == cell_2 || 3 == cell_2.getCellType())
						&& (null == cell_3 || 3 == cell_3.getCellType())
						&& (null == cell_4 || 3 == cell_4.getCellType())
						&& (null == cell_5 || 3 == cell_5.getCellType())
						&& (null == cell_6 || 3 == cell_6.getCellType())
						&& (null == cell_7 || 3 == cell_7.getCellType())
						&& (null == cell_8 || 3 == cell_8.getCellType())
						&& (null == cell_9 || 3 == cell_9.getCellType())) {
					sum--;
				}else {
					// 监测类别
					if (null == cell_1) {
						errorInfo += getI18nText("i18n_CheckTypeSetAction.downloadExample.errorInfo.line_n81i",i+"")+ getI18nText("i18n_CheckTypeSetAction.downloadExample.errorInfo1_n81i",1+"");
					} else if (cell_1.getCellType() == Cell.CELL_TYPE_STRING) {
						if ("".equals(cell_1.getStringCellValue())) {
							errorInfo += getI18nText("i18n_CheckTypeSetAction.downloadExample.errorInfo.line_n81i",i+"")+getI18nText("i18n_CheckTypeSetAction.downloadExample.errorInfo1_n81i",1+"");
						} else {
							checkTypeName = cell_1.getStringCellValue().trim();
						}
					} else {
						errorInfo +=  getI18nText("i18n_CheckTypeSetAction.downloadExample.errorInfo.line_n81i",i+"")+getI18nText("i18n_CheckTypeSetAction.downloadExample.errorInfo2_n81i",1+"");
					}
					
					// 监测类别名称
					if (null == cell_2) {
						errorInfo +=  getI18nText("i18n_CheckTypeSetAction.downloadExample.errorInfo.line_n81i",i+"")+getI18nText("i18n_CheckTypeSetAction.downloadExample.errorInfo3_n81i",2+"");
					} else if (cell_2.getCellType() == Cell.CELL_TYPE_STRING) {
						if ("".equals(cell_2.getStringCellValue())) {
							errorInfo +=  getI18nText("i18n_CheckTypeSetAction.downloadExample.errorInfo.line_n81i",i+"")+getI18nText("i18n_CheckTypeSetAction.downloadExample.errorInfo3_n81i",2+"");
						} else {
							checkTypeName1 = cell_2.getStringCellValue().trim();
						}
					} else {
						errorInfo += getI18nText("i18n_CheckTypeSetAction.downloadExample.errorInfo.line_n81i",i+"")+getI18nText("i18n_CheckTypeSetAction.downloadExample.errorInfo4_n81i",2+"");
					}
					
					// 备注
					if (null == cell_3) {
					} else if (cell_3.getCellType() == Cell.CELL_TYPE_STRING) {
						checkRemark = cell_3.getStringCellValue().trim();
							if(checkRemark.length()>100){
								errorInfo +=  getI18nText("i18n_CheckTypeSetAction.downloadExample.errorInfo.line_n81i",i+"")+getI18nText("i18n_CheckTypeSetAction.downloadExample.errorInfo5_n81i",3+"");
							}
					} else {
						errorInfo +=  getI18nText("i18n_CheckTypeSetAction.downloadExample.errorInfo.line_n81i",i+"")+getI18nText("i18n_CheckTypeSetAction.downloadExample.errorInfo6_n81i",3+"");
					}
					
					// 对应数据库表
					if (null == cell_4) {
						errorInfo +=  getI18nText("i18n_CheckTypeSetAction.downloadExample.errorInfo.line_n81i",i+"")+getI18nText("i18n_CheckTypeSetAction.downloadExample.errorInfo7_n81i",4+"");
					} else if (cell_4.getCellType() == Cell.CELL_TYPE_STRING) {
						if ("".equals(cell_4.getStringCellValue())) {
							errorInfo +=  getI18nText("i18n_CheckTypeSetAction.downloadExample.errorInfo.line_n81i",i+"")+getI18nText("i18n_CheckTypeSetAction.downloadExample.errorInfo7_n81i",4+"");
						} else {
							tableName = cell_4.getStringCellValue().trim();
						}
					} else {
						errorInfo +=  getI18nText("i18n_CheckTypeSetAction.downloadExample.errorInfo.line_n81i",i+"")+getI18nText("i18n_CheckTypeSetAction.downloadExample.errorInfo8_n81i",4+"");
					}
					
					// 表描述
					if (null == cell_5||cell_5.getCellType() == Cell.CELL_TYPE_BLANK) {
					} else if (cell_5.getCellType() == Cell.CELL_TYPE_STRING) {
						tableComments = cell_5.getStringCellValue().trim();
							if(tableComments.length()>25){
								errorInfo +=  getI18nText("i18n_CheckTypeSetAction.downloadExample.errorInfo.line_n81i",i+"")+getI18nText("i18n_CheckTypeSetAction.downloadExample.errorInfo9_n81i",5+"");
							}
					}else if (cell_5.getCellType() == Cell.CELL_TYPE_NUMERIC) {
						tableComments = String.valueOf((int)cell_5.getNumericCellValue());
						if(tableComments.length()>25){
							errorInfo +=  getI18nText("i18n_CheckTypeSetAction.downloadExample.errorInfo.line_n81i",i+"")+getI18nText("i18n_CheckTypeSetAction.downloadExample.errorInfo9_n81i",5+"");
						}
					} else {
						errorInfo +=  getI18nText("i18n_CheckTypeSetAction.downloadExample.errorInfo.line_n81i",i+"")+getI18nText("i18n_CheckTypeSetAction.downloadExample.errorInfo10_n81i",5+"");
					}

					// 查看权限
					if (null == cell_6) {
						errorInfo +=  getI18nText("i18n_CheckTypeSetAction.downloadExample.errorInfo.line_n81i",i+"")+getI18nText("i18n_CheckTypeSetAction.downloadExample.errorInfo11_n81i",6+"");
					} else if (cell_6.getCellType() == Cell.CELL_TYPE_NUMERIC) {
						viewLevel = (long)cell_6.getNumericCellValue();
					}else{
						errorInfo +=  getI18nText("i18n_CheckTypeSetAction.downloadExample.errorInfo.line_n81i",i+"")+getI18nText("i18n_CheckTypeSetAction.downloadExample.errorInfo12_n81i",6+"");
					}
					
					// 用户组
					if(null == cell_7||cell_7.getCellType() == Cell.CELL_TYPE_BLANK){
					}else if (cell_7.getCellType() == Cell.CELL_TYPE_NUMERIC) {
						groupName =String.valueOf((int)cell_7.getNumericCellValue());
					} else if (cell_7.getCellType() == Cell.CELL_TYPE_STRING) {
						groupName = cell_7.getStringCellValue();
					} else {
						errorInfo +=  getI18nText("i18n_CheckTypeSetAction.downloadExample.errorInfo.line_n81i",i+"")+getI18nText("i18n_CheckTypeSetAction.downloadExample.errorInfo13_n81i",7+"");
					}
					
					// SNMP监控
					if(null == cell_8 ||cell_8.getCellType() == Cell.CELL_TYPE_BLANK){
						errorInfo +=  getI18nText("i18n_CheckTypeSetAction.downloadExample.errorInfo.line_n81i",i+"")+getI18nText("i18n_CheckTypeSetAction.downloadExample.errorInfo14_n81i",8+"");
					}else if (cell_8.getCellType() == Cell.CELL_TYPE_NUMERIC) {
						isSnmp = (long)cell_8.getNumericCellValue();
					} else {
						errorInfo +=  getI18nText("i18n_CheckTypeSetAction.downloadExample.errorInfo.line_n81i",i+"")+getI18nText("i18n_CheckTypeSetAction.downloadExample.errorInfo15_n81i",8+"");
					}
					
					// OID
					if(null == cell_9 ||cell_9.getCellType() == Cell.CELL_TYPE_BLANK){
					}else if (cell_9.getCellType() == Cell.CELL_TYPE_STRING) {
						if ("".equals(cell_9.getStringCellValue())) {
						} else {
							snmpOID = cell_9.getStringCellValue().trim();
						}
					}else {
						errorInfo +=  getI18nText("i18n_CheckTypeSetAction.downloadExample.errorInfo.line_n81i",i+"")+getI18nText("i18n_CheckTypeSetAction.downloadExample.errorInfo16_n81i",9+"");
					}
					
					if ("".equals(errorInfo)) {// 保存节点
						errorInfo = this.saveNode(checkTypeName,checkTypeName1,checkRemark,tableName,tableComments,viewLevel,groupName,isSnmp,snmpOID);
					}
					if ("".equals(errorInfo)) {
						count++;
					} else {
						errorList.add(checkTypeName);
						errorList.add(checkTypeName1);
						errorList.add(checkRemark);
						errorList.add(tableName);
						errorList.add(tableComments);
						if(viewLevel==-25){
							errorList.add("");
						}else{
							errorList.add(String.valueOf((int)viewLevel));
						}
						errorList.add(groupName);
						if(isSnmp==-25){
							errorList.add("");
						}else{
							errorList.add(String.valueOf((int)isSnmp));
						}
						errorList.add(snmpOID);
						errorList.add(errorInfo);
						rowList.add(errorList);
						errorInfo = "";

					}
				}
			}
			
			//获取第二个sheet的值并保存
			
			// 创建对工作表的引用，得到表的第一页
			Sheet sheet1 = workbook.getSheetAt(1);
			// 读取左上端单元

			// 记录存储数据条数
			int count1 = 0;
			// 记录读入excel数据条数
			int sum1 = (sheet1.getLastRowNum());
			for (short i = 1; i <= sheet1.getLastRowNum(); i++) {
				String filedName = "";
				String filedComments= "";
				String filedType= "";
				String filedTypeLength= "";
				String chartState= "";
				String oid="";
				String checkTypeName1="";
				String tableName="";
				List<String> errorList = new ArrayList<String>();
				Row row = sheet1.getRow(i);
				Cell cell_1 = row.getCell((short) 0);
				Cell cell_2 = row.getCell((short) 1);
				Cell cell_3 = row.getCell((short) 2);
				Cell cell_4 = row.getCell((short) 3);
				Cell cell_5 = row.getCell((short) 4);
				Cell cell_6 = row.getCell((short) 5);
				Cell cell_7 = row.getCell((short) 6);
				Cell cell_8 = row.getCell((short) 7);
				if ((null == cell_1 || 3 == cell_1.getCellType())
						&& (null == cell_2 || 3 == cell_2.getCellType())
						&& (null == cell_3 || 3 == cell_3.getCellType())
						&& (null == cell_4 || 3 == cell_4.getCellType())
						&& (null == cell_5 || 3 == cell_5.getCellType())
						&& (null == cell_6 || 3 == cell_6.getCellType())
						&& (null == cell_7 || 3 == cell_7.getCellType())
						&& (null == cell_8 || 3 == cell_8.getCellType())) {
					sum1--;
				}else {
					// 字段名
					if (null == cell_1) {
						errorInfo +=  getI18nText("i18n_CheckTypeSetAction.downloadExample.errorInfo.line_n81i",i+"")+getI18nText("i18n_CheckTypeSetAction.downloadExample.errorInfo17_n81i",1+"");
					} else if (cell_1.getCellType() == Cell.CELL_TYPE_STRING) {
						if ("".equals(cell_1.getStringCellValue())) {
							errorInfo +=  getI18nText("i18n_CheckTypeSetAction.downloadExample.errorInfo.line_n81i",i+"")+getI18nText("i18n_CheckTypeSetAction.downloadExample.errorInfo17_n81i",1+"");
						} else {
							filedName = cell_1.getStringCellValue().trim();
						}
					} else {
						errorInfo +=  getI18nText("i18n_CheckTypeSetAction.downloadExample.errorInfo.line_n81i",i+"")+getI18nText("i18n_CheckTypeSetAction.downloadExample.errorInfo18_n81i",1+"");
					}
					
					// 字段描述
					if (null == cell_2) {
						errorInfo +=  getI18nText("i18n_CheckTypeSetAction.downloadExample.errorInfo.line_n81i",i+"")+getI18nText("i18n_CheckTypeSetAction.downloadExample.errorInfo19_n81i",2+"");
					} else if (cell_2.getCellType() == Cell.CELL_TYPE_STRING) {
						if ("".equals(cell_2.getStringCellValue())) {
							errorInfo +=  getI18nText("i18n_CheckTypeSetAction.downloadExample.errorInfo.line_n81i",i+"")+getI18nText("i18n_CheckTypeSetAction.downloadExample.errorInfo19_n81i",2+"");
						} else {
							filedComments = cell_2.getStringCellValue().trim();
						}
					} else {
						errorInfo += getI18nText("i18n_CheckTypeSetAction.downloadExample.errorInfo.line_n81i",i+"")+getI18nText("i18n_CheckTypeSetAction.downloadExample.errorInfo20_n81i",2+"");
					}
					
					// 字段类型
					if (null == cell_3) {
						errorInfo +=  getI18nText("i18n_CheckTypeSetAction.downloadExample.errorInfo.line_n81i",i+"")+getI18nText("i18n_CheckTypeSetAction.downloadExample.errorInfo21_n81i",3+"");
					} else if (cell_3.getCellType() == Cell.CELL_TYPE_STRING) {
						if ("".equals(cell_3.getStringCellValue())) {
							errorInfo += getI18nText("i18n_CheckTypeSetAction.downloadExample.errorInfo.line_n81i",i+"")+getI18nText("i18n_CheckTypeSetAction.downloadExample.errorInfo21_n81i",3+"");
						} else {
							filedType = cell_3.getStringCellValue().trim();
						}
					} else {
						errorInfo +=  getI18nText("i18n_CheckTypeSetAction.downloadExample.errorInfo.line_n81i",i+"")+getI18nText("i18n_CheckTypeSetAction.downloadExample.errorInfo22_n81i",3+"");
					}
					
					// 长度
					if (null == cell_4) {
					} else if (cell_4.getCellType() == Cell.CELL_TYPE_STRING) {
						filedTypeLength = cell_4.getStringCellValue().trim();
					}else if(cell_4.getCellType() == Cell.CELL_TYPE_NUMERIC){
						filedTypeLength =String.valueOf((int)cell_4.getNumericCellValue());
					} else {
						errorInfo +=  getI18nText("i18n_CheckTypeSetAction.downloadExample.errorInfo23_n81i",i+"");
					}
					
					// 是否用于统计
					if (null == cell_5) {
						errorInfo += getI18nText("i18n_CheckTypeSetAction.downloadExample.errorInfo24_n81i",i+"");
					} else if (cell_5.getCellType() == Cell.CELL_TYPE_STRING) {
						if ("".equals(cell_5.getStringCellValue())) {
							errorInfo += getI18nText("i18n_CheckTypeSetAction.downloadExample.errorInfo24_n81i",i+"");
						} else {
							chartState = cell_5.getStringCellValue().trim();
						}
					} else {
						errorInfo += getI18nText("i18n_CheckTypeSetAction.downloadExample.errorInfo25_n81i",i+"");
					}

					// OID
					if (null == cell_6) {
					} else if (cell_6.getCellType() == Cell.CELL_TYPE_STRING) {
						oid = cell_6.getStringCellValue().trim();
					}else{
						errorInfo +=  getI18nText("i18n_CheckTypeSetAction.downloadExample.errorInfo.line_n81i",i+"")+getI18nText("i18n_CheckTypeSetAction.downloadExample.errorInfo16_n81i",6+"");
					}
					
					// 监测类别
					if(null == cell_7){
						errorInfo +=  getI18nText("i18n_CheckTypeSetAction.downloadExample.errorInfo.line_n81i",i+"")+getI18nText("i18n_CheckTypeSetAction.downloadExample.errorInfo3_n81i",7+"");
					}else if (cell_7.getCellType() == Cell.CELL_TYPE_STRING) {
						if ("".equals(cell_7.getStringCellValue())) {
							errorInfo +=  getI18nText("i18n_CheckTypeSetAction.downloadExample.errorInfo.line_n81i",i+"")+getI18nText("i18n_CheckTypeSetAction.downloadExample.errorInfo3_n81i",7+"");
						} else {
							checkTypeName1 = cell_7.getStringCellValue().trim();
						}
					} else {
						errorInfo +=  getI18nText("i18n_CheckTypeSetAction.downloadExample.errorInfo.line_n81i",i+"")+getI18nText("i18n_CheckTypeSetAction.downloadExample.errorInfo4_n81i",7+"");
					}
					
					// 表名
					if(null == cell_8 ){
						errorInfo += getI18nText("i18n_CheckTypeSetAction.downloadExample.errorInfo.line_n81i",i+"")+getI18nText("i18n_CheckTypeSetAction.downloadExample.errorInfo26_n81i",8+"");
					}else if (cell_8.getCellType() == Cell.CELL_TYPE_STRING) {
						if ("".equals(cell_8.getStringCellValue())) {
							errorInfo += getI18nText("i18n_CheckTypeSetAction.downloadExample.errorInfo.line_n81i",i+"")+getI18nText("i18n_CheckTypeSetAction.downloadExample.errorInfo26_n81i",8+"");
						} else {
							tableName = cell_8.getStringCellValue().trim();
						}
					} else {
						errorInfo +=  getI18nText("i18n_CheckTypeSetAction.downloadExample.errorInfo.line_n81i",i+"")+getI18nText("i18n_CheckTypeSetAction.downloadExample.errorInfo27_n81i",8+"");
					}
					
					if ("".equals(errorInfo)) {// 保存节点
						errorInfo = this.saveNode1(filedName,filedComments,filedType,filedTypeLength,chartState,oid,checkTypeName1,tableName);
					}
					if ("".equals(errorInfo)) {
						count1++;
					} else {
						errorList.add(filedName);
						errorList.add(filedComments);
						errorList.add(filedType);
						errorList.add(filedTypeLength);
						errorList.add(chartState);
						errorList.add(oid);
						errorList.add(checkTypeName1);
						errorList.add(tableName);
						errorList.add(errorInfo);
						rowList1.add(errorList);
						errorInfo = "";

					}
				}
			}
			
			headerList.add(getI18nText("i18n_CheckTypeSetAction.downloadExample.detecateType_n81i"));
			headerList.add(getI18nText("i18n_CheckTypeSetAction.downloadExample.detecateTypeName_n81i"));
			headerList.add(getI18nText("i18n_CheckTypeSetAction.downloadExample.remark_n81i"));
			headerList.add(getI18nText("i18n_CheckTypeSetAction.downloadExample.tableMap_n81i"));
			headerList.add(getI18nText("i18n_CheckTypeSetAction.downloadExample.tableDesc_n81i"));
			headerList.add(getI18nText("i18n_CheckTypeSetAction.downloadExample.viewLevel_n81i"));
			headerList.add(getI18nText("i18n_CheckTypeSetAction.downloadExample.userGroup_n81i"));
			headerList.add(getI18nText("i18n_CheckTypeSetAction.downloadExample.snmpDetecat_n81i"));
			headerList.add("OID");
			headerList.add(getI18nText("i18n_CheckTypeSetAction.downloadExample.errorInfo_n81i"));
			
			headerList1.add(getI18nText("i18n_CheckTypeSetAction.downloadExample.fieldName_n81i"));
			headerList1.add(getI18nText("i18n_CheckTypeSetAction.downloadExample.fieldDesc_n81i"));
			headerList1.add(getI18nText("i18n_CheckTypeSetAction.downloadExample.fieldType_n81i"));
			headerList1.add(getI18nText("i18n_CheckTypeSetAction.downloadExample.length_n81i"));
			headerList1.add(getI18nText("i18n_CheckTypeSetAction.downloadExample.isChart_n81i"));
			headerList1.add("OID");
			headerList1.add(getI18nText("i18n_CheckTypeSetAction.downloadExample.detecateTypeName_n81i"));
			headerList1.add(getI18nText("i18n_CheckTypeSetAction.downloadExample.tableName_n81i"));
			headerList1.add(getI18nText("i18n_CheckTypeSetAction.downloadExample.errorInfo_n81i"));
			this.getRequest().setAttribute("rowList", rowList);
			this.getRequest().setAttribute("headerList", headerList);
			this.getRequest().setAttribute("rowList1", rowList1);
			this.getRequest().setAttribute("headerList1", headerList1);
			this.getRequest().setAttribute("errorTheme", getI18nText("i18n_CheckTypeSetAction.downloadExample.errorTheme_n81i"));
			if (count == sum && sum > 0&&count1 == sum1 && sum1 >= 0) {
//				this.getRequest().setAttribute("MSG", 1);
//				return  this.queryCheckTypeSetInfo();
				outHtmlString("<script type=\"text/javascript\">alert('i18n_CheckTypeSetAction.downloadExample.success_n81i');this.location='checkTypeSet.do?action=query'</script>");
				return null;
			} else if (sum == 0) {
				this.outHtmlString("<script>alert('i18n_CheckTypeSetAction.downloadExample.fileIsNull_n81i');history.back();</script>");
				return null;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "showError";
	}

	private String saveNode1(String filedName, String filedComments,
			String filedType, String filedTypeLength, String chartState,
			String oid, String checkTypeName1, String tableName) {
		String desc = "";
		Metadata metadata = new Metadata();
		try {
			commonService.beginTransaction();
			String hql = "from CheckTypeInfo where checkTypeName1=?";
			List<CheckTypeInfo> list = commonService.find(hql, checkTypeName1);
			if(list==null||list.size()==0){
				return getI18nText("i18n_CheckTypeSetAction.downloadExample.detecateTypeIsNull_n81i");
			}
			CheckTypeInfo checkTypeInfo = list.get(0);
			// 保存节点信息
			metadata.setFiledName(filedName);
			metadata.setFiledComments(filedComments);
			metadata.setFiledType(filedType);
			metadata.setFiledTypeLength(filedTypeLength);
			metadata.setChartState(chartState);
			metadata.setOid(oid);
			metadata.setCheckTypeInfo(checkTypeInfo);
			metadata.setTableName(tableName);
			metadata.setTableComments(checkTypeInfo.getTableComments());
			metadata.setCreateDate(new Date());
			metadata.setCreatePerson(getUserID());
			metadata.setState("0");
			
			String sql = "select count(*) from metadata t where CHECK_TYPE_ID ="+checkTypeInfo.getId()+" and FILED_NAME ='"+metadata.getFiledName()+"'";
			List list1 = this.commonService.executeSQL(sql);
			int num = Integer.parseInt(list1.get(0).toString());
			if(num>0){//判断是否有此列时，只能从metadata表中去判断，不能从数据库中是否真的创建了此列来判断
				return getI18nText("i18n_CheckTypeSetAction.downloadExample.fieldExists_n81i");
			}
			
			if(metadata.getFiledType().equals(getI18nText("i18n_CheckTypeSetAction.downloadExample.number_n81i"))){
				metadata.setFiledType("Number");
			}else if(metadata.getFiledType().equals(getI18nText("i18n_CheckTypeSetAction.downloadExample.DATE_n81i"))){
				metadata.setFiledType("DATE");
			}else if(metadata.getFiledType().equals(getI18nText("i18n_CheckTypeSetAction.downloadExample.text_n81i"))){
				if(metadata.getFiledTypeLength().equals("")){
					return getI18nText("i18n_CheckTypeSetAction.downloadExample.textInfo_n81i");
				}else{
					try {
						Integer.parseInt(metadata.getFiledTypeLength());
					} catch (Exception e) {
						// TODO: handle exception
						return getI18nText("i18n_CheckTypeSetAction.downloadExample.lenghtInfo_n81i");
					}
				}
				metadata.setFiledType("VARCHAR2("+metadata.getFiledTypeLength()+")");
			}else{
				return getI18nText("i18n_CheckTypeSetAction.downloadExample.filedTypeInfo_n81i");
			}
			
			if(metadata.getChartState().equals(getI18nText("i18n_CheckTypeSetAction.downloadExample.Y_n81i"))){
				metadata.setChartState("0");
			}else if(metadata.getChartState().equals(getI18nText("i18n_CheckTypeSetAction.downloadExample.N_n81i"))){
				metadata.setChartState("1");
			}else{
				return getI18nText("i18n_CheckTypeSetAction.downloadExample.isCHartInfo_n81i");
			}
			
			if(checkTypeInfo.getIsSnmp()==0||checkTypeInfo.getIsSnmp()==1){
				if(metadata.getOid().equals("")){
					return getI18nText("i18n_CheckTypeSetAction.downloadExample.oidIsNecessary_n81i");
				}
			}
			
			//获取最大“在传输中的序号"
			String getMaxNum = "select max(t.show_num) from metadata t where t.check_type_id="+checkTypeInfo.getId()+
								" and t.table_name='"+metadata.getTableName()+"' and t.state = 0";
			List maxNumList = this.commonService.executeSQL(getMaxNum);
			int max=0;
			if(maxNumList!=null && maxNumList.size()>0){
				if(maxNumList.get(0)!=null){
					max = Integer.parseInt(maxNumList.get(0).toString());	
				}else{
					max =0;
				}
			}
			metadata.setShowNum((long)(max+1));			
			
			
			//保存字段信息到表METADATA中去
			this.commonService.save(metadata);
			// 将更新操作写到操作日志中
			this.addDBOperationRpt(commonService,"metadata", "INSERT", metadata.getId());
			
			
			//如果表已经生成，则需要修改表的结构
			if(new MetaDataSetAction().hasCreatedTable(checkTypeInfo.getTableName())){
				//向数据库中添加新的字段
				StringBuffer sqlString = new StringBuffer("alter table ");
				sqlString.append(checkTypeInfo.getTableName().toUpperCase());
				sqlString.append(" add(");
				sqlString.append(metadata.getFiledName()+" "+metadata.getFiledType()+")");
				System.out.println(sqlString.toString());
				
				//执行添加字段
				this.commonService.updateBatchBySql(sqlString.toString());
			}
			
			//与NMSServer通信
			this.sendCheckTypeId(checkTypeInfo.getId()+"",commonService);
			commonService.commit();
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(e.getStackTrace());
			commonService.rollback();
			desc = getI18nText("i18n_CheckTypeSetAction.downloadExample.importInfo_n81i");
		}
		return desc;
	}

	private String saveNode(String checkTypeName,String checkTypeName1,String checkRemark,String tableName,String tableComments,long viewLevel,String groupName,long isSnmp,String snmpOID) {
		String desc = "";
		CheckTypeInfo checkTypeInfo = new CheckTypeInfo();
		try {
			commonService.beginTransaction();
			// 保存节点信息
			checkTypeInfo.setCheckTypeName(checkTypeName);
			checkTypeInfo.setCheckTypeName1(checkTypeName1);
			checkTypeInfo.setCheckRemark(checkRemark);
			checkTypeInfo.setTableName(tableName.toUpperCase());
			checkTypeInfo.setTableComments(tableComments);
			if(viewLevel==-25){
			}else{
				checkTypeInfo.setViewLevel(viewLevel);
			}			
			if(isSnmp==-25){
			}else{
				checkTypeInfo.setIsSnmp(isSnmp);
			}
			//checkTypeInfo.setGroupId(groupId);
			checkTypeInfo.setSnmpOID(snmpOID);
			checkTypeInfo.setCreateTime(new Date());
			checkTypeInfo.setCreteState("1");
			//checkTypeInfo.setSystemId(this.getSystemID());//系统ID
			//checkTypeInfo.setUserId(this.getUserID());//userID
			checkTypeInfo.setIsSchedule("1");
			
			//显示名称不允许重复
			String sql = "select count(*) from check_type_info t where CHECK_TYPE_NAME1 ='"+checkTypeInfo.getCheckTypeName1().trim()+"'";
			List list = this.commonService.executeSQL(sql);
			int num = Integer.parseInt(list.get(0).toString());
			if(num>0){
				return getI18nText("i18n_CheckTypeSetAction.downloadExample.detecateTypeNameRepeat_n81i");
			}else{
				//显示名称不允许重复
				sql = "select count(*) from check_type_info t where CHECK_TYPE_NAME ='"+checkTypeInfo.getCheckTypeName().trim()+"'";
				 list = this.commonService.executeSQL(sql);
					num = Integer.parseInt(list.get(0).toString());
					if(num>0){
						return getI18nText("i18n_CheckTypeSetAction.downloadExample.detecateTypeRepeat_n81i");
					}
			}
			
			//判断库中是否有该表记录
			String sql1 = "select count(*) from check_type_info t where TABLE_NAME ='"+checkTypeInfo.getTableName()+"'";
			List list1 = this.commonService.executeSQL(sql1);
			int num1 = Integer.parseInt(list1.get(0).toString());
			
			
			//判断数据库中是否存在该表实体
			/*String sql2 = "SELECT COUNT(*) from user_tables where table_name = '"+checkTypeInfo.getTableName()+"'";
			List list2 = this.commonService.executeSQL(sql2);
			int num2 = Integer.parseInt(list2.get(0).toString());*/
			//@2018-3-8 11:22:10 mysql适配
			int num2 = this.commonService.isTableExist(checkTypeInfo.getTableName());
			//双重判断
			if(num1>0 || num2>0){
				return getI18nText("i18n_CheckTypeSetAction.downloadExample.tableExists_n81i");
			}
			if (checkTypeInfo.getViewLevel() == 1) {
				checkTypeInfo.setUserId(this.getUserID());//userID
			}
			if (checkTypeInfo.getViewLevel() == 2) {
				if(groupName.equals("")){
					return getI18nText("i18n_CheckTypeSetAction.downloadExample.viewLevelInfo_n81i");
				}else{
					boolean isHave = false;
					List<XtJsJbxx> grouplist = commonService.find("from XtJsJbxx");
					
					for (int i = 0; i < grouplist.size(); i++) {
						if(groupName.equals(grouplist.get(i).getJsmc())){
							checkTypeInfo.setGroupId(grouplist.get(i).getJsbh());
							isHave=true;
						}
					}
					
					if(!isHave){
						return getI18nText("i18n_CheckTypeSetAction.downloadExample.noUserGroup_n81i");
					}
				}
			}
			checkTypeInfo.setSystemId(this.getSystemID());//系统ID
			if(checkTypeInfo.getIsSnmp()==0 || checkTypeInfo.getIsSnmp()==1){
				if(checkTypeInfo.getSnmpOID().equals("")){
					return getI18nText("i18n_CheckTypeSetAction.downloadExample.snmpDetecateInfo_n81i");
				}else{
					if(checkTypeInfo.getSnmpOID().startsWith(".")){
						checkTypeInfo.setSnmpOID(checkTypeInfo.getSnmpOID().substring(1,checkTypeInfo.getSnmpOID().length()));
					}
				}				
			}
			//如果是snmp监控，则执行下面代码
			if(checkTypeInfo.getIsSnmp()==0){
				SnmpAction sa = new SnmpAction(this.commonService);
				List<String> names =null;
				List<EntityInfo> allfileds = null;
				names = fileUtil.getAllMibFileNames();
				sa.loadAllMibs(names);
				sa.genJavaCode(FormatUtil.formatBeanName(checkTypeInfo.getTableName()),checkTypeInfo.getSnmpOID());
				sa.createClass(FormatUtil.formatBeanName(checkTypeInfo.getTableName()));
				allfileds = sa.getFiled(checkTypeInfo.getSnmpOID().trim());
				this.commonService.save(checkTypeInfo);
				sa.insertFiled(checkTypeInfo,allfileds);
			}else{
				this.commonService.save(checkTypeInfo);
			}
			commonService.commit();
		} catch (Exception e) {
			e.printStackTrace();
			commonService.rollback();
//			logger.error(e.getStackTrace());//i18nlog
			desc = getI18nText("i18n_CheckTypeSetAction.downloadExample.importInfo_n81i");
		}
		return desc;
	}
	
	// 当前页导出   程辉 2013-5-8新增
	public String emportCurrentXls() {
		try {
			StringBuffer hql = new StringBuffer();
			if(this.getAdminMark()){//如果是admin登陆则无限制
				hql.append("from CheckTypeInfo where isSchedule<>2 ");
				isAdmin ="true";
			}else{
				isAdmin="false";
				hql.append("from CheckTypeInfo t where isSchedule<>2 and (( t.viewLevel=1 and t.userId=");
				hql.append(this.getUserID());
				hql.append(" and t.systemId ="+this.getSystemID()+")");
				hql.append(" or ( t.viewLevel=2 and t.groupId in (select  x.jsbh from  XtYhJsIndex  x  where x.yhbh='");
				hql.append(this.getUser().getYhbh());
				hql.append("' and x.type = 1) and t.systemId = "+this.getSystemID()+") or (t.viewLevel=3 and t.systemId = "+this.getSystemID()+")");
				hql.append(" or (t.viewLevel=4 )");
				hql.append(") ");
			}
			
			if(ctn!=null && !"".equals(ctn)){
				hql.append(" and id = ");
				hql.append(ctn);
			}
			hql.append(" order by isSchedule asc , createTime desc");
			page = this.commonService.findByPage(hql.toString(), pageNo, pageSize);
			List<CheckTypeInfo> checkTypeSetList = (List<CheckTypeInfo>)page.getResult(); 
			
			for(int i=0;i<checkTypeSetList.size();i++){
				if(checkTypeSetList.get(i).getIsSchedule().equals("0")||checkTypeSetList.get(i).getIsSchedule().equals("2")){
					checkTypeSetList.get(i).setIsSchedule(getI18nText("i18n_CheckTypeSetAction.downloadExample.Y_n81i"));
				}
				if(checkTypeSetList.get(i).getIsSchedule().equals("1")){
					checkTypeSetList.get(i).setIsSchedule(getI18nText("i18n_CheckTypeSetAction.downloadExample.N_n81i"));
				}
				if(null==checkTypeSetList.get(i).getIsSnmp()||checkTypeSetList.get(i).getIsSnmp()==2){
					checkTypeSetList.get(i).setCreteState(getI18nText("i18n_CheckTypeSetAction.downloadExample.N_n81i"));
				}else if(checkTypeSetList.get(i).getIsSnmp()==0||checkTypeSetList.get(i).getIsSnmp()==1){
					checkTypeSetList.get(i).setCreteState(getI18nText("i18n_CheckTypeSetAction.downloadExample.Y_n81i"));					
				}
			}
			
			String[] title = { getI18nText("i18n_CheckTypeSetAction.downloadExample.detecateTypeName_n81i"),
								getI18nText("i18n_CheckTypeSetAction.downloadExample.detecateType_n81i"),
								getI18nText("i18n_CheckTypeSetAction.downloadExample.tableMap_n81i"),
								getI18nText("i18n_CheckTypeSetAction.downloadExample.tableDesc_n81i"),
								getI18nText("i18n_CheckTypeSetAction.downloadExample.isSchedule_n81i"),
								getI18nText("i18n_CheckTypeSetAction.downloadExample.creteState_n81i"),
								getI18nText("i18n_CheckTypeSetAction.downloadExample.remark_n81i")};
	
			String[] colu = { "checkTypeName1", "checkTypeName","tableName","tableComments","isSchedule","creteState","checkRemark"};
			ExportUtils m = new ExportUtils();
			m.setAutoSizeColumn(true);
			m.exportExcel(getI18nText("i18n_CheckTypeSetAction.downloadExample.sheet_n81i"),checkTypeSetList, title, colu);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	// 导出全部   程辉 2013-5-8新增
	public String emportAllXls() {
		try {			
			StringBuffer hql = new StringBuffer();
			if(this.getAdminMark()){//如果是admin登陆则无限制
				hql.append("from CheckTypeInfo where isSchedule<>2 ");
				isAdmin ="true";
			}else{
				isAdmin="false";
				hql.append("from CheckTypeInfo t where isSchedule<>2 and (( t.viewLevel=1 and t.userId=");
				hql.append(this.getUserID());
				hql.append(" and t.systemId ="+this.getSystemID()+")");
				hql.append(" or ( t.viewLevel=2 and t.groupId in (select  x.jsbh from  XtYhJsIndex  x  where x.yhbh='");
				hql.append(this.getUser().getYhbh());
				hql.append("' and x.type = 1) and t.systemId = "+this.getSystemID()+") or (t.viewLevel=3 and t.systemId = "+this.getSystemID()+")");
				hql.append(" or (t.viewLevel=4 )");
				hql.append(") ");
			}
			
			if(ctn!=null && !"".equals(ctn)){
				hql.append(" and id = ");
				hql.append(ctn);
			}
			hql.append(" order by isSchedule asc , createTime desc");
			List<CheckTypeInfo> checkTypeSetList = this.commonService.find(hql.toString());
			
			for(int i=0;i<checkTypeSetList.size();i++){
				if(checkTypeSetList.get(i).getIsSchedule().equals("0")||checkTypeSetList.get(i).getIsSchedule().equals("2")){
					checkTypeSetList.get(i).setIsSchedule(getI18nText("i18n_CheckTypeSetAction.downloadExample.Y_n81i"));
				}
				if(checkTypeSetList.get(i).getIsSchedule().equals("1")){
					checkTypeSetList.get(i).setIsSchedule(getI18nText("i18n_CheckTypeSetAction.downloadExample.N_n81i"));
				}
				if(null==checkTypeSetList.get(i).getIsSnmp()||checkTypeSetList.get(i).getIsSnmp()==2){
					checkTypeSetList.get(i).setCreteState(getI18nText("i18n_CheckTypeSetAction.downloadExample.N_n81i"));
				}else if(checkTypeSetList.get(i).getIsSnmp()==0||checkTypeSetList.get(i).getIsSnmp()==1){
					checkTypeSetList.get(i).setCreteState(getI18nText("i18n_CheckTypeSetAction.downloadExample.Y_n81i"));					
				}
			}
			
			String[] title = { getI18nText("i18n_CheckTypeSetAction.downloadExample.detecateTypeName_n81i"),
								getI18nText("i18n_CheckTypeSetAction.downloadExample.detecateType_n81i"),
								getI18nText("i18n_CheckTypeSetAction.downloadExample.tableMap_n81i"),
								getI18nText("i18n_CheckTypeSetAction.downloadExample.tableDesc_n81i"),
								getI18nText("i18n_CheckTypeSetAction.downloadExample.isSchedule_n81i"),
								getI18nText("i18n_CheckTypeSetAction.downloadExample.creteState_n81i"),
								getI18nText("i18n_CheckTypeSetAction.downloadExample.remark_n81i")};
	
			String[] colu = { "checkTypeName1", "checkTypeName","tableName","tableComments","isSchedule","creteState","checkRemark"};
			ExportUtils m = new ExportUtils();
			m.setAutoSizeColumn(true);
			m.exportExcel(getI18nText("i18n_CheckTypeSetAction.downloadExample.sheet_n81i"),checkTypeSetList, title, colu);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	
	public String queryCheckTypeSetInfo(){
		try {
			isComplete = this.getRequest().getParameter("isComplete");
			/*String hql = "";
			if(this.getAdminMark()){//如果是admin登陆则无限制
				hql = "from CheckTypeInfo where 1=1 and isSchedule<>2";
				isAdmin ="true";
			}else{
				isAdmin="false";
				//权限控制--------begin
				String sqlparam = " or (t.viewLevel=4 )" ;
				hql = "from CheckTypeInfo t where 1=1 and isSchedule<>2 and (( t.viewLevel=1 and t.userId="+ this.getUserID()+ ")"
							+ " or ( t.viewLevel=2 and t.groupId in (select  x.jsbh from  XtYhJsIndex  x  where x.yhbh='"
							+ this.getUser().getYhbh()
							+ "' and x.type = 1)) or (t.viewLevel=3 and t.systemId = "+this.getSystemID()+")"
							+ sqlparam + ") ";
				//----------------end
			}
			
			if(ctn!=null && !"".equals(ctn)){
				hql +=" and id = "+ctn;
			}
			hql +=" order by isSchedule asc , createTime desc";*/
			StringBuffer hql = new StringBuffer();
			if(this.getAdminMark()){//如果是admin登陆则无限制
				hql.append("from CheckTypeInfo where isSchedule<>2 ");
				isAdmin ="true";
			}else{
				isAdmin="false";
				//权限控制--------begin
				//权限控制--------begin
				hql.append("from CheckTypeInfo t where isSchedule<>2 and (( t.viewLevel=1 and t.userId=");
				hql.append(this.getUserID());
				hql.append(" and t.systemId ="+this.getSystemID()+")");
				hql.append(" or ( t.viewLevel=2 and t.groupId in (select  x.jsbh from  XtYhJsIndex  x  where x.yhbh='");
				hql.append(this.getUser().getYhbh());
				hql.append("' and x.type = 1) and t.systemId = "+this.getSystemID()+") or (t.viewLevel=3 and t.systemId = "+this.getSystemID()+")");
				hql.append(" or (t.viewLevel=4 )");
				hql.append(") ");
				//----------------end
//				isAdmin="false";
//				//权限控制--------begin
//				hql.append("from CheckTypeInfo t where isSchedule<>2 and (( t.viewLevel=1 and t.userId=");
//				hql.append(this.getUserID());
//				hql.append(")");
//				hql.append(" or ( t.viewLevel=2 and t.groupId in (select  x.jsbh from  XtYhJsIndex  x  where x.yhbh='");
//				hql.append(this.getUser().getYhbh());
//				hql.append("' and x.type = 1)) or (t.viewLevel=3 and t.systemId = ");
//				hql.append(this.getSystemID());
//				hql.append(")");
//				hql.append(" or (t.viewLevel=4 )");
//				hql.append(") ");
//				//----------------end
			}
			
			if(ctn!=null && !"".equals(ctn)){
				hql.append(" and id = ");
				hql.append(ctn);
			}
			hql.append(" order by isSchedule asc , createTime desc");
			page = this.commonService.findByPage(hql.toString(), pageNo, pageSize);
			checkTypeSetList = (List<CheckTypeInfo>)page.getResult(); 
			this.queryCheckTypeInfo();
		} catch (Exception e) {
			e.printStackTrace();
			outHtmlString("<script type=\"text/javascript\">alert('i18n_DeptManageAction.update.faild_n81i');this.location='checkTypeSet.do?action=query&pageNo="+pageNo+"&pageSize="+pageSize+"'</script>");
			logger.error(e.getStackTrace());
		}
		return "queryCheckTypeSetInfo";
	}
	
	public String queryCheckTypeSetInfoChild(){
		try {
			isComplete = this.getRequest().getParameter("isComplete");
			
			StringBuffer hql = new StringBuffer();
			if(this.getAdminMark()){//如果是admin登陆则无限制
				hql.append("from CheckTypeInfo where isSchedule<>2 ");
				isAdmin ="true";
			}else{
				isAdmin="false";
				//权限控制--------begin
				//权限控制--------begin
				hql.append("from CheckTypeInfo t where isSchedule<>2 and (( t.viewLevel=1 and t.userId=");
				hql.append(this.getUserID());
				hql.append(" and t.systemId ="+this.getSystemID()+")");
				hql.append(" or ( t.viewLevel=2 and t.groupId in (select  x.jsbh from  XtYhJsIndex  x  where x.yhbh='");
				hql.append(this.getUser().getYhbh());
				hql.append("' and x.type = 1) and t.systemId = "+this.getSystemID()+") or (t.viewLevel=3 and t.systemId = "+this.getSystemID()+")");
				hql.append(" or (t.viewLevel=4 )");
				hql.append(") ");
			}
			
			if(ctn!=null && !"".equals(ctn)){
				hql.append(" and id = ");
				hql.append(ctn);
			}
			hql.append(" order by isSchedule asc , createTime desc");
			page = this.commonService.findByPage(hql.toString(), pageNo, pageSize);
			checkTypeSetList = (List<CheckTypeInfo>)page.getResult(); 
			this.queryCheckTypeInfo();
		} catch (Exception e) {
			e.printStackTrace();
			outHtmlString("<script type=\"text/javascript\">alert('i18n_DeptManageAction.update.faild_n81i');this.location='checkTypeSet.do?action=query&pageNo="+pageNo+"&pageSize="+pageSize+"'</script>");
			logger.error(e.getStackTrace());
		}
		return "queryCheckTypeSetInfoChild";
	}
	
	private void queryCheckTypeInfo() throws Exception{
		try{
			/*String hql = "";
			if(this.getAdminMark()){//如果是admin登陆则无限制
				hql = "from CheckTypeInfo where 1=1 and isSchedule<>2";
				isAdmin ="true";
			}else{
				isAdmin="false";
				//权限控制--------begin
				String sqlparam = " or (t.viewLevel=4 )" ;
				hql = "from CheckTypeInfo t where 1=1 and isSchedule<>2 and (( t.viewLevel=1 and t.userId="+ this.getUserID()+ ")"
							+ " or ( t.viewLevel=2 and t.groupId in (select  x.jsbh from  XtYhJsIndex  x  where x.yhbh='"
							+ this.getUser().getYhbh()
							+ "' and x.type = 1)) or (t.viewLevel=3 and t.systemId = "+this.getSystemID()+")"
							+ sqlparam + ") ";
				//----------------end
			}
			hql +=" order by isSchedule asc , createTime desc";
			
			allCheckTypeInfo = this.commonService.find(hql);*/
			StringBuffer hql = new StringBuffer();
			if(this.getAdminMark()){//如果是admin登陆则无限制
				hql.append("from CheckTypeInfo where isSchedule<>2 ");
				isAdmin ="true";
			}else{
				isAdmin="false";
				//权限控制--------begin
				hql.append("from CheckTypeInfo t where isSchedule<>2 and (( t.viewLevel=1 and t.userId=");
				hql.append(this.getUserID());
				hql.append(" and t.systemId ="+this.getSystemID()+")");
				hql.append(" or ( t.viewLevel=2 and t.groupId in (select  x.jsbh from  XtYhJsIndex  x  where x.yhbh='");
				hql.append(this.getUser().getYhbh());
				hql.append("' and x.type = 1) and t.systemId = "+this.getSystemID()+") or (t.viewLevel=3 and t.systemId = "+this.getSystemID()+")");
				hql.append(" or (t.viewLevel=4 )");
				hql.append(") ");
				//----------------end
			}
			hql.append(" order by decode(isSchedule,0,0,2,0,1,1,2) asc ,decode(isSnmp,2,0,null,0,1) asc, ID asc");
			allCheckTypeInfo = this.commonService.find(hql.toString());
		}catch(Exception e){
			e.printStackTrace();
			logger.error(e.getStackTrace());
		}
	}
	
	//新增
	public void addCheckTypeSetInfo()throws Exception{
		SimpleDateFormat sdf = null;
		Date createDate = null;
		Date dNow=null;
		try {	
			commonService.beginTransaction();
			sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			dNow = new Date();
			createDate = sdf.parse(sdf.format(dNow));
			//显示名称不允许重复
			String sql = "select count(*) from check_type_info t where CHECK_TYPE_NAME1 ='"+checkTypeInfo.getCheckTypeName1().trim()+"'";
			List list = this.commonService.executeSQL(sql);
			int num = Integer.parseInt(list.get(0).toString());
			if(num>0){
				this.outHtmlString("<script>alert('i18n_CheckTypeSetAction.addCheckTypeSetInfo.detecateTypeNameRepeatInfo_n81i');this.location='checkTypeSet!executeAction.do?action=openAdd';</script>");
				return;
			}else{
				//显示名称不允许重复
				sql = "select count(*) from check_type_info t where CHECK_TYPE_NAME ='"+checkTypeInfo.getCheckTypeName().trim()+"'";
				 list = this.commonService.executeSQL(sql);
					num = Integer.parseInt(list.get(0).toString());
					if(num>0){
						this.outHtmlString("<script>alert('i18n_CheckTypeSetAction.addCheckTypeSetInfo.detecateTypeRepeatInfo_n81i');this.location='checkTypeSet.do?action=openAdd';</script>");
						return;
					}
			}
			
			//判断库中是否有该表记录
			String sql1 = "select count(*) from check_type_info t where TABLE_NAME ='"+checkTypeInfo.getTableName().trim().toUpperCase()+"'";
			List list1 = this.commonService.executeSQL(sql1);
			int num1 = Integer.parseInt(list1.get(0).toString());
			
			//判断数据库中是否存在该表实体
			/*String sql2 = "SELECT COUNT(*) from user_tables where table_name = '"+checkTypeInfo.getTableName().trim().toUpperCase()+"'";
			List list2 = this.commonService.executeSQL(sql2);
			int num2 = Integer.parseInt(list2.get(0).toString());*/
			//@2018-3-8 11:22:10 mysql适配
			int num2 = this.commonService.isTableExist(checkTypeInfo.getTableName());
			//双重判断
			if(num1>0 || num2>0){
				this.outHtmlString("<script>alert('i18n_CheckTypeSetAction.addCheckTypeSetInfo.tableExistsInfo_n81i');this.location='checkTypeSet.do?action=openAdd';</script>");
				return;
			}
			
			checkTypeInfo.setSystemId(this.getSystemID());//系统ID
			checkTypeInfo.setUserId(this.getUserID());//userID
			checkTypeInfo.setCreteState("1");
			//checkTypeInfo.setIsSchedule("1");
			checkTypeInfo.setTableName(checkTypeInfo.getTableName().trim().toUpperCase());
			//创建时间
			checkTypeInfo.setCreateTime(createDate);
			
			if(checkTypeInfo.getIsSnmp()==0 || checkTypeInfo.getIsSnmp()==1){
				if(checkTypeInfo.getSnmpOID().startsWith(".")){
					checkTypeInfo.setSnmpOID(checkTypeInfo.getSnmpOID().substring(1,checkTypeInfo.getSnmpOID().length()));
				}
			}
			//如果是snmp监控，则执行下面代码
			if(checkTypeInfo.getIsSnmp()==0){
//				//判断oid是否存在
//				String cSql="select count(*) from check_type_info t where t.oid='"+checkTypeInfo.getSnmpOID()+"'";
//				List oidlist = this.commonService.executeSQL(cSql);
//				int oidnum = Integer.parseInt(oidlist.get(0).toString());
//				if(oidnum>0){//如果oid存在，再去判断是否替换
//					if(replace.equals("1")){//替换
//						
//					}else{//不替换
//						
//					}
//				}
				SnmpAction sa = new SnmpAction(this.commonService);
				//1.load all mib
				List<String> names =null;
				List<EntityInfo> allfileds = null;
				try {
					names = fileUtil.getAllMibFileNames();
					sa.loadAllMibs(names);
				} catch (Exception e) {
//					logger.error(e.getStackTrace());//i18nlog
					this.outHtmlString("<script>alert('"+e.getMessage()+"');this.location='checkTypeSet.do?action=openAdd';</script>");
					return;
				}
				//2.create javaBean and class
				try {
					sa.genJavaCode(FormatUtil.formatBeanName(checkTypeInfo.getTableName()),checkTypeInfo.getSnmpOID());
				} catch (Exception e) {
					logger.error(e.getStackTrace());
					this.outHtmlString("<script>alert('"+e.getMessage()+"');this.location='checkTypeSet.do?action=openAdd';</script>");
					return;
				}
				
				try {
					sa.createClass(FormatUtil.formatBeanName(checkTypeInfo.getTableName()));
				} catch (Exception e1) {
					logger.error(e1.getStackTrace());
					this.outHtmlString("<script>alert('i18n_CheckTypeSetAction.addCheckTypeSetInfo.classFileInfo_n81i');this.location='checkTypeSet.do?action=openAdd';</script>");
					return;
				}
				
				//3.get all filed
				try {
					allfileds = sa.getFiled(checkTypeInfo.getSnmpOID().trim());
				} catch (Exception e) {
					logger.error(e.getStackTrace());
					this.outHtmlString("<script>alert('i18n_CheckTypeSetAction.addCheckTypeSetInfo.getObjectFaild_n81i');this.location='checkTypeSet.do?action=openAdd';</script>");
					return;
				}
				
				//4.save
				try {
					this.commonService.save(checkTypeInfo);
					sa.insertFiled(checkTypeInfo,allfileds);
					//this.getRequest().setAttribute("MSG", 1);
					
					// 将更新操作写到操作日志中
					this.addDBOperationRpt(commonService,"check_type_info", "INSERT", checkTypeInfo.getId());
					outHtmlString("<script type=\"text/javascript\">alert('i18n_CheckTypeSetAction.downloadExample.success_n81i');this.location='checkTypeSet.do?action=query&pageNo="+pageNo+"&pageSize="+pageSize+"'</script>");
				} catch (Exception e) {
					logger.error(e.getStackTrace());
					this.outHtmlString("<script>alert('i18n_CheckTypeSetAction.addCheckTypeSetInfo.saveFailed_n81i');this.location='checkTypeSet.do?action=query&pageNo="+pageNo+"&pageSize="+pageSize+"'</script>");
					return;
				}
			}else{
				this.commonService.save(checkTypeInfo);
				// 将更新操作写到操作日志中
				this.addDBOperationRpt(commonService,"check_type_info", "INSERT", checkTypeInfo.getId());
				outHtmlString("<script type=\"text/javascript\">alert('i18n_CheckTypeSetAction.downloadExample.success_n81i');this.location='metaDataSet.do?action=oppAdd&fromWhere="+fromWhere+"&typeids="+checkTypeInfo.getId()+"'</script>");
//				//记录用户操作用于设置向导
//				if(fromWhere!=null && !"".equals(fromWhere)){
//					if(fromWhere.equals("formGuide")){
//						outHtmlString("<script type=\"text/javascript\">alert('操作成功');this.location='boxSet.do?action=query&isComplete=0'</script>");
//					}
//				}else{
//					outHtmlString("<script type=\"text/javascript\">alert('操作成功');this.location='boxSet.do?action=query'</script>");
//				}
			}
			commonService.commit();
		} catch (Exception e) {
			logger.error(e.getStackTrace());
			e.printStackTrace();
			commonService.rollback();
			outHtmlString("<script type=\"text/javascript\">alert('i18n_DeptManageAction.update.faild_n81i');this.location='checkTypeSet.do?action=query&pageNo="+pageNo+"&pageSize="+pageSize+"'</script>");
		}
	}
	
	public String openUpdateCheckTypeSet(){
		try {
			if(ids!=null && ids.length>0){
				List list = this.commonService.find(
						"from CheckTypeInfo where id=?", ids[0]);
				if(list!=null && list.size()>0){
					checkTypeInfo = (CheckTypeInfo)list.get(0);
				}
				//判断数据库中是否存在改表实体
				/*String sql = "SELECT COUNT(*) from user_tables where table_name = '"+checkTypeInfo.getTableName().trim().toUpperCase()+"'";
				List isHaveist = this.commonService.executeSQL(sql);
				int num = Integer.parseInt(isHaveist.get(0).toString());*/
				//@2018-3-8 11:22:10 mysql适配
				int num = this.commonService.isTableExist(checkTypeInfo.getTableName());
				if(num >0 || checkTypeInfo.getCreteState().equals("0")){
					isHaveTable="1";
				}else{
					isHaveTable="0";
				}
			}
		} catch (Exception e) {
			logger.error(e.getStackTrace());
			outHtmlString("<script type=\"text/javascript\">alert('i18n_DeptManageAction.update.faild_n81i');this.location='checkTypeSet.do?action=query&pageNo="+pageNo+"&pageSize="+pageSize+"'</script>");
		}
		
		return "updateCheckTypeSetInfo";
		
	}
	
	public void updateCheck(){
		boolean flagName = false;
		boolean flag = false;
		List list;
		try {
			list = this.commonService.find("from CheckTypeInfo where (checkTypeName1=? or tableName=?)  and id<>?",
							checkTypeInfo.getCheckTypeName1().trim(),checkTypeInfo.getTableName().trim().toUpperCase()
							,checkTypeInfo.getId());
			if (list != null && list.size() > 0) {
				flagName = true;
			}
			list = this.commonService.find("from CheckTypeInfo where (checkTypeName=? or tableName=?) and id<>?",
						checkTypeInfo.getCheckTypeName().trim(),checkTypeInfo.getTableName().trim().toUpperCase(),
						checkTypeInfo.getId());
			if (list != null && list.size() > 0) {
				flag = true;
			}
		} catch (Exception e) {
			e.printStackTrace();
			logger.info("编辑监测类别管理验证异常",e);
			this.outString("exception");
		}
		if(flagName && flag){
			this.outString(getI18nText("i18n_CheckTypeSetAction.addCheckTypeSetInfo.detecateNameAndTypeRepeat_n81i"));
			return;
		}else if(flagName && !flag){
			this.outString(getI18nText("i18n_CheckTypeSetAction.addCheckTypeSetInfo.detecateNameRepeat_n81i"));
			return;
		}else if(flag && !flagName){
			this.outString(getI18nText("i18n_CheckTypeSetAction.addCheckTypeSetInfo.detecateRepeat_n81i"));
			return;
		}
		//是否是SNMP类型如果表已生成禁止修改
		try {
			CheckTypeInfo cti = (CheckTypeInfo)this.commonService.get(CheckTypeInfo.class, checkTypeInfo.getId());
			if(!cti.getIsSnmp().equals(checkTypeInfo.getIsSnmp())){
				//判断表是否已生成
				//判断数据库中是否存在该表实体
				/*list = this.commonService.executeSQL("SELECT COUNT(*) from user_tables where table_name = ? ",checkTypeInfo.getTableName().trim().toUpperCase());
				if(Integer.parseInt(list.get(0).toString()) > 0){
					this.outString("数据表已存在，禁止修改SNMP监控！");
					return;
				}*/
				
				//@2018-3-8 11:22:10 mysql适配
				int num = this.commonService.isTableExist(checkTypeInfo.getTableName());
				if(num > 0){
					this.outString(getI18nText("i18n_CheckTypeSetAction.addCheckTypeSetInfo.tableExists_n81i"));
					return;
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			logger.info("验证表是否存在异常",e);
			this.outString(getI18nText("i18n_CheckTypeSetAction.addCheckTypeSetInfo.validateTable_n81i"));
		}
		this.outString("success");
	}
	
	public void doUpdateCheckTypeSet()throws Exception{
		try {
			commonService.beginTransaction();
			CheckTypeInfo cti = (CheckTypeInfo)this.commonService.get(CheckTypeInfo.class, checkTypeInfo.getId());
			if(!cti.getTableName().equals(checkTypeInfo.getTableName().trim().toUpperCase())){
				//与NMSServer通信
				this.sendCheckTypeId(cti.getId()+"",commonService);
			}
			cti.setGroupId(checkTypeInfo.getGroupId());
			cti.setCheckRemark(checkTypeInfo.getCheckRemark().trim());
			cti.setCheckTypeName(checkTypeInfo.getCheckTypeName().trim());//监测用的类别
			cti.setCheckTypeName1(checkTypeInfo.getCheckTypeName1().trim());//展示给用户用的类别名
			cti.setTableName(checkTypeInfo.getTableName().trim().toUpperCase());
			cti.setTableComments(checkTypeInfo.getTableComments().trim());
			cti.setViewLevel(checkTypeInfo.getViewLevel());
			cti.setIsSnmp(checkTypeInfo.getIsSnmp());
			cti.setSnmpOID(checkTypeInfo.getSnmpOID());
			cti.setIsSchedule(checkTypeInfo.getIsSchedule());
			this.commonService.update(cti);
			// 将更新操作写到操作日志中
			this.addDBOperationRpt(commonService,"check_type_info", "UPDATE", checkTypeInfo.getId());
			commonService.commit();
			outHtmlString("<script type=\"text/javascript\">alert('i18n_CheckTypeSetAction.downloadExample.success_n81i');this.location='checkTypeSet.do?action=query&pageNo="+pageNo+"&pageSize="+pageSize+"'</script>");
		} catch (Exception e) {
			logger.error(e.getStackTrace());
			e.printStackTrace();
			commonService.rollback();
			outHtmlString("<script type=\"text/javascript\">alert('i18n_DeptManageAction.update.faild_n81i');this.location='checkTypeSet.do?action=query&pageNo="+pageNo+"&pageSize="+pageSize+"'</script>");
		}
	}
	
	public void delCheckTypeSetInfo()throws Exception{
		try {
			commonService.beginTransaction();
			if(ids!=null && ids.length>0){
				for(Long setid : ids){
					CheckTypeInfo cti = (CheckTypeInfo)this.commonService.get(CheckTypeInfo.class,setid);
					String tableName =cti.getTableName().trim().toUpperCase();
					
					String csql="select count(*) from detection_set_info t where CHECK_TYPE_ID ="+setid;
					List list = this.commonService.executeSQL(csql);
					int num = Integer.parseInt(list.get(0).toString());
					if(num==0){
						//删除源数据
						this.commonService.delete(Metadata.class,"check_type_id",setid);
						// 将更新操作写到操作日志中
						this.addDBOperationRpt(commonService,"metadata", "DELETE", setid);
						//删除记录
						this.commonService.delete(CheckTypeInfo.class, "id", setid);
						// 将更新操作写到操作日志中
						this.addDBOperationRpt(commonService,"check_type_info", "DELETE", setid);
						//删除数据表实体
						/*String sql2 = "SELECT COUNT(*) from user_tables where table_name = '"+tableName+"'";
						List list2 = this.commonService.executeSQL(sql2);
						int num2 = Integer.parseInt(list2.get(0).toString());*/
						
						//@2018-3-8 11:22:10 mysql适配
						int num2 = this.commonService.isTableExist(tableName);
						if(num2>0){
							this.commonService.updateBatchBySql("drop table "+tableName);
						}
					}else{
						this.outHtmlString("<script>alert('i18n_CheckTypeSetAction.addCheckTypeSetInfo.detecateSetsExists_n81i');history.back();</script>");
						return;
					}
				}
			}
			commonService.commit();
			outHtmlString("<script type=\"text/javascript\">alert('i18n_CheckTypeSetAction.downloadExample.success_n81i');this.location='checkTypeSet.do?action=query&pageNo="+pageNo+"&pageSize="+pageSize+"'</script>");
		} catch (Exception e) {
			logger.error(e.getStackTrace());
			commonService.rollback();
			outHtmlString("<script type=\"text/javascript\">alert('i18n_DeptManageAction.update.faild_n81i');this.location='checkTypeSet.do?action=query&pageNo="+pageNo+"&pageSize="+pageSize+"'</script>");
		}
	}
	
	// 查询业务系统和用户组信息等等
	public void getNMSsystem() throws Exception{
		// 查询没有被删除的业务系统
		try {
			// 查询当前用户所在的用户组
//			List<XtYhJsIndex> usergrouplist = this.commonService
//					.find("from XtYhJsIndex t  where type=1 and  t.yhId = "
//							+ this.getUserID());
			// 根据用户组的id查找用户在和系统关系表
			// systemtablelist = new HashSet<SystemTable>();
			// for (XtYhJsIndex usergroupref : usergrouplist) {
			// List<GorupSystemTable> groupsystemtable = this.commonService
			// .findByProperty(GorupSystemTable.class, "userGroupId",
			// usergroupref.getJsbh());
			// // 根据用户组查询系统
			// for (GorupSystemTable group : groupsystemtable) {
			// List<SystemTable> systables = this.commonService
			// .find(" from SystemTable s where s.systemState=0 and s.id="
			// + group.getSystemId());
			// if (systables != null && systables.size() > 0) {
			// systemtablelist.add(systables.get(0));
			// }
			// }
			// }
			// 获取当前业务系统的信息
			systemTable = (SystemTable) this.commonService.get(
					SystemTable.class, this.getSystemID());
//			nodegrouptables = this.commonService
//					.findByProperty(NodegroupTable.class, "systemId",systemTable.getSystemId());
			//queryNodeGroupInfo();
			// 查找用户组
			usergroupLists = this.commonService.findByProperty(XtJsJbxx.class,"type", 1l);
			// 根据当前用户查找用户组
			List<XtYhJsIndex> userrefgroups = this.commonService
					.find(" from XtYhJsIndex where type=1 and yhId="
							+ this.getUserID());
			HashSet<XtJsJbxx> setxtjs = new HashSet<XtJsJbxx>();
			for (XtYhJsIndex xt : userrefgroups) {
				// 根据系统和当前用户组查找用户组关系
				List<GorupSystemTable> groupsystables = this.commonService
						.find("from GorupSystemTable g where g.userGroupId="
								+ xt.getJsbh() + " and g.systemId="
								+ this.getSystemID());
				// 添加到页面用户组
				for (GorupSystemTable grouptable : groupsystables) {
					@SuppressWarnings("unused")
					List<XtJsJbxx> grouplist = this.commonService
							.find("from XtJsJbxx x   where  x.type=1 and  x.jsbh="
									+ grouptable.getUserGroupId());
					XtJsJbxx xtjs = (XtJsJbxx) this.commonService.get(
							XtJsJbxx.class, grouptable.getUserGroupId());
					setxtjs.add(xtjs);
				}
			}
			this.getRequest().setAttribute("setxtjs", setxtjs);
		} catch (Exception e) {
			logger.error(e.getStackTrace());
			outHtmlString("<script type=\"text/javascript\">alert('i18n_DeptManageAction.update.faild_n81i');this.location='checkTypeSet.do?action=query'</script>");
		}
	}
	
	// 自动生成一个监测类别标识
	public String getCheckTypeIden(){
		String checkTypeIden = null;
		try {
			for(int i=0; i<1000; i++){
				long type = 0l;
				List list = this.commonService.executeSQL("select SEQ_CHECK_TYPE_NAME.nextval seq_id from dual");
				if(list.get(0) != null && !"".equals(list.get(0))){
					type = Long.parseLong(list.get(0).toString());
				}
				
				checkTypeIden = "checktype" + type;
				
				//判断记录是否存在
				String sql = "select count(*) from check_type_info t where CHECK_TYPE_NAME ='"+checkTypeIden+"'";
				list = this.commonService.executeSQL(sql);
				long num = Long.parseLong(list.get(0).toString());
				if(num<=0){// 不存在
					break;
				}
			}
		} catch (Exception e) {
			logger.error(e.getStackTrace());
			e.printStackTrace();
			checkTypeIden = "checktype0";
		}
		return checkTypeIden;
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

	public String getCtn() {
		return ctn;
	}

	public void setCtn(String ctn) {
		this.ctn = ctn;
	}

	public Long[] getIds() {
		return ids;
	}

	public void setIds(Long[] ids) {
		this.ids = ids;
	}

	public List<CheckTypeInfo> getCheckTypeSetList() {
		return checkTypeSetList;
	}

	public void setCheckTypeSetList(List<CheckTypeInfo> checkTypeSetList) {
		this.checkTypeSetList = checkTypeSetList;
	}

	public CheckTypeInfo getCheckTypeInfo() {
		return checkTypeInfo;
	}

	public void setCheckTypeInfo(CheckTypeInfo checkTypeInfo) {
		this.checkTypeInfo = checkTypeInfo;
	}

	public String getIsHaveTable() {
		return isHaveTable;
	}

	public void setIsHaveTable(String isHaveTable) {
		this.isHaveTable = isHaveTable;
	}

	public SystemTable getSystemTable() {
		return systemTable;
	}

	public void setSystemTable(SystemTable systemTable) {
		this.systemTable = systemTable;
	}

	public List<XtJsJbxx> getUsergroupLists() {
		return usergroupLists;
	}

	public void setUsergroupLists(List<XtJsJbxx> usergroupLists) {
		this.usergroupLists = usergroupLists;
	}

	public String getIsAdmin() {
		return isAdmin;
	}

	public void setIsAdmin(String isAdmin) {
		this.isAdmin = isAdmin;
	}

	public List<CheckTypeInfo> getAllCheckTypeInfo() {
		return allCheckTypeInfo;
	}

	public void setAllCheckTypeInfo(List<CheckTypeInfo> allCheckTypeInfo) {
		this.allCheckTypeInfo = allCheckTypeInfo;
	}

	public String getReplace() {
		return replace;
	}

	public void setReplace(String replace) {
		this.replace = replace;
	}

	public Logger getLogger() {
		return logger;
	}

	public void setLogger(Logger logger) {
		this.logger = logger;
	}

	public void setCheckTypeIden(String checkTypeIden) {
		this.checkTypeIden = checkTypeIden;
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
