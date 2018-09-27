package nis.nms.web.actions.detection;

import java.io.File;
import java.io.FileInputStream;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import net.sf.json.JSONArray;
import nis.nms.core.Constants;
import nis.nms.domains.CheckTypeInfo;
import nis.nms.domains.DetectionSetInfo;
import nis.nms.domains.GorupSystemTable;
import nis.nms.domains.NodeTable;
import nis.nms.domains.NodegroupTable;
import nis.nms.domains.SystemTable;
import nis.nms.domains.XtJsJbxx;
import nis.nms.domains.XtYhJbxx;
import nis.nms.domains.XtYhJsIndex;
import nis.nms.service.CommonService;
import nis.nms.util.BaseAction;
import nis.nms.util.ExportUtils;
import nis.nms.util.Page;
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

@SuppressWarnings("unchecked")
@Results( {
		@Result(name = "queryDetecSetInfoChild", value = "/page/detection/detecSetInfoListChild.jsp"),
		@Result(name = "queryDetecSetInfo", value = "/page/detection/detecSetInfoList.jsp"),
		@Result(name = "addDetecSetInfo", value = "/page/detection/addDetecSetInfo.jsp"),
		@Result(name = "updateDetecSetInfo", value = "/page/detection/updateDetecSetInfo.jsp"),
		@Result(name = "detailDetecSetInfo", value = "/page/detection/detailDetecSetInfo.jsp"),
		@Result(name = "showError", value = "/showImportError.jsp"),
		@Result(name = "error", value = "/error.jsp") })
/**
 * 监测设置相关操作
 */
public class DetectionSetAction20170315Bak extends BaseAction {
	private Logger logger = Logger.getLogger(DetectionSetAction.class);
	private static final long serialVersionUID = 1L;
	private CommonService commonService;
	private int pageNo = 1;
	private int pageSize = this.getDefaultPageSize(); // 每页显示的记录条数
	private Page page;
	private String action;
	private List<DetectionSetInfo> detecSetList;
	private List<NodegroupTable> nodeGroupList;
	private List<NodeTable> nodeList;
	private DetectionSetInfo detectionSetInfo;
	private SystemTable systemTable;
	private List<Long> userEmailIds;

	private List<XtJsJbxx> usergroupLists = new ArrayList<XtJsJbxx>();
	private List<CheckTypeInfo> allCheckTypeInfo;
	private Long[] ids;
	private String ip;
	private String ctn;
	private String gid;
	private String pIden;
	private String detectSetIden;
	
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
		if ("query".equals(this.action)) {
			queryCheckTypeInfo();
			// this.getRequest().setAttribute("ADMFlag", this.getAdminMark());
			resultpage = this.queryDetecSetInfo();
		} else if ("queryChild".equals(this.action)) {
			queryCheckTypeInfo();
			// this.getRequest().setAttribute("ADMFlag", this.getAdminMark());
			resultpage = this.queryDetecSetInfoChild();
		} else if ("openAdd".equals(this.action)) {
			this.getNMSsystem();
			// this.getRequest().setAttribute("ADMFlag", this.getAdminMark());
			this.queryCheckTypeInfo();
			this.queryNodeGroupInfo();
			this.getRequest().setAttribute("fromWhere", fromWhere);
			detectSetIden = getDetectSetIden();
			resultpage = "addDetecSetInfo";
		} else if ("doAdd".equals(this.action)) {
			addDetecSetInfo();
			return null;
		} else if ("openUpdate".equals(this.action)) {
			this.getNMSsystem();
			// this.getRequest().setAttribute("ADMFlag", this.getAdminMark());
			this.queryCheckTypeInfo();
			// this.queryNodeGroupInfo();
			resultpage = this.openUpdateDetecSet();
		} else if ("doUpdate".equals(this.action)) {
			doUpdateDetecSet();
			return null;
		} else if ("detail".equals(this.action)) {
			resultpage = this.detailDetecSetInfo();
		} else if ("policeSet".equals(this.action)) {
			resultpage = this.addpoliceSet();
		} else if ("getAllNode".equals(this.action)) {
			resultpage = this.getAllNode();

		} else if ("queryUserInfo".equals(this.action)) {
			resultpage = this.queryUserInfo();
		} else if ("start".equals(this.action)) {//保存修改信息
			start();
			return null;
		}else if ("stop".equals(this.action)) {//保存修改信息
			stop();
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
			resultpage = this.queryDetecSetInfo();
		}
		return resultpage;
	}

	// 模板下载   程辉 2013-5-13新增
	public String downloadExample() {
		try {
			StringBuffer hql = new StringBuffer();
			if (this.getAdminMark()) {// 如果是admin登陆则无限制
				hql.append("from DetectionSetInfo di where checkTypeInfo.isSchedule<>2");
			} else {
				//使用监测设置权限
				hql.append("from DetectionSetInfo di where checkTypeInfo.isSchedule<>2 and (( di.viewLevel=1 and di.createUserId=");
				hql.append(this.getUserID());
				hql.append(" and di.systemId ="+this.getSystemID()+")");
				hql.append(" or ( di.viewLevel=2 and di.createUserGroupId in (select  x.jsbh from  XtYhJsIndex  x  where x.yhbh='");
				hql.append(this.getUser().getYhbh());
				hql.append("' and x.type = 1) and di.systemId = "+this.getSystemID()+") or (di.viewLevel=3 and di.systemId = "+this.getSystemID()+")");
				hql.append(" or (di.viewLevel=4 )");
				hql.append(") ");
			}

			hql.append(" order by  detectionSetState desc, nodeIp desc, id asc ");
			page = this.commonService.findByPage(hql.toString(), 1, 3);
			List<DetectionSetInfo> st = (List<DetectionSetInfo>) page.getResult();
			st = getDetecSetGroupForShow(st);
			st = getDetecSetIDForName(st);
			
			String[] title = { "设置名称(必填)","设置标识(必填)","监测类别(必填)","节点组范围(例：1或1,2,3)","节点IP范围(例：1或1,2,3)","查看权限(必填 1、发布人查看；2发布人所在组，需选择组；3系统内全部人员查看，当前业务系统内；4、无限制)" 
					,"创建者所在用户组","监测首次执行时间(格式：2012-12-12 18:18:18)","监测数据时间间隔(分钟)(必填 必须大于或等于5分钟)","超时时间(秒)(必填)","尝试次数(必填)","状态(1有效，0无效)","启动方式(必填 0：手工启动 1：NC启动)"
					,"控制启动时间(格式：2012-12-12 18:18:18)","进程PID文件","进程搜索关键字","启动文件路径","联系人(例：1或1,2,3)"};
	
			String[] colu = { "processIdenName", "processIden","checkTypeInfo.checkTypeName1","nodeGroupsName","nodeIpsName","viewLevel", 
					"nodeIpsId","planCheckTime","checkGap","checkOutTime","checkMaxTimes", "detectionSetState","isControlStart",
					"controlStartTime","processFile","processSearchCode", "processPath","contactUserIds" };
			ExportUtils m = new ExportUtils();
			m.setAutoSizeColumn(true);
			m.exportExcel("监测设置管理信息表", st, title, colu,"downloadExample");
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
				String processIdenName="";
				String processIden="";
				CheckTypeInfo checkTypeInfo = new CheckTypeInfo();
				String nodeGroupsName="";
				String nodeIpsName="";
				long viewLevel=-25l;
				String createUserGroupId="";
				Date planCheckTime=null;
				long checkGap=-25l;
				long checkOutTime=-25l;
				long checkMaxTimes=-25l;
				String detectionSetState="";
				String isControlStart="";
				Date controlStartTime=null;
				String processFile="";
				String processSearchCode="";
				String processPath="";
				String contactUserIds="";
				
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
				Cell cell_10 = row.getCell((short) 9);
				Cell cell_11= row.getCell((short) 10);
				Cell cell_12 = row.getCell((short) 11);
				Cell cell_13 = row.getCell((short) 12);
				Cell cell_14 = row.getCell((short) 13);
				Cell cell_15 = row.getCell((short) 14);
				Cell cell_16 = row.getCell((short) 15);
				Cell cell_17 = row.getCell((short) 16);
				Cell cell_18 = row.getCell((short) 17);
				if ((null == cell_1 || 3 == cell_1.getCellType())
						&& (null == cell_2 || 3 == cell_2.getCellType())
						&& (null == cell_3 || 3 == cell_3.getCellType())
						&& (null == cell_4 || 3 == cell_4.getCellType())
						&& (null == cell_5 || 3 == cell_5.getCellType())
						&& (null == cell_6 || 3 == cell_6.getCellType())
						&& (null == cell_7 || 3 == cell_7.getCellType())
						&& (null == cell_8 || 3 == cell_8.getCellType())
						&& (null == cell_9 || 3 == cell_9.getCellType())
						&& (null == cell_10 || 3 == cell_10.getCellType())
						&& (null == cell_11 || 3 == cell_11.getCellType())
						&& (null == cell_12 || 3 == cell_12.getCellType())
						&& (null == cell_13 || 3 == cell_13.getCellType())
						&& (null == cell_14 || 3 == cell_14.getCellType())
						&& (null == cell_15 || 3 == cell_15.getCellType())
						&& (null == cell_16 || 3 == cell_16.getCellType())
						&& (null == cell_17 || 3 == cell_17.getCellType())
						&& (null == cell_18 || 3 == cell_18.getCellType())){
					sum--;
				}else {
					//设置名称
					if (null == cell_1) {
						errorInfo += i + "行1列节点设置名称不能为空;";
					} else if (cell_1.getCellType() == Cell.CELL_TYPE_STRING) {
						if ("".equals(cell_1.getStringCellValue())) {
							errorInfo += i + "行1列节点设置名称不能为空;";
						} else {
							processIdenName = cell_1.getStringCellValue().trim();
						}
					} else {
						errorInfo += i + "行1列节点设置名称错误;";
					}
					//设置标识
					if (null == cell_2) {
						errorInfo += i + "行2列节点设置标识不能为空;";
					} else if (cell_2.getCellType() == Cell.CELL_TYPE_STRING) {
						if ("".equals(cell_2.getStringCellValue())) {
							errorInfo += i + "行2列节点设置标识不能为空;";
						} else {
							processIden = cell_2.getStringCellValue().trim();
						}
					} else {
						errorInfo += i + "行2列节点设置标识错误;";
					}
					//监测类别
					if (null == cell_3) {
						errorInfo += i + "行3列节点监测类别不能为空;";
					} else if (cell_3.getCellType() == Cell.CELL_TYPE_NUMERIC) {
						checkTypeInfo.setCheckTypeName1(String.valueOf((int)cell_3.getNumericCellValue()));
					} else if (cell_3.getCellType() == Cell.CELL_TYPE_STRING) {
						checkTypeInfo.setCheckTypeName1(cell_3.getStringCellValue());
					}else {
						errorInfo += i + "行3列节点监测类别错误;";
					}					
					//节点组范围
					if (null == cell_4||cell_4.getCellType()==Cell.CELL_TYPE_BLANK) {
					} else if (cell_4.getCellType() == Cell.CELL_TYPE_STRING) {
						nodeGroupsName = cell_4.getStringCellValue().trim();
					} else if (cell_4.getCellType() == Cell.CELL_TYPE_NUMERIC) {
						nodeGroupsName = String.valueOf(cell_4.getNumericCellValue());
					} else {
						errorInfo += i + "行4列节点节点组范围错误;";
					}
					//节点范围
					if (null == cell_5 ||cell_5.getCellType()==Cell.CELL_TYPE_BLANK) {
					} else if (cell_5.getCellType() == Cell.CELL_TYPE_STRING) {
						nodeIpsName = cell_5.getStringCellValue().trim();
					} else if (cell_5.getCellType() == Cell.CELL_TYPE_NUMERIC) {
						nodeIpsName = String.valueOf(cell_5.getNumericCellValue());
					} else {
						errorInfo += i + "行5列节点节点范围错误;";
					}
					//查看权限
					if (null == cell_6) {
						errorInfo += i + "行6列节点查看权限不能为空;";
					} else if (cell_6.getCellType() == Cell.CELL_TYPE_NUMERIC) {
						viewLevel= (long)cell_6.getNumericCellValue();
					} else {
						errorInfo += i + "行6列节点查看权限错误;";
					}
					//创建者所在用户组
					if (null == cell_7 ||cell_7.getCellType()==Cell.CELL_TYPE_BLANK||(cell_7.getCellType()==Cell.CELL_TYPE_STRING&&cell_7.getStringCellValue().equals(""))) {
					} else if (cell_7.getCellType() == Cell.CELL_TYPE_NUMERIC) {
						createUserGroupId= String.valueOf((int)cell_7.getNumericCellValue());
					}else if(cell_7.getCellType()==Cell.CELL_TYPE_STRING){
						createUserGroupId= cell_7.getStringCellValue().trim();
					}else {
						errorInfo += i + "行7列节点创建者所在用户组错误;";
					}
					//监测首次执行时间
					if (null == cell_8 ||cell_8.getCellType()==Cell.CELL_TYPE_BLANK) {
					} else if (cell_8.getCellType() == Cell.CELL_TYPE_STRING) {
						if(!cell_8.getStringCellValue().equals("")){
							try {
								planCheckTime= new SimpleDateFormat("yyyy-MM-dd hh:mm:ss").parse(cell_8.getStringCellValue());
							} catch (Exception e) {
								// TODO: handle exception
								errorInfo += i + "行8列节点监测首次执行时间格式错误;";
							}
						}
					} else if (cell_8.getCellType() == Cell.CELL_TYPE_NUMERIC) {
						planCheckTime=cell_8.getDateCellValue();
					} else {
						errorInfo += i + "行8列节点监测首次执行时间错误;";
					}
					//监测数据时间间隔(分钟)
					if (null == cell_9) {
						errorInfo += i + "行9列节点监测数据时间间隔不能为空;";
					} else if (cell_9.getCellType() == Cell.CELL_TYPE_NUMERIC) {
						checkGap= (long)cell_9.getNumericCellValue();
					} else {
						errorInfo += i + "行9列节点监测数据时间间隔错误;";
					}
					//超时时间(秒)
					if (null == cell_10) {
						errorInfo += i + "行10列节点超时时间不能为空;";
					} else if (cell_10.getCellType() == Cell.CELL_TYPE_NUMERIC) {
						checkOutTime= (long)cell_10.getNumericCellValue();
					} else {
						errorInfo += i + "行10列节点超时时间错误;";
					}
					//尝试次数
					if (null == cell_11) {
						errorInfo += i + "行11列节点尝试次数不能为空;";
					} else if (cell_11.getCellType() == Cell.CELL_TYPE_NUMERIC) {
						checkMaxTimes= (long)cell_11.getNumericCellValue();
					} else {
						errorInfo += i + "行11列节点尝试次数错误;";
					}
					//状态
					if (null == cell_12 ||cell_12.getCellType()==Cell.CELL_TYPE_BLANK) {
					} else if (cell_12.getCellType() == Cell.CELL_TYPE_STRING) {
						detectionSetState = cell_12.getStringCellValue().trim();
					} else if (cell_12.getCellType() == Cell.CELL_TYPE_NUMERIC) {
						detectionSetState = String.valueOf((int)cell_12.getNumericCellValue());
					} else {
						errorInfo += i + "行12列节点状态错误;";
					}
					//启动方式
					if (null == cell_13 ||cell_13.getCellType()==Cell.CELL_TYPE_BLANK) {
						errorInfo += i + "行13列节点启动方式不能为空;";
					} else if (cell_13.getCellType() == Cell.CELL_TYPE_STRING) {
						isControlStart = cell_13.getStringCellValue().trim();
					} else if (cell_13.getCellType() == Cell.CELL_TYPE_NUMERIC) {
						isControlStart = String.valueOf((int)cell_13.getNumericCellValue());
					} else {
						errorInfo += i + "行13列节点启动方式错误;";
					}
					//控制启动时间
					if (null == cell_14||cell_14.getCellType()==Cell.CELL_TYPE_BLANK) {
					} else if (cell_14.getCellType() == Cell.CELL_TYPE_STRING) {
						if(!cell_14.getStringCellValue().equals("")){
							try {
								controlStartTime= new SimpleDateFormat("yyyy-MM-dd hh:mm:ss").parse(cell_14.getStringCellValue());
							} catch (Exception e) {
								// TODO: handle exception
								errorInfo += i + "行14列节点控制启动时间格式错误;";
							}
						}
					}else if(cell_14.getCellType() == Cell.CELL_TYPE_NUMERIC){
						controlStartTime=cell_14.getDateCellValue();
					} else {
						errorInfo += i + "行14列节点控制启动时间错误;";
					}
					//进程PID文件
					if (null == cell_15 ||cell_15.getCellType()==Cell.CELL_TYPE_BLANK) {
					} else if (cell_15.getCellType() == Cell.CELL_TYPE_STRING) {
						processFile = cell_15.getStringCellValue().trim();
					} else {
						errorInfo += i + "行15列节点进程PID文件错误;";
					}
					//进程搜索关键字
					if (null == cell_16 ||cell_16.getCellType()==Cell.CELL_TYPE_BLANK) {
					} else if (cell_16.getCellType() == Cell.CELL_TYPE_STRING) {
						processSearchCode = cell_16.getStringCellValue().trim();
					} else {
						errorInfo += i + "行16列节点进程搜索关键字错误;";
					}
					//启动文件路径
					if (null == cell_17||cell_17.getCellType()==Cell.CELL_TYPE_BLANK) {
					} else if (cell_17.getCellType() == Cell.CELL_TYPE_STRING) {
						processPath = cell_17.getStringCellValue().trim();
					} else {
						errorInfo += i + "行17列节点启动文件路径错误;";
					}
					//联系人ID		
					if (null == cell_18 ||cell_18.getCellType()==Cell.CELL_TYPE_BLANK) {
					} else if (cell_18.getCellType() == Cell.CELL_TYPE_STRING) {
						contactUserIds = cell_18.getStringCellValue().trim();
					} else if (cell_18.getCellType() == Cell.CELL_TYPE_NUMERIC) {
						contactUserIds = String.valueOf((int)cell_18.getNumericCellValue());
					} else {
						errorInfo += i + "行18列节点联系人错误;";
					}
					
					if ("".equals(errorInfo)) {// 保存节点
						errorInfo = this.saveNode(processIdenName,processIden,checkTypeInfo,nodeGroupsName,nodeIpsName,viewLevel,
						createUserGroupId,planCheckTime,checkGap,checkOutTime,checkMaxTimes,detectionSetState,isControlStart,controlStartTime,
						processFile,processSearchCode,processPath,contactUserIds);
					}
					if ("".equals(errorInfo)) {
						count++;
					} else {
						errorList.add(processIdenName);
						errorList.add(processIden);
						errorList.add(checkTypeInfo.getCheckTypeName1());
						errorList.add(nodeGroupsName);
						errorList.add(nodeIpsName);
						if(viewLevel==-25){
							errorList.add("");
						}else{
							errorList.add(String.valueOf((int)viewLevel));
						}
						errorList.add(createUserGroupId);
						if (null == planCheckTime) {
							errorList.add("");
						} else {
							errorList.add(new SimpleDateFormat(
									"yyyy-MM-dd hh:mm:ss")
									.format(planCheckTime));
						}
						if(checkGap==-25){
							errorList.add("");
						}else{
							errorList.add(String.valueOf((int)checkGap));
						}
						if(checkOutTime==-25){
							errorList.add("");
						}else{
							errorList.add(String.valueOf((int)checkOutTime));
						}
						if(checkMaxTimes==-25){
							errorList.add("");
						}else{
							errorList.add(String.valueOf((int)checkMaxTimes));
						}
						errorList.add(detectionSetState);
						errorList.add(isControlStart);
						if (null == controlStartTime) {
							errorList.add("");
						} else {
							errorList.add(new SimpleDateFormat(
									"yyyy-MM-dd hh:mm:ss")
									.format(controlStartTime));
						}
						errorList.add(processFile);
						errorList.add(processSearchCode);
						errorList.add(processPath);
						errorList.add(contactUserIds);
						errorList.add(errorInfo);
						rowList.add(errorList);
						errorInfo = "";
					}
				}
			}
			headerList.add("设置名称");
			headerList.add("设置标识");
			headerList.add("监测类别");
			headerList.add("节点组范围");
			headerList.add("节点范围");
			headerList.add("查看权限");
			headerList.add("创建者所在用户组");
			headerList.add("监测首次执行时间");
			headerList.add("监测数据时间间隔(分钟)");
			headerList.add("超时时间(秒)");
			headerList.add("尝试次数");
			headerList.add("状态");
			headerList.add("启动方式");
			headerList.add("控制启动时间");
			headerList.add("进程PID文件");
			headerList.add("进程搜索关键字");
			headerList.add("启动文件路径");
			headerList.add("联系人");
			headerList.add("错误信息");
			this.getRequest().setAttribute("rowList", rowList);
			this.getRequest().setAttribute("headerList", headerList);
			if (count == sum && sum > 0) {
//				this.getRequest().setAttribute("MSG", 1);
//				return  this.queryDetecSetInfo();
				outHtmlString("<script type=\"text/javascript\">alert('操作成功');this.location='detectionSet.do?action=query'</script>");
				return null;
			} else if (sum == 0) {
				this
						.outHtmlString("<script>alert('选择的文件为空，请重新选择！');history.back();</script>");
				return null;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "showError";
	}

	private String saveNode(String processIdenName,String processIden,CheckTypeInfo checkTypeInfo,String nodeGroupsName,String nodeIpsName,long viewLevel,
			String createUserGroupId,Date planCheckTime,long checkGap,long checkOutTime,long checkMaxTimes,String detectionSetState,String isControlStart,Date controlStartTime,
			String processFile,String processSearchCode,String processPath,String contactUserIds) {
		String desc = "";
		DetectionSetInfo detectionSetInfo = new DetectionSetInfo();
		try {
			// 保存节点信息
			detectionSetInfo.setProcessIdenName(processIdenName);
			detectionSetInfo.setProcessIden(processIden);
			
			List<CheckTypeInfo> clist = commonService.find("from CheckTypeInfo where checkTypeName1=?", checkTypeInfo.getCheckTypeName1());
			if(clist!=null&&clist.size()>0){
				detectionSetInfo.setCheckTypeInfo(clist.get(0));
			}else{
				return "监测类别名称不存在";
			}
			String nodeGroupsId="";
			String nodeIpsId="";
			if(nodeGroupsName!=null&&!nodeGroupsName.equals("")){
				if(nodeGroupsName.endsWith(",")||nodeGroupsName.startsWith(",")){
					return "节点组名称格式错误";
				}
				String[] GroupNames = nodeGroupsName.split(",");
				for (int i = 0; i < GroupNames.length; i++) {
					List<NodegroupTable> nodeGroupTables = this.commonService.find(
							"from NodegroupTable where groupName=? ", GroupNames[i].trim());
					if(nodeGroupTables!=null && nodeGroupTables.size()>0){
						NodegroupTable nodeGroup = nodeGroupTables.get(0);
						nodeGroupsId += nodeGroup.getGroupId() + ",";
					}else{
						return "节点组名称"+GroupNames[i]+"不存在";
					}
				}
				detectionSetInfo.setNodeGroupsId(nodeGroupsId.substring(0,nodeGroupsId.length()-1));
			}
			
			if(nodeIpsName!=null&&!nodeIpsName.equals("")){
				if(nodeIpsName.endsWith(",")||nodeIpsName.startsWith(",")){
					return "节点IP格式错误";
				}
				String[] IpNames = nodeIpsName.split(",");
				for (int i = 0; i < IpNames.length; i++) {
					List<NodeTable> nodeTableGroup = this.commonService.find(
							"from NodeTable where nodeIp=? ", IpNames[i].trim());
					if (nodeTableGroup != null && nodeTableGroup.size() > 0) {
						NodeTable nodeTable = nodeTableGroup.get(0);
						nodeIpsId += nodeTable.getNodeId() + ",";
					} else {
						return "节点IP"+IpNames[i]+"不存在";
					}
				}
				detectionSetInfo.setNodeIpsId(nodeIpsId.substring(0,nodeIpsId.length()-1));
			}
			
			detectionSetInfo.setViewLevel(viewLevel);
			//detectionSetInfo.setCreateUserGroupId(createUserGroupId);
			detectionSetInfo.setPlanCheckTime(planCheckTime);
			detectionSetInfo.setCheckGap(checkGap);
			detectionSetInfo.setCheckOutTime(checkOutTime);
			detectionSetInfo.setCheckMaxTimes(checkMaxTimes);
			detectionSetInfo.setDetectionSetState(detectionSetState);
			detectionSetInfo.setIsControlStart(isControlStart);
			detectionSetInfo.setControlStartTime(controlStartTime);
			detectionSetInfo.setProcessFile(processFile);
			detectionSetInfo.setProcessSearchCode(processSearchCode);
			detectionSetInfo.setProcessPath(processPath);
			if(!contactUserIds.equals("")){
				String[] UserNames = contactUserIds.split(",");
				String UserIds = "";
				for (int i = 0; i < UserNames.length; i++) {
					List<XtYhJbxx> xtYhJbxxList = commonService.find("from XtYhJbxx where yhmc='"+UserNames[i]+"'");
					if(xtYhJbxxList!=null&&xtYhJbxxList.size()>0){
						UserIds +=xtYhJbxxList.get(0).getYhid()+",";
					}else{
						return "用户名"+ UserNames[i]+"不存在;";
					}
				}
				detectionSetInfo.setContactUserIds(UserIds.substring(0, UserIds.length()-1));
			}

			List list = null;
			boolean flagName = false;
			StringBuffer hqlBuffer = null;
			// 判断监测类别是否存在
			hqlBuffer = new StringBuffer();
			hqlBuffer
					.append("from CheckTypeInfo where id=?");
			list = this.commonService.find(hqlBuffer.toString(),detectionSetInfo.getCheckTypeInfo().getId());
			if (list == null || list.size() == 0) {
				return "监测类别ID不存在;";
			}
			// 先判断设置的节点范围是否重复
			if (detectionSetInfo.getNodeIpsId() != null
					&& !"".equals(detectionSetInfo.getNodeIpsId())) {// 节点组和节点都不为空
				hqlBuffer = new StringBuffer();
				hqlBuffer
						.append("from DetectionSetInfo where nodeGroupsId = ? and nodeIpsId= ? and checkTypeInfo.id= ? ");
				list = this.commonService.find(hqlBuffer.toString(),
						detectionSetInfo.getNodeGroupsId(), detectionSetInfo
								.getNodeIpsId(), detectionSetInfo
								.getCheckTypeInfo().getId());
				if (list != null && list.size() > 0) {
					return "设置节点范围重复;";
				}
			} else if (detectionSetInfo.getNodeGroupsId() != null
					&& !"".equals(detectionSetInfo.getNodeGroupsId())) {// 节点组不为空，节点为空
				hqlBuffer = new StringBuffer();
				hqlBuffer
						.append("from DetectionSetInfo where nodeGroupsId = ? and checkTypeInfo.id= ?  and (nodeIpsId='' or nodeIpsId is null) ");
				list = this.commonService.find(hqlBuffer.toString(),
						detectionSetInfo.getNodeGroupsId(), detectionSetInfo
								.getCheckTypeInfo().getId());
				if (list != null && list.size() > 0) {
					return "设置节点组范围重复;";
				}
			} else {// 节点组、节点均为空
				hqlBuffer = new StringBuffer();
				hqlBuffer
						.append("from DetectionSetInfo where (nodeGroupsId ='' or nodeGroupsId is null) and checkTypeInfo.id= ?  and (nodeIpsId='' or nodeIpsId is null) ");
				list = this.commonService.find(hqlBuffer.toString(),
						detectionSetInfo.getCheckTypeInfo().getId());
				if (list != null && list.size() > 0) {
					return "设置范围重复;";
				}

			}
			// 判断数据是否存在
			list = this.commonService
					.find(
							"from DetectionSetInfo where checkTypeInfo.id=? and PROCESS_IDEN_NAME=?",
							detectionSetInfo.getCheckTypeInfo().getId(),
							detectionSetInfo.getProcessIdenName());
			if (list != null && list.size() > 0) {
				flagName = true;
			}
			list = this.commonService
					.find(
							"from DetectionSetInfo where checkTypeInfo.id=? and processIden=?",
							detectionSetInfo.getCheckTypeInfo().getId(),
							detectionSetInfo.getProcessIden());
			if (list != null && list.size() > 0) {
				if (flagName) {
					return "设置名称重复和设置标识重复;";
				} else {
					return "设置标识重复;";
				}
			} else {
				if (flagName) {
					return "设置名称重复;";
				}
			}
			CheckTypeInfo typeInfo = (CheckTypeInfo) this.commonService.get(
					CheckTypeInfo.class, detectionSetInfo.getCheckTypeInfo()
							.getId());
			detectionSetInfo.setCheckTypeInfo(typeInfo);
			detectionSetInfo.setIsIssueFile("1");
			detectionSetInfo.setIsIssued("1");
			if (typeInfo.getId() == 6//ping
					|| typeInfo.getId() == 7//握手
					|| typeInfo.getId() == 5//时间差=时钟同步
					|| (typeInfo.getIsSnmp() != null && (typeInfo.getIsSnmp() == 0l || typeInfo
							.getIsSnmp() == 1l))) {
				detectionSetInfo.setCheckWay("0");
			} else {
				detectionSetInfo.setCheckWay("1");
			}
			if((typeInfo.getId()==8||(typeInfo.getId()>8&&typeInfo.getIsSnmp()!=1))&&detectionSetInfo.getIsControlStart().equals("1")){
				if(detectionSetInfo.getProcessFile().equals("")){
					return "当前监测类别和启动方式下，进程PID文件不能为空；";
				}
				if(detectionSetInfo.getProcessSearchCode().equals("")){
					return "当前监测类别和启动方式下，进程搜索关键字不能为空；";
				}
				if(detectionSetInfo.getProcessPath().equals("")){
					return "当前监测类别和启动方式下，启动文件路径不能为空；";
				}
			}else if(typeInfo.getId()==8&&detectionSetInfo.getIsControlStart().equals("0")){
				if(detectionSetInfo.getProcessFile().equals("")){
					return "当前监测类别和启动方式下，进程PID文件不能为空；";
				}
				if(detectionSetInfo.getProcessSearchCode().equals("")){
					return "当前监测类别和启动方式下，进程搜索关键字不能为空；";
				}
			}
			//判断不同查看权限下的数据是否合理
			if(detectionSetInfo.getViewLevel()==2){
				if(createUserGroupId.equals("")){
					return "当前查看权限下用户组不能为空;";
				}else{
					List<XtJsJbxx> xtJsJbxxList = commonService.find("from XtJsJbxx where jsmc='"+createUserGroupId+"'");
					if(xtJsJbxxList!=null&&xtJsJbxxList.size()>0){
						detectionSetInfo.setCreateUserGroupId(xtJsJbxxList.get(0).getJsbh());						
					}else{
						return "用户组不存在;";
					}
				}
			}
			if(detectionSetInfo.getViewLevel()==3){
				detectionSetInfo.setSystemId(this.getSystemID());
			}
			
			//监测数据时间间隔必须大于或等于5分钟 
			if(detectionSetInfo.getCheckGap()<5){
				return "监测数据时间间隔必须大于或等于5分钟;";
			}
			
			if (detectionSetInfo.getNodegroup() == null
					|| detectionSetInfo.getNodegroup().getGroupId() == null) {
				detectionSetInfo.setNodegroup(null);
			} else {
				NodegroupTable ng = (NodegroupTable) this.commonService.get(
						NodegroupTable.class, detectionSetInfo.getNodegroup()
								.getGroupId());
				detectionSetInfo.setNodegroup(ng);
			}
			//detectionSetInfo.setNodeIp(detectionSetInfo.getNodeIpsName());
			detectionSetInfo.setCreateUserId(this.getUserID());
			//detectionSetInfo.setSystemId(this.getSystemID());
			this.commonService.save(detectionSetInfo);
			// 将更新操作写到操作日志中
			this.addDBOperationRpt(commonService, "detection_Set_Info",
					"INSERT", detectionSetInfo.getId());
			// 用来实现即时向客户端发送配置信息
			sendSetInfo(null, detectionSetInfo, commonService);
		} catch (Exception e) {
			e.printStackTrace();
			desc = "该节点信息导入异常;";
		}
		return desc;
	}
	
	// 当前页导出   程辉 2013-5-8新增
	public String emportCurrentXls() {
		try {
			StringBuffer hql = new StringBuffer();
			if (this.getAdminMark()) {// 如果是admin登陆则无限制
				hql.append("from DetectionSetInfo di where checkTypeInfo.isSchedule<>2");
			} else {
				//使用监测设置权限
				hql.append("from DetectionSetInfo di where checkTypeInfo.isSchedule<>2 and (( di.viewLevel=1 and di.createUserId=");
				hql.append(this.getUserID());
				hql.append(" and di.systemId ="+this.getSystemID()+")");
				hql.append(" or ( di.viewLevel=2 and di.createUserGroupId in (select  x.jsbh from  XtYhJsIndex  x  where x.yhbh='");
				hql.append(this.getUser().getYhbh());
				hql.append("' and x.type = 1) and di.systemId = "+this.getSystemID()+") or (di.viewLevel=3 and di.systemId = "+this.getSystemID()+")");
				hql.append(" or (di.viewLevel=4 )");
				hql.append(") ");
			}
			if (ip != null && !"".equals(ip)) {
				hql.append(" and instr(nodeIp,'"+ip.trim()+"') <> 0");
			}
			if (ctn != null && !"".equals(ctn)) {
				hql.append(" and checkTypeInfo.id = " + ctn);
			}

			if (pIden != null && !"".equals(pIden)) {
				hql.append(" and Upper(processIdenName) like '%" + pIden.trim().toUpperCase() + "%'");
			}

			hql.append(" order by  detectionSetState desc, nodeIp desc, id asc ");
			page = this.commonService.findByPage(hql.toString(), pageNo, pageSize);
			List<DetectionSetInfo> detecSetList = (List<DetectionSetInfo>) page.getResult();
			detecSetList = getDetecSetGroupForShow(detecSetList);
			
			for(int i=0;i<detecSetList.size();i++){
				if(detecSetList.get(i).getIsControlStart().equals("0")){
					detecSetList.get(i).setIsControlStart("手动启动");
				}
				if(detecSetList.get(i).getIsControlStart().equals("1")){
					detecSetList.get(i).setIsControlStart("NC启动");
				}
				if(detecSetList.get(i).getCheckTypeInfo().getIsSchedule().equals("0")){
					detecSetList.get(i).getCheckTypeInfo().setIsSchedule("是");
				}
				if(detecSetList.get(i).getCheckTypeInfo().getIsSchedule().equals("1")){
					detecSetList.get(i).getCheckTypeInfo().setIsSchedule("否");
				}
				if(detecSetList.get(i).getDetectionSetState().equals("0")){
					detecSetList.get(i).setDetectionSetState("无效");
				}
				if(detecSetList.get(i).getDetectionSetState().equals("1")){
					detecSetList.get(i).setDetectionSetState("有效");
				}
			}
			
			String[] title = { "节点组","节点IP","监测类别名称","监测间隔(分钟)","尝试次数","超时时间(秒)" 
					,"首次监测时间","设置名称","进程PID文件","启动文件路径","启动方式","控制启动时间","是否预置信息","状态"};
	
			String[] colu = { "nodeGroupsName", "nodeIpsName","checkTypeInfo.checkTypeName1","checkGap","checkMaxTimes","checkOutTime", "planCheckTime",
					"processIdenName","processFile","processPath","isControlStart", "controlStartTime","checkTypeInfo.isSchedule","detectionSetState"};
			ExportUtils m = new ExportUtils();
			m.setAutoSizeColumn(true);
			m.exportExcel("监测设置管理信息表", detecSetList, title, colu);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	// 导出全部   程辉 2013-5-8新增
	public String emportAllXls() {
		try {
			StringBuffer hql = new StringBuffer();
			if (this.getAdminMark()) {// 如果是admin登陆则无限制
				hql.append("from DetectionSetInfo di where checkTypeInfo.isSchedule<>2");
			} else {
				//使用监测设置权限
				hql.append("from DetectionSetInfo di where checkTypeInfo.isSchedule<>2 and (( di.viewLevel=1 and di.createUserId=");
				hql.append(this.getUserID());
				hql.append(" and di.systemId ="+this.getSystemID()+")");
				hql.append(" or ( di.viewLevel=2 and di.createUserGroupId in (select  x.jsbh from  XtYhJsIndex  x  where x.yhbh='");
				hql.append(this.getUser().getYhbh());
				hql.append("' and x.type = 1) and di.systemId = "+this.getSystemID()+") or (di.viewLevel=3 and di.systemId = "+this.getSystemID()+")");
				hql.append(" or (di.viewLevel=4 )");
				hql.append(") ");
			}
			if (ip != null && !"".equals(ip)) {
				hql.append(" and instr(nodeIp,'"+ip.trim()+"') <> 0");
			}
			if (ctn != null && !"".equals(ctn)) {
				hql.append(" and checkTypeInfo.id = " + ctn);
			}

			if (pIden != null && !"".equals(pIden)) {
				hql.append(" and Upper(processIdenName) like '%" + pIden.trim().toUpperCase() + "%'");
			}

			hql.append(" order by  detectionSetState desc, nodeIp desc, id asc ");
			List<DetectionSetInfo> detecSetList  = this.commonService.find(hql.toString());
			detecSetList = getDetecSetGroupForShow(detecSetList);
			
			for(int i=0;i<detecSetList.size();i++){
				if(detecSetList.get(i).getIsControlStart().equals("0")){
					detecSetList.get(i).setIsControlStart("手动启动");
				}
				if(detecSetList.get(i).getIsControlStart().equals("1")){
					detecSetList.get(i).setIsControlStart("NC启动");
				}
				if(detecSetList.get(i).getCheckTypeInfo().getIsSchedule().equals("0")){
					detecSetList.get(i).getCheckTypeInfo().setIsSchedule("是");
				}
				if(detecSetList.get(i).getCheckTypeInfo().getIsSchedule().equals("1")){
					detecSetList.get(i).getCheckTypeInfo().setIsSchedule("否");
				}
				if(detecSetList.get(i).getDetectionSetState().equals("0")){
					detecSetList.get(i).setDetectionSetState("无效");
				}
				if(detecSetList.get(i).getDetectionSetState().equals("1")){
					detecSetList.get(i).setDetectionSetState("有效");
				}
			}
			
			String[] title = { "节点组","节点IP","监测类别名称","监测间隔(分钟)","尝试次数","超时时间(秒)" 
					,"首次监测时间","设置名称","进程PID文件","启动文件路径","启动方式","控制启动时间","是否预置信息","状态"};
	
			String[] colu = { "nodeGroupsName", "nodeIpsName","checkTypeInfo.checkTypeName1","checkGap","checkMaxTimes","checkOutTime", "planCheckTime",
					"processIdenName","processFile","processPath","isControlStart", "controlStartTime","checkTypeInfo.isSchedule","detectionSetState"};
			ExportUtils m = new ExportUtils();
			m.setAutoSizeColumn(true);
			m.exportExcel("监测设置管理信息表", detecSetList, title, colu);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}	
	
	public String queryDetecSetInfo() {
		try {
			isComplete = this.getRequest().getParameter("isComplete");
			StringBuffer hql = new StringBuffer();
			if (this.getAdminMark()) {// 如果是admin登陆则无限制
				//hql = "from DetectionSetInfo di where checkTypeInfo.isSchedule<>2";
				hql.append("from DetectionSetInfo di where checkTypeInfo.isSchedule<>2");
			} else {
				// 权限控制------begin
				/*String sqlparam = " or (di.checkTypeInfo.viewLevel=4 )";
				hql = "from DetectionSetInfo t where checkTypeInfo.isSchedule<>2 and (( di.checkTypeInfo.viewLevel=1 and di.checkTypeInfo.userId="
						+ this.getUserID()
						+ ")"
						+ " or ( di.checkTypeInfo.viewLevel=2 and di.checkTypeInfo.groupId in (select  x.jsbh from  XtYhJsIndex  x  where x.yhbh='"
						+ this.getUser().getYhbh()
						+ "' and x.type = 1)) or (di.checkTypeInfo.viewLevel=3 and di.checkTypeInfo.systemId = "
						+ this.getSystemID() + ")" + sqlparam + ") ";*/
				// -------------end
				//使用监测类别的权限
				/*//权限控制--------begin
				hql.append("from CheckTypeInfo t where isSchedule<>2 and (( t.viewLevel=1 and t.userId=");
				hql.append(this.getUserID());
				hql.append(" and t.systemId ="+this.getSystemID()+")");
				hql.append(" or ( t.viewLevel=2 and t.groupId in (select  x.jsbh from  XtYhJsIndex  x  where x.yhbh='");
				hql.append(this.getUser().getYhbh());
				hql.append("' and x.type = 1) and t.systemId = "+this.getSystemID()+") or (t.viewLevel=3 and t.systemId = "+this.getSystemID()+")");
				hql.append(" or (t.viewLevel=4 )");
				hql.append(") ");
				//----------------end*/
				//使用监测设置权限
				hql.append("from DetectionSetInfo di where checkTypeInfo.isSchedule<>2 and (( di.viewLevel=1 and di.createUserId=");
				hql.append(this.getUserID());
				hql.append(" and di.systemId ="+this.getSystemID()+")");
				hql.append(" or ( di.viewLevel=2 and di.createUserGroupId in (select  x.jsbh from  XtYhJsIndex  x  where x.yhbh='");
				hql.append(this.getUser().getYhbh());
				hql.append("' and x.type = 1) and di.systemId = "+this.getSystemID()+") or (di.viewLevel=3 and di.systemId = "+this.getSystemID()+")");
				hql.append(" or (di.viewLevel=4 )");
				hql.append(") ");
			}
			if (ip != null && !"".equals(ip)) {
				//hql += " and nodeIp like '%" + ip.trim() + "%'";
				//hql.append(" and nodeIp like '%" + ip.trim() + "%'");
				hql.append(" and instr(nodeIp,'"+ip.trim()+"') <> 0");
			}
			if (ctn != null && !"".equals(ctn)) {
				//hql += " and checkTypeInfo.id = " + ctn;
				hql.append(" and checkTypeInfo.id = " + ctn);
			}

			if (pIden != null && !"".equals(pIden)) {
				//hql += " and processIdenName like '%" + pIden.trim() + "%'";
				hql.append(" and Upper(processIdenName) like '%" + pIden.trim().toUpperCase() + "%'");
			}

			//hql += " order by  detectionSetState desc, nodeIp desc, id asc ";
			hql.append(" order by  detectionSetState desc, nodeIp desc, id asc ");
			System.out.println(hql.toString());
			page = this.commonService.findByPage(hql.toString(), pageNo, pageSize);
			detecSetList = (List<DetectionSetInfo>) page.getResult();
			detecSetList = getDetecSetGroupForShow(detecSetList);
			queryCheckTypeInfo();
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(e.getStackTrace());
			outHtmlString("<script type=\"text/javascript\">alert('操作失败');this.location='detectionSet.do?action=query&pageNo="
					+ pageNo + "&pageSize=" + pageSize + "'</script>");
		}
		return "queryDetecSetInfo";
	}
	
	public String queryDetecSetInfoChild() {
		try {
			isComplete = this.getRequest().getParameter("isComplete");
			StringBuffer hql = new StringBuffer();
			if (this.getAdminMark()) {// 如果是admin登陆则无限制
				//hql = "from DetectionSetInfo di where checkTypeInfo.isSchedule<>2";
				hql.append("from DetectionSetInfo di where checkTypeInfo.isSchedule<>2");
			} else {
				
				//使用监测设置权限
				hql.append("from DetectionSetInfo di where checkTypeInfo.isSchedule<>2 and (( di.viewLevel=1 and di.createUserId=");
				hql.append(this.getUserID());
				hql.append(" and di.systemId ="+this.getSystemID()+")");
				hql.append(" or ( di.viewLevel=2 and di.createUserGroupId in (select  x.jsbh from  XtYhJsIndex  x  where x.yhbh='");
				hql.append(this.getUser().getYhbh());
				hql.append("' and x.type = 1) and di.systemId = "+this.getSystemID()+") or (di.viewLevel=3 and di.systemId = "+this.getSystemID()+")");
				hql.append(" or (di.viewLevel=4 )");
				hql.append(") ");
			}
			if (ip != null && !"".equals(ip)) {
				hql.append(" and instr(nodeIp,'"+ip.trim()+"') <> 0");
			}
			if (ctn != null && !"".equals(ctn)) {
				hql.append(" and checkTypeInfo.id = " + ctn);
			}

			if (pIden != null && !"".equals(pIden)) {
				hql.append(" and Upper(processIdenName) like '%" + pIden.trim().toUpperCase() + "%'");
			}

			hql.append(" order by  detectionSetState desc, nodeIp desc, id asc ");
			System.out.println(hql.toString());
			page = this.commonService.findByPage(hql.toString(), pageNo, pageSize);
			detecSetList = (List<DetectionSetInfo>) page.getResult();
			detecSetList = getDetecSetGroupForShow(detecSetList);
			queryCheckTypeInfo();
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(e.getStackTrace());
			outHtmlString("<script type=\"text/javascript\">alert('操作失败');this.location='detectionSet.do?action=query&pageNo="
					+ pageNo + "&pageSize=" + pageSize + "'</script>");
		}
		return "queryDetecSetInfoChild";
	}

	/**
	 * 
	 * 循环处理DetectionSet列表，将其中的节点组id转换为节点组名称，用逗号连接，将节点id转换为ip，用逗号连接
	 * 
	 * @author hyx Jun 15, 2012
	 * @version 1.0
	 * @param detectSetList
	 * @return
	 */
	public List<DetectionSetInfo> getDetecSetGroupForShow(
			List<DetectionSetInfo> detectSetList) {
		List<DetectionSetInfo> detectSetGroup = new ArrayList<DetectionSetInfo>();
		try {
			for (DetectionSetInfo detectSet : detectSetList) {
				detectSetGroup.add(getDetectSetForShow(detectSet));
			}
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(e.getStackTrace());
		}

		return detectSetGroup;
	}
	
	public DetectionSetInfo getDetectSetForShow(DetectionSetInfo detectSet)
			throws Exception {
		// 获得节点组名称
		String nodeGroupIdsStr = detectSet.getNodeGroupsId();
		System.out.println("节点组ID：" + nodeGroupIdsStr);
		if (nodeGroupIdsStr != null) {
			String[] nodeGroupIdGroup = nodeGroupIdsStr.split(",");
			String nodeGroupNamesStr = getNodeGroupNames(nodeGroupIdGroup);
			detectSet.setNodeGroupsName(nodeGroupNamesStr);
		}
		// 获得节点组ip
		String nodeIdsStr = detectSet.getNodeIpsId();
		System.out.println("节点ID：" + nodeIdsStr);
		if (nodeIdsStr != null && !"".equals(nodeIdsStr)) {
			String[] nodeIdGroup = nodeIdsStr.split(",");
			String nodeIpsStr = getNodeIps(nodeIdGroup);
			detectSet.setNodeIpsName(nodeIpsStr);
		}
		return detectSet;
	}

	private String getNodeGroupNames(String[] groupIds) throws Exception {
		String nodeGroupNames = "";
		for (String groupId : groupIds) {
			List<NodegroupTable> nodeGroupTables = this.commonService.find(
					"from NodegroupTable where groupId=? ", Long
							.valueOf(groupId));
			if(nodeGroupTables!=null && nodeGroupTables.size()>0){
				NodegroupTable nodeGroup = nodeGroupTables.get(0);
				nodeGroupNames += nodeGroup.getGroupName() + ", ";
			}else{
				continue;
			}
		}
		if (nodeGroupNames.endsWith(", ")) {
			nodeGroupNames = nodeGroupNames.substring(0, nodeGroupNames
					.length() - 2);
		}
		return nodeGroupNames;
	}

	private String getNodeIps(String[] nodeIds) throws Exception {
		String nodeIps = "";
		for (String nodeId : nodeIds) {
			List<NodeTable> nodeTableGroup = this.commonService.find(
					"from NodeTable where nodeId=? ", Long.valueOf(nodeId));
			if (nodeTableGroup != null && nodeTableGroup.size() > 0) {
				NodeTable nodeTable = nodeTableGroup.get(0);
				nodeIps += nodeTable.getNodeIp() + ", ";
			} else {
				continue;
			}
		}
		if (nodeIps.endsWith(", ")) {
			nodeIps = nodeIps.substring(0, nodeIps.length() - 2);
		}
		return nodeIps;
	}

	public List<DetectionSetInfo> getDetecSetIDForName(
			List<DetectionSetInfo> detectSetList) {
		List<DetectionSetInfo> detectSetGroup = new ArrayList<DetectionSetInfo>();
		try {
			for (DetectionSetInfo detectSet : detectSetList) {
				if(detectSet.getCreateUserGroupId()!=null&&!"".equals(detectSet.getCreateUserGroupId())){
					XtJsJbxx xtJsJbxx = (XtJsJbxx)commonService.get(XtJsJbxx.class, detectSet.getCreateUserGroupId());
					detectSet.setNodeIpsId(xtJsJbxx.getJsmc());
				}else{
					detectSet.setNodeIpsId(null);
				}
				if(detectSet.getContactUserIds()!=null&&!"".equals(detectSet.getContactUserIds())){
					String[] UserIds = detectSet.getContactUserIds().split(",");
					String UserNames = "";
					for (int i = 0; i < UserIds.length; i++) {
						XtYhJbxx xtYhJbxx = (XtYhJbxx)commonService.get(XtYhJbxx.class,Long.parseLong(UserIds[i]));
						UserNames += xtYhJbxx.getYhmc()+",";
					}
					detectSet.setContactUserIds(UserNames.substring(0, UserNames.length()-1));
				}
				detectSetGroup.add(detectSet);
			}
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(e.getStackTrace());
		}

		return detectSetGroup;
	}
	
	public void addDetecSetInfo() throws Exception {
		List list = null;
		boolean flagName = false;
		StringBuffer hqlBuffer = null;
		StringBuffer errBuffer = null;
		try {
			//先判断设置的节点范围是否重复
			if (detectionSetInfo.getNodeIpsId() != null
					&& !"".equals(detectionSetInfo.getNodeIpsId())) {//节点组和节点都不为空
				// hqlBuffer.append("");
				hqlBuffer = new StringBuffer();
				hqlBuffer
						.append("from DetectionSetInfo where nodeGroupsId = ? and nodeIpsId= ? and checkTypeInfo.id= ? ");
				list = this.commonService.find(hqlBuffer.toString(),
						detectionSetInfo.getNodeGroupsId(), detectionSetInfo
								.getNodeIpsId(), detectionSetInfo.getCheckTypeInfo().getId());
				if (list != null && list.size() > 0) {
					if (errBuffer == null) {
						errBuffer = new StringBuffer();
					}
					errBuffer.append("设置节点范围重复，");
				}
			} else if (detectionSetInfo.getNodeGroupsId() != null
					&& !"".equals(detectionSetInfo.getNodeGroupsId())) {//节点组不为空，节点为空
				hqlBuffer = new StringBuffer();
				hqlBuffer
						.append("from DetectionSetInfo where nodeGroupsId = ? and checkTypeInfo.id= ?  and (nodeIpsId='' or nodeIpsId is null) ");
				list = this.commonService.find(hqlBuffer.toString(),
						detectionSetInfo.getNodeGroupsId(), detectionSetInfo.getCheckTypeInfo().getId());
				if (list != null && list.size() > 0) {
					if (errBuffer == null) {
						errBuffer = new StringBuffer();
					}
					errBuffer.append("设置节点组范围重复，");
				}
			}else {//节点组、节点均为空
				hqlBuffer = new StringBuffer();
				hqlBuffer
						.append("from DetectionSetInfo where (nodeGroupsId ='' or nodeGroupsId is null) and checkTypeInfo.id= ?  and (nodeIpsId='' or nodeIpsId is null) ");
				list = this.commonService.find(hqlBuffer.toString(), detectionSetInfo.getCheckTypeInfo().getId());
				if (list != null && list.size() > 0) {
					if (errBuffer == null) {
						errBuffer = new StringBuffer();
					}
					errBuffer.append("设置范围重复，");
				}
				
			}
			// 判断数据是否存在
			list = this.commonService
					.find(
							"from DetectionSetInfo where checkTypeInfo.id=? and PROCESS_IDEN_NAME=?",
							detectionSetInfo.getCheckTypeInfo().getId(),
							detectionSetInfo.getProcessIdenName());
			if (list != null && list.size() > 0) {
				/*
				 * this.outHtmlString("<script>alert('设置名称重复，请重新输入！');history.back();</script>");
				 * return;
				 */
				flagName = true;
			}
			list = this.commonService
					.find(
							"from DetectionSetInfo where checkTypeInfo.id=? and processIden=?",
							detectionSetInfo.getCheckTypeInfo().getId(),
							detectionSetInfo.getProcessIden());
			if (list != null && list.size() > 0) {
				if (flagName) {
					if (errBuffer == null) {
						errBuffer = new StringBuffer();
					}
					errBuffer.append("设置名称重复和设置标识重复，");
					/*this
							.outHtmlString("<script>alert('设置名称重复和设置标识重复，请重新输入！');history.back();</script>");
					return;*/
				} else {
					if (errBuffer == null) {
						errBuffer = new StringBuffer();
					}
					errBuffer.append("设置标识重复，");
					/*this
							.outHtmlString("<script>alert('设置标识重复，请重新输入！');history.back();</script>");
					return;*/
				}
			} else {
				if (flagName) {
					if (errBuffer == null) {
						errBuffer = new StringBuffer();
					}
					errBuffer.append("设置名称重复，");
					/*this
							.outHtmlString("<script>alert('设置名称重复，请重新输入！');history.back();</script>");
					return;*/
				}
			}
			if(errBuffer != null  && !"".equals(errBuffer.toString())){
				this.outHtmlString("<script>alert('" + errBuffer.toString()
						+ "请重新输入！');this.location='detectionSet.do?action=openAdd'</script>");
				return;
			}
			CheckTypeInfo typeInfo = (CheckTypeInfo) this.commonService.get(
					CheckTypeInfo.class, detectionSetInfo.getCheckTypeInfo()
							.getId());
			detectionSetInfo.setCheckTypeInfo(typeInfo);
			detectionSetInfo.setIsIssueFile("1");
			detectionSetInfo.setIsIssued("1");
			if (typeInfo.getId() == 6
					|| typeInfo.getId() == 7
					|| typeInfo.getId() == 5//时间差=时钟同步
					|| (typeInfo.getIsSnmp() != null && (typeInfo.getIsSnmp() == 0l || typeInfo
							.getIsSnmp() == 1l))) {
				detectionSetInfo.setCheckWay("0");
			} else {
				detectionSetInfo.setCheckWay("1");
			}
			StringBuffer userEmailIdsStr = new StringBuffer();
			if (userEmailIds != null && userEmailIds.size() > 0) {
				for (Iterator eIte = userEmailIds.iterator(); eIte.hasNext();) {
					Long id = (Long) eIte.next();
					userEmailIdsStr.append("," + id);
				}
				userEmailIdsStr.delete(0, 1);
			}
			detectionSetInfo.setContactUserIds(userEmailIdsStr.toString());

			if (detectionSetInfo.getNodegroup() == null
					|| detectionSetInfo.getNodegroup().getGroupId() == null) {
				detectionSetInfo.setNodegroup(null);
			} else {
				NodegroupTable ng = (NodegroupTable) this.commonService.get(
						NodegroupTable.class, detectionSetInfo.getNodegroup()
								.getGroupId());
				detectionSetInfo.setNodegroup(ng);
			}
			detectionSetInfo.setNodeIp(detectionSetInfo.getNodeIpsName());
			detectionSetInfo.setDetectionSetState("1");
			detectionSetInfo.setCreateUserId(this.getUserID());
			detectionSetInfo.setSystemId(this.getSystemID());
			this.commonService.save(detectionSetInfo);
			// 将更新操作写到操作日志中
			this.addDBOperationRpt(commonService, "detection_Set_Info",
					"INSERT", detectionSetInfo.getId());
			// 用来实现即时向客户端发送配置信息
			sendSetInfo(null, detectionSetInfo, commonService);
			
			//记录用户操作用于设置向导
			if(fromWhere!=null && !"".equals(fromWhere)){
				if(fromWhere.equals("formGuide")){
					outHtmlString("<script type=\"text/javascript\">alert('操作成功');this.location='detectionSet.do?action=query&isComplete=0'</script>");
				}
			}else{
				outHtmlString("<script type=\"text/javascript\">alert('操作成功');this.location='detectionSet.do?action=query&pageNo="
						+ pageNo + "&pageSize=" + pageSize + "'</script>");
			}
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(e.getStackTrace());
			outHtmlString("<script type=\"text/javascript\">alert('操作失败');this.location='detectionSet.do?action=query&pageNo="
					+ pageNo + "&pageSize=" + pageSize + "'</script>");
		}

	}

	public String openUpdateDetecSet() {

		try {
			String tString = "";
			if (ids != null && ids.length > 0) {
				List list = this.commonService.find(
						"from DetectionSetInfo where id=?", ids[0]);
				if (list != null && list.size() > 0) {
					detectionSetInfo = (DetectionSetInfo) list.get(0);
				}
				detectionSetInfo = getDetectSetForShow(detectionSetInfo);
				// if(detectionSetInfo.getNodegroup()!=null){
				// tString ="select * from node_table where node_state = 0 and
				// NODE_group_ID =
				// "+detectionSetInfo.getNodegroup().getGroupId()+"";
				// System.out.println(tString);
				// nodeList
				// =this.commonService.executeSQL(tString,NodeTable.class);
				// }else{
				// if(detectionSetInfo.getNodeIp()!=null){
				// NodeTable ntNodeTable = (NodeTable)
				// this.commonService.find("from NodeTable where nodeIp =
				// ?",detectionSetInfo.getNodeIp()).get(0);
				// nodeList = new ArrayList<NodeTable>();
				// nodeList.add(ntNodeTable);
				// }
				// }
			}
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(e.getStackTrace());
			outHtmlString("<script type=\"text/javascript\">alert('操作失败');this.location='detectionSet.do?action=query&pageNo="
					+ pageNo + "&pageSize=" + pageSize + "'</script>");
		}

		return "updateDetecSetInfo";

	}

	public void queryNodeGroupInfo() throws Exception {
		try {
			String hql = "from NodegroupTable where 1=1";
			String sqlCondition = "where 1=1";
			if (getSystemID().intValue() == -1) {

			} else {
				// 如果当前登录选择了业务系统，则只做和本业务系统相关的操作
				if (this.getSystemID() != null) {
					hql += " and systemId = " + this.getSystemID();
					sqlCondition += " and system_id=" + this.getSystemID();
				}
				// 1 发布人查看,2 发布人所在组查看,3 系统内全部人员可看
				hql += " and (";
				hql += " (viewLevel=1 and createUserId=" + this.getUserID()
						+ ")";
				hql += " or (viewLevel=2 and createUsergroupId in (select jsbh from XtYhJsIndex "
						+ " where type=1 and yhbh='"
						+ this.getUser().getYhbh()
						+ "') )";
				if (this.getSystemID() != null) {
					hql += " or (viewLevel=3 and systemId="
							+ this.getSystemID() + ")";
				} else {
					hql += " or (viewLevel=3 and systemId in"
							+ " (select systemId from GorupSystemTable where userGroupId in"
							+ " (select jsbh from XtYhJsIndex where type=1 and yhbh='"
							+ this.getUser().getYhbh() + "')" + " ) )";
				}
				hql += ")";
			}
			hql += " and nvl(isValid,0)=1";
			hql += " order by isValid desc,groupCreatetime desc";
			sqlCondition += " order by is_valid asc,Group_createtime desc";

			// 将查询请求记入到操作日志表中
			this.addDBOperationRpt(commonService, sqlCondition,
					"nodegroup_table");

			nodeGroupList = (List<NodegroupTable>) this.commonService.find(hql);
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(e.getStackTrace());
			outHtmlString("<script type=\"text/javascript\">alert('操作失败');this.location='detectionSet.do?action=query&pageNo="
					+ pageNo + "&pageSize=" + pageSize + "'</script>");
		}
	}

	// 查询业务系统和用户组信息等等
	private void getNMSsystem() throws Exception {
		// 查询没有被删除的业务系统
		try {
			// 查询当前用户所在的用户组
			// List<XtYhJsIndex> usergrouplist = this.commonService
			// .find("from XtYhJsIndex t where type=1 and t.yhId = "
			// + this.getUserID());
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
			// nodegrouptables = this.commonService
			// .findByProperty(NodegroupTable.class,
			// "systemId",systemTable.getSystemId());
			// queryNodeGroupInfo();
			// 查找用户组
			// usergroupLists =
			// this.commonService.findByProperty(XtJsJbxx.class,"type", 1l);
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
			e.printStackTrace();
			logger.error(e.getStackTrace());
			outHtmlString("<script type=\"text/javascript\">alert('操作失败');this.location='detectionSet.do?action=query&pageNo="
					+ pageNo + "&pageSize=" + pageSize + "'</script>");
		}
	}

	/**
	 * 查询用户联系信息
	 * 
	 * @time Feb 3, 2012-3:50:28 PM
	 * @return
	 */
	private String queryUserInfo() throws Exception {
		String viewType = this.getRequest().getParameter("viewType");
		String userGroupId = this.getRequest().getParameter("userGroupId");
		// pl(viewType+" ********** "+userGroupId);
		List<XtYhJbxx> usersLists = new ArrayList<XtYhJbxx>();
		if (StringUtils.isNotEmpty(viewType)) {
			int type0 = Integer.parseInt(viewType);
			if (type0 == 4) { // 无限制 无需查询
				return null;
			} else if (type0 == 1) { // 个人
				usersLists.add(this.getUser());
			} else { // 用户组 或 系统下用户
				/*
				 * select xyj.yhid,xyj.yhmc,xyj.email from xt_yh_jbxx xyj left
				 * join xt_yh_js_index xyji on xyji.yhid = xyj.yhid left join
				 * xt_js_jbxx xjj on xjj.jsbh = xyji.jsbh left join
				 * gorup_system_table gst on gst.user_group_id = xjj.jsbh where
				 * xyji.jsbh = 9 and gst.system_id = 3 and xyj.zxbz = 0 --用户
				 * 有效标识 and xjj.type = 1 --业务维护组标识 and xjj.zxbz = 0 --业务维护组有效状态
				 */
				StringBuffer sql = new StringBuffer();
				sql.append("select distinct xyj.yhid,xyj.yhmc,xyj.email ");
				sql.append("from xt_yh_jbxx xyj ");
				sql
						.append("left join xt_yh_js_index xyji on xyji.yhid = xyj.yhid ");
				sql.append("left join xt_js_jbxx xjj on xjj.jsbh = xyji.jsbh ");
				sql
						.append("left join gorup_system_table gst on gst.user_group_id = xjj.jsbh ");
				sql.append("where 1=1 ");
				if (StringUtils.isNotEmpty(userGroupId)) {
					sql.append("and xyji.jsbh = '" + userGroupId + "' ");
				}
				if (this.getSystemID() != null) {
					sql.append("and gst.system_id = '" + this.getSystemID()
							+ "' ");
				}
				sql.append("and xyj.zxbz = 0 "); // --用户 有效标识
				sql.append("and xjj.type = 1 "); // --业务维护组标识
				sql.append("and xjj.zxbz = 0 "); // --业务维护组有效状态
				try {
					List<Object[]> list = this.commonService.executeSQL(sql
							.toString());
					if (list != null && list.size() > 0) {
						for (Object[] objects : list) {
							XtYhJbxx yhJbxx = new XtYhJbxx();
							yhJbxx.setYhid(objects[0] == null ? null : Long
									.parseLong(objects[0].toString()));
							yhJbxx.setYhmc(objects[1] == null ? null
									: objects[1].toString());
							yhJbxx.setEmail(objects[2] == null ? null
									: objects[2].toString());
							usersLists.add(yhJbxx);
						}
					}
				} catch (Exception e) {
					e.printStackTrace();
				}

			}
		}
		// pl(usersLists.size());
		// String jsonStr = JSONArray.fromObject(usersLists).toString();
		// pl(jsonStr);
		this.outJsonArray(usersLists);
		return null;
	}
	
	public void updateCheck(){
		StringBuffer hqlBuffer = null;
		// 错误提示信息
		StringBuffer errBuffer = null;
		List list = null;
		// 判断设置是否重复
		try{
		if (detectionSetInfo.getNodeIpsId() != null
				&& !"".equals(detectionSetInfo.getNodeIpsId())) {
			hqlBuffer = new StringBuffer();
			hqlBuffer
					.append("from DetectionSetInfo where nodeGroupsId = ? and nodeIpsId= ? and checkTypeInfo.id= ? and id<> ? ");
			list = this.commonService.find(hqlBuffer.toString(),
					detectionSetInfo.getNodeGroupsId(), detectionSetInfo
							.getNodeIpsId(), detectionSetInfo.getCheckTypeInfo().getId(),
					detectionSetInfo.getId());
			if (list != null && list.size() > 0) {
				if (errBuffer == null) {
					errBuffer = new StringBuffer();
				}
				errBuffer.append("设置节点范围重复，");
			}
		} else if (detectionSetInfo.getNodeGroupsId() != null
				&& !"".equals(detectionSetInfo.getNodeGroupsId())) {
			hqlBuffer = new StringBuffer();
			hqlBuffer
					.append("from DetectionSetInfo where nodeGroupsId = ? and checkTypeInfo.id= ? and id<> ? and (nodeIpsId='' or nodeIpsId is null) ");
			list = this.commonService.find(hqlBuffer.toString(),
					detectionSetInfo.getNodeGroupsId(), detectionSetInfo.getCheckTypeInfo().getId(), detectionSetInfo.getId());
			if (list != null && list.size() > 0) {
				if (errBuffer == null) {
					errBuffer = new StringBuffer();
				}
				errBuffer.append("设置节点组范围重复，");
			}
		}else {//节点组、节点均为空
			hqlBuffer = new StringBuffer();
			hqlBuffer
					.append("from DetectionSetInfo where (nodeGroupsId ='' or nodeGroupsId is null) and checkTypeInfo.id= ? and id<>? and (nodeIpsId='' or nodeIpsId is null) ");
			list = this.commonService.find(hqlBuffer.toString(), detectionSetInfo.getCheckTypeInfo().getId(), detectionSetInfo.getId());
			if (list != null && list.size() > 0) {
				if (errBuffer == null) {
					errBuffer = new StringBuffer();
				}
				errBuffer.append("设置范围重复，");
			}
		}		
		hqlBuffer = null;
		hqlBuffer = new StringBuffer();
		hqlBuffer.append("from DetectionSetInfo where processIdenName= ? and checkTypeInfo.id= ? and id<> ? ");
		list = this.commonService
				.find(hqlBuffer.toString(), detectionSetInfo
						.getProcessIdenName(), detectionSetInfo.getCheckTypeInfo().getId(),detectionSetInfo.getId());
		if (list != null && list.size() > 0) {
			if (errBuffer == null) {
				errBuffer = new StringBuffer();
			}
			errBuffer.append("设置名称重复，");
		}
		if(errBuffer != null  && !"".equals(errBuffer.toString())){
			this.outString(errBuffer.toString() + "请重新输入！");
			return;
		}
		}catch (Exception e) {
			e.printStackTrace();
			logger.info("修改监测配置校验异常",e);
			this.outString("exception");
		}
		this.outString("success");
	}
	

	public void doUpdateDetecSet() throws Exception {
		// String hql="";
		
		try {
			
			// 判断记录是否存在-end

			// 获取修改后检测类别信息
			CheckTypeInfo typeInfo = (CheckTypeInfo) this.commonService.get(
					CheckTypeInfo.class, detectionSetInfo.getCheckTypeInfo()
							.getId());

			List setlist = this.commonService.find(
					"from DetectionSetInfo where id=?", detectionSetInfo
							.getId());
			if (setlist != null && setlist.size() > 0) {
				DetectionSetInfo setInfo2 = new DetectionSetInfo();// 未修改之前的信息
				DetectionSetInfo setInfo = (DetectionSetInfo) setlist.get(0);// 修改之后的信息

				// if(isIp){
				// setInfo.setNodeIp(detectionSetInfo.getNodeIp());
				// }else{
				// setInfo.setNodeIp(detectionSetInfo.getNodeIp());
				// }
				// 2012年6月15号：注释以下if语句，因为修改后节点组id（用逗号连接）用String存储
				// if(detectionSetInfo.getNodegroup().getGroupId()!=null){
				// NodegroupTable ngt =(NodegroupTable)
				// this.commonService.get(NodegroupTable.class,detectionSetInfo.getNodegroup().getGroupId());
				// setInfo.setNodegroup(ngt);
				// }
				setInfo2.setId(setInfo.getId());
				// setInfo2.setNodegroup(setInfo.getNodegroup());
				setInfo2.setNodeGroupsId(setInfo.getNodeGroupsId());// 设置节点组id（多个用逗号连接）
				setInfo2.setCheckTypeInfo(typeInfo);
				setInfo2.setProcessIden(setInfo.getProcessIden());
				// setInfo2.setNodeIp(setInfo.getNodeIp());
				setInfo2.setNodeIpsId(setInfo.getNodeIpsId());// 设置节点id（多个逗号连接）
				setInfo2.setCheckWay(setInfo.getCheckWay());
				setInfo2.setDetectionSetState(setInfo.getDetectionSetState());
				setInfo2.setCheckTypeInfo(typeInfo);

				setInfo.setCheckTypeInfo(typeInfo);
				setInfo.setNodeIp(detectionSetInfo.getNodeIpsName());
				setInfo.setNodeIpsId(detectionSetInfo.getNodeIpsId());// 设置节点id
				setInfo.setNodeGroupsId(detectionSetInfo.getNodeGroupsId());// 设置节点组id，之前没有设置此信息
				setInfo.setDetectionSetState(detectionSetInfo
						.getDetectionSetState());
				setInfo.setCheckWay(detectionSetInfo.getCheckWay());
				setInfo.setCheckGap(detectionSetInfo.getCheckGap());
				setInfo.setCheckOutTime(detectionSetInfo.getCheckOutTime());
				// setInfo.setUploadGap(detectionSetInfo.getUploadGap());
				setInfo.setCheckMaxTimes(detectionSetInfo.getCheckMaxTimes());
				setInfo.setProcessIden(detectionSetInfo.getProcessIden());// 设置标识
				setInfo.setProcessIdenName(detectionSetInfo
						.getProcessIdenName());// 设置名称
				setInfo.setProcessFile(detectionSetInfo.getProcessFile());
				setInfo.setProcessPath(detectionSetInfo.getProcessPath());
				setInfo.setIsControlStart(detectionSetInfo.getIsControlStart());
				setInfo.setControlStartTime(detectionSetInfo
						.getControlStartTime());
				setInfo.setIsIssueFile(detectionSetInfo.getIsIssueFile());
				setInfo.setIsIssued(detectionSetInfo.getIsIssued());
				setInfo.setCreateUserGroupId(detectionSetInfo
						.getCreateUserGroupId());
				setInfo.setViewLevel(detectionSetInfo.getViewLevel());
				setInfo.setPlanCheckTime(detectionSetInfo.getPlanCheckTime());
				setInfo.setCreateUserId(this.getUserID());
				setInfo.setSystemId(this.getSystemID());
				setInfo.setProcessSearchCode(detectionSetInfo.getProcessSearchCode());
				StringBuffer userEmailIdsStr = new StringBuffer();
				if (userEmailIds != null && userEmailIds.size() > 0) {
					for (Iterator eIte = userEmailIds.iterator(); eIte
							.hasNext();) {
						Long id = (Long) eIte.next();
						userEmailIdsStr.append("," + id);
					}
					userEmailIdsStr.delete(0, 1);
				}
				setInfo.setContactUserIds(userEmailIdsStr.toString());

				this.commonService.update(setInfo);// 更新修改后的监测设置信息，为什么不直接更新detectionSetInfo？	
				
				//处理监测数据和告警数据的有效性标志
				String newSeqIds = getValidSeq(setInfo.getNodeIpsId(),setInfo.getNodeGroupsId());//返回：1,2,3。若节点id不为空，则根据节点id获得seq_id。否则，若节点组非空，则根据节点组id，获得-有效-节点的seq_id--seq_id要去重。若都为空，则取所有有效节点
				handleDetectInfoValid(setInfo.getId(),newSeqIds,Constants.DETECTION_INFO_TABLE_NAME);//处理监测数据的有效性标志
				handleDetectInfoValid(setInfo.getId(),newSeqIds,Constants.DETECTION_WARNING_TABLE_NAME);//处理告警数据的有效性标志
				
				// 将更新操作写到操作日志中
				this.addDBOperationRpt(commonService, "detection_Set_Info",
						"UPDATE", setInfo.getId());
				// 用来实现即时向客户端发送配置信息
				sendSetInfo(setInfo2, setInfo, commonService);
			}
			outHtmlString("<script type=\"text/javascript\">alert('操作成功');this.location='detectionSet.do?action=query&pIden="+pIden+"&ctn="+ctn+"&ip="+ip+"&pageNo="
					+ pageNo + "&pageSize=" + pageSize + "'</script>");
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(e.getStackTrace());
			outHtmlString("<script type=\"text/javascript\">alert('操作失败');this.location='detectionSet.do?action=query&pIden="+pIden+"&ctn="+ctn+"&ip="+ip+"&pageNo="
					+ pageNo + "&pageSize=" + pageSize + "'</script>");
		}

	}
	
	//比较新seqid和监测数据中的seqid：在修改后的范围内的，update为1有效（valid=0的），不在范围内的，update为0无效（valid=1的）（对于DC在update之后入库的数据，由DC端进行处理）
	public void handleDetectInfoValid(Long detectSetId,String newSeqIds,String tableName) {
		if(detectSetId!=null&&tableName!=null&&!"".equals(tableName)) {
			try {
				String updateValidSeqIds = "";
				String updateInvalidSeqIds = "";
				//监测数据表：数据是否有效的更新
				String detectInfoSql = "select distinct t.seq_id" +
										" from "+tableName+" t" +
										" where t.detection_set_info_id="+detectSetId;
				List detectSeqGroup = (List<String>) this.commonService.executeSQL(detectInfoSql);
				if(null!=detectSeqGroup&&detectSeqGroup.size()>0){
					System.out.println("对应的seqids="+newSeqIds);
					newSeqIds = ","+newSeqIds+",";
					for(int i=0;i<detectSeqGroup.size();i++) {
						String detectSeq = detectSeqGroup.get(i).toString();
						if(detectSeq!=null&&!"".equals(detectSeq)) {
							if(!newSeqIds.contains(","+detectSeq+",")) {//此节点为去掉的节点，需要将监测数据和告警数据表中对应的信息置为无效
								updateValidSeqIds = updateValidSeqIds + detectSeq + ",";
							}else {
								updateInvalidSeqIds = updateInvalidSeqIds + detectSeq + ",";
							}
						}
					}		
					if(updateValidSeqIds.endsWith(",")) {
						updateValidSeqIds = updateValidSeqIds.substring(0,updateValidSeqIds.length()-1);
						String updateDetectSql = "update "+tableName+" t set valid=0 where t.valid=1  and t.detection_set_info_id="+detectSetId+" and t.seq_id in ("+updateValidSeqIds+")";
						this.commonService.updateBySql(updateDetectSql);
					}
					if(updateInvalidSeqIds.endsWith(",")) {
						updateInvalidSeqIds = updateInvalidSeqIds.substring(0,updateInvalidSeqIds.length()-1);
						String updateDetectSql = "update "+tableName+" t set valid=1 where t.valid=0  and t.detection_set_info_id="+detectSetId+" and t.seq_id in ("+updateInvalidSeqIds+")";
						this.commonService.updateBySql(updateDetectSql);
					}
				}
			}catch(Exception e) {
				logger.error("更新监测数据有效性 异常",e);
			}
		}
	}
	
	/*
	 * 根据节点id和节点组id，获得有效的seqId，并用逗号连接:1,2,3,5
	 */
	public String getValidSeq(String ipIds,String groupIds) {
		String seqIds = "";
		try{
			String sql = "";
			if(ipIds!=null && !"".equals(ipIds.trim())) {//节点非空
				sql=" select  distinct t.seq_id" +
							" from node_table t " +
							" where t.node_id in ("+ipIds+") " +
							" and t.node_state='0' ";//有效节点
			}else if(groupIds!=null && !"".equals(groupIds.trim())) {//节点空，节点组非空
				sql=" select  distinct t.seq_id" +
							" from node_table t " +
							" where t.node_group_id in ("+groupIds+") " +
							" and t.node_state='0' ";//有效节点
			}else {//全局节点-没有业务系统的限制
				sql=" select  distinct t.seq_id" +
							" from node_table t " +
							" where  t.node_state='0' ";//有效节点
			}
			List seqList = this.commonService.executeSQL(sql);				
			String str = StringUtils.join(seqList.toArray(),",");
			seqIds = str==null?"":str;
		}catch(Exception e) {
			logger.error("根据节点id和节点组id，获得有效的seqId 异常",e);
		}
		return seqIds;
	}

	public String detailDetecSetInfo() {
		try {
			if (ids != null && ids.length > 0) {
				List list = this.commonService.find(
						"from DetectionSetInfo where id=?", ids[0]);
				if (list != null && list.size() > 0) {
					detectionSetInfo = (DetectionSetInfo) list.get(0);
					detectionSetInfo = getDetectSetForShow(detectionSetInfo);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(e.getStackTrace());
			outHtmlString("<script type=\"text/javascript\">alert('操作失败');this.location='detectionSet.do?action=query&pageNo="
					+ pageNo + "&pageSize=" + pageSize + "'</script>");
		}

		return "detailDetecSetInfo";
	}

	private void queryCheckTypeInfo() throws Exception {
		/*try {
			String hql = "";
			if (getAdminMark()) {// 如果是admin登陆则无限制
				hql = "from CheckTypeInfo where isSchedule<>2 ";
			} else {
				// 权限控制--------begin
				String sqlparam = " or (t.viewLevel=4 )";
				hql = "from CheckTypeInfo t where isSchedule<>2 and (( t.viewLevel=1 and t.userId="
						+ this.getUserID()
						+ ")"
						+ " or ( t.viewLevel=2 and t.groupId in (select  x.jsbh from  XtYhJsIndex  x  where x.yhbh='"
						+ this.getUser().getYhbh()
						+ "' and x.type = 1)) or (t.viewLevel=3 and t.systemId = "
						+ this.getSystemID() + ")" + sqlparam + ") ";
				// ----------------end
			}
			hql += " and creteState = 0 order by isSchedule asc , createTime asc";

			allCheckTypeInfo = this.commonService.find(hql);
		} catch (Exception e) {
			e.printStackTrace();
		}*/
		try {
			StringBuffer hql = new StringBuffer();
			if (getAdminMark()) {// 如果是admin登陆则无限制
				hql.append("from CheckTypeInfo where isSchedule<>2 ");
			} else {
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
//			hql.append(" and creteState = 0 order by isSchedule asc , createTime asc");
			hql.append(" and creteState = 0 order by decode(isSchedule,0,0,2,0,1,1,2) asc ,decode(isSnmp,2,0,null,0,1) asc, ID asc");
			allCheckTypeInfo = this.commonService.find(hql.toString());
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(e.getStackTrace());
		}
	}

	private String getAllNode() throws Exception {
		List<NodeTable> nodeList = null;
		List resuList = null;
		try {
			if (gid != null && !"".equals(gid)) {// 查询有效节点
				String tString = "select * from node_table where node_state = 0 and node_group_id = "
						+ gid + "";

				System.out.println(tString);

				nodeList = this.commonService.executeSQL(tString,
						NodeTable.class);
				resuList = new ArrayList();
				if (nodeList != null && nodeList.size() > 0) {
					for (int i = 0; i < nodeList.size(); i++) {
						NodeTable nTable = nodeList.get(i);
						// Map nodeMap = new HashMap();
						// nodeMap.put("name",nTable.getNodeId());
						// nodeMap.put("data",nTable.getNodeIp());
						// resuList.add(nodeMap);
						resuList.add(nTable.getNodeIp());
					}
				}

				String jsonStr = JSONArray.fromObject(resuList).toString();
				System.out.println(jsonStr);
				this.getResponse().setCharacterEncoding("utf-8");
				PrintWriter printWriter = this.getResponse().getWriter();
				printWriter.write(jsonStr);
				printWriter.close();
				printWriter = null;

			}

		} catch (Exception e) {
			logger.error(e.getStackTrace());
			e.printStackTrace();
		}
		return null;
	}

	public String stop(){
		try {
			if(ids !=null && ids.length>0){
				for(int i= 0;i<ids.length;i++){
					List dsList = this.commonService.find(
							"from DetectionSetInfo where id=?", ids[i]);
					if(dsList!=null && dsList.size()>0){
						DetectionSetInfo ds = (DetectionSetInfo)dsList.get(0);
						//set old DetectionSetInfo-------------------------------
						DetectionSetInfo dsOld = new DetectionSetInfo();
						dsOld.setId(ds.getId());
						dsOld.setCheckTypeInfo(ds.getCheckTypeInfo());
						dsOld.setNodeIp(ds.getNodeIpsName());
						dsOld.setNodeIpsId(ds.getNodeIpsId());// 设置节点id
						dsOld.setNodeGroupsId(ds.getNodeGroupsId());// 设置节点组id，之前没有设置此信息
						dsOld.setDetectionSetState(ds.getDetectionSetState());
						dsOld.setCheckWay(ds.getCheckWay());
						dsOld.setCheckGap(ds.getCheckGap());
						dsOld.setCheckOutTime(ds.getCheckOutTime());
						dsOld.setUploadGap(ds.getUploadGap());
						dsOld.setCheckMaxTimes(ds.getCheckMaxTimes());
						dsOld.setProcessIden(ds.getProcessIden());// 设置标识
						dsOld.setProcessIdenName(ds.getProcessIdenName());// 设置名称
						dsOld.setProcessFile(ds.getProcessFile());
						dsOld.setProcessPath(ds.getProcessPath());
						dsOld.setIsControlStart(ds.getIsControlStart());
						dsOld.setControlStartTime(ds.getControlStartTime());
						dsOld.setIsIssueFile(ds.getIsIssueFile());
						dsOld.setIsIssued(ds.getIsIssued());
						dsOld.setCreateUserGroupId(ds.getCreateUserGroupId());
						dsOld.setViewLevel(ds.getViewLevel());
						dsOld.setPlanCheckTime(ds.getPlanCheckTime());
						dsOld.setCreateUserId(ds.getCreateUserId());
						dsOld.setSystemId(ds.getSystemId());
						dsOld.setProcessSearchCode(ds.getProcessSearchCode());
						dsOld.setContactUserIds(ds.getContactUserIds());
						//set old DetectionSetInfo-------------------------------
						
						ds.setDetectionSetState("0");
						this.commonService.update(ds);
						
						//将更新操作写到操作日志中
						this.addDBOperationRpt(commonService, "detection_set_info", "UPDATE", ds.getId());
						
						// 用来实现即时向客户端发送配置信息
						sendSetInfo(dsOld, ds, commonService);
					}
				}
				
			}
			outHtmlString("<script type=\"text/javascript\">alert('操作成功');this.location='detectionSet.do?action=query&pageNo="
					+ pageNo + "&pageSize=" + pageSize + "'</script>");
		} catch (Exception e) {
			logger.error(e.getStackTrace());
			e.printStackTrace();
		}
		return null;
	}
	
	public String start(){
		try {
			if(ids !=null && ids.length>0){
				for(int i= 0;i<ids.length;i++){
					List dsList = this.commonService.find(
							"from DetectionSetInfo where id=?", ids[i]);
					
					if(dsList!=null && dsList.size()>0){
						DetectionSetInfo ds = (DetectionSetInfo)dsList.get(0);
						//set old DetectionSetInfo-------------------------------
						DetectionSetInfo dsOld = new DetectionSetInfo();
						dsOld.setId(ds.getId());
						dsOld.setCheckTypeInfo(ds.getCheckTypeInfo());
						dsOld.setNodeIp(ds.getNodeIpsName());
						dsOld.setNodeIpsId(ds.getNodeIpsId());// 设置节点id
						dsOld.setNodeGroupsId(ds.getNodeGroupsId());// 设置节点组id，之前没有设置此信息
						dsOld.setDetectionSetState(ds.getDetectionSetState());
						dsOld.setCheckWay(ds.getCheckWay());
						dsOld.setCheckGap(ds.getCheckGap());
						dsOld.setCheckOutTime(ds.getCheckOutTime());
						dsOld.setUploadGap(ds.getUploadGap());
						dsOld.setCheckMaxTimes(ds.getCheckMaxTimes());
						dsOld.setProcessIden(ds.getProcessIden());// 设置标识
						dsOld.setProcessIdenName(ds.getProcessIdenName());// 设置名称
						dsOld.setProcessFile(ds.getProcessFile());
						dsOld.setProcessPath(ds.getProcessPath());
						dsOld.setIsControlStart(ds.getIsControlStart());
						dsOld.setControlStartTime(ds.getControlStartTime());
						dsOld.setIsIssueFile(ds.getIsIssueFile());
						dsOld.setIsIssued(ds.getIsIssued());
						dsOld.setCreateUserGroupId(ds.getCreateUserGroupId());
						dsOld.setViewLevel(ds.getViewLevel());
						dsOld.setPlanCheckTime(ds.getPlanCheckTime());
						dsOld.setCreateUserId(ds.getCreateUserId());
						dsOld.setSystemId(ds.getSystemId());
						dsOld.setProcessSearchCode(ds.getProcessSearchCode());
						dsOld.setContactUserIds(ds.getContactUserIds());
						//set old DetectionSetInfo-------------------------------
						ds.setDetectionSetState("1");
						
						this.commonService.update(ds);
						
						//将更新操作写到操作日志中
						this.addDBOperationRpt(commonService, "detection_set_info", "UPDATE", ds.getId());
						
						// 用来实现即时向客户端发送配置信息
						sendSetInfo(dsOld, ds, commonService);
					}	
				}
			}
			outHtmlString("<script type=\"text/javascript\">alert('操作成功');this.location='detectionSet.do?action=query&pageNo="
					+ pageNo + "&pageSize=" + pageSize + "'</script>");
		} catch (Exception e) {
			logger.error(e.getStackTrace());
			e.printStackTrace();
		}
		return null;
	}
	
	
	
	public String addpoliceSet() {
		return null;
	}

	private boolean isNodeIpExist(String node_ip) throws Exception {
		boolean flag = false;
		List list = this.commonService.find("from NodeTable where nodeIp = ?",
				node_ip);
		if (list != null && list.size() > 0) {
			flag = true;
		}

		return flag;
	}

	// 自动生成一个监测设置标识
	public String getDetectSetIden() {
		String detectSetIden = null;
		try {
			for (int i = 0; i < 1000; i++) {
				long type = 0l;
				List list = this.commonService
						.executeSQL("select SEQ_DETECTION_SET_IDEN.nextval seq_id from dual");
				if (list.get(0) != null && !"".equals(list.get(0))) {
					type = Long.parseLong(list.get(0).toString());
				}

				detectSetIden = "detection" + type;

				// 判断记录是否存在
				String sql = "select count(*) from DETECTION_SET_INFO t where PROCESS_IDEN ='"
						+ detectSetIden + "'";
				list = this.commonService.executeSQL(sql);
				long num = Long.parseLong(list.get(0).toString());
				if (num <= 0) {// 不存在
					break;
				}
			}
		} catch (Exception e) {
			logger.error(e.getStackTrace());
			e.printStackTrace();
			detectSetIden = "detection0";
		}
		return detectSetIden;
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

	public List<DetectionSetInfo> getDetecSetList() {
		return detecSetList;
	}

	public void setDetecSetList(List<DetectionSetInfo> detecSetList) {
		this.detecSetList = detecSetList;
	}

	public DetectionSetInfo getDetectionSetInfo() {
		return detectionSetInfo;
	}

	public void setDetectionSetInfo(DetectionSetInfo detectionSetInfo) {
		this.detectionSetInfo = detectionSetInfo;
	}

	public String getIp() {
		return ip;
	}

	public void setIp(String ip) {
		this.ip = ip;
	}

	public List<CheckTypeInfo> getAllCheckTypeInfo() {
		return allCheckTypeInfo;
	}

	public void setAllCheckTypeInfo(List<CheckTypeInfo> allCheckTypeInfo) {
		this.allCheckTypeInfo = allCheckTypeInfo;
	}

	public Long[] getIds() {
		return ids;
	}

	public void setIds(Long[] ids) {
		this.ids = ids;
	}

	public List<NodegroupTable> getNodeGroupList() {
		return nodeGroupList;
	}

	public void setNodeGroupList(List<NodegroupTable> nodeGroupList) {
		this.nodeGroupList = nodeGroupList;
	}

	public String getCtn() {
		return ctn;
	}

	public void setCtn(String ctn) {
		this.ctn = ctn;
	}

	public String getGid() {
		return gid;
	}

	public void setGid(String gid) {
		this.gid = gid;
	}

	public List<NodeTable> getNodeList() {
		return nodeList;
	}

	public void setNodeList(List<NodeTable> nodeList) {
		this.nodeList = nodeList;
	}

	public String getpIden() {
		return pIden;
	}

	public void setpIden(String pIden) {
		this.pIden = pIden;
	}

	public List<XtJsJbxx> getUsergroupLists() {
		return usergroupLists;
	}

	public void setUsergroupLists(List<XtJsJbxx> usergroupLists) {
		this.usergroupLists = usergroupLists;
	}

	public SystemTable getSystemTable() {
		return systemTable;
	}

	public void setSystemTable(SystemTable systemTable) {
		this.systemTable = systemTable;
	}

	public List<Long> getUserEmailIds() {
		return userEmailIds;
	}

	public void setUserEmailIds(List<Long> userEmailIds) {
		this.userEmailIds = userEmailIds;
	}

	public Logger getLogger() {
		return logger;
	}

	public void setLogger(Logger logger) {
		this.logger = logger;
	}

	public void setDetectSetIden(String detectSetIden) {
		this.detectSetIden = detectSetIden;
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
