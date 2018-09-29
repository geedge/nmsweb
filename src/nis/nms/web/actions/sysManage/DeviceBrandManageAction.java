package nis.nms.web.actions.sysManage;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import nis.nms.core.Constants;
import nis.nms.domains.CheckTypeInfo;
import nis.nms.domains.DeviceBoardsoltBoard;
import nis.nms.domains.DeviceBrandInfo;
import nis.nms.domains.DeviceBrandType;
import nis.nms.domains.DeviceTypeInfo;
import nis.nms.domains.Metadata;
import nis.nms.service.CommonService;
import nis.nms.util.BaseAction;
import nis.nms.util.ExportUtils;
import nis.nms.util.FileUtil;
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
		@Result(name = "deviceBrandInfoList", value = "/page/system/deviceManage/deviceBrandInfoList.jsp"),
		@Result(name = "toAddDevBrand", value = "/page/system/deviceManage/addDevBrandInfo.jsp"),
		@Result(name = "toUpdateDevBrand", value = "/page/system/deviceManage/updateDevBrandInfo.jsp"),
		@Result(name = "detailBrand", value = "/page/system/deviceManage/detailDevBrandInfo.jsp"),

		@Result(name = "showError", value = "/showImportError.jsp"),
		@Result(name = "showError1", value = "/showImportError1.jsp"),
		@Result(name = "selectBanKa", value = "/page/system/deviceManage/selectBanKa.jsp"),
		
		@Result(name = "deviceTypeInfoList", value = "/page/system/deviceManage/deviceTypeInfoList.jsp"),
		@Result(name = "deviceTypeInfoListChild", value = "/page/system/deviceManage/deviceTypeInfoListChild.jsp"),
		@Result(name = "toAddDevType", value = "/page/system/deviceManage/addDevTypeInfo.jsp"),
		@Result(name = "toAddPosDevType", value = "/page/system/deviceManage/addPosDevTypeInfo.jsp"),
		@Result(name = "toConfDevPos", value = "/page/system/deviceManage/confDevPos.jsp"),
		@Result(name = "toAddBatchDevType", value = "/page/system/deviceManage/addBatchDevTypeInfo.jsp"),
		@Result(name = "toUpdateDevType", value = "/page/system/deviceManage/updateDevTypeInfo.jsp"),
		@Result(name = "detailDevType", value = "/page/system/deviceManage/detailDevTypeInfo.jsp"),

		@Result(name = "error", value = "/error.jsp") })
public class DeviceBrandManageAction extends BaseAction {
	/**
	 * 
	 */
	private Logger logger = Logger.getLogger(DeviceBrandManageAction.class);
	private static final long serialVersionUID = 1L;
	private CommonService commonService;
	
	private int pageNo = 1;
	private int pageSize = this.getDefaultPageSize(); // 每页显示的记录条数
	private Page page;
	
	private String action;// 系统操作
	
	private List<DeviceBrandInfo> devBrandListInfo = new ArrayList<DeviceBrandInfo>();
	private DeviceBrandInfo devBrand;//保存品牌信息
	
	private String brandNameForSearch;// 品牌名称,品牌列表查询的时候输入的条件
	private String ids;//品牌列表，选中的品牌的id
	private String deviceRandCode;//品牌编码（新增品牌型号时使用）
	
	//设备型号
	private String devId;
	private List<DeviceTypeInfo> devTypeListInfo = new ArrayList<DeviceTypeInfo>();
	private List<DeviceTypeInfo> devTypeListForSearch = new ArrayList<DeviceTypeInfo>();
	private List<DeviceTypeInfo> devTypeForPosList = new ArrayList<DeviceTypeInfo>();//需要配置设备位置的设备列表
	private List<DeviceTypeInfo> devTypeForBankaList = new ArrayList<DeviceTypeInfo>();//板槽对应板卡
	private List<DeviceBrandType> deviceBrandTypeList = new ArrayList<DeviceBrandType>();
	private String devTypeCodeForSearch;
	private String parDevId;//查询条件的父设备id
	private String parDevCode;//查询条件的父设备型号
	private String posParDevId;//槽位的父设备id
	private String devRandCodeForSearch;
	private String hasSubType;//当前修改的品牌是否有型号
	private DeviceTypeInfo devType;//保存设备型号信息
	private String pzbkbc;//用来保存板卡槽位关系
	

	private String jsonStr;

	private List<String> metadataList = new ArrayList<String>();
	private List<Metadata> fieldList = new ArrayList<Metadata>();
	//private List<Object[]> pardevList=new ArrayList<Object[]>();

	private String devScrollHeight = "0";// 展示时，设备的总高度
	//配置位置时，底图显示的位置
	private long rootDeviceX = 550;// 第一个设备的坐标
	private long rootDeviceY = 30;// 第一个设备的坐标
	private String linkStr = "-";
	//配置完成后，界面显示监测信息的底图的位置
	private long devShowX = 35;
	private long devShowY = 35;
	
	//上传设备图片
	private File figureFill;
	private String figureFillFileName;
	private static final String uploadSvgPath = "/images/svg/upload/";
	private static final String svgPath = "/images/svg/";
	private static final String modelPath = "/images/svg/model/";
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

	public String executeAction() {
		try {
            // 设备品牌管理
			if (action.equals("queryDeviceBrandInfo")) {// 查询品牌列表
				queryDeviceBrandInfo();
				return "deviceBrandInfoList";
			}
			if (action.equals("toAddDevBrand")) {//新增品牌
				toAddDevBrand();
				return "toAddDevBrand";
			}
			if (action.equals("addDevBrand")) {//新增品牌
				addDevBrand();
				return null;
			}
			if (action.equals("toUpdateDevBrand")) {//修改品牌
				toUpdateDevBrand();
				return "toUpdateDevBrand";
			}
			if (action.equals("updateDevBrand")) {//修改品牌
				updateDevBrand();
				return null;
			}			
			if (action.equals("detailBrand")) {//查看品牌详细信息
//				detailBrand();
				return "detailBrand";
			}
			
			if (action.equals("deleteDevBrand")) {//删除品牌
				return deleteDevBrand();
			}
			
			if (action.equals("hasDevBrand")) {//设备品牌是否重复
				hasDevBrand();
				return null;
			}
			
			if (action.equals("hasDevBrandForUpdate")) {//品牌编号是否重复:更新
				hasDevBrandForUpdate();
				return null;
			}
			
			
			// 设备型号管理
			if (action.equals("queryDeviceTypeInfo")) {// 查询型号列表
				queryDeviceTypeInfo1();
				return "deviceTypeInfoList";
			}
			if (action.equals("queryDeviceTypeInfoChild")) {// 查询型号列表
				queryDeviceTypeInfo1();
				return "deviceTypeInfoListChild";
			}
			
			if (action.equals("toAddDevType")) {//新建设备型号
				toAddDevType();
				return "toAddDevType";
			}
			if (action.equals("toAddPosDevType")) {//新建槽位设备
				toAddPosDevType();
				return "toAddPosDevType";
			}
			if (action.equals("toAddBatchDevType")) {//批量新建设备型号
				toAddDevType();
				return "toAddBatchDevType";
			}
			if (action.equals("addDevType")) {//新建设备型号
				addDevType();
				return null;
			}
			if (action.equals("addPosDevType")) {//新建设备型号
				addPosDevType();
				return null;
			}
			if (action.equals("toConfDevPos")) {//配置设备位置
				toConfDevPos();
				return "toConfDevPos";
			}
			if (action.equals("addDevicePos")) {//新增设备位置配置
				configDevicePos();
				return null;
			}
			if (action.equals("addBatchDevType")) {//批量新建设备型号
				addBatchDevType();
				return null;
			}
			if (action.equals("hasDevType")) {//设备型号是否重复
				hasDevType();
				return null;
			}
			if (action.equals("hasDevTypeForUpdate")) {//设备型号是否重复:更新
				hasDevTypeForUpdate();
				return null;
			}
			if (action.equals("deleteDevType")) {//删除设备型号
				return deleteDevType();
			}
			
			if (action.equals("toUpdateDevType")) {//修改设备型号
				toUpdateDevType();
				return "toUpdateDevType";
			}
			if (action.equals("updateDevType")) {//修改设备型号
				updateDevType();
				return null;
			}		
			
			if (action.equals("detailDevType")) {//查看设备型号详细信息
				detailDevType();
				return "detailDevType";
			}
			
			if ("downloadExample".equals(this.action)) {//下载品牌模板
				return downloadExample();
			}
			if ("importXls".equals(this.action)) {
				return importXls();
			}
			if ("emportCurrentXls".equals(this.action)) {
				return emportCurrentXls();
			}
			if ("emportAllXls".equals(this.action)) {
				return emportAllXls();
			}
			if ("downloadExampleType".equals(this.action)) {//下载设备导入模板
				//return downloadExampleType();
				return downloadExampleType1();
			}
			if ("importXlsType".equals(this.action)) {
				//return importXlsType();
				return impDevicesByExcel();
			}
			if ("emportCurrentXlsType".equals(this.action)) {
				return emportCurrentXlsType();
			}
			if ("emportAllXlsType".equals(this.action)) {
				return emportAllXlsType();
			}
			if("ajaxForParDevCode".equals(this.action)){
				return ajaxForParDevCode();
			}
			if("selectBanKa".equals(this.action)){
				selectBanKa();
				return "selectBanKa";
			}
			if("suggestResult".equals(this.action)){
				suggestResult();
				return null;
			}
		} catch (Exception e) {
			e.printStackTrace();
			return "error";
		}
		return null;
	}
	
	public void suggestResult(){
		List<String> pardevList=new ArrayList<String>();
		List<DeviceBrandInfo> devBrandList = new ArrayList<DeviceBrandInfo>();
		String devBrand = this.getRequest().getParameter("brand");
		String keyWord = this.getRequest().getParameter("keyWord").toLowerCase();
		try {
			if(StringUtils.isBlank(devBrand)){
				pardevList= this.commonService.executeSQL("select device_type_code from device_type_info where pid=0 and lower(device_type_code) like ?",keyWord+"%");//父设备型号选择列表
			}else{
				devBrandList=this.commonService.find("from DeviceBrandInfo where deviceRandCode=?",devBrand);
				if(devBrandList!=null&&devBrandList.size()>0){
					pardevList= this.commonService.executeSQL("select device_type_code from device_type_info where device_rand_code=? and pid=0 and lower(device_type_code) like ?",devBrandList.get(0).getDeviceRandCode(),keyWord+"%");//父设备型号选择列表			
				}
			}
			String str = StringUtils.join(pardevList.toArray(),",");
			 	this.getResponse().setCharacterEncoding("utf-8");
				PrintWriter printWriter = this.getResponse().getWriter();
				printWriter.write(str);
				printWriter.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	// 模板下载   程辉 2013-5-13新增
	public String downloadExampleType() {
		try {
			String hql = "from DeviceTypeInfo order by id asc";
			page = this.commonService.findByPage(hql, 1,3);
			List<DeviceTypeInfo> devTypeListInfo = (ArrayList<DeviceTypeInfo>)page.getResult();
			
			Map<String,String> idCodeMap = getIdCodeMap();
			
			for (DeviceTypeInfo dev : devTypeListInfo) {
				if (dev.getPid().equals("0")) {
					dev.setPid("");
				} else {
					dev.setPid(idCodeMap.get(dev.getPid()));
				}
			}
			
			String hql1="from DeviceBrandType order by deviceBrandCode,parDeviceTypeCode asc";
			List<DeviceBrandType> deviceBrandType = (ArrayList<DeviceBrandType>)commonService.findByPage(hql1,1,3).getResult();
			
			String[] title = { getI18nText("i18n_DeviceBrandManageAction.downloadExampleType.title.deviceModel_n81i"), 
					getI18nText("i18n_DeviceBrandManageAction.downloadExampleType.title.brand_n81i"),
					getI18nText("i18n_DeviceBrandManageAction.downloadExampleType.title.deviceDesc_n81i"),
					getI18nText("i18n_DeviceBrandManageAction.downloadExampleType.title.postionNum_n81i"),
					getI18nText("i18n_DeviceBrandManageAction.downloadExampleType.title.parentModel_n81i"),
					getI18nText("i18n_DeviceBrandManageAction.downloadExampleType.title.picType_n81i"),
					getI18nText("i18n_DeviceBrandManageAction.downloadExampleType.title.X_n81i"),
					getI18nText("i18n_DeviceBrandManageAction.downloadExampleType.title.Y_n81i"),
					getI18nText("i18n_DeviceBrandManageAction.downloadExampleType.title.width_n81i"),
					getI18nText("i18n_DeviceBrandManageAction.downloadExampleType.title.heigh_n81i"),
					getI18nText("i18n_DeviceBrandManageAction.downloadExampleType.title.color_n81i"),
					getI18nText("i18n_DeviceBrandManageAction.downloadExampleType.title.lineWidth_n81i"),
					getI18nText("i18n_DeviceBrandManageAction.downloadExampleType.title.picName_n81i"),
					getI18nText("i18n_DeviceBrandManageAction.downloadExampleType.title.nameFormate_n81i"),
					getI18nText("i18n_DeviceBrandManageAction.downloadExampleType.title.monitorType_n81i"),
					getI18nText("i18n_DeviceBrandManageAction.downloadExampleType.title.linkField_n81i"),
					getI18nText("i18n_DeviceBrandManageAction.downloadExampleType.title.stateField_n81i"),
					getI18nText("i18n_DeviceBrandManageAction.downloadExampleType.title.character_n81i"),
					getI18nText("i18n_DeviceBrandManageAction.downloadExampleType.title.value_n81i"),
					getI18nText("i18n_DeviceBrandManageAction.downloadExampleType.title.picLevel_n81i"),
					getI18nText("i18n_DeviceBrandManageAction.downloadExampleType.title.isLinked_n81i"),
					getI18nText("i18n_DeviceBrandManageAction.downloadExampleType.title.isLeaf_n81i"),
					getI18nText("i18n_DeviceBrandManageAction.downloadExampleType.title.maxConn_n81i")};
	
			String[] colu = { "deviceTypeCode","deviceRandCode","deviceDesc","showIndex" ,"pid","figureType","figureX","figureY","figureWidth","figureHeight",
					"figureStroke","figureStrokeWidth","figureFill","nameFormat","diTableName","indexFiled",
					"statusFiled","statusSymbols","statusValue","showLevel","isLink","isLeaf","maxDeviceNum"};
			
			String[] title1 = { getI18nText("i18n_DeviceBrandManageAction.downloadExampleType.title1.brandCode_n81i"),
								getI18nText("i18n_DeviceBrandManageAction.downloadExampleType.title1.deviceModel_n81i"),
								getI18nText("i18n_DeviceBrandManageAction.downloadExampleType.title1.parentDevice_n81i")};
	
			String[] colu1 = { "deviceBrandCode","parDeviceTypeCode","subDeviceTypeCode"};
			ExportUtils m = new ExportUtils();
			m.setAutoSizeColumn(true);
			m.exportExcel2Sheet(getI18nText("i18n_DeviceBrandManageAction.downloadExampleType.deviceManageInfoTable_n81i"),getI18nText("i18n_DeviceBrandManageAction.downloadExampleType.deviceManageInfo_n81i"),getI18nText("i18n_DeviceBrandManageAction.downloadExampleType.brandLinkInfo_n81i"), devTypeListInfo, title, colu, deviceBrandType, title1, colu1);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	// 导入 程辉 2013-5-8新增
	public String importXlsType() {
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
				DeviceTypeInfo deviceTypeInfo = new DeviceTypeInfo();
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
				Cell cell_11 = row.getCell((short) 10);
				Cell cell_12 = row.getCell((short) 11);
				Cell cell_13 = row.getCell((short) 12);
				Cell cell_14 = row.getCell((short) 13);
				Cell cell_15 = row.getCell((short) 14);
				Cell cell_16 = row.getCell((short) 15);
				Cell cell_17 = row.getCell((short) 16);
				Cell cell_18 = row.getCell((short) 17);
				Cell cell_19 = row.getCell((short) 18);
				Cell cell_20 = row.getCell((short) 19);
				Cell cell_21 = row.getCell((short) 20);
				Cell cell_22 = row.getCell((short) 21);
				Cell cell_23 = row.getCell((short) 22);
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
						&& (null == cell_18 || 3 == cell_18.getCellType())
						&& (null == cell_19 || 3 == cell_19.getCellType())
						&& (null == cell_20 || 3 == cell_20.getCellType())
						&& (null == cell_21 || 3 == cell_21.getCellType())
						&& (null == cell_22 || 3 == cell_22.getCellType())
						&& (null == cell_23 || 3 == cell_23.getCellType())) {
					sum--;
				}else {
					//设备型号
					if (null == cell_1) {
						errorInfo +=  getI18nText("i18n_DeviceBrandManageAction.downloadExampleType.errorInfo1_n81i",i+"");
					} else if (cell_1.getCellType() == Cell.CELL_TYPE_STRING) {
						if ("".equals(cell_1.getStringCellValue())) {
							errorInfo +=  getI18nText("i18n_DeviceBrandManageAction.downloadExampleType.errorInfo1_n81i",i+"");
						} else {
							deviceTypeInfo.setDeviceTypeCode(cell_1.getStringCellValue().trim());
						}
					}else if(cell_1.getCellType() == Cell.CELL_TYPE_NUMERIC){
						deviceTypeInfo.setDeviceTypeCode(String.valueOf((int) cell_1.getNumericCellValue()));
					} else {
						errorInfo +=  getI18nText("i18n_DeviceBrandManageAction.downloadExampleType.errorInfo2_n81i",i+"");
					}

					//所属品牌（必填，对应品牌编号）
					if (null == cell_2) {
						errorInfo +=  getI18nText("i18n_DeviceBrandManageAction.downloadExampleType.errorInfo3_n81i",i+"");
					} else if (cell_2.getCellType() == Cell.CELL_TYPE_STRING) {
						if ("".equals(cell_2.getStringCellValue())) {
							errorInfo +=  getI18nText("i18n_DeviceBrandManageAction.downloadExampleType.errorInfo3_n81i",i+"");
						} else {
							deviceTypeInfo.setDeviceRandCode(cell_2.getStringCellValue().trim());
						}
					} else if(cell_2.getCellType() == Cell.CELL_TYPE_NUMERIC){
						deviceTypeInfo.setDeviceRandCode(String.valueOf((int) cell_2.getNumericCellValue()));
					} else{
						errorInfo +=  getI18nText("i18n_DeviceBrandManageAction.downloadExampleType.errorInfo4_n81i",i+"");
					}

					//设备描述
					if(null == cell_3 || cell_3.getCellType()==Cell.CELL_TYPE_BLANK){
					}else if(cell_3.getCellType() == Cell.CELL_TYPE_NUMERIC){
						deviceTypeInfo.setDeviceDesc(String.valueOf((int)cell_3.getNumericCellValue()));
					}else if (cell_3.getCellType() == Cell.CELL_TYPE_STRING) {
						deviceTypeInfo.setDeviceDesc(cell_3.getStringCellValue().trim());
					} else {
						errorInfo +=  getI18nText("i18n_DeviceBrandManageAction.downloadExampleType.errorInfo5_n81i",i+"");
					}
					
					//级别下位置序号
					if(null == cell_4||cell_4.getCellType()==Cell.CELL_TYPE_BLANK){
					}else if(cell_4.getCellType() == Cell.CELL_TYPE_NUMERIC){
						deviceTypeInfo.setShowIndex((long)cell_4.getNumericCellValue());
					}else {
						errorInfo +=  getI18nText("i18n_DeviceBrandManageAction.downloadExampleType.errorInfo6_n81i",i+"");
					}
					
					//父设备型号（为空默认为顶级设备）
					if (null == cell_5||cell_5.getCellType()==Cell.CELL_TYPE_BLANK) {
					} else if (cell_5.getCellType() == Cell.CELL_TYPE_STRING) {
						deviceTypeInfo.setPid(cell_5.getStringCellValue().trim());
					} else if (cell_5.getCellType() == Cell.CELL_TYPE_NUMERIC) {
						deviceTypeInfo.setPid(String.valueOf((int)cell_5.getNumericCellValue()));
					}else{
						errorInfo +=  getI18nText("i18n_DeviceBrandManageAction.downloadExampleType.errorInfo7_n81i",i+"");
					}
					
					//图片类型figureType
					if (null == cell_6||cell_6.getCellType()==Cell.CELL_TYPE_BLANK) {
					} else if (cell_6.getCellType() == Cell.CELL_TYPE_STRING) {
						deviceTypeInfo.setFigureType(cell_6.getStringCellValue().trim());
					} else{
						errorInfo +=  getI18nText("i18n_DeviceBrandManageAction.downloadExampleType.errorInfo8_n81i",i+"");
					}
					
					//X坐标figureX
					if (null == cell_7||cell_7.getCellType()==Cell.CELL_TYPE_BLANK) {
					} else if (cell_7.getCellType() == Cell.CELL_TYPE_NUMERIC) {
						deviceTypeInfo.setFigureX((long) cell_7.getNumericCellValue());
					} else{
						errorInfo +=  getI18nText("i18n_DeviceBrandManageAction.downloadExampleType.errorInfo9_n81i",i+"");
					}
					
					//Y坐标figureY
					if (null == cell_8||cell_8.getCellType()==Cell.CELL_TYPE_BLANK) {
					} else if (cell_8.getCellType() == Cell.CELL_TYPE_NUMERIC) {
						deviceTypeInfo.setFigureY((long) cell_8.getNumericCellValue());
					} else{
						errorInfo +=  getI18nText("i18n_DeviceBrandManageAction.downloadExampleType.errorInfo10_n81i",i+"");
					}
					
					//宽figureWidth
					if (null == cell_9||cell_9.getCellType()==Cell.CELL_TYPE_BLANK) {
					} else if (cell_9.getCellType() == Cell.CELL_TYPE_NUMERIC) {
						deviceTypeInfo.setFigureWidth((long) cell_9.getNumericCellValue());
					} else{
						errorInfo +=  getI18nText("i18n_DeviceBrandManageAction.downloadExampleType.errorInfo11_n81i",i+"");
					}
					
					//高figureHeight
					if (null == cell_10||cell_10.getCellType()==Cell.CELL_TYPE_BLANK) {
					} else if (cell_10.getCellType() == Cell.CELL_TYPE_NUMERIC) {
						deviceTypeInfo.setFigureHeight((long) cell_10.getNumericCellValue());
					} else{
						errorInfo +=  getI18nText("i18n_DeviceBrandManageAction.downloadExampleType.errorInfo12_n81i",i+"");
					}
					
					//边颜色figureStroke
					if (null == cell_11||cell_11.getCellType()==Cell.CELL_TYPE_BLANK) {
					} else if (cell_11.getCellType() == Cell.CELL_TYPE_STRING) {
						deviceTypeInfo.setFigureStroke(cell_11.getStringCellValue().trim());
					} else if (cell_11.getCellType() == Cell.CELL_TYPE_NUMERIC) {
						deviceTypeInfo.setFigureStroke(String.valueOf((int) cell_11.getNumericCellValue()));
					} else{
						errorInfo +=  getI18nText("i18n_DeviceBrandManageAction.downloadExampleType.errorInfo13_n81i",i+"");
					}
					
					//边宽figureStrokeWidth
					if (null == cell_12||cell_12.getCellType()==Cell.CELL_TYPE_BLANK) {
					} else if (cell_12.getCellType() == Cell.CELL_TYPE_NUMERIC) {
						deviceTypeInfo.setFigureStrokeWidth((long) cell_12.getNumericCellValue());
					} else{
						errorInfo +=  getI18nText("i18n_DeviceBrandManageAction.downloadExampleType.errorInfo14_n81i",i+"");
					}
					
					//图片名称（必填）figureFill
					if (null == cell_13) {
						errorInfo +=  getI18nText("i18n_DeviceBrandManageAction.downloadExampleType.errorInfo15_n81i",i+"");
					} else if (cell_13.getCellType() == Cell.CELL_TYPE_STRING) {
						if ("".equals(cell_13.getStringCellValue())) {
							errorInfo +=  getI18nText("i18n_DeviceBrandManageAction.downloadExampleType.errorInfo15_n81i",i+"");
						} else {
							deviceTypeInfo.setFigureFill(cell_13.getStringCellValue().trim());
						}
					}else {
						errorInfo +=  getI18nText("i18n_DeviceBrandManageAction.downloadExampleType.errorInfo16_n81i",i+"");
					}
					
					//命名格式（[Y]:代表设备本身在父设备的位置，[X]:代表父设备在祖父设备的位置）nameFormat
					if (null == cell_14||cell_14.getCellType()==Cell.CELL_TYPE_BLANK) {
					} else if (cell_14.getCellType() == Cell.CELL_TYPE_STRING) {
						deviceTypeInfo.setNameFormat(cell_14.getStringCellValue().trim());
					}else {
						errorInfo +=  getI18nText("i18n_DeviceBrandManageAction.downloadExampleType.errorInfo17_n81i",i+"");
					}
					/*//创建时间addTime
					if (null == cell_15||cell_15.getCellType()==Cell.CELL_TYPE_BLANK) {
					} else if (cell_15.getCellType() == Cell.CELL_TYPE_STRING) {
						try{
							deviceTypeInfo.setAddTime(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(cell_15.getStringCellValue().trim()));
						}catch (Exception e) {
							// TODO: handle exception
							errorInfo += i + "行15列节点创建时间填写格式错误;";
						}
					}else if (cell_15.getCellType() == Cell.CELL_TYPE_NUMERIC) {
						deviceTypeInfo.setAddTime(cell_15.getDateCellValue());
					}else {
						errorInfo += i + "行15列节点创建时间错误;";
					}
					
					//添加人addUserid
					if (null == cell_16||cell_16.getCellType()==Cell.CELL_TYPE_BLANK) {
					} else if (cell_16.getCellType() == Cell.CELL_TYPE_NUMERIC) {
						deviceTypeInfo.setAddUserid((long)cell_16.getNumericCellValue());
					}else {
						errorInfo += i + "行16列节点添加人错误;";
					}
					
					//最后更改时间lastUpdateTime
					if (null == cell_17||cell_17.getCellType()==Cell.CELL_TYPE_BLANK) {
					} else if (cell_17.getCellType() == Cell.CELL_TYPE_STRING) {
						try{
							deviceTypeInfo.setLastUpdateTime(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(cell_17.getStringCellValue().trim()));
						}catch (Exception e) {
							// TODO: handle exception
							errorInfo += i + "行17列节点最后更改时间填写格式错误;";
						}
					}else if (cell_17.getCellType() == Cell.CELL_TYPE_NUMERIC) {
						deviceTypeInfo.setLastUpdateTime(cell_17.getDateCellValue());
					}else {
						errorInfo += i + "行17列节点最后更改时间错误;";
					}
					
					//最后更改人lastUpdateUserid
					if (null == cell_18||cell_18.getCellType()==Cell.CELL_TYPE_BLANK) {
					} else if (cell_18.getCellType() == Cell.CELL_TYPE_NUMERIC) {
						deviceTypeInfo.setLastUpdateUserid((long)cell_18.getNumericCellValue());
					}else {
						errorInfo += i + "行18列节点最后更改人错误;";
					}*/
					
					//监测类别表diTableName
					if (null == cell_15||cell_15.getCellType()==Cell.CELL_TYPE_BLANK) {
					} else if (cell_15.getCellType() == Cell.CELL_TYPE_STRING) {
						deviceTypeInfo.setDiTableName(cell_15.getStringCellValue().trim());
					}else {
						errorInfo +=  getI18nText("i18n_DeviceBrandManageAction.downloadExampleType.errorInfo18_n81i",i+"");
					}
					
					//连接字段indexFiled
					if (null == cell_16||cell_16.getCellType()==Cell.CELL_TYPE_BLANK) {
					} else if (cell_16.getCellType() == Cell.CELL_TYPE_STRING) {
						deviceTypeInfo.setIndexFiled(cell_16.getStringCellValue().trim());
					}else {
						errorInfo +=  getI18nText("i18n_DeviceBrandManageAction.downloadExampleType.errorInfo19_n81i",i+"");
					}
					
					//状态字段statusFiled
					if (null == cell_17||cell_17.getCellType()==Cell.CELL_TYPE_BLANK) {
					} else if (cell_17.getCellType() == Cell.CELL_TYPE_STRING) {
						deviceTypeInfo.setStatusFiled(cell_17.getStringCellValue().trim());
					}else {
						errorInfo +=  getI18nText("i18n_DeviceBrandManageAction.downloadExampleType.errorInfo20_n81i",i+"");
					}
					
					//异常比较符(>,<,=)statusSymbols
					if (null == cell_18||cell_18.getCellType()==Cell.CELL_TYPE_BLANK) {
					} else if (cell_18.getCellType() == Cell.CELL_TYPE_STRING) {
						deviceTypeInfo.setStatusSymbols(cell_18.getStringCellValue().trim());
					}else {
						errorInfo +=  getI18nText("i18n_DeviceBrandManageAction.downloadExampleType.errorInfo21_n81i",i+"");
					}
					
					//异常比较值statusValue
					if (null == cell_19||cell_19.getCellType()==Cell.CELL_TYPE_BLANK) {
					} else if (cell_19.getCellType() == Cell.CELL_TYPE_STRING) {
						deviceTypeInfo.setStatusValue(cell_19.getStringCellValue().trim());
					} else if (cell_19.getCellType() == Cell.CELL_TYPE_NUMERIC) {
						deviceTypeInfo.setStatusValue(String.valueOf(cell_19.getNumericCellValue()));
					}else {
						errorInfo +=  getI18nText("i18n_DeviceBrandManageAction.downloadExampleType.errorInfo33_n81i",i+"");
					}
					
					//图形级别showLevel
					if (null == cell_20||cell_20.getCellType()==Cell.CELL_TYPE_BLANK) {
					}else if (cell_20.getCellType() == Cell.CELL_TYPE_NUMERIC) {
						deviceTypeInfo.setShowLevel((long)cell_20.getNumericCellValue());
					}else {
						errorInfo +=  getI18nText("i18n_DeviceBrandManageAction.downloadExampleType.errorInfo23_n81i",i+"");
					}
					
					//是否有链接isLink
					if (null == cell_21||cell_21.getCellType()==Cell.CELL_TYPE_BLANK) {
					}else if (cell_21.getCellType() == Cell.CELL_TYPE_NUMERIC) {
						deviceTypeInfo.setIsLink((long)cell_21.getNumericCellValue());
					}else {
						errorInfo +=  getI18nText("i18n_DeviceBrandManageAction.downloadExampleType.errorInfo22_n81i",i+"");
					}
					
					//是否叶子设备（必填，1是，0否）isLeaf
					if (null == cell_22||cell_22.getCellType()==Cell.CELL_TYPE_BLANK) {
						errorInfo +=  getI18nText("i18n_DeviceBrandManageAction.downloadExampleType.errorInfo24_n81i",i+"");
					} else if(cell_22.getCellType() == Cell.CELL_TYPE_NUMERIC){
						deviceTypeInfo.setIsLeaf((long) cell_22.getNumericCellValue());
					} else {
						errorInfo +=  getI18nText("i18n_DeviceBrandManageAction.downloadExampleType.errorInfo25_n81i",i+"");
					}
					
					//设备最大叠加数（整形数值，默认为1）maxDeviceNum
					if (null == cell_23||cell_23.getCellType()==Cell.CELL_TYPE_BLANK) {
					} else if(cell_23.getCellType() == Cell.CELL_TYPE_NUMERIC){
						deviceTypeInfo.setMaxDeviceNum((long) cell_23.getNumericCellValue());
					} else {
						errorInfo +=  getI18nText("i18n_DeviceBrandManageAction.downloadExampleType.errorInfo26_n81i",i+"");
					}
					
					if ("".equals(errorInfo)) {// 保存节点
						errorInfo = this.saveNodeType(deviceTypeInfo);
					}
					if ("".equals(errorInfo)) {
						count++;
					} else {
						if(deviceTypeInfo.getDeviceTypeCode()==null){
							errorList.add("");
						}else{
							errorList.add(deviceTypeInfo.getDeviceTypeCode());
						}
						if(deviceTypeInfo.getDeviceRandCode()==null){
							errorList.add("");
						}else{
							errorList.add(deviceTypeInfo.getDeviceRandCode());
						}
						if(deviceTypeInfo.getDeviceDesc()==null){
							errorList.add("");
						}else{
							errorList.add(deviceTypeInfo.getDeviceDesc());
						}
						if(deviceTypeInfo.getShowIndex()==null){
							errorList.add("");
						}else{
							errorList.add(deviceTypeInfo.getShowIndex().toString());
						}						
						if(deviceTypeInfo.getPid()==null){
							errorList.add("");
						}else{
							errorList.add(deviceTypeInfo.getPid());
						}
						if(deviceTypeInfo.getFigureType()==null){
							errorList.add("");
						}else{
							errorList.add(deviceTypeInfo.getFigureType());
						}
						if(deviceTypeInfo.getFigureX()==null){
							errorList.add("");
						}else{
							errorList.add(deviceTypeInfo.getFigureX().toString());
						}
						if(deviceTypeInfo.getFigureY()==null){
							errorList.add("");
						}else{
							errorList.add(deviceTypeInfo.getFigureY().toString());
						}
						if(deviceTypeInfo.getFigureWidth()==null){
							errorList.add("");
						}else{
							errorList.add(deviceTypeInfo.getFigureWidth().toString());
						}						
						if(deviceTypeInfo.getFigureHeight()==null){
							errorList.add("");
						}else{
							errorList.add(deviceTypeInfo.getFigureHeight().toString());
						}						
						if(deviceTypeInfo.getFigureStroke()==null){
							errorList.add("");
						}else{
							errorList.add(deviceTypeInfo.getFigureStroke());
						}
						if(deviceTypeInfo.getFigureStrokeWidth()==null){
							errorList.add("");
						}else{
							errorList.add(deviceTypeInfo.getFigureStrokeWidth().toString());
						}
						if(deviceTypeInfo.getFigureFill()==null){
							errorList.add("");
						}else{
							errorList.add(deviceTypeInfo.getFigureFill());
						}
						if(deviceTypeInfo.getNameFormat()==null){
							errorList.add("");
						}else{
							errorList.add(deviceTypeInfo.getNameFormat());
						}
						if(deviceTypeInfo.getDiTableName()==null){
							errorList.add("");
						}else{
							errorList.add(deviceTypeInfo.getDiTableName());
						}
						if(deviceTypeInfo.getIndexFiled()==null){
							errorList.add("");
						}else{
							errorList.add(deviceTypeInfo.getIndexFiled());
						}
						if(deviceTypeInfo.getStatusFiled()==null){
							errorList.add("");
						}else{
							errorList.add(deviceTypeInfo.getStatusFiled());
						}
						if(deviceTypeInfo.getStatusSymbols()==null){
							errorList.add("");
						}else{
							errorList.add(deviceTypeInfo.getStatusSymbols());
						}
						if(deviceTypeInfo.getStatusValue()==null){
							errorList.add("");
						}else{
							errorList.add(deviceTypeInfo.getStatusValue());
						}
						if(deviceTypeInfo.getShowLevel()==null){
							errorList.add("");
						}else{
							errorList.add(deviceTypeInfo.getShowLevel().toString());
						}
						if(deviceTypeInfo.getIsLink()==null){
							errorList.add("");
						}else{
							errorList.add(deviceTypeInfo.getIsLink().toString());
						}
						if(deviceTypeInfo.getIsLeaf()==null){
							errorList.add("");
						}else{
							errorList.add(deviceTypeInfo.getIsLeaf().toString());
						}
						if(deviceTypeInfo.getMaxDeviceNum()==null){
							errorList.add("");
						}else{
							errorList.add(deviceTypeInfo.getMaxDeviceNum().toString());
						}
						errorList.add(errorInfo);
						rowList.add(errorList);
						errorInfo = "";

					}
				}
			}
			
			// 创建对工作表的引用，得到表的第一页
			Sheet sheet1 = workbook.getSheetAt(1);
			// 读取左上端单元

			// 记录存储数据条数
			int count1 = 0;
			// 记录读入excel数据条数
			int sum1 = (sheet1.getLastRowNum());
			for (short i = 1; i <= sheet1.getLastRowNum(); i++) {
				DeviceBrandType deviceBrandType = new DeviceBrandType();
				List<String> errorList = new ArrayList<String>();
				Row row = sheet1.getRow(i);
				Cell cell_1 = row.getCell((short) 0);
				Cell cell_2 = row.getCell((short) 1);
				Cell cell_3 = row.getCell((short) 2);
				if((null == cell_1 ||3==cell_1.getCellType()) 
						&&(null == cell_2 ||3==cell_2.getCellType()) 
						&&(null == cell_3 ||3==cell_3.getCellType())){
					sum1--;
				}else {
					//设备品牌代码（必填）
					if (null == cell_1||cell_1.getCellType()==Cell.CELL_TYPE_BLANK) {
						errorInfo +=  getI18nText("i18n_DeviceBrandManageAction.downloadExampleType.errorInfo27_n81i",i+"");
					} else if (cell_1.getCellType() == Cell.CELL_TYPE_STRING) {
						if ("".equals(cell_1.getStringCellValue())) {
							errorInfo +=  getI18nText("i18n_DeviceBrandManageAction.downloadExampleType.errorInfo27_n81i",i+"");
						} else {
							deviceBrandType.setDeviceBrandCode(cell_1.getStringCellValue().trim());
						}
					}else if(cell_1.getCellType() == Cell.CELL_TYPE_NUMERIC){
						deviceBrandType.setDeviceBrandCode(String.valueOf((int) cell_1.getNumericCellValue()));
					} else {
						errorInfo +=  getI18nText("i18n_DeviceBrandManageAction.downloadExampleType.errorInfo28_n81i",i+"");
					}

					//设备型号（必填）
					if (null == cell_2||cell_2.getCellType()==Cell.CELL_TYPE_BLANK) {
						errorInfo +=  getI18nText("i18n_DeviceBrandManageAction.downloadExampleType.errorInfo31_n81i",i+"");
					} else if (cell_2.getCellType() == Cell.CELL_TYPE_STRING) {
						if ("".equals(cell_2.getStringCellValue())) {
							errorInfo +=  getI18nText("i18n_DeviceBrandManageAction.downloadExampleType.errorInfo31_n81i",i+"");
						} else {
							deviceBrandType.setParDeviceTypeCode(cell_2.getStringCellValue().trim());
						}
					} else if(cell_2.getCellType() == Cell.CELL_TYPE_NUMERIC){
						deviceBrandType.setParDeviceTypeCode(String.valueOf((int) cell_2.getNumericCellValue()));
					} else{
						errorInfo +=  getI18nText("i18n_DeviceBrandManageAction.downloadExampleType.errorInfo32_n81i",i+"");
					}

					//可配父设备（必填）
					if(null == cell_3 || cell_3.getCellType()==Cell.CELL_TYPE_BLANK){
						errorInfo +=  getI18nText("i18n_DeviceBrandManageAction.downloadExampleType.errorInfo29_n81i",i+"");
					}else if(cell_3.getCellType() == Cell.CELL_TYPE_NUMERIC){
						deviceBrandType.setSubDeviceTypeCode(String.valueOf((int)cell_3.getNumericCellValue()));
					}else if (cell_3.getCellType() == Cell.CELL_TYPE_STRING) {
						if ("".equals(cell_3.getStringCellValue())) {
							errorInfo +=  getI18nText("i18n_DeviceBrandManageAction.downloadExampleType.errorInfo29_n81i",i+"");
						} else {
							deviceBrandType.setSubDeviceTypeCode(cell_3.getStringCellValue().trim());
						}
					} else {
						errorInfo +=  getI18nText("i18n_DeviceBrandManageAction.downloadExampleType.errorInfo30_n81i",i+"");
					}
					
					if ("".equals(errorInfo)) {// 保存节点
						errorInfo = this.saveNodeBrandType(deviceBrandType);
					}
					if ("".equals(errorInfo)) {
						count1++;
					} else {
						if(deviceBrandType.getDeviceBrandCode()==null){
							errorList.add("");
						}else{
							errorList.add(deviceBrandType.getDeviceBrandCode());
						}
						if(deviceBrandType.getParDeviceTypeCode()==null){
							errorList.add("");
						}else{
							errorList.add(deviceBrandType.getParDeviceTypeCode());
						}
						if(deviceBrandType.getSubDeviceTypeCode()==null){
							errorList.add("");
						}else{
							errorList.add(deviceBrandType.getSubDeviceTypeCode());
						}						
						errorList.add(errorInfo);
						rowList1.add(errorList);
						errorInfo = "";

					}
				}
			}
			
			headerList.add(getI18nText("i18n_DeviceBrandManageAction.downloadExampleType.deviceType_n81i"));
			headerList.add(getI18nText("i18n_DeviceBrandManageAction.downloadExampleType.brandBelong_n81i"));
			headerList.add(getI18nText("i18n_DeviceBrandManageAction.downloadExampleType.deviceDesc_n81i"));
			headerList.add(getI18nText("i18n_DeviceBrandManageAction.downloadExampleType.positionId_n81i"));
			headerList.add(getI18nText("i18n_DeviceBrandManageAction.downloadExampleType.parentDeviceType_n81i"));
			headerList.add(getI18nText("i18n_DeviceBrandManageAction.downloadExampleType.pictureType_n81i"));
			headerList.add(getI18nText("i18n_DeviceBrandManageAction.downloadExampleType.XHeight_n81i"));
			headerList.add(getI18nText("i18n_DeviceBrandManageAction.downloadExampleType.YWeith_n81i"));
			headerList.add(getI18nText("i18n_DeviceBrandManageAction.downloadExampleType.weith_n81i"));
			headerList.add(getI18nText("i18n_DeviceBrandManageAction.downloadExampleType.height_n81i"));
			headerList.add(getI18nText("i18n_DeviceBrandManageAction.downloadExampleType.lineColor_n81i"));
			headerList.add(getI18nText("i18n_DeviceBrandManageAction.downloadExampleType.lineWeith_n81i"));
			headerList.add(getI18nText("i18n_DeviceBrandManageAction.downloadExampleType.pictureName_n81i"));
			headerList.add(getI18nText("i18n_DeviceBrandManageAction.downloadExampleType.nameFormat_n81i"));
			headerList.add(getI18nText("i18n_DeviceBrandManageAction.downloadExampleType.detecateTypeTable_n81i"));
			headerList.add(getI18nText("i18n_DeviceBrandManageAction.downloadExampleType.linkField_n81i"));
			headerList.add(getI18nText("i18n_DeviceBrandManageAction.downloadExampleType.stateField_n81i"));
			headerList.add(getI18nText("i18n_DeviceBrandManageAction.downloadExampleType.exceptionCompare_n81i"));
			headerList.add(getI18nText("i18n_DeviceBrandManageAction.downloadExampleType.exceptionCompareValue_n81i"));
			headerList.add(getI18nText("i18n_DeviceBrandManageAction.downloadExampleType.pictureLevel_n81i"));
			headerList.add(getI18nText("i18n_DeviceBrandManageAction.downloadExampleType.isLinked_n81i"));
			headerList.add(getI18nText("i18n_DeviceBrandManageAction.downloadExampleType.isLeafDevice_n81i"));
			headerList.add(getI18nText("i18n_DeviceBrandManageAction.downloadExampleType.maxNum_n81i"));
			headerList.add(getI18nText("i18n_DeviceBrandManageAction.downloadExampleType.errorInfo_n81i"));
			
			headerList1.add(getI18nText("i18n_DeviceBrandManageAction.downloadExampleType.deviceBrandCode_n81i"));
			headerList1.add(getI18nText("i18n_DeviceBrandManageAction.downloadExampleType.deviceBrand_n81i"));
			headerList1.add(getI18nText("i18n_DeviceBrandManageAction.downloadExampleType.parentDevice_n81i"));
			headerList1.add(getI18nText("i18n_DeviceBrandManageAction.downloadExampleType.errorInfo_n81i"));
			this.getRequest().setAttribute("rowList", rowList);
			this.getRequest().setAttribute("headerList", headerList);

			this.getRequest().setAttribute("errorTheme", getI18nText("i18n_DeviceBrandManageAction.downloadExampleType.brandLinkInfo_n81i"));
			this.getRequest().setAttribute("rowList1", rowList1);
			this.getRequest().setAttribute("headerList1", headerList1);
			if (count == sum && sum > 0&&count1 == sum1 && sum1 >= 0) {
//				this.getRequest().setAttribute("MSG", 1);
//				queryDeviceTypeInfo();
//				return "deviceTypeInfoList";
				outHtmlString("<script type=\"text/javascript\">alert('i18n_DeviceBrandManageAction.downloadExampleType.success_n81i');this.location='deviceBrandManage.do?action=queryDeviceTypeInfo'</script>");
				return null;
			} else if (sum == 0&&sum1 ==0) {
				this
						.outHtmlString("<script>alert('i18n_DeviceBrandManageAction.downloadExampleType.selectFileIsNull_n81i');history.back();</script>");
				return null;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "showError";
	}

	private String saveNodeType(DeviceTypeInfo devType) {
		String desc = "";
		DeviceTypeInfo devType1=null;
		try {
			commonService.beginTransaction();
			String operator="save"; 
			// 设备型号不能重复:不同品牌可以重复吗？
			List<DeviceTypeInfo> list = this.commonService
					.find("from DeviceTypeInfo where deviceTypeCode='"
							+ devType.getDeviceTypeCode().trim()
							+ "' and deviceRandCode='"
							+ devType.getDeviceRandCode() + "'");
			if (list != null && list.size() > 0) {
				devType1 = list.get(0);
				devType.setId(devType1.getId());
				devType.setAddTime(devType1.getAddTime());
				devType.setAddUserid(devType1.getAddUserid());
				operator="update"; 
			}
			list.clear();
			if (devType.getMaxDeviceNum() == null) {
				devType.setMaxDeviceNum(1l);
			}
			if (devType.getIsLeaf() != 0 && devType.getIsLeaf() != 1) {
				return getI18nText("i18n_DeviceBrandManageAction.downloadExampleType.slotDeviceInputErr_n81i")+";";
			}
			if (devType.getDiTableName() != null && !devType.getDiTableName().equals("")) {
				List<CheckTypeInfo> checkTypeInfoInfo = this.commonService
						.find("from CheckTypeInfo where tableName = ?",devType.getDiTableName());
				if(checkTypeInfoInfo==null||checkTypeInfoInfo.size()==0){
					return getI18nText("i18n_DeviceBrandManageAction.downloadExampleType.currentDetecateTypeNotExists_n81i")+";";
				}
			}
			if (devType.getStatusSymbols() != null&&!devType.getStatusSymbols().equals("")
					&& (devType.getStatusSymbols() != ">"
							|| devType.getStatusSymbols() != "<" || devType
							.getStatusSymbols() != "=")) {
				return getI18nText("i18n_DeviceBrandManageAction.downloadExampleType.exceptionValidateErr_n81i")+";";
			}
			Date date = new Date();
			if(operator.equals("save")){
				devType.setAddTime(date);
				devType.setAddUserid(this.getUserID());
				devType.setLastUpdateTime(date);
				devType.setLastUpdateUserid(this.getUserID());
			}else{
				devType.setLastUpdateTime(date);
				devType.setLastUpdateUserid(this.getUserID());
			}
			// showIdex：用户输入，pid：界面选择
			if (devType.getShowIndex() == null) {// 一级设备，默认的shouIndex=1
				devType.setShowIndex(1l);
			}
			// x，y，width，height:空着
			devType.setFigureType("image");
			devType.setFigureStroke("red");
			devType.setFigureStrokeWidth(1l);

			// showLevel,isLink
			String tabName = devType.getDiTableName();
			if (StringUtils.isNotBlank(tabName)
					&& "DI_SWITCHPORT".equalsIgnoreCase(tabName)) {
				devType.setIsLink(1l);
			} else {
				devType.setIsLink(0l);
			}

//			devType.setFigureWidth(359l);
//			devType.setFigureHeight(40l);
			
			//若pid为空 默认为顶级设备 不为空 转换成相应id号
			if(devType.getPid()==null||devType.getPid().equals("")){
				devType.setPid("0");
			}else{	
				//2014-11-18 wx注释，deviceTypeInfolist修改
				//List<DeviceTypeInfo> deviceTypeInfolist = commonService.find("from DeviceTypeInfo where deviceTypeCode=?",devType.getPid());			
				List<DeviceTypeInfo> deviceTypeInfolist = commonService.find("from DeviceTypeInfo where id=?",Long.parseLong(devType.getPid()));
				if(deviceTypeInfolist==null||deviceTypeInfolist.size()==0){
					return getI18nText("i18n_DeviceBrandManageAction.downloadExampleType.parentDeviceBrandIsNull_n81i")+";";
				}
				devType.setPid(deviceTypeInfolist.get(0).getId().toString());
			}
			if(operator.equals("save")){
				this.commonService.save(devType);
			}else{
				commonService.clear();
				this.commonService.update(devType);
			}
			commonService.commit();
		} catch (Exception e) {
			commonService.rollback();
			e.printStackTrace();
			desc = getI18nText("BrandManageAction.downloadExampleType.nodeInfoImportErr_n81i")+";";
		}
		return desc;
	}
	
	private String saveNodeBrandType(DeviceBrandType deviceBrandType) {
		String desc = "";
		try {
			commonService.beginTransaction();
			List<DeviceBrandInfo> DeviceBrandInfolist = commonService.find("from DeviceBrandInfo where deviceRandCode=?",deviceBrandType.getDeviceBrandCode());
			if(DeviceBrandInfolist==null||DeviceBrandInfolist.size()==0){
				return getI18nText("i18n_DeviceBrandManageAction.downloadExampleType.deviceBrandCodeNotExists_n81i");
			}
			/*
			 *2014 11 18 wx 添加注释 修改DeviceTypeInfolist 设备型号 可配父设备 原来代码写反了
			 */
			List<DeviceTypeInfo> DeviceTypeInfolist = commonService.find("from DeviceTypeInfo where deviceTypeCode=?",deviceBrandType.getSubDeviceTypeCode());
			if(DeviceTypeInfolist==null||DeviceTypeInfolist.size()==0){
				return getI18nText("i18n_DeviceBrandManageAction.downloadExampleType.deviceBrandNotExists_n81i");
			}
			
			DeviceTypeInfolist = commonService.find("from DeviceTypeInfo where deviceTypeCode=?",deviceBrandType.getParDeviceTypeCode());
			if(DeviceTypeInfolist==null||DeviceTypeInfolist.size()==0){
				return getI18nText("i18n_DeviceBrandManageAction.downloadExampleType.parentDeviceNotExists_n81i");
			}
			//判断品牌与主机架关系
			DeviceTypeInfolist = commonService.find("from DeviceTypeInfo where deviceTypeCode=? and deviceRandCode=?",deviceBrandType.getParDeviceTypeCode(),deviceBrandType.getDeviceBrandCode());
			if(DeviceTypeInfolist==null||DeviceTypeInfolist.size()==0){
				return deviceBrandType.getDeviceBrandCode()+getI18nText("i18n_DeviceBrandManageAction.downloadExampleType.exceptionValidateErr1_n81i")+deviceBrandType.getParDeviceTypeCode()+getI18nText("i18n_DeviceBrandManageAction.downloadExampleType.exceptionValidateErr2_n81i");
			}
			//判断品牌与板卡关系
			DeviceTypeInfolist = commonService.find("from DeviceTypeInfo where deviceTypeCode=? and deviceRandCode=?",deviceBrandType.getSubDeviceTypeCode(),deviceBrandType.getDeviceBrandCode());
			if(DeviceTypeInfolist==null||DeviceTypeInfolist.size()==0){
				return deviceBrandType.getDeviceBrandCode()+getI18nText("i18n_DeviceBrandManageAction.downloadExampleType.exceptionValidateErr1_n81i")+deviceBrandType.getSubDeviceTypeCode()+getI18nText("i18n_DeviceBrandManageAction.downloadExampleType.exceptionValidateErr2_n81i");
			}
			List<DeviceBrandType> list = commonService.find("from DeviceBrandType where deviceBrandCode=? and parDeviceTypeCode=? and subDeviceTypeCode=?",
					deviceBrandType.getDeviceBrandCode(),deviceBrandType.getParDeviceTypeCode(),deviceBrandType.getSubDeviceTypeCode());
			if(list!=null&&list.size()>0){
				return getI18nText("i18n_DeviceBrandManageAction.downloadExampleType.mapExists_n81i");
			}
			
			commonService.save(deviceBrandType);
			commonService.commit();
		} catch (Exception e) {
			commonService.rollback();
			e.printStackTrace();
			desc = getI18nText("i18n_DeviceBrandManageAction.downloadExampleType.nodeInfoImportErr_n81i");
		}
		return desc;
	}
	
	// 当前页导出   程辉 2013-5-8新增
	public String emportCurrentXlsType() {
		try {
			String hql = "from DeviceTypeInfo where 1=1 ";
			//设备型号
			if (StringUtils.isNotBlank(devTypeCodeForSearch)) {
				hql += " and lower(deviceTypeCode) like lower('%" + devTypeCodeForSearch.trim() + "%')";
			}
			//设备品牌
			if (StringUtils.isNotBlank(devRandCodeForSearch)) {
				hql += " and lower(deviceRandCode) = lower('" + devRandCodeForSearch.trim() + "')";
			}
			//父设备型号
			if (StringUtils.isNotBlank(parDevCode)) {
				DeviceTypeInfo deviceTypeInfo=(DeviceTypeInfo)this.commonService.getUniqueByHql("from DeviceTypeInfo where deviceTypeCode=?", parDevCode.trim());//根据父设备型号获得父设备
				if(deviceTypeInfo!=null){
					hql += " and pid='" + deviceTypeInfo.getId()+"'";
				}else{
					this.outHtmlString("<script>alert('i18n_DeviceBrandManageAction.emportCurrentXlsType.exportResultNotExists_n81i！');window.location='/nmsweb/sysManage/deviceBrandManage.do?action=queryDeviceTypeInfo';</script>");
				}
			}
			hql += "order by lastUpdateTime desc,deviceRandCode desc, showLevel asc,pid asc,id asc,showIndex asc";
			page = this.commonService.findByPage(hql, pageNo,pageSize);
			List<DeviceTypeInfo> devTypeListInfo = (ArrayList<DeviceTypeInfo>)page.getResult();
			Map<String,String> idCodeMap = getIdCodeMap();
			String parDeviceTypeCodes ="";
			for (DeviceTypeInfo dev : devTypeListInfo) {
				if (dev.getPid().equals("0")) {
					dev.setPid("");
				} else {
					dev.setPid(idCodeMap.get(dev.getPid()));
				}
				parDeviceTypeCodes +="'"+dev.getDeviceTypeCode()+"',";
			}
			String hql1 = "";
			if(!parDeviceTypeCodes.equals("")){
				parDeviceTypeCodes = parDeviceTypeCodes.substring(0,parDeviceTypeCodes.length()-1);
				hql1="from DeviceBrandType where parDeviceTypeCode in ("+parDeviceTypeCodes+") order by deviceBrandCode,parDeviceTypeCode asc";
			}else{
				hql1="from DeviceBrandType where 1=2 order by deviceBrandCode,parDeviceTypeCode asc";
			}			
			List<DeviceBrandType> deviceBrandType = commonService.find(hql1);
			String[] title = { getI18nText("i18n_DeviceBrandManageAction.downloadExampleType.deviceBrand_n81i"),
								getI18nText("i18n_DeviceBrandManageAction.downloadExampleType.brandBelong_n81i"),
								getI18nText("i18n_DeviceBrandManageAction.downloadExampleType.deviceDesc_n81i"),
								getI18nText("i18n_DeviceBrandManageAction.downloadExampleType.parentDeviceType_n81i"),
								getI18nText("i18n_DeviceBrandManageAction.emportCurrentXlsType.title.createTime_n81i")};
			String[] colu = { "deviceTypeCode","deviceRandCode","deviceDesc","pid","addTime"};
			String[] title1 = { getI18nText("i18n_DeviceBrandManageAction.downloadExampleType.deviceBrandCode_n81i"),
								getI18nText("i18n_DeviceBrandManageAction.downloadExampleType.deviceBrand_n81i"),
								getI18nText("i18n_DeviceBrandManageAction.emportCurrentXlsType.title1.subDevice_n81i")};
			String[] colu1 = { "deviceBrandCode","parDeviceTypeCode","subDeviceTypeCode"};
			ExportUtils m = new ExportUtils();
			m.setAutoSizeColumn(true);
			m.exportExcel2Sheet(getI18nText("i18n_DeviceBrandManageAction.downloadExampleType.deviceManageInfoTable_n81i"),getI18nText("i18n_DeviceBrandManageAction.downloadExampleType.deviceManageInfo_n81i"),getI18nText("i18n_DeviceBrandManageAction.downloadExampleType.brandLinkInfo_n81i"), devTypeListInfo, title, colu, deviceBrandType, title1, colu1);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	// 导出全部   程辉 2013-5-8新增
	public String emportAllXlsType() {
		try {
			String hql = "from DeviceTypeInfo where 1=1 ";
			//设备型号
			if (StringUtils.isNotBlank(devTypeCodeForSearch)) {
				hql += " and lower(deviceTypeCode) like lower('%" + devTypeCodeForSearch.trim() + "%')";
			}
			//设备品牌
			if (StringUtils.isNotBlank(devRandCodeForSearch)) {
				hql += " and lower(deviceRandCode) = lower('" + devRandCodeForSearch.trim() + "')";
			}
			//父设备型号
			if (StringUtils.isNotBlank(parDevCode)) {
				DeviceTypeInfo deviceTypeInfo=(DeviceTypeInfo)this.commonService.getUniqueByHql("from DeviceTypeInfo where deviceTypeCode=?", parDevCode.trim());//根据父设备型号获得父设备
				if(deviceTypeInfo!=null){
					hql += " and pid='" + deviceTypeInfo.getId()+"'";
				}
			}
			hql += "order by lastUpdateTime desc,deviceRandCode desc, showLevel asc,pid asc,id asc,showIndex asc";
			List<DeviceTypeInfo> devTypeListInfo = this.commonService.find(hql);;
			Map<String,String> idCodeMap = getIdCodeMap();
			for (DeviceTypeInfo dev : devTypeListInfo) {
				if (dev.getPid().equals("0")) {
					dev.setPid("");
				} else {
					dev.setPid(idCodeMap.get(dev.getPid()));
				}
			}
			String hql1="from DeviceBrandType order by deviceBrandCode,parDeviceTypeCode asc";
			List<DeviceBrandType> deviceBrandType = commonService.find(hql1);
			String[] title = { getI18nText("i18n_DeviceBrandManageAction.downloadExampleType.deviceType_n81i"),
								getI18nText("i18n_DeviceBrandManageAction.downloadExampleType.brandBelong_n81i"),
								getI18nText("i18n_DeviceBrandManageAction.downloadExampleType.deviceDesc_n81i"),
								getI18nText("i18n_DeviceBrandManageAction.downloadExampleType.parentDeviceType_n81i"),
								getI18nText("i18n_DeviceBrandManageAction.emportCurrentXlsType.title.createTime_n81i")};
			String[] colu = { "deviceTypeCode","deviceRandCode","deviceDesc","pid","addTime"};
			String[] title1 = { getI18nText("i18n_DeviceBrandManageAction.downloadExampleType.deviceBrandCode_n81i"),
								getI18nText("i18n_DeviceBrandManageAction.downloadExampleType.deviceBrand_n81i"),
								getI18nText("i18n_DeviceBrandManageAction.downloadExampleType.parentDevice_n81i")};
			String[] colu1 = { "deviceBrandCode","parDeviceTypeCode","subDeviceTypeCode"};
			ExportUtils m = new ExportUtils();
			m.setAutoSizeColumn(true);
			m.exportExcel2Sheet(getI18nText("i18n_DeviceBrandManageAction.downloadExampleType.deviceManageInfoTable_n81i"),getI18nText("i18n_DeviceBrandManageAction.downloadExampleType.deviceManageInfo_n81i"),getI18nText("i18n_DeviceBrandManageAction.downloadExampleType.brandLinkInfo_n81i"), devTypeListInfo, title, colu, deviceBrandType, title1, colu1);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	

	// 模板下载   程辉 2013-5-13新增
	public String downloadExample() {
		try {
			String hql = "from DeviceBrandInfo ";
			hql += "order by lastUpdateTime desc";
			page = this.commonService.findByPage(hql, 1,3);
			List<DeviceBrandInfo> devBrandListInfo = (ArrayList<DeviceBrandInfo>)page.getResult();
			
			String[] title = { getI18nText("i18n_DeviceBrandManageAction.downloadExample.title.brandCode_n81i"),
								getI18nText("i18n_DeviceBrandManageAction.downloadExample.title.brandName_n81i"),
								getI18nText("i18n_DeviceBrandManageAction.downloadExample.title.brandDesc_n81i") };
	
			String[] colu = { "deviceRandCode", "deviceRandName","deviceBrandDesc" };
			ExportUtils m = new ExportUtils();
			m.setAutoSizeColumn(true);
			m.exportExcel(getI18nText("i18n_DeviceBrandManageAction.downloadExample.brandManageTable_n81i"), devBrandListInfo, title, colu,"downloadExample");
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
				String deviceRandCode="";
				String deviceRandName="";
				String deviceBrandDesc="";
				List<String> errorList = new ArrayList<String>();
				Row row = sheet.getRow(i);
				Cell cell_1 = row.getCell((short) 0);
				Cell cell_2 = row.getCell((short) 1);
				Cell cell_3 = row.getCell((short) 2);
				if((null == cell_1 ||3==cell_1.getCellType()) 
						&&(null == cell_2 ||3==cell_2.getCellType()) 
						&&(null == cell_3 ||3==cell_3.getCellType())){
					sum--;
				}else {
					// 品牌编号(必填)
					if (null == cell_1) {
						errorInfo +=  getI18nText("i18n_DeviceBrandManageAction.importXls.errorInfo1_n81i",i+"");
					} else if (cell_1.getCellType() == Cell.CELL_TYPE_STRING) {
						if ("".equals(cell_1.getStringCellValue())) {
							errorInfo +=  getI18nText("i18n_DeviceBrandManageAction.importXls.errorInfo1_n81i",i+"");
						} else {
							deviceRandCode = cell_1.getStringCellValue().trim();
						}
					}else if(cell_1.getCellType() == Cell.CELL_TYPE_NUMERIC){
						deviceRandCode =String.valueOf((int) cell_1.getNumericCellValue());
					} else {
						errorInfo +=  getI18nText("i18n_DeviceBrandManageAction.importXls.errorInfo2_n81i",i+"");
					}

					// 品牌名称(必填)
					if (null == cell_2) {
						errorInfo +=  getI18nText("i18n_DeviceBrandManageAction.importXls.errorInfo3_n81i",i+"");
					} else if (cell_2.getCellType() == Cell.CELL_TYPE_STRING) {
						if ("".equals(cell_2.getStringCellValue())) {
							errorInfo +=  getI18nText("i18n_DeviceBrandManageAction.importXls.errorInfo3_n81i",i+"");
						} else {
							deviceRandName = cell_2.getStringCellValue().trim();
						}
					} else if(cell_2.getCellType() == Cell.CELL_TYPE_NUMERIC){
						deviceRandName =String.valueOf((int) cell_2.getNumericCellValue());
					} else{
						errorInfo +=  getI18nText("i18n_DeviceBrandManageAction.importXls.errorInfo4_n81i",i+"");
					}
					
					// 品牌描述 
					if(null == cell_3 || cell_3.getCellType()==Cell.CELL_TYPE_BLANK){
					}else if (cell_3.getCellType() == Cell.CELL_TYPE_STRING) {
						deviceBrandDesc = cell_3.getStringCellValue().trim();
					} else if(cell_3.getCellType() == Cell.CELL_TYPE_NUMERIC){
						deviceBrandDesc =String.valueOf((int) cell_3.getNumericCellValue());
					} else {
						errorInfo +=  getI18nText("i18n_DeviceBrandManageAction.importXls.errorInfo5_n81i",i+"");
					}
					
					if ("".equals(errorInfo)) {// 保存节点
						errorInfo = this.saveNode(deviceRandCode, deviceRandName,deviceBrandDesc );
					}
					if ("".equals(errorInfo)) {
						count++;
					} else {
						errorList.add(deviceRandCode);
						errorList.add(deviceRandName);
						errorList.add(deviceBrandDesc);
						errorList.add(errorInfo);
						rowList.add(errorList);
						errorInfo = "";

					}
				}
			}
			headerList.add(getI18nText("i18n_DeviceBrandManageAction.importXls.brandID_n81i"));
			headerList.add(getI18nText("i18n_DeviceBrandManageAction.importXls.brandName_n81i"));
			headerList.add(getI18nText("i18n_DeviceBrandManageAction.importXls.brandDesc_n81i"));
			headerList.add(getI18nText("i18n_DeviceBrandManageAction.importXls.errorInfo_n81i"));
			this.getRequest().setAttribute("rowList", rowList);
			this.getRequest().setAttribute("headerList", headerList);
			if (count == sum && sum > 0) {
//				this.getRequest().setAttribute("MSG", 1);
//				queryDeviceBrandInfo();
//				return  "deviceBrandInfoList";
				outHtmlString("<script type=\"text/javascript\">alert('i18n_DeviceBrandManageAction.importXls.success_n81i');this.location='deviceBrandManage.do?action=queryDeviceBrandInfo'</script>");
				return null;
			} else if (sum == 0) {
				this
						.outHtmlString("<script>alert('i18n_DeviceBrandManageAction.importXls.selectFileIsNull_n81i');history.back();</script>");
				return null;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "showError";
	}

	private String saveNode(String deviceRandCode,String deviceRandName,String deviceBrandDesc ) {
		String desc = "";		
		try {
			// 保存节点信息
			DeviceBrandInfo devBrand = new DeviceBrandInfo();
			devBrand.setDeviceRandCode(deviceRandCode);
			devBrand.setDeviceRandName(deviceRandName);
			devBrand.setDeviceBrandDesc(deviceBrandDesc);
			devBrand.setAddTime(new Date());
			devBrand.setAddUserid(getUserID());
			devBrand.setLastUpdateTime(new Date());
			devBrand.setLastUpdateUserid(getUserID());

			//品牌编号不能重复
			List list = this.commonService.find("from DeviceBrandInfo where deviceRandCode='"+devBrand.getDeviceRandCode().trim()+"'");
			//品牌名称不能重复，会引起使用者误会
			List list2 = this.commonService.find("from DeviceBrandInfo where deviceRandName='"+devBrand.getDeviceRandName().trim()+"'");
			if(list!=null && list.size()>0) {
				list.clear();
				return getI18nText("i18n_DeviceBrandManageAction.importXls.brandIdExists_n81i")+";";				
			}else if(list2!=null && list.size()>0) {
				list2.clear();
				return getI18nText("i18n_DeviceBrandManageAction.importXls.brandNameExists_n81i")+";";
			}else {
				this.commonService.save(devBrand);
			}
		} catch (Exception e) {
			e.printStackTrace();
			desc = getI18nText("i18n_DeviceBrandManageAction.downloadExampleType.nodeInfoImportErr_n81i")+";";
		}
		return desc;
	}
	
	// 当前页导出   程辉 2013-5-8新增
	public String emportCurrentXls() {
		try {
			String hql = "from DeviceBrandInfo where 1=1 ";
			if (StringUtils.isNotBlank(brandNameForSearch)) {
				hql += " and deviceRandName like '%" + brandNameForSearch.trim() + "%'";
			}
			hql += " order by lastUpdateTime desc";
			page = this.commonService.findByPage(hql, pageNo,pageSize);
			List<DeviceBrandInfo> devBrandListInfo = (ArrayList<DeviceBrandInfo>)page.getResult();
			
			String[] title = { getI18nText("i18n_DeviceBrandManageAction.emportCurrentXls.title.brandId_n81i"),
								getI18nText("i18n_DeviceBrandManageAction.emportCurrentXls.title.brandName_n81i"),
								getI18nText("i18n_DeviceBrandManageAction.emportCurrentXls.title.brandDesc_n81i"),
								getI18nText("i18n_DeviceBrandManageAction.emportCurrentXls.title.createTime_n81i") };
	
			String[] colu = { "deviceRandCode","deviceRandName","deviceBrandDesc","addTime" };
			String url = "deviceBrandManage.do?action=queryDeviceBrandInfo&brandNameForSearch="+brandNameForSearch+"&pageSize="+pageSize+"&pageNo="+pageNo;
			ExportUtils m = new ExportUtils();
			m.setAutoSizeColumn(true);
			m.exportExcel(url,getI18nText("i18n_DeviceBrandManageAction.emportCurrentXls.brandManageInfoTable_n81i"), devBrandListInfo, title, colu);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	// 导出全部   程辉 2013-5-8新增
	public String emportAllXls() {
		try {
			String hql = "from DeviceBrandInfo where 1=1 ";
			if (StringUtils.isNotBlank(brandNameForSearch)) {
				hql += " and deviceRandName like '%" + brandNameForSearch.trim() + "%'";
			}
			hql += " order by lastUpdateTime desc";
			List<DeviceBrandInfo> devBrandListInfo  = this.commonService.find(hql);
			
			String[] title = { getI18nText("i18n_DeviceBrandManageAction.emportCurrentXls.title.brandId_n81i"),
					getI18nText("i18n_DeviceBrandManageAction.emportCurrentXls.title.brandName_n81i"),
					getI18nText("i18n_DeviceBrandManageAction.emportCurrentXls.title.brandDesc_n81i"),
					getI18nText("i18n_DeviceBrandManageAction.emportCurrentXls.title.createTime_n81i") };
	
			String[] colu = { "deviceRandCode","deviceRandName","deviceBrandDesc","addTime" };
			String url = "deviceBrandManage.do?action=queryDeviceBrandInfo&brandNameForSearch="+brandNameForSearch+"&pageSize="+pageSize+"&pageNo="+pageNo;
			ExportUtils m = new ExportUtils();
			m.setAutoSizeColumn(true);
			m.exportExcel(url,getI18nText("i18n_DeviceBrandManageAction.emportCurrentXls.brandManageInfoTable_n81i"), devBrandListInfo, title, colu);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	
	/**
	 * 
	 * 查询品牌信息：查询条件+分页 
	 * @author Administrator May 3, 2013
	 * @version 1.0 
	 * @return
	 */
	public String queryDeviceBrandInfo() {
		try {
			
			String hql = "from DeviceBrandInfo where 1=1 ";
			String sqlCondition = "where 1=1";// 将查询条件记录到操作日志中
			if (StringUtils.isNotBlank(brandNameForSearch)) {
				hql += " and Upper(deviceRandName) like '%" + brandNameForSearch.trim().toUpperCase() + "%'";
				sqlCondition += " and Upper(deviceRandName) like '%" + brandNameForSearch.trim().toUpperCase() + "%'";
			}
			hql += "order by lastUpdateTime desc";
			page = this.commonService.findByPage(hql, pageNo,pageSize);
			devBrandListInfo = (ArrayList<DeviceBrandInfo>)page.getResult();

			// 将查询请求记入到操作日志表中
			this.addDBOperationRpt(commonService, sqlCondition,"DeviceBrandInfo");
		} catch (Exception e) {
			e.printStackTrace();
			return "error";
		}
		return null;
	}
	
	//进入新增页面
	public String toAddDevBrand() {
		System.out.println(brandNameForSearch);
		return null;
	}
	
	//添加品牌信息操作
	public void addDevBrand() {
		try {
			commonService.beginTransaction();
			if(devBrand!=null && StringUtils.isNotBlank(devBrand.getDeviceRandCode())){
				//品牌编号不能重复
				List list = this.commonService.find("from DeviceBrandInfo where deviceRandCode='"+devBrand.getDeviceRandCode().trim()+"'");
				if(list!=null && list.size()>0) {
//					outHtmlString("<script type=\"text/javascript\">alert('品牌编号已存在');this.location='deviceBrandManage.do?action=toAddDevBrand'</script>");
					outHtmlString("<script type=\"text/javascript\">alert('i18n_DeviceBrandManageAction.importXls.brandIdExists_n81i');this.location='deviceBrandManage.do?action=toAddDevBrand';</script>");
				}else {
					Date date = new Date();
					devBrand.setAddTime(date);
					devBrand.setAddUserid(this.getUserID());
					devBrand.setLastUpdateTime(date);
					devBrand.setLastUpdateUserid(this.getUserID());
					devBrand.setDeviceRandCode(devBrand.getDeviceRandCode().trim());
					this.commonService.save(devBrand);
					// 将添加操作写到操作日志中
					this.addDBOperationRpt(commonService, "DeviceBrandInfo", "INSERT",devBrand.getId());
					outHtmlString("<script type=\"text/javascript\">alert('i18n_DeviceBrandManageAction.importXls.success_n81i');this.location='deviceBrandManage.do?action=queryDeviceBrandInfo'</script>");
				}
			}else {
				outHtmlString("<script type=\"text/javascript\">alert('i18n_DeviceBrandManageAction.emportCurrentXls.brandIdIsNotNull_n81i');this.location='deviceBrandManage.do?action=toAddDevBrand';</script>");
			}
			commonService.commit();
		} catch (Exception e) {
			commonService.rollback();
			e.printStackTrace();
			outHtmlString("<script type=\"text/javascript\">alert('i18n_DeviceBrandManageAction.importXls.faild_n81i');this.location='deviceBrandManage.do?action=queryDeviceBrandInfo'</script>");
		}
	}
	
	
	//进入修改页面
	public String toUpdateDevBrand() {
		try {
			if(ids!=null&&!"".equals(ids) ){
				List list = this.commonService.find("from DeviceBrandInfo where id=?", Long.valueOf(ids));
				if(list!=null && list.size()>0){
					devBrand = (DeviceBrandInfo)list.get(0);
				}
				
				//当前品牌是否有型号:1有，0无
//				List subTypeList = this.commonService.find("from DeviceTypeInfo where deviceRandCode in (select deviceRandCode from DeviceBrandInfo where id="+ids+")");
//				if(subTypeList!=null && subTypeList.size()>0) {
//					hasSubType = "1";
//				}
//				hasSubType="0";
			}
		} catch (Exception e) {
			e.printStackTrace();
			outHtmlString("<script type=\"text/javascript\">alert('i18n_DeviceBrandManageAction.importXls.faild_n81i');this.location='deviceBrandManage!execute.do?action=queryDeviceBrandInfo'</script>");
		}
		return null;
	}
	
	
	// 进行修改品牌信息操作
	public String updateDevBrand() {
		try {
			commonService.beginTransaction();
			if(devBrand!=null && StringUtils.isNotBlank(devBrand.getDeviceRandCode())) {
				//品牌编号不能重复
				List list = this.commonService.find("from DeviceBrandInfo where deviceRandCode='"+devBrand.getDeviceRandCode().trim()+"' and id<>"+devBrand.getId());
				if(list!=null && list.size()>0) {
//					outHtmlString("<script type=\"text/javascript\">alert('品牌编号已存在');window.history.go(-1);</script>");
				}else {
					DeviceBrandInfo brandForUpdate = (DeviceBrandInfo) commonService.get(DeviceBrandInfo.class, devBrand.getId());
					String oldBrandCode = brandForUpdate.getDeviceRandCode();//原品牌编码
					brandForUpdate.setDeviceRandCode(devBrand.getDeviceRandCode());
					brandForUpdate.setDeviceRandName(devBrand.getDeviceRandName());
					brandForUpdate.setDeviceBrandDesc(devBrand.getDeviceBrandDesc());
					
					Date date = new Date();
					brandForUpdate.setAddTime(date);
					brandForUpdate.setAddUserid(this.getUserID());
					brandForUpdate.setLastUpdateTime(date);
					brandForUpdate.setLastUpdateUserid(this.getUserID());
					
					this.commonService.update(brandForUpdate);
					
					//修改device_type_info,device_brand_type
					this.commonService.updateBySql("update device_type_info set DEVICE_RAND_CODE='"+devBrand.getDeviceRandCode()+"'  where DEVICE_RAND_CODE='"+oldBrandCode+"'");
					this.commonService.updateBySql("update device_brand_type set DEVICE_BRAND_CODE='"+devBrand.getDeviceRandCode()+"'  where DEVICE_BRAND_CODE='"+oldBrandCode+"'");
					
					
					// 将更新操作写到操作日志中
					this.addDBOperationRpt(commonService, "DeviceBrandInfo", "UPDATE",brandForUpdate.getId());
					outHtmlString("<script type=\"text/javascript\">alert('i18n_DeviceBrandManageAction.importXls.success_n81i');this.location='deviceBrandManage.do?action=queryDeviceBrandInfo&pageNo="+pageNo+"&pageSize="+pageSize+"'</script>");
				}
			}else {
				outHtmlString("<script type=\"text/javascript\">alert('i18n_DeviceBrandManageAction.emportCurrentXls.brandCodeIsNotNull_n81i');window.history.go(-1);</script>");
			}
			commonService.commit();
			return null;
		} catch (Exception e) {
			commonService.rollback();
			e.printStackTrace();
			outHtmlString("<script type=\"text/javascript\">alert('i18n_DeviceBrandManageAction.importXls.faild_n81i');this.location='deviceBrandManage.do?action=queryDeviceBrandInfo&pageNo="+pageNo+"&pageSize="+pageSize+"'</script>");
			return null;
		}
	}
//	
//	// 进行修改品牌信息操作
//	public String detailBrand() {
//		try {
//			String brandId = this.getRequest().getParameter("brandId");
//			brand = (Brand) commonService.get(Brand.class, Long.valueOf(brandId));
//			// 将更新操作写到操作日志中
//			this.addDBOperationRpt(commonService, "Brand", "SELECT",brand.getId());
//		} catch (Exception e) {
//			e.printStackTrace();
//			outHtmlString("<script type=\"text/javascript\">alert('操作失败');this.location='brandManage.do?action=queryBrandInfo'</script>");
//		}
//		return null;
//	}
//	
	//删除品牌信息
	public String deleteDevBrand()throws Exception{
		try {
			if(ids!=null&&!"".equals(ids)) {
				//不能删除有设备型号的品牌
				List list = this.commonService.find("from DeviceTypeInfo where deviceRandCode in( select deviceRandCode from DeviceBrandInfo where id in("+ids+"))");
				if(list!=null && list.size()>0) {
					outHtmlString("<script type=\"text/javascript\">alert('i18n_DeviceBrandManageAction.emportCurrentXls.brandDeleteDisable_n81i');window.history.go(-1);</script>");
				}else {
					String hql = "DELETE FROM DeviceBrandInfo WHERE ID IN ("+ ids + ")";
					this.commonService.delete(hql);
				}
			}
			outHtmlString("<script type=\"text/javascript\">alert('i18n_DeviceBrandManageAction.importXls.success_n81i');this.location='deviceBrandManage.do?action=queryDeviceBrandInfo'</script>");
		} catch (Exception e) {
			e.printStackTrace();
			outHtmlString("<script type=\"text/javascript\">alert('i18n_DeviceBrandManageAction.importXls.faild_n81i');this.location='deviceBrandManage.do?action=queryDeviceBrandInfo'</script>");
		}
		return null;
	}
	

	public String queryDeviceTypeInfo() {
		try {
			
			//查询所有品牌
			devBrandListInfo = (ArrayList<DeviceBrandInfo>)this.commonService.find("from DeviceBrandInfo");
			
			String hql = "from DeviceTypeInfo where 1=1 ";
			String sqlCondition = "where 1=1";// 将查询条件记录到操作日志中
			//设备型号
			if (StringUtils.isNotBlank(devTypeCodeForSearch)) {
				hql += " and lower(deviceTypeCode) like lower('%" + devTypeCodeForSearch.trim() + "%')";
				sqlCondition += " and lower(deviceTypeCode) like lower('%" + devTypeCodeForSearch.trim() + "%')";
			}
			//设备品牌
			if (StringUtils.isNotBlank(devRandCodeForSearch)) {
				hql += " and lower(deviceRandCode) = lower('" + devRandCodeForSearch.trim() + "')";
				sqlCondition += " and lower(deviceRandCode) = lower('" + devRandCodeForSearch.trim() + "')";
			}
			//父设备型号
			if (StringUtils.isNotBlank(parDevId)) {
				hql += " and pid='" + parDevId.trim()+"'";
				sqlCondition += " and pid=" + parDevId.trim()+"'";
			}
//			hql += "order by deviceRandCode desc, showLevel asc,pid asc,id asc,showIndex asc,lastUpdateTime desc";
			hql += "order by lastUpdateTime desc,deviceRandCode desc, showLevel asc,pid asc,id asc,showIndex asc";
			page = this.commonService.findByPage(hql, pageNo,pageSize);
			devTypeListInfo = (ArrayList<DeviceTypeInfo>)page.getResult();
			
			Map<String,String> idCodeMap = getIdCodeMap();
			
			for(DeviceTypeInfo dev:devTypeListInfo) {
				dev.setParDevCode(idCodeMap.get(dev.getPid()));
			}
			
			devTypeListForSearch = (ArrayList<DeviceTypeInfo>)this.commonService.find("from DeviceTypeInfo ");//父设备型号选择列表
			
			// 将查询请求记入到操作日志表中
			this.addDBOperationRpt(commonService, sqlCondition,"DeviceTypeInfo");
		} catch (Exception e) {
			e.printStackTrace();
			return "error";
		}
		return null;
	}
	/**
	 * 2014-11-19 wx
	 * 父设备改为suggest 插件自动提示，查询方法需要稍微修改
	 * @return
	 */
	public String queryDeviceTypeInfo1() {
		try {
			//查询所有品牌
			devBrandListInfo = (ArrayList<DeviceBrandInfo>)this.commonService.find("from DeviceBrandInfo");
			String hql = "from DeviceTypeInfo where 1=1 ";
			String sqlCondition = "where 1=1";// 将查询条件记录到操作日志中
			//设备型号
			if (StringUtils.isNotBlank(devTypeCodeForSearch)) {
				hql += " and lower(deviceTypeCode) like lower('%" + devTypeCodeForSearch.trim() + "%')";
				sqlCondition += " and lower(deviceTypeCode) like lower('%" + devTypeCodeForSearch.trim() + "%')";
			}
			//设备品牌
			if (StringUtils.isNotBlank(devRandCodeForSearch)) {
				hql += " and lower(deviceRandCode) = lower('" + devRandCodeForSearch.trim() + "')";
				sqlCondition += " and lower(deviceRandCode) = lower('" + devRandCodeForSearch.trim() + "')";
			}
			//父设备型号
			if (StringUtils.isNotBlank(parDevCode)) {
				DeviceTypeInfo deviceTypeInfo=(DeviceTypeInfo)this.commonService.getUniqueByHql("from DeviceTypeInfo where deviceTypeCode=?", parDevCode.trim());//根据父设备型号获得父设备
				if(deviceTypeInfo!=null){
					hql += " and pid='" + deviceTypeInfo.getId()+"'";
					sqlCondition += " and pid=" + deviceTypeInfo.getId()+"'";
				}else{
					return null;
				}
			}
			hql += "order by lastUpdateTime desc,deviceRandCode desc, showLevel asc,pid asc,id asc,showIndex asc";
			page = this.commonService.findByPage(hql, pageNo,pageSize);
			devTypeListInfo = (ArrayList<DeviceTypeInfo>)page.getResult();
			Map<String,String> idCodeMap = getIdCodeMap();
			for(DeviceTypeInfo dev:devTypeListInfo) {
				dev.setParDevCode(idCodeMap.get(dev.getPid()));
			}
			devTypeListForSearch = (ArrayList<DeviceTypeInfo>)this.commonService.find("from DeviceTypeInfo ");//父设备型号选择列表
			// 将查询请求记入到操作日志表中
			this.addDBOperationRpt(commonService, sqlCondition,"DeviceTypeInfo");
		} catch (Exception e) {
			e.printStackTrace();
			return "error";
		}
		return null;
	}
	/*
	 * ajax获取父设备型号
	 */
	public String ajaxForParDevCode(){
		
		String data="";
		List<DeviceBrandInfo> devBrandList=null;
		List<String> pardevList=null;
		//回传的品牌编码
		String brand=this.getRequest().getParameter("brand");
		try {	
			if(brand!=null&&!"".equals(brand)){
				//查询品牌
				devBrandList= (ArrayList<DeviceBrandInfo>)this.commonService.find("from DeviceBrandInfo where deviceRandCode=?",brand );
				//查询品牌对应的父设备
				if(devBrandList!=null&&devBrandList.size()>0)
					pardevList= (ArrayList<String>)this.commonService.executeSQL("select t.device_type_code from device_type_info t where t.device_rand_code=? and t.pid=0",devBrandList.get(0).getDeviceRandCode());//父设备型号选择列表			
			}else {
				pardevList= (ArrayList<String>)this.commonService.executeSQL("select t.device_type_code from device_type_info t where t.pid=0");//父设备型号选择列表
			}
			StringBuffer dataString=new StringBuffer();
			if(pardevList!=null&&pardevList.size()>0){
				for(int i=0;i<pardevList.size();i++){
					dataString.append(pardevList.get(i)+",");
				}
			}
			 data=(dataString.toString().lastIndexOf(",")==-1)?null:dataString.substring(0,dataString.toString().lastIndexOf(","));
			System.out.println(data);
			 this.getResponse().setCharacterEncoding("utf-8");
				PrintWriter printWriter = this.getResponse().getWriter();
				printWriter.write(data);
				printWriter.close();
				printWriter = null;
		} catch (Exception e) {
			e.printStackTrace();
			return "error";
		}
		return null;
	}
	private Map<String,String> getIdCodeMap() {
		Map<String,String> idCodeMap = new HashMap<String,String>();
		List<DeviceTypeInfo> devTypeTmpList;
		try
		{
			devTypeTmpList = (ArrayList<DeviceTypeInfo>)this.commonService.find("from DeviceTypeInfo ");
			for(DeviceTypeInfo devTmp:devTypeTmpList) {
				idCodeMap.put(devTmp.getId()+"", devTmp.getDeviceTypeCode());
			}
		} catch (Exception e)
		{
			e.printStackTrace();
		}//父设备型号选择列表
		return idCodeMap;
	}
	
	
	//进入新增品牌型号页面
	public String toAddDevType() {
		try
		{
			devBrandListInfo = (ArrayList<DeviceBrandInfo>)this.commonService.find("from DeviceBrandInfo");
			devTypeListInfo = (ArrayList<DeviceTypeInfo>)this.commonService.find("from DeviceTypeInfo");
			metadataList = (ArrayList<String>)this.commonService.find("select distinct tableName from Metadata order by tableName");
			fieldList = (ArrayList<Metadata>)this.commonService.find("select distinct tableName,filedName from Metadata");
		} catch (Exception e)
		{
			e.printStackTrace();
		}
		return null;
	}
	
	//进入新增槽位设备页面
	public String toAddPosDevType() {
		try
		{
			devBrandListInfo = (ArrayList<DeviceBrandInfo>)this.commonService.find("from DeviceBrandInfo");
			devTypeListInfo = (ArrayList<DeviceTypeInfo>)this.commonService.find("from DeviceTypeInfo");
			metadataList = (ArrayList<String>)this.commonService.find("select distinct tableName from Metadata order by tableName");
			fieldList = (ArrayList<Metadata>)this.commonService.find("select distinct tableName,filedName from Metadata");
			if (StringUtils.isNotBlank(posParDevId)) {
				List<DeviceTypeInfo> list = this.commonService.find("from DeviceTypeInfo where id='" + posParDevId.trim()+"'");
				if(list!=null && list.size()>0) {
					devType = list.get(0);
				}
			}
			
		} catch (Exception e)
		{
			e.printStackTrace();
		}
		return null;
	}
	
	/**
	 * 进入选择板卡弹出层页面
	 */
	public void selectBanKa(){
		try {
				//查询板卡的信息
		//?	 	devTypeForBankaList = (ArrayList<DeviceTypeInfo>)this.commonService.find("from DeviceTypeInfo where deviceTypeCode in (select subDeviceTypeCode from DeviceBrandType where parDeviceTypeCode='"+posParDevId+"')");
				deviceBrandTypeList = (ArrayList<DeviceBrandType>)this.commonService.find("from DeviceBrandType where parDeviceTypeCode='"+posParDevId+"'");
				//当前子设备的板卡信息
			//	String bcname = this.getRequest().getParameter("bcname");
			//	List<DeviceBoardsoltBoard> dbblist = new ArrayList<DeviceBoardsoltBoard>();
			//	dbblist = commonService.findByProperty(DeviceBoardsoltBoard.class, "deviceBoardSoltCode", bcname);
			//	this.getRequest().setAttribute("dbblist", dbblist);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * 配置设备位置:
	 * 	1.根据父设备id，查询父设备底图、父设备的所有子设备，以便设置子设备的位置
	 */
	public void toConfDevPos()
	{
		if (StringUtils.isNotBlank(posParDevId))
		{
			try
			{
				// 步骤一：查询对应设备型号的底图，无则返回并提示
				String searchDeviceSql = " from DeviceTypeInfo  where id=" + posParDevId.trim();				
				logger.info("操作记录：查询设备底图sql=" + searchDeviceSql);
				List<DeviceTypeInfo> deviceInfoList = commonService.find(searchDeviceSql);
				if (deviceInfoList != null && deviceInfoList.size() > 0)
				{
					devType = deviceInfoList.get(0);
				} else
				{
					outHtmlString("<script type=\"text/javascript\">alert('无对应设备！');this.location='deviceBrandManage.do?action=queryDeviceTypeInfo'</script>");
				}
				
				Long devHeight = devType.getFigureHeight()== null ? 0 : devType.getFigureHeight();
				devScrollHeight = (devHeight + 1500)+"";
				
				// 步骤二：查询对应设备的子设备，用于配置位置
				String searchDevTypeForPosSql = " from DeviceTypeInfo  where  pid = " + posParDevId.trim()+ " order by isLeaf asc,isPositionDev asc,showIndex asc";	
				
				logger.info("操作记录：查询设备的子设备（用于配置设备位置）sql=" + searchDevTypeForPosSql);
				devTypeForPosList = commonService.find(searchDevTypeForPosSql);	
		//		devTypeForBankaList = (ArrayList<DeviceTypeInfo>)this.commonService.find("from DeviceTypeInfo where deviceTypeCode in (select subDeviceTypeCode from DeviceBrandType where parDeviceTypeCode='"+devType.getDeviceTypeCode()+"')");//查询板卡的信息
				System.out.println("devchangdu:"+devTypeForBankaList.size());
			} catch (Exception e)
			{
				logger.error("Get child device exception（ Parent device id=" + posParDevId + "）", e);
			}
		}
	}
	public String ajaxGetBanKa(){
		try {
			List<String> list = new ArrayList<String>();
			String bcname = this.getRequest().getParameter("bcname");
			String deviceTypeCode = this.getRequest().getParameter("deviceTypeCode");
			List<DeviceBoardsoltBoard> dbblist = new ArrayList<DeviceBoardsoltBoard>();
			String hql ="from DeviceBoardsoltBoard where deviceTypeCode = ? and deviceBoardSoltCode = ?";
			dbblist =commonService.find(hql,deviceTypeCode,bcname);
			for(DeviceBoardsoltBoard dbb:dbblist){
				list.add(dbb.getDeviceBoardCode());
			}
			JSONArray array = JSONArray.fromObject(list);
			HttpServletResponse response = this.getResponse();
			response.setCharacterEncoding("utf-8");
			PrintWriter out = response.getWriter();
			out.write(array.toString());
			out.flush();
			out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		/*try {
			DeviceBoardsoltBoard dbb=new DeviceBoardsoltBoard();
			if (commonService.findByProperty(DeviceBoardsoltBoard.class, "deviceBoardSoltCode", bcname).size()>=1) {
				dbb=(DeviceBoardsoltBoard)commonService.findByProperty(DeviceBoardsoltBoard.class, "deviceBoardSoltCode", bcname).get(0);
			}else {
				dbb.setDeviceBoardCode("");
			}
			
			HttpServletResponse response = this.getResponse();
			response.setCharacterEncoding("utf-8");
			PrintWriter out = response.getWriter();
			out.write(dbb.getDeviceBoardCode());
			out.flush();
			out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}*/
		
		return null;
	}
	
	public String ajaxGetBanCao(){
		String bkname = this.getRequest().getParameter("bkname");
		try {
			DeviceBoardsoltBoard dbb=new DeviceBoardsoltBoard();
			if (commonService.findByProperty(DeviceBoardsoltBoard.class, "deviceBoardCode", bkname).size()>=1) {
				dbb=(DeviceBoardsoltBoard)commonService.findByProperty(DeviceBoardsoltBoard.class, "deviceBoardCode", bkname).get(0);
			}else {
				dbb.setDeviceBoardSoltCode("");
			}
			
			HttpServletResponse response = this.getResponse();
			response.setCharacterEncoding("utf-8");
			PrintWriter out = response.getWriter();
			out.write(dbb.getDeviceBoardSoltCode());
			out.flush();
			out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return null;
	}
	//配置设备的位置 
	public void configDevicePos(){
		try {
			commonService.beginTransaction();
			if(devTypeForPosList!=null && devTypeForPosList.size()>0){
				List<DeviceTypeInfo> updateBatchDevList = new ArrayList<DeviceTypeInfo>();  //更新板槽位置信息
				List<DeviceBoardsoltBoard> updateDBBList = new ArrayList<DeviceBoardsoltBoard>();
				JSONObject jsonObj = JSONObject.fromObject(jsonStr); //jsonStr中保存操作过的子设备-板卡的map集合
				Map<String, List<String>> map = (Map<String, List<String>>)jsonObj;
				
				for(DeviceTypeInfo devTypeTmp:devTypeForPosList) {
					if(devTypeTmp!=null && devTypeTmp.getId()!=null) {
						DeviceTypeInfo oldDevType = (DeviceTypeInfo)this.commonService.get(DeviceTypeInfo.class, devTypeTmp.getId());
						oldDevType.setFigureX(devTypeTmp.getFigureX());
						oldDevType.setFigureY(devTypeTmp.getFigureY());
						oldDevType.setFigureWidth(devTypeTmp.getFigureWidth());
						oldDevType.setFigureHeight(devTypeTmp.getFigureHeight());
						oldDevType.setHasInstance(0l);
						
						updateBatchDevList.add(oldDevType);
						
						List<String> list = map.get(devTypeTmp.getDeviceTypeCode());
						if(list!=null){
							//删除当前板槽下的所有板卡
							List<DeviceBoardsoltBoard> deleList=this.commonService.find("from DeviceBoardsoltBoard where deviceBoardSoltCode = '"+devTypeTmp.getDeviceTypeCode()+"' and deviceTypeCode = '"+posParDevId+"'");
							if(deleList.size()>0){
								for (int i = 0; i < deleList.size(); i++) {
									this.commonService.delete("delete from DeviceBoardsoltBoard where id = "+deleList.get(i).getId());
								}
							}
							//添加新板卡
							for(String str : list){
								DeviceBoardsoltBoard dbb=new DeviceBoardsoltBoard();
								dbb.setDeviceBrandCode(oldDevType.getDeviceRandCode()); //品牌
								dbb.setDeviceBoardSoltCode(devTypeTmp.getDeviceTypeCode());//槽位code
								dbb.setDeviceBoardCode(str);   //板卡code
								dbb.setDeviceTypeCode(posParDevId); //设备型号
								updateDBBList.add(dbb);
							}
						}
					}
				}
				this.commonService.saveOrUpdate(updateBatchDevList);
				this.commonService.saveOrUpdate(updateDBBList);
				// 将添加操作写到操作日志中
				this.addDBOperationRpt(commonService, "DeviceTypeInfo", "UPDATE",null);
			}
			outHtmlString("<script type=\"text/javascript\">alert('i18n_DeviceBrandManageAction.importXls.success_n81i');this.location='deviceBrandManage.do?action=queryDeviceTypeInfo'</script>");
			commonService.commit();
		}catch(Exception e){
			commonService.rollback();
	    	 e.printStackTrace();
	    	 outHtmlString("<script type=\"text/javascript\">alert('i18n_DeviceBrandManageAction.importXls.faild_n81i');this.location='deviceBrandManage.do?action=queryDeviceTypeInfo'</script>");
	     }
	}
	public void configDevicePos2()
	{
		System.out.println("right here!");
		//System.out.println("banka bancao关系:"+pzbkbc+"size:"+devTypeForPosList.size());
		try {
			commonService.beginTransaction();
			if(devTypeForPosList!=null && devTypeForPosList.size()>0){
//				String[] strGroup = new String[0];
				List<DeviceTypeInfo> updateBatchDevList = new ArrayList<DeviceTypeInfo>();  //更新板卡位置信息
				List<DeviceBoardsoltBoard> updateDBBList = new ArrayList<DeviceBoardsoltBoard>();
				for(DeviceTypeInfo devTypeTmp:devTypeForPosList) {
					if(devTypeTmp!=null && devTypeTmp.getId()!=null) {
						DeviceTypeInfo oldDevType = (DeviceTypeInfo)this.commonService.get(DeviceTypeInfo.class, devTypeTmp.getId());
						oldDevType.setFigureX(devTypeTmp.getFigureX());
						oldDevType.setFigureY(devTypeTmp.getFigureY());
						oldDevType.setFigureWidth(devTypeTmp.getFigureWidth());
						oldDevType.setFigureHeight(devTypeTmp.getFigureHeight());
						oldDevType.setHasInstance(0l);
						
						updateBatchDevList.add(oldDevType);
						
//						ArrayUtils.add(strGroup, devTypeTmp.getId()+"");
//						this.commonService.saveOrUpdate(oldDevType);
						//把板卡板槽关系插入中间表
						//System.out.println("pinpainame:"+oldDevType.getDeviceRandCode());
						System.out.println("pzbkbc.length:"+pzbkbc.length()+", content:"+pzbkbc);
						if (pzbkbc!=null&&pzbkbc.length()!=0) {
							if (pzbkbc.lastIndexOf(devTypeTmp.getDeviceTypeCode())!=-1) {
							int a = pzbkbc.lastIndexOf(devTypeTmp.getDeviceTypeCode())+devTypeTmp.getDeviceTypeCode().length();//冒号位置
							int b = pzbkbc.indexOf(";",a);//分号位置
							String bankaname=pzbkbc.substring(a+1,b);
							if (!"undefined".equals(bankaname)&&!"".equals(bankaname)) {
							DeviceBoardsoltBoard deviceBoardsoltBoard=new DeviceBoardsoltBoard();
							DeviceBoardsoltBoard olddbb=new DeviceBoardsoltBoard();
							//System.out.println("***********/*/*/*////*/:"+posParDevId+"bankaname:"+bankaname);
							List<DeviceBoardsoltBoard> deleList=this.commonService.find("from DeviceBoardsoltBoard where deviceBoardSoltCode = '"+devTypeTmp.getDeviceTypeCode()+"' and deviceTypeCode = '"+bankaname+"'");
							int ih=deleList.size();
							//System.out.println("changdu:"+ih);
							if (ih!=0) {
								for (int i = 0; i < deleList.size(); i++) {
									this.commonService.delete("delete from DeviceBoardsoltBoard where id = "+deleList.get(i).getId());
								}
								
							}
							//System.out.println("***********/*/*/*////*/:"+posParDevId+"bankaname:"+bankaname);
							deviceBoardsoltBoard.setDeviceTypeCode(posParDevId);
							deviceBoardsoltBoard.setDeviceBoardSoltCode(devTypeTmp.getDeviceTypeCode());
							deviceBoardsoltBoard.setDeviceBrandCode(oldDevType.getDeviceRandCode());
							deviceBoardsoltBoard.setDeviceBoardCode(bankaname);
							//System.out.println("板卡名称:"+bankaname+",主机架名称："+zjjname);
							if (deviceBoardsoltBoard.getDeviceBoardCode()==null||"".equals(deviceBoardsoltBoard.getDeviceBoardCode())) {
								
							}else {
								updateDBBList.add(deviceBoardsoltBoard);
							}
							}
							}
							
						}
						
					}
				}
				this.commonService.saveOrUpdate(updateBatchDevList);
				this.commonService.saveOrUpdate(updateDBBList);
//				StringUtil.linkToString(strGroup, ",", "");
				// 将添加操作写到操作日志中
				this.addDBOperationRpt(commonService, "DeviceTypeInfo", "UPDATE",null);
			}
			outHtmlString("<script type=\"text/javascript\">alert('i18n_DeviceBrandManageAction.importXls.success_n81i');this.location='deviceBrandManage.do?action=queryDeviceTypeInfo'</script>");
			commonService.commit();
		} catch (Exception e) {
			commonService.rollback();
			e.printStackTrace();
			outHtmlString("<script type=\"text/javascript\">alert('i18n_DeviceBrandManageAction.importXls.faild_n81i');this.location='deviceBrandManage.do?action=queryDeviceTypeInfo'</script>");
		}
	}
	
	
	public void addDevType() {
		try {
			commonService.beginTransaction();
			if(devType!=null && StringUtils.isNotBlank(devType.getDeviceTypeCode())){
				//设备型号不能重复:不同品牌可以重复吗？
				List list = this.commonService.find("from DeviceTypeInfo where deviceTypeCode='"+devType.getDeviceTypeCode().trim()+"' and deviceRandCode='"+devType.getDeviceRandCode()+"'");
				if(list!=null && list.size()>0) {
					//已经使用json进行过判断，此处不需要判断了
//					outHtmlString("<script type=\"text/javascript\">alert('设备型号已存在');window.history.go(-1);</script>");
				}else {
					Date date = new Date();
					devType.setAddTime(date);
					devType.setAddUserid(this.getUserID());
					devType.setLastUpdateTime(date);
					devType.setLastUpdateUserid(this.getUserID());
					
					devType.setDeviceTypeCode(devType.getDeviceTypeCode().trim());
					devType.setDeviceRandCode(devType.getDeviceRandCode().trim());
					devType.setDeviceDesc(devType.getDeviceDesc().trim());
					//showIdex：用户输入，pid：界面选择
					if(devType.getShowIndex()==null) {//一级设备，默认的shouIndex=1
						devType.setShowIndex(1l);
					}
					//x，y，width，height:空着
					devType.setFigureType("image");
					devType.setFigureStroke("red");
					devType.setFigureStrokeWidth(1l);
					//上传设备图片文件
					if(figureFill!=null && StringUtils.isNotBlank(figureFillFileName)) {
						String path = this.getServletContext().getRealPath(uploadSvgPath);//上传路径
						String fileReName = uploadFile(figureFill,path,figureFillFileName);//上传到upload目录
						
						String svgPathTmp = this.getServletContext().getRealPath(svgPath);//上传路径svg
						String modelPathTmp = this.getServletContext().getRealPath(modelPath);//上传路径model
						uploadFile(figureFill,svgPathTmp,figureFillFileName);//上传到svg目录
						uploadFile(figureFill,modelPathTmp,figureFillFileName);//上传到model目录
						
						devType.setFigureFill(figureFillFileName);
						
						BufferedImage buff = ImageIO.read(new File(path + "/" + figureFillFileName));
						devType.setFigureWidth(Long.parseLong(buff.getWidth()+""));
						devType.setFigureHeight(Long.parseLong(buff.getHeight()+""));
						
					}
					if(StringUtils.isBlank(devType.getNameFormat())) {
						devType.setNameFormat(devType.getDeviceTypeCode());
					}else {
						devType.setNameFormat(devType.getNameFormat().trim());
					}
					devType.setStatusValue(devType.getStatusValue()!=null?devType.getStatusValue().trim():"");
					
					//showLevel,isLink,isLeaf
					Long isLeaf = devType.getIsPositionDev()==null?0l:devType.getIsPositionDev();//1:位置设备，0：非位置设备
					System.out.println("isleaf:"+isLeaf);
					devType.setIsLeaf(1l);
					String tabName = devType.getDiTableName();
					if(StringUtils.isNotBlank(tabName)&&Constants.DI_SWITCHPORT_TABLE_NAME.equalsIgnoreCase(tabName)) {
						devType.setIsLink(1l);						
					}else {
						devType.setIsLink(0l);		
					}
					//新增机框、板卡时使用：如果父设备为空
					String pid = devType.getPid();
					String canConfigPid = devType.getCanConfigPid();
					if(StringUtils.isNotBlank(pid)) {//端口、电源、风扇
						//父设备修改为非叶子节点
						DeviceTypeInfo devTypeTmp = (DeviceTypeInfo)this.commonService.get(DeviceTypeInfo.class, Long.parseLong(pid));
						if(devTypeTmp.getIsLeaf()==1l){
							devTypeTmp.setIsLeaf(0l);
							this.commonService.update(devTypeTmp);							
						}
						
						//中间表：板卡可配置的父设备（机框）、设备level
						if(devTypeTmp!=null && devTypeTmp.getShowLevel()!=null) {
							devType.setShowLevel(devTypeTmp.getShowLevel()+1);								
//							//中间表
//							DeviceBrandType devBrandType = new DeviceBrandType();
//							devBrandType.setSubDeviceTypeCode(devType.getDeviceTypeCode());
//							devBrandType.setParDeviceTypeCode(devTypeTmp.getDeviceTypeCode());
//							devBrandType.setDeviceBrandCode(devType.getDeviceRandCode());
//							this.commonService.save(devBrandType);
						}
					}else if(StringUtils.isNotBlank(canConfigPid)){//可以配置的设备：板卡
						DeviceTypeInfo devTypeTmp = (DeviceTypeInfo)this.commonService.get(DeviceTypeInfo.class, Long.parseLong(canConfigPid));
						
						devType.setPid("0");
						if(devTypeTmp!=null && devTypeTmp.getShowLevel()!=null) {
							devType.setShowLevel(devTypeTmp.getShowLevel()+1);		
						}else {
							devType.setShowLevel(2l);
						}
						
							devType.setIsLeaf(0l);
						
						//中间表
						DeviceBrandType devBrandType = new DeviceBrandType();
						devBrandType.setSubDeviceTypeCode(devType.getDeviceTypeCode());
						devBrandType.setParDeviceTypeCode(devTypeTmp.getDeviceTypeCode());
						devBrandType.setDeviceBrandCode(devType.getDeviceRandCode());
						this.commonService.save(devBrandType);
					}else {//机框
						devType.setPid("0");
						devType.setShowLevel(1l);						
					}
					devType.setHasInstance(0l);
					
					
					//devType.setFigureX(10l);
					//devType.setFigureY(10l);
					//devType.setFigureWidth(35l);
					//devType.setFigureHeight(382l);
					devType.setFigureX(devShowX);
					devType.setFigureY(devShowY);
					
					this.commonService.save(devType);
					
					
					// 将添加操作写到操作日志中
					this.addDBOperationRpt(commonService, "DeviceTypeInfo", "INSERT",devType.getId());
					outHtmlString("<script type=\"text/javascript\">alert('i18n_DeviceBrandManageAction.importXls.success_n81i');this.location='deviceBrandManage.do?action=queryDeviceTypeInfo&devTypeCodeForSearch="+devTypeCodeForSearch+"&devRandCodeForSearch="+devRandCodeForSearch+"&parDevId="+parDevId+"'</script>");
				}
			}else {
				outHtmlString("<script type=\"text/javascript\">alert('i18n_DeviceBrandManageAction.toConfDevPos.deviceBrandIsNotNull_n81i');window.history.go(-1);</script>");
			}
			commonService.commit();
		} catch (Exception e) {
			commonService.rollback();
			e.printStackTrace();
			outHtmlString("<script type=\"text/javascript\">alert('i18n_DeviceBrandManageAction.importXls.faild_n81i');this.location='deviceBrandManage.do?action=queryDeviceTypeInfo'</script>");
		}
	}
	
	public static void main(String[] args) {
		BufferedImage buff;
		try
		{
			buff = ImageIO.read(new File("D:/Tomcat/apache-tomcat-6.0.18/webapps/nmsweb/images/svg/upload/RS-89-S2-48-GE-RJ.png"));
			System.out.println(buff.getWidth());
			System.out.println(buff.getHeight());
		} catch (IOException e)
		{
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	private List <DeviceTypeInfo> getExampleData(String hql)throws Exception{
		List <DeviceTypeInfo>dataList=null;
			page = this.commonService.findByPage(hql, 1,3);
			dataList=(ArrayList<DeviceTypeInfo>)page.getResult();
		
		return dataList;
	}
	// 模板下载   wx 2014-11-13
	public String downloadExampleType1() {
		try {
			List titleList=new ArrayList();
			titleList.add(new String[]{getI18nText("i18n_DeviceBrandManageAction.importXls.brandID_n81i"),
										getI18nText("i18n_DeviceBrandManageAction.importXls.brandName_n81i"),
										getI18nText("i18n_DeviceBrandManageAction.importXls.brandDesc_n81i")});//品牌sheet标题
			//主机架sheet
			titleList.add(new String[]{getI18nText("i18n_DeviceBrandManageAction.downloadExampleType1.title1.mainFrameModel_n81i"),
										getI18nText("i18n_DeviceBrandManageAction.downloadExampleType1.title1.brand_n81i"),
										getI18nText("i18n_DeviceBrandManageAction.downloadExampleType1.title1.deviceDesc_n81i"),
										getI18nText("i18n_DeviceBrandManageAction.downloadExampleType1.title1.positionNum_n81i"),
										getI18nText("i18n_DeviceBrandManageAction.downloadExampleType1.title1.picType_n81i"),
										getI18nText("i18n_DeviceBrandManageAction.downloadExampleType1.title1.X_n81i"),
										getI18nText("i18n_DeviceBrandManageAction.downloadExampleType1.title1.Y_n81i"),
										getI18nText("i18n_DeviceBrandManageAction.downloadExampleType1.title1.width_n81i"),
										getI18nText("i18n_DeviceBrandManageAction.downloadExampleType1.title1.high_n81i"),
										getI18nText("i18n_DeviceBrandManageAction.downloadExampleType1.title1.lineColor_n81i"),
										getI18nText("i18n_DeviceBrandManageAction.downloadExampleType1.title1.lineWidth_n81i"),
										getI18nText("i18n_DeviceBrandManageAction.downloadExampleType1.title1.picName_n81i"),
										getI18nText("i18n_DeviceBrandManageAction.downloadExampleType1.title1.nameFormat_n81i"),
										getI18nText("i18n_DeviceBrandManageAction.downloadExampleType1.title1.monitorTypeTab_n81i"),
										getI18nText("i18n_DeviceBrandManageAction.downloadExampleType1.title1.picLevel_n81i"),
										getI18nText("i18n_DeviceBrandManageAction.downloadExampleType1.title1_n81i")});//主机架sheet标题
			String [] colu1 = { "deviceTypeCode","deviceRandCode","deviceDesc","showIndex","figureType","figureX","figureY","figureWidth","figureHeight",
					"figureStroke","figureStrokeWidth","figureFill","nameFormat","diTableName","showLevel","maxDeviceNum"};
			//板槽sheet
			titleList.add(new String[]{getI18nText("i18n_DeviceBrandManageAction.downloadExampleType1.title2.boardSlot_n81i"),
										getI18nText("i18n_DeviceBrandManageAction.downloadExampleType1.title2.brand_n81i"),
										getI18nText("i18n_DeviceBrandManageAction.downloadExampleType1.title2.deviceDesc_n81i"),
										getI18nText("i18n_DeviceBrandManageAction.downloadExampleType1.title2.positionNum_n81i"),
										getI18nText("i18n_DeviceBrandManageAction.downloadExampleType1.title2.parentDevice_n81i"),
										getI18nText("i18n_DeviceBrandManageAction.downloadExampleType1.title2.picType_n81i"),
										getI18nText("i18n_DeviceBrandManageAction.downloadExampleType1.title2.X_n81i"),
										getI18nText("i18n_DeviceBrandManageAction.downloadExampleType1.title2.Y_n81i"),
										getI18nText("i18n_DeviceBrandManageAction.downloadExampleType1.title2.width_n81i"),
										getI18nText("i18n_DeviceBrandManageAction.downloadExampleType1.title2.high_n81i"),
										getI18nText("i18n_DeviceBrandManageAction.downloadExampleType1.title2.lineColor_n81i"),
										getI18nText("i18n_DeviceBrandManageAction.downloadExampleType1.title2.lineWidth_n81i"),
										getI18nText("i18n_DeviceBrandManageAction.downloadExampleType1.title2.picName_n81i"),
										getI18nText("i18n_DeviceBrandManageAction.downloadExampleType1.title2.nameFormat_n81i"),
										getI18nText("i18n_DeviceBrandManageAction.downloadExampleType1.title2.picLevel_n81i"),
										getI18nText("i18n_DeviceBrandManageAction.downloadExampleType1.title2.isLeaf_n81i")});
			String [] colu1_1 = { "deviceTypeCode","deviceRandCode","deviceDesc","showIndex" ,"parDevCode","figureType","figureX","figureY","figureWidth","figureHeight",
					"figureStroke","figureStrokeWidth","figureFill","nameFormat","showLevel","isLeaf"};
			//板卡sheet
			titleList.add(new String[]{getI18nText("i18n_DeviceBrandManageAction.downloadExampleType1.title3.bordModel_n81i"),
										getI18nText("i18n_DeviceBrandManageAction.downloadExampleType1.title3.brand_n81i"),
										getI18nText("i18n_DeviceBrandManageAction.downloadExampleType1.title3.brand_n81i"),
										getI18nText("i18n_DeviceBrandManageAction.downloadExampleType1.title3.picType_n81i"),
										getI18nText("i18n_DeviceBrandManageAction.downloadExampleType1.title3.X_n81i"),
										getI18nText("i18n_DeviceBrandManageAction.downloadExampleType1.title3.Y_n81i"),
										getI18nText("i18n_DeviceBrandManageAction.downloadExampleType1.title3.width_n81i"),
										getI18nText("i18n_DeviceBrandManageAction.downloadExampleType1.title3.high_n81i"),
										getI18nText("i18n_DeviceBrandManageAction.downloadExampleType1.title3.lineColor_n81i"),
										getI18nText("i18n_DeviceBrandManageAction.downloadExampleType1.title3.lineWidth_n81i"),
										getI18nText("i18n_DeviceBrandManageAction.downloadExampleType1.title3.picName_n81i"),
										getI18nText("i18n_DeviceBrandManageAction.downloadExampleType1.title3.picLevel_n81i"),
										getI18nText("i18n_DeviceBrandManageAction.downloadExampleType1.title3.isLeaf_n81i")});
			String [] colu1_2 = { "deviceTypeCode","deviceRandCode","deviceDesc","figureType","figureX","figureY","figureWidth","figureHeight",
					"figureStroke","figureStrokeWidth","figureFill","showLevel","isLeaf"};
			//端口sheet
			titleList.add(new String[]{getI18nText("i18n_DeviceBrandManageAction.downloadExampleType1.title4.portModel_n81i"),
										getI18nText("i18n_DeviceBrandManageAction.downloadExampleType1.title4.brand_n81i"),
										getI18nText("i18n_DeviceBrandManageAction.downloadExampleType1.title4.deviceDesc_n81i"),
										getI18nText("i18n_DeviceBrandManageAction.downloadExampleType1.title4.positionNum_n81i"),
										getI18nText("i18n_DeviceBrandManageAction.downloadExampleType1.title4.parentDevice_n81i"),
										getI18nText("i18n_DeviceBrandManageAction.downloadExampleType1.title4.picType_n81i"),
										getI18nText("i18n_DeviceBrandManageAction.downloadExampleType1.title4.X_n81i"),
										getI18nText("i18n_DeviceBrandManageAction.downloadExampleType1.title4.Y_n81i"),
										getI18nText("i18n_DeviceBrandManageAction.downloadExampleType1.title4.width_n81i"),
										getI18nText("i18n_DeviceBrandManageAction.downloadExampleType1.title4.high_n81i"),
										getI18nText("i18n_DeviceBrandManageAction.downloadExampleType1.title4.lineColor_n81i"),
										getI18nText("i18n_DeviceBrandManageAction.downloadExampleType1.title4.lineWidth_n81i"),
										getI18nText("i18n_DeviceBrandManageAction.downloadExampleType1.title4.picName_n81i"),
										getI18nText("i18n_DeviceBrandManageAction.downloadExampleType1.title4.nameFormat_n81i"),
										getI18nText("i18n_DeviceBrandManageAction.downloadExampleType1.title4.monitorTypeTab_n81i"),
										getI18nText("i18n_DeviceBrandManageAction.downloadExampleType1.title4.linkField_n81i"),
										getI18nText("i18n_DeviceBrandManageAction.downloadExampleType1.title4.stateField_n81i"),
										getI18nText("i18n_DeviceBrandManageAction.downloadExampleType1.title4.charactor_n81i"),
										getI18nText("i18n_DeviceBrandManageAction.downloadExampleType1.title4.value_n81i"),
										getI18nText("i18n_DeviceBrandManageAction.downloadExampleType1.title4.picLevel_n81i"),
										getI18nText("i18n_DeviceBrandManageAction.downloadExampleType1.title4.isLink_n81i"),
										getI18nText("i18n_DeviceBrandManageAction.downloadExampleType1.title4.isLeaf_n81i"),
										getI18nText("i18n_DeviceBrandManageAction.downloadExampleType1.title4.maxNum_n81i")});//主机架sheet标题
			String [] colu1_3 = { "deviceTypeCode","deviceRandCode","deviceDesc","showIndex" ,"parDevCode","figureType","figureX","figureY","figureWidth","figureHeight",
					"figureStroke","figureStrokeWidth","figureFill","nameFormat","diTableName","indexFiled",
					"statusFiled","statusSymbols","statusValue","showLevel","isLink","isLeaf","maxDeviceNum"};
			titleList.add(new String[]{getI18nText("i18n_DeviceBrandManageAction.downloadExampleType1.title5.deviceBrandCode_n81i"),
										getI18nText("i18n_DeviceBrandManageAction.downloadExampleType1.title5.mainFrame_n81i"),
										getI18nText("i18n_DeviceBrandManageAction.downloadExampleType1.title5.bordModel_n81i")});
			titleList.add(new String[]{getI18nText("i18n_DeviceBrandManageAction.downloadExampleType1.title6.deviceBrandCode_n81i"),
										getI18nText("i18n_DeviceBrandManageAction.downloadExampleType1.title6.bordSlot_n81i"),
										getI18nText("i18n_DeviceBrandManageAction.downloadExampleType1.title6.bordModel_n81i"),
										getI18nText("i18n_DeviceBrandManageAction.downloadExampleType1.title6.mainFrame_n81i")});
			String[] sheetNames={getI18nText("i18n_DeviceBrandManageAction.downloadExampleType1.sheetNames.brand_n81i"),
								getI18nText("i18n_DeviceBrandManageAction.downloadExampleType1.sheetNames.mainFrame_n81i"),
								getI18nText("i18n_DeviceBrandManageAction.downloadExampleType1.sheetNames.bordSlot_n81i"),
								getI18nText("i18n_DeviceBrandManageAction.downloadExampleType1.sheetNames.bord_n81i"),
								getI18nText("i18n_DeviceBrandManageAction.downloadExampleType1.sheetNames.port_n81i"),
								getI18nText("i18n_DeviceBrandManageAction.downloadExampleType1.sheetNames.bordMainRelation_n81i"),
								getI18nText("i18n_DeviceBrandManageAction.downloadExampleType1.sheetNames.bordSlotRelation_n81i")};
			/*
			 * 向模板中添加示例数据
			 */
			List dataList =new ArrayList<List<Object>>();
			List<Object[]> coluList=new ArrayList<Object[]>();
			List parDeviceList=new ArrayList<List<String>>();//父设备型号列表
			/*
			 * 品牌数据
			 */
			String hql = "from DeviceBrandInfo ";
			hql += "order by lastUpdateTime desc";
			page = this.commonService.findByPage(hql, 1,3);
			List<DeviceBrandInfo> devBrandListInfo = (ArrayList<DeviceBrandInfo>)page.getResult();	
			if(devBrandListInfo!=null&&devBrandListInfo.size()>0){
				dataList.add(devBrandListInfo);//添加品牌数据
			}else{
				dataList.add(new ArrayList(0));
			}
		
			String[] colu = { "deviceRandCode", "deviceRandName","deviceBrandDesc" };
			coluList.add(colu);
			/*
			 * 主机架
			 */
			List<String> soltList=new ArrayList<String>();
			hql="from DeviceTypeInfo where pid=0 and diTableName='DI_SYSTEM' and showLevel=1";
			hql += "order by lastUpdateTime desc";
			page = this.commonService.findByPage(hql, 1,5);
			List <DeviceTypeInfo> deviceTypeInfoList=(ArrayList<DeviceTypeInfo>)page.getResult();
			if(deviceTypeInfoList!=null&&deviceTypeInfoList.size()>0){
				for(DeviceTypeInfo d:deviceTypeInfoList){
					soltList.add(d.getId().toString());
				}
				for(DeviceTypeInfo d:deviceTypeInfoList){
					d.setParDevCode("");
				}
				dataList.add(deviceTypeInfoList);
			}else{
				dataList.add(new ArrayList(0));
			}
			coluList.add(colu1);
			/*
			 * 板槽
			 */
			if(soltList.size()>0){
				System.out.println("板槽示例数据：");
				hql="from DeviceTypeInfo where pid in(";
				for(String s:soltList){
					hql+="'"+s+"',";
				}
				hql=hql.substring(0,hql.lastIndexOf(","));
				hql += ") order by lastUpdateTime asc";
				page = this.commonService.findByPage(hql, 1,3);
				deviceTypeInfoList=(ArrayList<DeviceTypeInfo>)page.getResult();
				if(deviceTypeInfoList!=null&&deviceTypeInfoList.size()>0){
					for(DeviceTypeInfo d:deviceTypeInfoList){
						List<String> temp=(ArrayList<String>)this.commonService.executeSQL("select t.device_type_code from device_type_info t where t.id=?", d.getPid());
						if(temp.size()==1){
							d.setParDevCode(temp.get(0));
						}else{
							d.setParDevCode("");
						}
						
					}
				dataList.add(deviceTypeInfoList);
				}else{
					dataList.add(new ArrayList(0));
				}
			}
			soltList=null;
			coluList.add(colu1_1);
			/*
			 * 板卡
			 */
			//DeviceTypeInfo device2=null;
			hql="from DeviceTypeInfo where pid=0 and showLevel=2";
			hql += "order by lastUpdateTime desc";
			page = this.commonService.findByPage(hql, 1,5);
			deviceTypeInfoList=(ArrayList<DeviceTypeInfo>)page.getResult();
			if(deviceTypeInfoList!=null&&deviceTypeInfoList.size()>0){
				//device2=deviceTypeInfoList.get(0);				
				for(DeviceTypeInfo d:deviceTypeInfoList){					
						d.setParDevCode("");				
				}
				dataList.add(deviceTypeInfoList);
			}else{
				dataList.add(new ArrayList(0));
			}
			coluList.add(colu1_2);
			/*
			 * 端口
			 */
				hql="from DeviceTypeInfo where showLevel=3 and isLink=1 and isLeaf=1";
				hql += " order by deviceRandCode,deviceTypeCode ";
				page = this.commonService.findByPage(hql, 1,3);
				deviceTypeInfoList=(ArrayList<DeviceTypeInfo>)page.getResult();
				System.out.println("端口集合大小"+deviceTypeInfoList.size());
				if(deviceTypeInfoList!=null&&deviceTypeInfoList.size()>0){				
					for(DeviceTypeInfo d:deviceTypeInfoList){
						List<String> temp=(ArrayList<String>)this.commonService.executeSQL("select t.device_type_code from device_type_info t where t.id=?", d.getPid());
						if(temp.size()==1){
							d.setParDevCode(temp.get(0));
						}else{
							d.setParDevCode("");
						}				
					}
					dataList.add(deviceTypeInfoList);
				}else{
					dataList.add(new ArrayList(0));
				}
			
			coluList.add(colu1_3);
			/*
			 * 板卡主机架关系
			 */
			List <DeviceBrandType> deviceBrandTypeList=null;
			hql="from DeviceBrandType ";
			page = this.commonService.findByPage(hql, 1,5);
			deviceBrandTypeList=(ArrayList<DeviceBrandType>)page.getResult();
			if(deviceBrandTypeList!=null&&deviceBrandTypeList.size()>0){
				dataList.add(deviceBrandTypeList);
			}else {
				dataList.add(new ArrayList(0));
			}
			String[] colu2={"deviceBrandCode","parDeviceTypeCode","subDeviceTypeCode"};
			coluList.add(colu2);
			/*
			 * 板槽板卡关系
			 */
			List <DeviceBoardsoltBoard> deviceBoardsoltBoardList=null;
			hql="from DeviceBoardsoltBoard ";
			page = this.commonService.findByPage(hql, 1,5);
			deviceBoardsoltBoardList=(ArrayList<DeviceBoardsoltBoard>)page.getResult();
			if(deviceBoardsoltBoardList!=null&&deviceBoardsoltBoardList.size()>0){
				dataList.add(deviceBoardsoltBoardList);
			}else {
				dataList.add(new ArrayList(0));
			}
			String[] colu3={"deviceBrandCode","deviceBoardSoltCode","deviceBoardCode","deviceTypeCode"};
			coluList.add(colu3);
			ExportUtils m = new ExportUtils();
			m.setAutoSizeColumn(true);
			m.exportExcel1(getI18nText("i18n_DeviceBrandManageAction.downloadExampleType1.brandRecord_n81i"), dataList,sheetNames, titleList ,coluList,"downloadExample");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	private int[] saveDevicesByExcel(String sheetFlag,Sheet sheet,String errorInfo,List headerList,List<List<String>> rowList){
		// 记录存储数据条数
		int count=0;
		// 记录读入excel数据条数
		int sum = (sheet.getLastRowNum());
		int[] flag=new int[2];
		if(sheetFlag.equals("mainframe")){//主机架
			if(sheet.getLastRowNum()>=1){
				for (short i = 1; i <= sheet.getLastRowNum(); i++) {
					String errorParDeviceTypeCodeString="";
					DeviceTypeInfo deviceTypeInfo = new DeviceTypeInfo();
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
					Cell cell_11 = row.getCell((short) 10);
					Cell cell_12 = row.getCell((short) 11);
					Cell cell_13 = row.getCell((short) 12);
					Cell cell_14 = row.getCell((short) 13);
					Cell cell_15 = row.getCell((short) 14);
					Cell cell_16 = row.getCell((short) 15);
					//Cell cell_17 = row.getCell((short) 16);
					//Cell cell_18 = row.getCell((short) 17);
					//Cell cell_19 = row.getCell((short) 18);
					//Cell cell_20 = row.getCell((short) 19);
					//Cell cell_21 = row.getCell((short) 20);
					//Cell cell_22 = row.getCell((short) 21);
					//Cell cell_23 = row.getCell((short) 22);
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
							&& (null == cell_16 || 3 == cell_16.getCellType())){
						sum--;
					}else {
						//设备型号
						if (null == cell_1) {
							errorInfo += i +1+ getI18nText("i18n_DeviceBrandManageAction.saveDevicesByExcel.errorInfo1.before_n81i")+sheetFlag+getI18nText("i18n_DeviceBrandManageAction.saveDevicesByExcel.errorInfo1.after_n81i");
						} else if (cell_1.getCellType() == Cell.CELL_TYPE_STRING) {
							if ("".equals(cell_1.getStringCellValue())) {
								errorInfo += i+1 + getI18nText("i18n_DeviceBrandManageAction.saveDevicesByExcel.errorInfo1.before_n81i")+sheetFlag+getI18nText("i18n_DeviceBrandManageAction.saveDevicesByExcel.errorInfo1.after_n81i");
							} else {
								deviceTypeInfo.setDeviceTypeCode(cell_1.getStringCellValue().trim());
							}
						}else if(cell_1.getCellType() == Cell.CELL_TYPE_NUMERIC){
							deviceTypeInfo.setDeviceTypeCode(String.valueOf((int) cell_1.getNumericCellValue()));
						} else {
							errorInfo += i+1 + getI18nText("i18n_DeviceBrandManageAction.saveDevicesByExcel.errorInfo2.before_n81i")+sheetFlag+getI18nText("i18n_DeviceBrandManageAction.saveDevicesByExcel.errorInfo2.after_n81i");
						}

						//所属品牌（必填，对应品牌编号）
						if (null == cell_2) {
							errorInfo += i+1 + getI18nText("i18n_DeviceBrandManageAction.saveDevicesByExcel.errorInfo3_n81i");
						} else if (cell_2.getCellType() == Cell.CELL_TYPE_STRING) {
							if ("".equals(cell_2.getStringCellValue())) {
								errorInfo += i +1+getI18nText("i18n_DeviceBrandManageAction.saveDevicesByExcel.errorInfo3_n81i");
							} else {
								deviceTypeInfo.setDeviceRandCode(cell_2.getStringCellValue().trim());
							}
						} else if(cell_2.getCellType() == Cell.CELL_TYPE_NUMERIC){
							deviceTypeInfo.setDeviceRandCode(String.valueOf((int) cell_2.getNumericCellValue()));
						} else{
							errorInfo += i+1 + getI18nText("i18n_DeviceBrandManageAction.saveDevicesByExcel.errorInfo4_n81i");
						}

						//设备描述
						if(null == cell_3 || cell_3.getCellType()==Cell.CELL_TYPE_BLANK){
						}else if(cell_3.getCellType() == Cell.CELL_TYPE_NUMERIC){
							deviceTypeInfo.setDeviceDesc(String.valueOf((int)cell_3.getNumericCellValue()));
						}else if (cell_3.getCellType() == Cell.CELL_TYPE_STRING) {
							deviceTypeInfo.setDeviceDesc(cell_3.getStringCellValue().trim());
						} else {
							errorInfo += i+1 + getI18nText("i18n_DeviceBrandManageAction.saveDevicesByExcel.errorInfo5_n81i");
						}
						
						//级别下位置序号
						if(null == cell_4||cell_4.getCellType()==Cell.CELL_TYPE_BLANK){
						}else if(cell_4.getCellType() == Cell.CELL_TYPE_NUMERIC){
							deviceTypeInfo.setShowIndex((long)cell_4.getNumericCellValue());
						}else {
							errorInfo += i+1 + getI18nText("i18n_DeviceBrandManageAction.saveDevicesByExcel.errorInfo6_n81i");
						}
						
						
						//图片类型figureType
						if (null == cell_5||cell_5.getCellType()==Cell.CELL_TYPE_BLANK) {
						} else if (cell_5.getCellType() == Cell.CELL_TYPE_STRING) {
							deviceTypeInfo.setFigureType(cell_5.getStringCellValue().trim());
						} else{
							errorInfo += i+1 + getI18nText("i18n_DeviceBrandManageAction.saveDevicesByExcel.errorInfo7_n81i");
						}
						
						//X坐标figureX
						if (null == cell_6||cell_6.getCellType()==Cell.CELL_TYPE_BLANK) {
						} else if (cell_6.getCellType() == Cell.CELL_TYPE_NUMERIC) {
							deviceTypeInfo.setFigureX((long) cell_6.getNumericCellValue());
						} else{
							errorInfo += i+1 + getI18nText("i18n_DeviceBrandManageAction.saveDevicesByExcel.errorInfo8_n81i");
						}
						
						//Y坐标figureY
						if (null == cell_7||cell_7.getCellType()==Cell.CELL_TYPE_BLANK) {
						} else if (cell_7.getCellType() == Cell.CELL_TYPE_NUMERIC) {
							deviceTypeInfo.setFigureY((long) cell_7.getNumericCellValue());
						} else{
							errorInfo += i+1 + getI18nText("i18n_DeviceBrandManageAction.saveDevicesByExcel.errorInfo9_n81i");
						}
						
						//宽figureWidth
						if (null == cell_8||cell_8.getCellType()==Cell.CELL_TYPE_BLANK) {
						} else if (cell_8.getCellType() == Cell.CELL_TYPE_NUMERIC) {
							deviceTypeInfo.setFigureWidth((long) cell_8.getNumericCellValue());
						} else{
							errorInfo += i+1 + getI18nText("i18n_DeviceBrandManageAction.saveDevicesByExcel.errorInfo10_n81i");
						}
						
						//高figureHeight
						if (null == cell_9||cell_9.getCellType()==Cell.CELL_TYPE_BLANK) {
						} else if (cell_9.getCellType() == Cell.CELL_TYPE_NUMERIC) {
							deviceTypeInfo.setFigureHeight((long) cell_9.getNumericCellValue());
						} else{
							errorInfo += i+1 + getI18nText("i18n_DeviceBrandManageAction.saveDevicesByExcel.errorInfo11_n81i");
						}
						
						//边颜色figureStroke
						if (null == cell_10||cell_10.getCellType()==Cell.CELL_TYPE_BLANK) {
						} else if (cell_10.getCellType() == Cell.CELL_TYPE_STRING) {
							deviceTypeInfo.setFigureStroke(cell_10.getStringCellValue().trim());
						} else if (cell_10.getCellType() == Cell.CELL_TYPE_NUMERIC) {
							deviceTypeInfo.setFigureStroke(String.valueOf((int) cell_10.getNumericCellValue()));
						} else{
							errorInfo += i+1 + getI18nText("i18n_DeviceBrandManageAction.saveDevicesByExcel.errorInfo12_n81i");
						}
						
						//边宽figureStrokeWidth
						if (null == cell_11||cell_11.getCellType()==Cell.CELL_TYPE_BLANK) {
						} else if (cell_11.getCellType() == Cell.CELL_TYPE_NUMERIC) {
							deviceTypeInfo.setFigureStrokeWidth((long) cell_11.getNumericCellValue());
						} else{
							errorInfo += i+1 + getI18nText("i18n_DeviceBrandManageAction.saveDevicesByExcel.errorInfo13_n81i");
						}
						
						//图片名称（必填）figureFill
						if (null == cell_12) {
							errorInfo += i+1 + getI18nText("i18n_DeviceBrandManageAction.saveDevicesByExcel.errorInfo14_n81i");
						} else if (cell_12.getCellType() == Cell.CELL_TYPE_STRING) {
							if ("".equals(cell_12.getStringCellValue())) {
								errorInfo += i+1 + getI18nText("i18n_DeviceBrandManageAction.saveDevicesByExcel.errorInfo14_n81i");
							} else {
								deviceTypeInfo.setFigureFill(cell_12.getStringCellValue().trim());
							}
						}else {
							errorInfo += i+1 + getI18nText("i18n_DeviceBrandManageAction.saveDevicesByExcel.errorInfo15_n81i");
						}
						
						//命名格式（[Y]:代表设备本身在父设备的位置，[X]:代表父设备在祖父设备的位置）nameFormat
						if (null == cell_13||cell_13.getCellType()==Cell.CELL_TYPE_BLANK) {
						} else if (cell_13.getCellType() == Cell.CELL_TYPE_STRING) {
							deviceTypeInfo.setNameFormat(cell_13.getStringCellValue().trim());
						}else {
							errorInfo += i+1 + getI18nText("i18n_DeviceBrandManageAction.saveDevicesByExcel.errorInfo16_n81i");
						}												
						//监测类别表diTableName
						if (null == cell_14||cell_14.getCellType()==Cell.CELL_TYPE_BLANK) {
						} else if (cell_14.getCellType() == Cell.CELL_TYPE_STRING) {
							deviceTypeInfo.setDiTableName(cell_14.getStringCellValue().trim());
						}else {
							errorInfo += i+1 + getI18nText("i18n_DeviceBrandManageAction.saveDevicesByExcel.errorInfo17_n81i");
						}
						
						//图形级别showLevel
						if (null == cell_15||cell_15.getCellType()==Cell.CELL_TYPE_BLANK) {
						}else if (cell_15.getCellType() == Cell.CELL_TYPE_NUMERIC) {
							deviceTypeInfo.setShowLevel((long)cell_15.getNumericCellValue());
						}else {
							errorInfo += i+1 + getI18nText("i18n_DeviceBrandManageAction.saveDevicesByExcel.errorInfo18_n81i");
						}
						
						
						//设备最大叠加数（整形数值，默认为1）maxDeviceNum
						if (null == cell_16||cell_16.getCellType()==Cell.CELL_TYPE_BLANK) {
						} else if(cell_16.getCellType() == Cell.CELL_TYPE_NUMERIC){
							deviceTypeInfo.setMaxDeviceNum((long) cell_16.getNumericCellValue());
						} else {
							errorInfo += i+1 + getI18nText("i18n_DeviceBrandManageAction.saveDevicesByExcel.errorInfo19_n81i");
						}
						if ("".equals(errorInfo)) {// 保存主机架							
							deviceTypeInfo.setIsLink(0L);
							deviceTypeInfo.setIsLeaf(0L);
							errorInfo = this.saveNodeType(deviceTypeInfo);
						}
						if ("".equals(errorInfo)) {
							count++;
						} else {
							if(deviceTypeInfo.getDeviceTypeCode()==null){
								errorList.add("");
							}else{
								errorList.add(deviceTypeInfo.getDeviceTypeCode());
							}
							if(deviceTypeInfo.getDeviceRandCode()==null){
								errorList.add("");
							}else{
								errorList.add(deviceTypeInfo.getDeviceRandCode());
							}
							if(deviceTypeInfo.getDeviceDesc()==null){
								errorList.add("");
							}else{
								errorList.add(deviceTypeInfo.getDeviceDesc());
							}
							if(deviceTypeInfo.getShowIndex()==null){
								errorList.add("");
							}else{
								errorList.add(deviceTypeInfo.getShowIndex().toString());
							}						
							if(deviceTypeInfo.getFigureType()==null){
								errorList.add("");
							}else{
								errorList.add(deviceTypeInfo.getFigureType());
							}
							if(deviceTypeInfo.getFigureX()==null){
								errorList.add("");
							}else{
								errorList.add(deviceTypeInfo.getFigureX().toString());
							}
							if(deviceTypeInfo.getFigureY()==null){
								errorList.add("");
							}else{
								errorList.add(deviceTypeInfo.getFigureY().toString());
							}
							if(deviceTypeInfo.getFigureWidth()==null){
								errorList.add("");
							}else{
								errorList.add(deviceTypeInfo.getFigureWidth().toString());
							}						
							if(deviceTypeInfo.getFigureHeight()==null){
								errorList.add("");
							}else{
								errorList.add(deviceTypeInfo.getFigureHeight().toString());
							}						
							if(deviceTypeInfo.getFigureStroke()==null){
								errorList.add("");
							}else{
								errorList.add(deviceTypeInfo.getFigureStroke());
							}
							if(deviceTypeInfo.getFigureStrokeWidth()==null){
								errorList.add("");
							}else{
								errorList.add(deviceTypeInfo.getFigureStrokeWidth().toString());
							}
							if(deviceTypeInfo.getFigureFill()==null){
								errorList.add("");
							}else{
								errorList.add(deviceTypeInfo.getFigureFill());
							}
							if(deviceTypeInfo.getNameFormat()==null){
								errorList.add("");
							}else{
								errorList.add(deviceTypeInfo.getNameFormat());
							}
							if(deviceTypeInfo.getDiTableName()==null){
								errorList.add("");
							}else{
								errorList.add(deviceTypeInfo.getDiTableName());
							}
							if(deviceTypeInfo.getShowLevel()==null){
								errorList.add("");
							}else{
								errorList.add(deviceTypeInfo.getShowLevel().toString());
							}
							if(deviceTypeInfo.getMaxDeviceNum()==null){
								errorList.add("");
							}else{
								errorList.add(deviceTypeInfo.getMaxDeviceNum().toString());
							}
							errorList.add(errorInfo);
							rowList.add(errorList);
							errorInfo = "";
						}
					}
				}
				
			}
			
			headerList.add(sheetFlag+getI18nText("i18n_DeviceBrandManageAction.saveDevicesByExcel.brand_n81i"));
			headerList.add(getI18nText("i18n_DeviceBrandManageAction.downloadExampleType.brandBelong_n81i"));
			headerList.add(getI18nText("i18n_DeviceBrandManageAction.downloadExampleType.deviceDesc_n81i"));
			headerList.add(getI18nText("i18n_DeviceBrandManageAction.downloadExampleType.positionId_n81i"));
			headerList.add(getI18nText("i18n_DeviceBrandManageAction.downloadExampleType.pictureType_n81i"));
			headerList.add(getI18nText("i18n_DeviceBrandManageAction.downloadExampleType.XHeight_n81i"));
			headerList.add(getI18nText("i18n_DeviceBrandManageAction.downloadExampleType.YWeith_n81i"));
			headerList.add(getI18nText("i18n_DeviceBrandManageAction.downloadExampleType.weith_n81i"));
			headerList.add(getI18nText("i18n_DeviceBrandManageAction.downloadExampleType.height_n81i"));
			headerList.add(getI18nText("i18n_DeviceBrandManageAction.downloadExampleType.lineColor_n81i"));
			headerList.add(getI18nText("i18n_DeviceBrandManageAction.downloadExampleType.lineWeith_n81i"));
			headerList.add(getI18nText("i18n_DeviceBrandManageAction.downloadExampleType.pictureName_n81i"));
			headerList.add(getI18nText("i18n_DeviceBrandManageAction.downloadExampleType.nameFormat_n81i"));
			headerList.add(getI18nText("i18n_DeviceBrandManageAction.downloadExampleType.detecateTypeTable_n81i"));
			headerList.add(getI18nText("i18n_DeviceBrandManageAction.downloadExampleType.pictureLevel_n81i"));
			headerList.add(getI18nText("i18n_DeviceBrandManageAction.downloadExampleType.maxNum_n81i"));
			headerList.add(getI18nText("i18n_DeviceBrandManageAction.downloadExampleType.errorInfo_n81i"));
				flag[0]=count;
				flag[1]=sum;
			
		}else if(sheetFlag.equals("boardSlot")){
			if(sheet.getLastRowNum()>=1){
				for (short i = 1; i <= sheet.getLastRowNum(); i++) {
					String errorParDeviceTypeCodeString="";
					DeviceTypeInfo deviceTypeInfo = new DeviceTypeInfo();
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
					Cell cell_11 = row.getCell((short) 10);
					Cell cell_12 = row.getCell((short) 11);
					Cell cell_13 = row.getCell((short) 12);
					Cell cell_14 = row.getCell((short) 13);
					Cell cell_15 = row.getCell((short) 14);
					Cell cell_16 = row.getCell((short) 15);
					//Cell cell_23 = row.getCell((short) 22);
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
							) {
						sum--;
					}else {
						//设备型号
						if (null == cell_1) {
							errorInfo += i +1+ getI18nText("i18n_DeviceBrandManageAction.saveDevicesByExcel.errorInfo1.before_n81i")+sheetFlag+getI18nText("i18n_DeviceBrandManageAction.saveDevicesByExcel.errorInfo1.after_n81i");
						} else if (cell_1.getCellType() == Cell.CELL_TYPE_STRING) {
							if ("".equals(cell_1.getStringCellValue())) {
								errorInfo += i+1 + getI18nText("i18n_DeviceBrandManageAction.saveDevicesByExcel.errorInfo1.before_n81i")+sheetFlag+getI18nText("i18n_DeviceBrandManageAction.saveDevicesByExcel.errorInfo1.after_n81i");
							} else {
								deviceTypeInfo.setDeviceTypeCode(cell_1.getStringCellValue().trim());
							}
						}else if(cell_1.getCellType() == Cell.CELL_TYPE_NUMERIC){
							deviceTypeInfo.setDeviceTypeCode(String.valueOf((int) cell_1.getNumericCellValue()));
						} else {
							errorInfo += i+1 + getI18nText("i18n_DeviceBrandManageAction.saveDevicesByExcel.errorInfo2.before_n81i")+sheetFlag+getI18nText("i18n_DeviceBrandManageAction.saveDevicesByExcel.errorInfo2.after_n81i");
						}

						//所属品牌（必填，对应品牌编号）
						if (null == cell_2) {
							errorInfo += i+1 + getI18nText("i18n_DeviceBrandManageAction.saveDevicesByExcel.errorInfo3_n81i");
						} else if (cell_2.getCellType() == Cell.CELL_TYPE_STRING) {
							if ("".equals(cell_2.getStringCellValue())) {
								errorInfo += i +1+ getI18nText("i18n_DeviceBrandManageAction.saveDevicesByExcel.errorInfo3_n81i");
							} else {
								deviceTypeInfo.setDeviceRandCode(cell_2.getStringCellValue().trim());
							}
						} else if(cell_2.getCellType() == Cell.CELL_TYPE_NUMERIC){
							deviceTypeInfo.setDeviceRandCode(String.valueOf((int) cell_2.getNumericCellValue()));
						} else{
							errorInfo += i+1 + getI18nText("i18n_DeviceBrandManageAction.saveDevicesByExcel.errorInfo4_n81i");
						}

						//设备描述
						if(null == cell_3 || cell_3.getCellType()==Cell.CELL_TYPE_BLANK){
						}else if(cell_3.getCellType() == Cell.CELL_TYPE_NUMERIC){
							deviceTypeInfo.setDeviceDesc(String.valueOf((int)cell_3.getNumericCellValue()));
						}else if (cell_3.getCellType() == Cell.CELL_TYPE_STRING) {
							deviceTypeInfo.setDeviceDesc(cell_3.getStringCellValue().trim());
						} else {
							errorInfo += i+1 + getI18nText("i18n_DeviceBrandManageAction.saveDevicesByExcel.errorInfo5_n81i");
						}
						
						//级别下位置序号
						if(null == cell_4||cell_4.getCellType()==Cell.CELL_TYPE_BLANK){
						}else if(cell_4.getCellType() == Cell.CELL_TYPE_NUMERIC){
							deviceTypeInfo.setShowIndex((long)cell_4.getNumericCellValue());
						}else {
							errorInfo += i+1 + getI18nText("i18n_DeviceBrandManageAction.saveDevicesByExcel.errorInfo6_n81i");
						}
						
						//父设备型号（为空默认为顶级设备）,不为空查找数据库获得父设备ID，找不到则添加错误信息
						if (null == cell_5||cell_5.getCellType()==Cell.CELL_TYPE_BLANK) {//父设备型号为空
							//System.out.println("父设备型号为空");
							//deviceTypeInfo.setPid("0");
							//errorParDeviceTypeCodeString="";
						} else if (cell_5.getCellType() == Cell.CELL_TYPE_STRING) {//查找数据库获得PID
							if(!"".equals(cell_5.getStringCellValue().trim())){
								DeviceTypeInfo parentDevice=(DeviceTypeInfo)this.commonService.getUniqueByHql(" from DeviceTypeInfo where deviceTypeCode=?",cell_5.getStringCellValue().trim() );
								if(parentDevice!=null&&"0".equals(parentDevice.getPid())){//父设备，包括主机架以及板卡，其PID都是0
									deviceTypeInfo.setPid(parentDevice.getId().toString());//子设备设置PID为父设备的ID
								}else{//没有查到准确的父设备
									errorInfo += i+1 + getI18nText("i18n_DeviceBrandManageAction.saveDevicesByExcel.errorInfo20_n81i");
									errorParDeviceTypeCodeString=cell_5.getStringCellValue().trim();
								}
							}
						} else if (cell_5.getCellType() == Cell.CELL_TYPE_NUMERIC) {
							if(!"".equals(String.valueOf((int)cell_5.getNumericCellValue()))){
								DeviceTypeInfo parentDevice=(DeviceTypeInfo)this.commonService.getUniqueByHql(" from DeviceTypeInfo where deviceTypeCode=?",String.valueOf((int)cell_5.getNumericCellValue()));
								if(parentDevice!=null&&"0".equals(parentDevice.getPid())){//父设备，包括主机架以及板卡，其PID都是0
									deviceTypeInfo.setPid(parentDevice.getId().toString());//子设备设置PID为父设备的ID
								}else{//没有查到准确的父设备
									errorInfo += i+1+ getI18nText("i18n_DeviceBrandManageAction.saveDevicesByExcel.errorInfo20_n81i");
									errorParDeviceTypeCodeString=String.valueOf((int)cell_5.getNumericCellValue());
								}
							}
						}else{
							errorInfo += i+1+ getI18nText("i18n_DeviceBrandManageAction.saveDevicesByExcel.errorInfo21_n81i");
						}
						
						//图片类型figureType
						if (null == cell_6||cell_6.getCellType()==Cell.CELL_TYPE_BLANK) {
						} else if (cell_6.getCellType() == Cell.CELL_TYPE_STRING) {
							deviceTypeInfo.setFigureType(cell_6.getStringCellValue().trim());
						} else{
							errorInfo += i+1 + getI18nText("i18n_DeviceBrandManageAction.saveDevicesByExcel.errorInfo22_n81i");
						}
						
						//X坐标figureX
						if (null == cell_7||cell_7.getCellType()==Cell.CELL_TYPE_BLANK) {
						} else if (cell_7.getCellType() == Cell.CELL_TYPE_NUMERIC) {
							deviceTypeInfo.setFigureX((long) cell_7.getNumericCellValue());
						} else{
							errorInfo += i+1 +getI18nText("i18n_DeviceBrandManageAction.saveDevicesByExcel.errorInfo23_n81i");
						}
						
						//Y坐标figureY
						if (null == cell_8||cell_8.getCellType()==Cell.CELL_TYPE_BLANK) {
						} else if (cell_8.getCellType() == Cell.CELL_TYPE_NUMERIC) {
							deviceTypeInfo.setFigureY((long) cell_8.getNumericCellValue());
						} else{
							errorInfo += i+1 + getI18nText("i18n_DeviceBrandManageAction.saveDevicesByExcel.errorInfo24_n81i");
						}
						
						//宽figureWidth
						if (null == cell_9||cell_9.getCellType()==Cell.CELL_TYPE_BLANK) {
						} else if (cell_9.getCellType() == Cell.CELL_TYPE_NUMERIC) {
							deviceTypeInfo.setFigureWidth((long) cell_9.getNumericCellValue());
						} else{
							errorInfo += i+1 + getI18nText("i18n_DeviceBrandManageAction.saveDevicesByExcel.errorInfo25_n81i");
						}
						
						//高figureHeight
						if (null == cell_10||cell_10.getCellType()==Cell.CELL_TYPE_BLANK) {
						} else if (cell_10.getCellType() == Cell.CELL_TYPE_NUMERIC) {
							deviceTypeInfo.setFigureHeight((long) cell_10.getNumericCellValue());
						} else{
							errorInfo += i+1 + getI18nText("i18n_DeviceBrandManageAction.saveDevicesByExcel.errorInfo26_n81i");
						}
						
						//边颜色figureStroke
						if (null == cell_11||cell_11.getCellType()==Cell.CELL_TYPE_BLANK) {
						} else if (cell_11.getCellType() == Cell.CELL_TYPE_STRING) {
							deviceTypeInfo.setFigureStroke(cell_11.getStringCellValue().trim());
						} else if (cell_11.getCellType() == Cell.CELL_TYPE_NUMERIC) {
							deviceTypeInfo.setFigureStroke(String.valueOf((int) cell_11.getNumericCellValue()));
						} else{
							errorInfo += i+1 + getI18nText("i18n_DeviceBrandManageAction.saveDevicesByExcel.errorInfo27_n81i");
						}
						
						//边宽figureStrokeWidth
						if (null == cell_12||cell_12.getCellType()==Cell.CELL_TYPE_BLANK) {
						} else if (cell_12.getCellType() == Cell.CELL_TYPE_NUMERIC) {
							deviceTypeInfo.setFigureStrokeWidth((long) cell_12.getNumericCellValue());
						} else{
							errorInfo += i+1 + getI18nText("i18n_DeviceBrandManageAction.saveDevicesByExcel.errorInfo28_n81i");
						}
						
						//图片名称（必填）figureFill
						if (null == cell_13) {
							errorInfo += i+1 + getI18nText("i18n_DeviceBrandManageAction.saveDevicesByExcel.errorInfo29_n81i");
						} else if (cell_13.getCellType() == Cell.CELL_TYPE_STRING) {
							if ("".equals(cell_13.getStringCellValue())) {
								errorInfo += i+1 + getI18nText("i18n_DeviceBrandManageAction.saveDevicesByExcel.errorInfo29_n81i");
							} else {
								deviceTypeInfo.setFigureFill(cell_13.getStringCellValue().trim());
							}
						}else {
							errorInfo += i+1 + getI18nText("i18n_DeviceBrandManageAction.saveDevicesByExcel.errorInfo30_n81i");
						}
						
						//命名格式（[Y]:代表设备本身在父设备的位置，[X]:代表父设备在祖父设备的位置）nameFormat
						if (null == cell_14||cell_14.getCellType()==Cell.CELL_TYPE_BLANK) {
						} else if (cell_14.getCellType() == Cell.CELL_TYPE_STRING) {
							deviceTypeInfo.setNameFormat(cell_14.getStringCellValue().trim());
						}else {
							errorInfo += i+1 + getI18nText("i18n_DeviceBrandManageAction.saveDevicesByExcel.errorInfo31_n81i");
						}												
											
						//图形级别showLevel
						if (null == cell_15||cell_15.getCellType()==Cell.CELL_TYPE_BLANK) {
						}else if (cell_15.getCellType() == Cell.CELL_TYPE_NUMERIC) {
							deviceTypeInfo.setShowLevel((long)cell_15.getNumericCellValue());
						}else {
							errorInfo += i+1 + getI18nText("i18n_DeviceBrandManageAction.saveDevicesByExcel.errorInfo18_n81i");
						}						
						//是否叶子设备（必填，1是，0否）isLeaf
						if (null == cell_16||cell_16.getCellType()==Cell.CELL_TYPE_BLANK) {
							errorInfo += i+1 + getI18nText("i18n_DeviceBrandManageAction.saveDevicesByExcel.errorInfo53_n81i");
						} else if(cell_16.getCellType() == Cell.CELL_TYPE_NUMERIC){
							deviceTypeInfo.setIsLeaf((long) cell_16.getNumericCellValue());
						} else {
							errorInfo += i+1 + getI18nText("i18n_DeviceBrandManageAction.saveDevicesByExcel.errorInfo54_n81i");
						}
						
						if ("".equals(errorInfo)) {// 保存主机架							
							deviceTypeInfo.setIsLink(0L);
							deviceTypeInfo.setMaxDeviceNum(1l);
							errorInfo = this.saveNodeType(deviceTypeInfo);
						}
						if ("".equals(errorInfo)) {
							count++;
						} else {
							if(deviceTypeInfo.getDeviceTypeCode()==null){
								errorList.add("");
							}else{
								errorList.add(deviceTypeInfo.getDeviceTypeCode());
							}
							if(deviceTypeInfo.getDeviceRandCode()==null){
								errorList.add("");
							}else{
								errorList.add(deviceTypeInfo.getDeviceRandCode());
							}
							if(deviceTypeInfo.getDeviceDesc()==null){
								errorList.add("");
							}else{
								errorList.add(deviceTypeInfo.getDeviceDesc());
							}
							if(deviceTypeInfo.getShowIndex()==null){
								errorList.add("");
							}else{
								errorList.add(deviceTypeInfo.getShowIndex().toString());
							}						
							if(deviceTypeInfo.getPid()==null){
								errorList.add("");
							}else{
								errorList.add(errorParDeviceTypeCodeString);
							}
							if(deviceTypeInfo.getFigureType()==null){
								errorList.add("");
							}else{
								errorList.add(deviceTypeInfo.getFigureType());
							}
							if(deviceTypeInfo.getFigureX()==null){
								errorList.add("");
							}else{
								errorList.add(deviceTypeInfo.getFigureX().toString());
							}
							if(deviceTypeInfo.getFigureY()==null){
								errorList.add("");
							}else{
								errorList.add(deviceTypeInfo.getFigureY().toString());
							}
							if(deviceTypeInfo.getFigureWidth()==null){
								errorList.add("");
							}else{
								errorList.add(deviceTypeInfo.getFigureWidth().toString());
							}						
							if(deviceTypeInfo.getFigureHeight()==null){
								errorList.add("");
							}else{
								errorList.add(deviceTypeInfo.getFigureHeight().toString());
							}						
							if(deviceTypeInfo.getFigureStroke()==null){
								errorList.add("");
							}else{
								errorList.add(deviceTypeInfo.getFigureStroke());
							}
							if(deviceTypeInfo.getFigureStrokeWidth()==null){
								errorList.add("");
							}else{
								errorList.add(deviceTypeInfo.getFigureStrokeWidth().toString());
							}
							if(deviceTypeInfo.getFigureFill()==null){
								errorList.add("");
							}else{
								errorList.add(deviceTypeInfo.getFigureFill());
							}
							if(deviceTypeInfo.getNameFormat()==null){
								errorList.add("");
							}else{
								errorList.add(deviceTypeInfo.getNameFormat());
							}
							if(deviceTypeInfo.getDiTableName()==null){
								errorList.add("");
							}else{
								errorList.add(deviceTypeInfo.getDiTableName());
							}
							if(deviceTypeInfo.getShowLevel()==null){
								errorList.add("");
							}else{
								errorList.add(deviceTypeInfo.getShowLevel().toString());
							}
							if(deviceTypeInfo.getIsLeaf()==null){
								errorList.add("");
							}else{
								errorList.add(deviceTypeInfo.getIsLeaf().toString());
							}
							errorList.add(errorInfo);
							rowList.add(errorList);
							errorInfo = "";
						}
					}
				}
				
			}
			headerList.add(sheetFlag+getI18nText("i18n_DeviceBrandManageAction.saveDevicesByExcel.brand_n81i"));
			headerList.add(getI18nText("i18n_DeviceBrandManageAction.downloadExampleType.brandBelong_n81i"));
			headerList.add(getI18nText("i18n_DeviceBrandManageAction.downloadExampleType.deviceDesc_n81i"));
			headerList.add(getI18nText("i18n_DeviceBrandManageAction.downloadExampleType.positionId_n81i"));
			headerList.add(getI18nText("i18n_DeviceBrandManageAction.downloadExampleType.parentDeviceType_n81i"));
			headerList.add(getI18nText("i18n_DeviceBrandManageAction.downloadExampleType.pictureType_n81i"));
			headerList.add(getI18nText("i18n_DeviceBrandManageAction.downloadExampleType.XHeight_n81i"));
			headerList.add(getI18nText("i18n_DeviceBrandManageAction.downloadExampleType.YWeith_n81i"));
			headerList.add(getI18nText("i18n_DeviceBrandManageAction.downloadExampleType.weith_n81i"));
			headerList.add(getI18nText("i18n_DeviceBrandManageAction.downloadExampleType.height_n81i"));
			headerList.add(getI18nText("i18n_DeviceBrandManageAction.downloadExampleType.lineColor_n81i"));
			headerList.add(getI18nText("i18n_DeviceBrandManageAction.downloadExampleType.lineWeith_n81i"));
			headerList.add(getI18nText("i18n_DeviceBrandManageAction.downloadExampleType.pictureName_n81i"));
			headerList.add(getI18nText("i18n_DeviceBrandManageAction.downloadExampleType.nameFormat_n81i"));
			headerList.add(getI18nText("i18n_DeviceBrandManageAction.downloadExampleType.detecateTypeTable_n81i"));
			headerList.add(getI18nText("i18n_DeviceBrandManageAction.downloadExampleType.pictureLevel_n81i"));
			headerList.add(getI18nText("i18n_DeviceBrandManageAction.downloadExampleType.isLeafDevice_n81i"));
			headerList.add(getI18nText("i18n_DeviceBrandManageAction.downloadExampleType.errorInfo_n81i"));
				flag[0]=count;
				flag[1]=sum;
		}else if(sheetFlag.equals("board")){
			if(sheet.getLastRowNum()>=1){
				for (short i = 1; i <= sheet.getLastRowNum(); i++) {
					String errorParDeviceTypeCodeString="";
					DeviceTypeInfo deviceTypeInfo = new DeviceTypeInfo();
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
					Cell cell_11 = row.getCell((short) 10);
					Cell cell_12 = row.getCell((short) 11);
					Cell cell_13 = row.getCell((short) 12);
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
							) {
						sum--;
					}else {
						//设备型号
						if (null == cell_1) {
							errorInfo += i +1+ getI18nText("i18n_DeviceBrandManageAction.saveDevicesByExcel.errorInfo1.before_n81i")+sheetFlag+getI18nText("i18n_DeviceBrandManageAction.saveDevicesByExcel.errorInfo1.after_n81i");
						} else if (cell_1.getCellType() == Cell.CELL_TYPE_STRING) {
							if ("".equals(cell_1.getStringCellValue())) {
								errorInfo += i+1 + getI18nText("i18n_DeviceBrandManageAction.saveDevicesByExcel.errorInfo1.before_n81i")+sheetFlag+getI18nText("i18n_DeviceBrandManageAction.saveDevicesByExcel.errorInfo1.after_n81i");
							} else {
								deviceTypeInfo.setDeviceTypeCode(cell_1.getStringCellValue().trim());
							}
						}else if(cell_1.getCellType() == Cell.CELL_TYPE_NUMERIC){
							deviceTypeInfo.setDeviceTypeCode(String.valueOf((int) cell_1.getNumericCellValue()));
						} else {
							errorInfo += i+1 + getI18nText("i18n_DeviceBrandManageAction.saveDevicesByExcel.errorInfo2.before_n81i")+sheetFlag+getI18nText("i18n_DeviceBrandManageAction.saveDevicesByExcel.errorInfo2.after_n81i");
						}

						//所属品牌（必填，对应品牌编号）
						if (null == cell_2) {
							errorInfo += i+1 + getI18nText("i18n_DeviceBrandManageAction.saveDevicesByExcel.errorInfo3_n81i");
						} else if (cell_2.getCellType() == Cell.CELL_TYPE_STRING) {
							if ("".equals(cell_2.getStringCellValue())) {
								errorInfo += i +1+ getI18nText("i18n_DeviceBrandManageAction.saveDevicesByExcel.errorInfo3_n81i");
							} else {
								deviceTypeInfo.setDeviceRandCode(cell_2.getStringCellValue().trim());
							}
						} else if(cell_2.getCellType() == Cell.CELL_TYPE_NUMERIC){
							deviceTypeInfo.setDeviceRandCode(String.valueOf((int) cell_2.getNumericCellValue()));
						} else{
							errorInfo += i+1 + getI18nText("i18n_DeviceBrandManageAction.saveDevicesByExcel.errorInfo4_n81i");
						}

						//设备描述
						if(null == cell_3 || cell_3.getCellType()==Cell.CELL_TYPE_BLANK){
						}else if(cell_3.getCellType() == Cell.CELL_TYPE_NUMERIC){
							deviceTypeInfo.setDeviceDesc(String.valueOf((int)cell_3.getNumericCellValue()));
						}else if (cell_3.getCellType() == Cell.CELL_TYPE_STRING) {
							deviceTypeInfo.setDeviceDesc(cell_3.getStringCellValue().trim());
						} else {
							errorInfo += i+1 + getI18nText("i18n_DeviceBrandManageAction.saveDevicesByExcel.errorInfo5_n81i");
						}																										
						//图片类型figureType
						if (null == cell_4||cell_4.getCellType()==Cell.CELL_TYPE_BLANK) {
						} else if (cell_4.getCellType() == Cell.CELL_TYPE_STRING) {
							deviceTypeInfo.setFigureType(cell_4.getStringCellValue().trim());
						} else{
							errorInfo += i+1 + getI18nText("i18n_DeviceBrandManageAction.saveDevicesByExcel.errorInfo6_n81i");
						}
						
						//X坐标figureX
						if (null == cell_5||cell_5.getCellType()==Cell.CELL_TYPE_BLANK) {
						} else if (cell_5.getCellType() == Cell.CELL_TYPE_NUMERIC) {
							deviceTypeInfo.setFigureX((long) cell_5.getNumericCellValue());
						} else{
							errorInfo += i+1 + getI18nText("i18n_DeviceBrandManageAction.saveDevicesByExcel.errorInfo33_n81i");
						}
						
						//Y坐标figureY
						if (null == cell_6||cell_6.getCellType()==Cell.CELL_TYPE_BLANK) {
						} else if (cell_6.getCellType() == Cell.CELL_TYPE_NUMERIC) {
							deviceTypeInfo.setFigureY((long) cell_6.getNumericCellValue());
						} else{
							errorInfo += i+1 + getI18nText("i18n_DeviceBrandManageAction.saveDevicesByExcel.errorInfo34_n81i");
						}
						
						//宽figureWidth
						if (null == cell_7||cell_7.getCellType()==Cell.CELL_TYPE_BLANK) {
						} else if (cell_7.getCellType() == Cell.CELL_TYPE_NUMERIC) {
							deviceTypeInfo.setFigureWidth((long) cell_7.getNumericCellValue());
						} else{
							errorInfo += i+1 + getI18nText("i18n_DeviceBrandManageAction.saveDevicesByExcel.errorInfo35_n81i");
						}
						
						//高figureHeight
						if (null == cell_8||cell_8.getCellType()==Cell.CELL_TYPE_BLANK) {
						} else if (cell_8.getCellType() == Cell.CELL_TYPE_NUMERIC) {
							deviceTypeInfo.setFigureHeight((long) cell_8.getNumericCellValue());
						} else{
							errorInfo += i+1 + getI18nText("i18n_DeviceBrandManageAction.saveDevicesByExcel.errorInfo36_n81i");
						}
						
						//边颜色figureStroke
						if (null == cell_9||cell_9.getCellType()==Cell.CELL_TYPE_BLANK) {
						} else if (cell_9.getCellType() == Cell.CELL_TYPE_STRING) {
							deviceTypeInfo.setFigureStroke(cell_9.getStringCellValue().trim());
						} else if (cell_9.getCellType() == Cell.CELL_TYPE_NUMERIC) {
							deviceTypeInfo.setFigureStroke(String.valueOf((int) cell_9.getNumericCellValue()));
						} else{
							errorInfo += i+1 + getI18nText("i18n_DeviceBrandManageAction.saveDevicesByExcel.errorInfo37_n81i");
						}
						
						//边宽figureStrokeWidth
						if (null == cell_10||cell_10.getCellType()==Cell.CELL_TYPE_BLANK) {
						} else if (cell_10.getCellType() == Cell.CELL_TYPE_NUMERIC) {
							deviceTypeInfo.setFigureStrokeWidth((long) cell_10.getNumericCellValue());
						} else{
							errorInfo += i+1 +getI18nText("i18n_DeviceBrandManageAction.saveDevicesByExcel.errorInfo38_n81i");
						}
						
						//图片名称（必填）figureFill
						if (null == cell_11) {
							errorInfo += i+1 + getI18nText("i18n_DeviceBrandManageAction.saveDevicesByExcel.errorInfo39_n81i");
						} else if (cell_11.getCellType() == Cell.CELL_TYPE_STRING) {
							if ("".equals(cell_11.getStringCellValue())) {
								errorInfo += i+1 + getI18nText("i18n_DeviceBrandManageAction.saveDevicesByExcel.errorInfo39_n81i");
							} else {
								deviceTypeInfo.setFigureFill(cell_11.getStringCellValue().trim());
							}
						}else {
							errorInfo += i+1 + getI18nText("i18n_DeviceBrandManageAction.saveDevicesByExcel.errorInfo40_n81i");
						}																													
						//图形级别showLevel
						if (null == cell_12||cell_12.getCellType()==Cell.CELL_TYPE_BLANK) {
						}else if (cell_12.getCellType() == Cell.CELL_TYPE_NUMERIC) {
							deviceTypeInfo.setShowLevel((long)cell_12.getNumericCellValue());
						}else {
							errorInfo += i+1 + getI18nText("i18n_DeviceBrandManageAction.saveDevicesByExcel.errorInfo41_n81i");
						}
																
						//是否叶子设备（必填，1是，0否）isLeaf
						if (null == cell_13||cell_13.getCellType()==Cell.CELL_TYPE_BLANK) {
							errorInfo += i+1 + getI18nText("i18n_DeviceBrandManageAction.saveDevicesByExcel.errorInfo53_n81i");
						} else if(cell_13.getCellType() == Cell.CELL_TYPE_NUMERIC){
							deviceTypeInfo.setIsLeaf((long) cell_13.getNumericCellValue());
						} else {
							errorInfo += i+1 + getI18nText("i18n_DeviceBrandManageAction.saveDevicesByExcel.errorInfo42_n81i");
						}
						
						if ("".equals(errorInfo)) {// 保存主机架							
							deviceTypeInfo.setShowIndex(1L);
							deviceTypeInfo.setIsLink(0L);
							deviceTypeInfo.setMaxDeviceNum(1L);
							errorInfo = this.saveNodeType(deviceTypeInfo);
						}
						if ("".equals(errorInfo)) {
							count++;
						} else {
							if(deviceTypeInfo.getDeviceTypeCode()==null){
								errorList.add("");
							}else{
								errorList.add(deviceTypeInfo.getDeviceTypeCode());
							}
							if(deviceTypeInfo.getDeviceRandCode()==null){
								errorList.add("");
							}else{
								errorList.add(deviceTypeInfo.getDeviceRandCode());
							}
							if(deviceTypeInfo.getDeviceDesc()==null){
								errorList.add("");
							}else{
								errorList.add(deviceTypeInfo.getDeviceDesc());
							}					
							
							if(deviceTypeInfo.getFigureType()==null){
								errorList.add("");
							}else{
								errorList.add(deviceTypeInfo.getFigureType());
							}
							if(deviceTypeInfo.getFigureX()==null){
								errorList.add("");
							}else{
								errorList.add(deviceTypeInfo.getFigureX().toString());
							}
							if(deviceTypeInfo.getFigureY()==null){
								errorList.add("");
							}else{
								errorList.add(deviceTypeInfo.getFigureY().toString());
							}
							if(deviceTypeInfo.getFigureWidth()==null){
								errorList.add("");
							}else{
								errorList.add(deviceTypeInfo.getFigureWidth().toString());
							}						
							if(deviceTypeInfo.getFigureHeight()==null){
								errorList.add("");
							}else{
								errorList.add(deviceTypeInfo.getFigureHeight().toString());
							}						
							if(deviceTypeInfo.getFigureStroke()==null){
								errorList.add("");
							}else{
								errorList.add(deviceTypeInfo.getFigureStroke());
							}
							if(deviceTypeInfo.getFigureStrokeWidth()==null){
								errorList.add("");
							}else{
								errorList.add(deviceTypeInfo.getFigureStrokeWidth().toString());
							}
							if(deviceTypeInfo.getFigureFill()==null){
								errorList.add("");
							}else{
								errorList.add(deviceTypeInfo.getFigureFill());
							}
							
							if(deviceTypeInfo.getShowLevel()==null){
								errorList.add("");
							}else{
								errorList.add(deviceTypeInfo.getShowLevel().toString());
							}
							
							if(deviceTypeInfo.getIsLeaf()==null){
								errorList.add("");
							}else{
								errorList.add(deviceTypeInfo.getIsLeaf().toString());
							}
							errorList.add(errorInfo);
							rowList.add(errorList);
							errorInfo = "";
						}
					}
				}
				
			}
			headerList.add(sheetFlag+getI18nText("i18n_DeviceBrandManageAction.saveDevicesByExcel.brand_n81i"));
			headerList.add(getI18nText("i18n_DeviceBrandManageAction.downloadExampleType.brandBelong_n81i"));
			headerList.add(getI18nText("i18n_DeviceBrandManageAction.downloadExampleType.deviceDesc_n81i"));
			headerList.add(getI18nText("i18n_DeviceBrandManageAction.downloadExampleType.pictureType_n81i"));
			headerList.add(getI18nText("i18n_DeviceBrandManageAction.downloadExampleType.XHeight_n81i"));
			headerList.add(getI18nText("i18n_DeviceBrandManageAction.downloadExampleType.YWeith_n81i"));
			headerList.add(getI18nText("i18n_DeviceBrandManageAction.downloadExampleType.weith_n81i"));
			headerList.add(getI18nText("i18n_DeviceBrandManageAction.downloadExampleType.height_n81i"));
			headerList.add(getI18nText("i18n_DeviceBrandManageAction.downloadExampleType.lineColor_n81i"));
			headerList.add(getI18nText("i18n_DeviceBrandManageAction.downloadExampleType.lineWeith_n81i"));
			headerList.add(getI18nText("i18n_DeviceBrandManageAction.downloadExampleType.pictureName_n81i"));
			
			headerList.add(getI18nText("i18n_DeviceBrandManageAction.downloadExampleType.pictureLevel_n81i"));
			
			headerList.add(getI18nText("i18n_DeviceBrandManageAction.downloadExampleType.isLeafDevice_n81i"));
		
			headerList.add(getI18nText("i18n_DeviceBrandManageAction.downloadExampleType.errorInfo_n81i"));
				flag[0]=count;
				flag[1]=sum;
		}
		else if(sheetFlag.equals("port")){
			if(sheet.getLastRowNum()>=1){
				for (short i = 1; i <= sheet.getLastRowNum(); i++) {
					String errorParDeviceTypeCodeString="";
					DeviceTypeInfo deviceTypeInfo = new DeviceTypeInfo();
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
					Cell cell_11 = row.getCell((short) 10);
					Cell cell_12 = row.getCell((short) 11);
					Cell cell_13 = row.getCell((short) 12);
					Cell cell_14 = row.getCell((short) 13);
					Cell cell_15 = row.getCell((short) 14);
					Cell cell_16 = row.getCell((short) 15);
					Cell cell_17 = row.getCell((short) 16);
					Cell cell_18 = row.getCell((short) 17);
					Cell cell_19 = row.getCell((short) 18);
					Cell cell_20 = row.getCell((short) 19);
					Cell cell_21 = row.getCell((short) 20);
					Cell cell_22 = row.getCell((short) 21);
					Cell cell_23 = row.getCell((short) 22);
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
							&& (null == cell_18 || 3 == cell_18.getCellType())
							&& (null == cell_19 || 3 == cell_19.getCellType())
							&& (null == cell_20 || 3 == cell_20.getCellType())
							&& (null == cell_21 || 3 == cell_21.getCellType())
							&& (null == cell_22 || 3 == cell_22.getCellType())
							&& (null == cell_23 || 3 == cell_23.getCellType())) {
						sum--;
					}else {
						//设备型号
						if (null == cell_1) {
							errorInfo += i +1+getI18nText("i18n_DeviceBrandManageAction.saveDevicesByExcel.errorInfo1.before_n81i")+sheetFlag+getI18nText("i18n_DeviceBrandManageAction.saveDevicesByExcel.errorInfo1.after_n81i");
						} else if (cell_1.getCellType() == Cell.CELL_TYPE_STRING) {
							if ("".equals(cell_1.getStringCellValue())) {
								errorInfo += i+1 + getI18nText("i18n_DeviceBrandManageAction.saveDevicesByExcel.errorInfo1.before_n81i")+sheetFlag+getI18nText("i18n_DeviceBrandManageAction.saveDevicesByExcel.errorInfo1.after_n81i");
							} else {
								deviceTypeInfo.setDeviceTypeCode(cell_1.getStringCellValue().trim());
							}
						}else if(cell_1.getCellType() == Cell.CELL_TYPE_NUMERIC){
							deviceTypeInfo.setDeviceTypeCode(String.valueOf((int) cell_1.getNumericCellValue()));
						} else {
							errorInfo += i+1 + getI18nText("i18n_DeviceBrandManageAction.saveDevicesByExcel.errorInfo2.before_n81i")+sheetFlag+getI18nText("i18n_DeviceBrandManageAction.saveDevicesByExcel.errorInfo2.after_n81i");
						}

						//所属品牌（必填，对应品牌编号）
						if (null == cell_2) {
							errorInfo += i+1 + getI18nText("i18n_DeviceBrandManageAction.saveDevicesByExcel.errorInfo3_n81i");
						} else if (cell_2.getCellType() == Cell.CELL_TYPE_STRING) {
							if ("".equals(cell_2.getStringCellValue())) {
								errorInfo += i +1+ getI18nText("i18n_DeviceBrandManageAction.saveDevicesByExcel.errorInfo3_n81i");
							} else {
								deviceTypeInfo.setDeviceRandCode(cell_2.getStringCellValue().trim());
							}
						} else if(cell_2.getCellType() == Cell.CELL_TYPE_NUMERIC){
							deviceTypeInfo.setDeviceRandCode(String.valueOf((int) cell_2.getNumericCellValue()));
						} else{
							errorInfo += i+1 + getI18nText("i18n_DeviceBrandManageAction.saveDevicesByExcel.errorInfo4_n81i");
						}

						//设备描述
						if(null == cell_3 || cell_3.getCellType()==Cell.CELL_TYPE_BLANK){
						}else if(cell_3.getCellType() == Cell.CELL_TYPE_NUMERIC){
							deviceTypeInfo.setDeviceDesc(String.valueOf((int)cell_3.getNumericCellValue()));
						}else if (cell_3.getCellType() == Cell.CELL_TYPE_STRING) {
							deviceTypeInfo.setDeviceDesc(cell_3.getStringCellValue().trim());
						} else {
							errorInfo += i+1 +getI18nText("i18n_DeviceBrandManageAction.saveDevicesByExcel.errorInfo5_n81i");
						}
						
						//级别下位置序号
						if(null == cell_4||cell_4.getCellType()==Cell.CELL_TYPE_BLANK){
						}else if(cell_4.getCellType() == Cell.CELL_TYPE_NUMERIC){
							deviceTypeInfo.setShowIndex((long)cell_4.getNumericCellValue());
						}else {
							errorInfo += i+1 + getI18nText("i18n_DeviceBrandManageAction.saveDevicesByExcel.errorInfo6_n81i");
						}
						
						//父设备型号（为空默认为顶级设备）,不为空查找数据库获得父设备ID，找不到则添加错误信息
						if (null == cell_5||cell_5.getCellType()==Cell.CELL_TYPE_BLANK) {//父设备型号为空
							//System.out.println("父设备型号为空");
							//deviceTypeInfo.setPid("0");
							//errorParDeviceTypeCodeString="";
						} else if (cell_5.getCellType() == Cell.CELL_TYPE_STRING) {//查找数据库获得PID
							if(!"".equals(cell_5.getStringCellValue().trim())){
								DeviceTypeInfo parentDevice=(DeviceTypeInfo)this.commonService.getUniqueByHql(" from DeviceTypeInfo where deviceTypeCode=?",cell_5.getStringCellValue().trim() );
								if(parentDevice!=null&&"0".equals(parentDevice.getPid())){//父设备，包括主机架以及板卡，其PID都是0
									deviceTypeInfo.setPid(parentDevice.getId().toString());//子设备设置PID为父设备的ID
								}else{//没有查到准确的父设备
									errorInfo += i+1 + getI18nText("i18n_DeviceBrandManageAction.saveDevicesByExcel.errorInfo20_n81i");
									errorParDeviceTypeCodeString=cell_5.getStringCellValue().trim();
								}
							}
						} else if (cell_5.getCellType() == Cell.CELL_TYPE_NUMERIC) {
							if(!"".equals(String.valueOf((int)cell_5.getNumericCellValue()))){
								DeviceTypeInfo parentDevice=(DeviceTypeInfo)this.commonService.getUniqueByHql(" from DeviceTypeInfo where deviceTypeCode=?",String.valueOf((int)cell_5.getNumericCellValue()));
								if(parentDevice!=null&&"0".equals(parentDevice.getPid())){//父设备，包括主机架以及板卡，其PID都是0
									deviceTypeInfo.setPid(parentDevice.getId().toString());//子设备设置PID为父设备的ID
								}else{//没有查到准确的父设备
									errorInfo += i+1+ getI18nText("i18n_DeviceBrandManageAction.saveDevicesByExcel.errorInfo20_n81i");
									errorParDeviceTypeCodeString=String.valueOf((int)cell_5.getNumericCellValue());
								}
							}
						}else{
							errorInfo += i+1+ getI18nText("i18n_DeviceBrandManageAction.saveDevicesByExcel.errorInfo21_n81i");
						}
						
						//图片类型figureType
						if (null == cell_6||cell_6.getCellType()==Cell.CELL_TYPE_BLANK) {
						} else if (cell_6.getCellType() == Cell.CELL_TYPE_STRING) {
							deviceTypeInfo.setFigureType(cell_6.getStringCellValue().trim());
						} else{
							errorInfo += i+1 + getI18nText("i18n_DeviceBrandManageAction.saveDevicesByExcel.errorInfo22_n81i");
						}
						
						//X坐标figureX
						if (null == cell_7||cell_7.getCellType()==Cell.CELL_TYPE_BLANK) {
						} else if (cell_7.getCellType() == Cell.CELL_TYPE_NUMERIC) {
							deviceTypeInfo.setFigureX((long) cell_7.getNumericCellValue());
						} else{
							errorInfo += i+1 + getI18nText("i18n_DeviceBrandManageAction.saveDevicesByExcel.errorInfo23_n81i");
						}
						
						//Y坐标figureY
						if (null == cell_8||cell_8.getCellType()==Cell.CELL_TYPE_BLANK) {
						} else if (cell_8.getCellType() == Cell.CELL_TYPE_NUMERIC) {
							deviceTypeInfo.setFigureY((long) cell_8.getNumericCellValue());
						} else{
							errorInfo += i+1 + getI18nText("i18n_DeviceBrandManageAction.saveDevicesByExcel.errorInfo24_n81i");
						}
						
						//宽figureWidth
						if (null == cell_9||cell_9.getCellType()==Cell.CELL_TYPE_BLANK) {
						} else if (cell_9.getCellType() == Cell.CELL_TYPE_NUMERIC) {
							deviceTypeInfo.setFigureWidth((long) cell_9.getNumericCellValue());
						} else{
							errorInfo += i+1 + getI18nText("i18n_DeviceBrandManageAction.saveDevicesByExcel.errorInfo25_n81i");
						}
						
						//高figureHeight
						if (null == cell_10||cell_10.getCellType()==Cell.CELL_TYPE_BLANK) {
						} else if (cell_10.getCellType() == Cell.CELL_TYPE_NUMERIC) {
							deviceTypeInfo.setFigureHeight((long) cell_10.getNumericCellValue());
						} else{
							errorInfo += i+1 + getI18nText("i18n_DeviceBrandManageAction.saveDevicesByExcel.errorInfo26_n81i");
						}
						
						//边颜色figureStroke
						if (null == cell_11||cell_11.getCellType()==Cell.CELL_TYPE_BLANK) {
						} else if (cell_11.getCellType() == Cell.CELL_TYPE_STRING) {
							deviceTypeInfo.setFigureStroke(cell_11.getStringCellValue().trim());
						} else if (cell_11.getCellType() == Cell.CELL_TYPE_NUMERIC) {
							deviceTypeInfo.setFigureStroke(String.valueOf((int) cell_11.getNumericCellValue()));
						} else{
							errorInfo += i+1 + getI18nText("i18n_DeviceBrandManageAction.saveDevicesByExcel.errorInfo27_n81i");
						}
						
						//边宽figureStrokeWidth
						if (null == cell_12||cell_12.getCellType()==Cell.CELL_TYPE_BLANK) {
						} else if (cell_12.getCellType() == Cell.CELL_TYPE_NUMERIC) {
							deviceTypeInfo.setFigureStrokeWidth((long) cell_12.getNumericCellValue());
						} else{
							errorInfo += i+1 + getI18nText("i18n_DeviceBrandManageAction.saveDevicesByExcel.errorInfo28_n81i");
						}
						
						//图片名称（必填）figureFill
						if (null == cell_13) {
							errorInfo += i+1 + getI18nText("i18n_DeviceBrandManageAction.saveDevicesByExcel.errorInfo29_n81i");
						} else if (cell_13.getCellType() == Cell.CELL_TYPE_STRING) {
							if ("".equals(cell_13.getStringCellValue())) {
								errorInfo += i+1 + getI18nText("i18n_DeviceBrandManageAction.saveDevicesByExcel.errorInfo29_n81i");
							} else {
								deviceTypeInfo.setFigureFill(cell_13.getStringCellValue().trim());
							}
						}else {
							errorInfo += i+1 + getI18nText("i18n_DeviceBrandManageAction.saveDevicesByExcel.errorInfo30_n81i");
						}
						
						//命名格式（[Y]:代表设备本身在父设备的位置，[X]:代表父设备在祖父设备的位置）nameFormat
						if (null == cell_14||cell_14.getCellType()==Cell.CELL_TYPE_BLANK) {
						} else if (cell_14.getCellType() == Cell.CELL_TYPE_STRING) {
							deviceTypeInfo.setNameFormat(cell_14.getStringCellValue().trim());
						}else {
							errorInfo += i+1 + getI18nText("i18n_DeviceBrandManageAction.saveDevicesByExcel.errorInfo31_n81i");
						}												
						//监测类别表diTableName
						if (null == cell_15||cell_15.getCellType()==Cell.CELL_TYPE_BLANK) {
						} else if (cell_15.getCellType() == Cell.CELL_TYPE_STRING) {
							deviceTypeInfo.setDiTableName(cell_15.getStringCellValue().trim());
						}else {
							errorInfo += i+1 + getI18nText("i18n_DeviceBrandManageAction.saveDevicesByExcel.errorInfo43_n81i");
						}
						
						//连接字段indexFiled
						if (null == cell_16||cell_16.getCellType()==Cell.CELL_TYPE_BLANK) {
						} else if (cell_16.getCellType() == Cell.CELL_TYPE_STRING) {
							deviceTypeInfo.setIndexFiled(cell_16.getStringCellValue().trim());
						}else {
							errorInfo += i+1 +getI18nText("i18n_DeviceBrandManageAction.saveDevicesByExcel.errorInfo47_n81i");
						}
						
						//状态字段statusFiled
						if (null == cell_17||cell_17.getCellType()==Cell.CELL_TYPE_BLANK) {
						} else if (cell_17.getCellType() == Cell.CELL_TYPE_STRING) {
							deviceTypeInfo.setStatusFiled(cell_17.getStringCellValue().trim());
						}else {
							errorInfo += i+1 + getI18nText("i18n_DeviceBrandManageAction.saveDevicesByExcel.errorInfo48_n81i");
						}
						
						//异常比较符(>,<,=)statusSymbols
						if (null == cell_18||cell_18.getCellType()==Cell.CELL_TYPE_BLANK) {
						} else if (cell_18.getCellType() == Cell.CELL_TYPE_STRING) {
							deviceTypeInfo.setStatusSymbols(cell_18.getStringCellValue().trim());
						}else {
							errorInfo += i+1 + getI18nText("i18n_DeviceBrandManageAction.saveDevicesByExcel.errorInfo49_n81i");
						}
						
						//异常比较值statusValue
						if (null == cell_19||cell_19.getCellType()==Cell.CELL_TYPE_BLANK) {
						} else if (cell_19.getCellType() == Cell.CELL_TYPE_STRING) {
							deviceTypeInfo.setStatusValue(cell_19.getStringCellValue().trim());
						} else if (cell_19.getCellType() == Cell.CELL_TYPE_NUMERIC) {
							deviceTypeInfo.setStatusValue(String.valueOf(cell_19.getNumericCellValue()));
						}else {
							errorInfo += i+1 +getI18nText("i18n_DeviceBrandManageAction.saveDevicesByExcel.errorInfo50_n81i");
						}
						
						//图形级别showLevel
						if (null == cell_20||cell_20.getCellType()==Cell.CELL_TYPE_BLANK) {
						}else if (cell_20.getCellType() == Cell.CELL_TYPE_NUMERIC) {
							deviceTypeInfo.setShowLevel((long)cell_20.getNumericCellValue());
						}else {
							errorInfo += i+1 + getI18nText("i18n_DeviceBrandManageAction.saveDevicesByExcel.errorInfo44_n81i");
						}
						
						//是否有链接isLink
						if (null == cell_21||cell_21.getCellType()==Cell.CELL_TYPE_BLANK) {
						}else if (cell_21.getCellType() == Cell.CELL_TYPE_NUMERIC) {
							deviceTypeInfo.setIsLink((long)cell_21.getNumericCellValue());
						}else {
							errorInfo += i+1 + getI18nText("i18n_DeviceBrandManageAction.saveDevicesByExcel.errorInfo52_n81i");
						}
						
						//是否叶子设备（必填，1是，0否）isLeaf
						if (null == cell_22||cell_22.getCellType()==Cell.CELL_TYPE_BLANK) {
							errorInfo += i+1 + getI18nText("i18n_DeviceBrandManageAction.saveDevicesByExcel.errorInfo53_n81i");
						} else if(cell_22.getCellType() == Cell.CELL_TYPE_NUMERIC){
							deviceTypeInfo.setIsLeaf((long) cell_22.getNumericCellValue());
						} else {
							errorInfo += i+1 + getI18nText("i18n_DeviceBrandManageAction.saveDevicesByExcel.errorInfo45_n81i");
						}
						
						//设备最大叠加数（整形数值，默认为1）maxDeviceNum
						if (null == cell_23||cell_23.getCellType()==Cell.CELL_TYPE_BLANK) {
						} else if(cell_23.getCellType() == Cell.CELL_TYPE_NUMERIC){
							deviceTypeInfo.setMaxDeviceNum((long) cell_23.getNumericCellValue());
						} else {
							errorInfo += i+1 + getI18nText("i18n_DeviceBrandManageAction.saveDevicesByExcel.errorInfo46_n81i");
						}
						if ("".equals(errorInfo)) {// 保存主机架							
							//deviceTypeInfo.setDiTableName("DI_SYSTEM");
							errorInfo = this.saveNodeType(deviceTypeInfo);
						}
						if ("".equals(errorInfo)) {
							count++;
						} else {
							if(deviceTypeInfo.getDeviceTypeCode()==null){
								errorList.add("");
							}else{
								errorList.add(deviceTypeInfo.getDeviceTypeCode());
							}
							if(deviceTypeInfo.getDeviceRandCode()==null){
								errorList.add("");
							}else{
								errorList.add(deviceTypeInfo.getDeviceRandCode());
							}
							if(deviceTypeInfo.getDeviceDesc()==null){
								errorList.add("");
							}else{
								errorList.add(deviceTypeInfo.getDeviceDesc());
							}
							if(deviceTypeInfo.getShowIndex()==null){
								errorList.add("");
							}else{
								errorList.add(deviceTypeInfo.getShowIndex().toString());
							}						
							if(deviceTypeInfo.getPid()==null){
								errorList.add("");
							}else{
								errorList.add(errorParDeviceTypeCodeString);
							}
							if(deviceTypeInfo.getFigureType()==null){
								errorList.add("");
							}else{
								errorList.add(deviceTypeInfo.getFigureType());
							}
							if(deviceTypeInfo.getFigureX()==null){
								errorList.add("");
							}else{
								errorList.add(deviceTypeInfo.getFigureX().toString());
							}
							if(deviceTypeInfo.getFigureY()==null){
								errorList.add("");
							}else{
								errorList.add(deviceTypeInfo.getFigureY().toString());
							}
							if(deviceTypeInfo.getFigureWidth()==null){
								errorList.add("");
							}else{
								errorList.add(deviceTypeInfo.getFigureWidth().toString());
							}						
							if(deviceTypeInfo.getFigureHeight()==null){
								errorList.add("");
							}else{
								errorList.add(deviceTypeInfo.getFigureHeight().toString());
							}						
							if(deviceTypeInfo.getFigureStroke()==null){
								errorList.add("");
							}else{
								errorList.add(deviceTypeInfo.getFigureStroke());
							}
							if(deviceTypeInfo.getFigureStrokeWidth()==null){
								errorList.add("");
							}else{
								errorList.add(deviceTypeInfo.getFigureStrokeWidth().toString());
							}
							if(deviceTypeInfo.getFigureFill()==null){
								errorList.add("");
							}else{
								errorList.add(deviceTypeInfo.getFigureFill());
							}
							if(deviceTypeInfo.getNameFormat()==null){
								errorList.add("");
							}else{
								errorList.add(deviceTypeInfo.getNameFormat());
							}
							if(deviceTypeInfo.getDiTableName()==null){
								errorList.add("");
							}else{
								errorList.add(deviceTypeInfo.getDiTableName());
							}
							if(deviceTypeInfo.getIndexFiled()==null){
								errorList.add("");
							}else{
								errorList.add(deviceTypeInfo.getIndexFiled());
							}
							if(deviceTypeInfo.getStatusFiled()==null){
								errorList.add("");
							}else{
								errorList.add(deviceTypeInfo.getStatusFiled());
							}
							if(deviceTypeInfo.getStatusSymbols()==null){
								errorList.add("");
							}else{
								errorList.add(deviceTypeInfo.getStatusSymbols());
							}
							if(deviceTypeInfo.getStatusValue()==null){
								errorList.add("");
							}else{
								errorList.add(deviceTypeInfo.getStatusValue());
							}
							if(deviceTypeInfo.getShowLevel()==null){
								errorList.add("");
							}else{
								errorList.add(deviceTypeInfo.getShowLevel().toString());
							}
							if(deviceTypeInfo.getIsLink()==null){
								errorList.add("");
							}else{
								errorList.add(deviceTypeInfo.getIsLink().toString());
							}
							if(deviceTypeInfo.getIsLeaf()==null){
								errorList.add("");
							}else{
								errorList.add(deviceTypeInfo.getIsLeaf().toString());
							}
							if(deviceTypeInfo.getMaxDeviceNum()==null){
								errorList.add("");
							}else{
								errorList.add(deviceTypeInfo.getMaxDeviceNum().toString());
							}
							errorList.add(errorInfo);
							rowList.add(errorList);
							errorInfo = "";
						}
					}
				}
				
			}
			headerList.add(sheetFlag+getI18nText("i18n_DeviceBrandManageAction.saveDevicesByExcel.brand_n81i"));
			headerList.add(getI18nText("i18n_DeviceBrandManageAction.downloadExampleType.brandBelong_n81i"));
			headerList.add(getI18nText("i18n_DeviceBrandManageAction.downloadExampleType.deviceDesc_n81i"));
			headerList.add(getI18nText("i18n_DeviceBrandManageAction.downloadExampleType.positionId_n81i"));
			headerList.add(getI18nText("i18n_DeviceBrandManageAction.downloadExampleType.parentDeviceType_n81i"));
			headerList.add(getI18nText("i18n_DeviceBrandManageAction.downloadExampleType.pictureType_n81i"));
			headerList.add(getI18nText("i18n_DeviceBrandManageAction.downloadExampleType.XHeight_n81i"));
			headerList.add(getI18nText("i18n_DeviceBrandManageAction.downloadExampleType.YWeith_n81i"));
			headerList.add(getI18nText("i18n_DeviceBrandManageAction.downloadExampleType.weith_n81i"));
			headerList.add(getI18nText("i18n_DeviceBrandManageAction.downloadExampleType.height_n81i"));
			headerList.add(getI18nText("i18n_DeviceBrandManageAction.downloadExampleType.lineColor_n81i"));
			headerList.add(getI18nText("i18n_DeviceBrandManageAction.downloadExampleType.lineWeith_n81i"));
			headerList.add(getI18nText("i18n_DeviceBrandManageAction.downloadExampleType.pictureName_n81i"));
			headerList.add(getI18nText("i18n_DeviceBrandManageAction.downloadExampleType.nameFormat_n81i"));
			headerList.add(getI18nText("i18n_DeviceBrandManageAction.downloadExampleType.detecateTypeTable_n81i"));
			headerList.add(getI18nText("i18n_DeviceBrandManageAction.downloadExampleType.linkField_n81i"));
			headerList.add(getI18nText("i18n_DeviceBrandManageAction.downloadExampleType.stateField_n81i"));
			headerList.add(getI18nText("i18n_DeviceBrandManageAction.downloadExampleType.exceptionCompare_n81i"));
			headerList.add(getI18nText("i18n_DeviceBrandManageAction.downloadExampleType.exceptionCompareValue_n81i"));
			headerList.add(getI18nText("i18n_DeviceBrandManageAction.downloadExampleType.pictureLevel_n81i"));
			headerList.add(getI18nText("i18n_DeviceBrandManageAction.downloadExampleType.isLinked_n81i"));
			headerList.add(getI18nText("i18n_DeviceBrandManageAction.downloadExampleType.isLeafDevice_n81i"));
			headerList.add(getI18nText("i18n_DeviceBrandManageAction.downloadExampleType.maxNum_n81i"));
			headerList.add(getI18nText("i18n_DeviceBrandManageAction.downloadExampleType.errorInfo_n81i"));
				flag[0]=count;
				flag[1]=sum;
		}
			return flag;
	}
	/*
	 * 通过Excel新增设备。
	 * Excel列：品牌，主机架，板槽，板卡，端口
	 * 同时对应的关系必须导入。导入成功后能在特种设备配置中正确显示
	 * 品牌为空的时候不导入品牌
	 * 主机架导入时父设备为空，品牌必须在库中存在。
	 * 板槽父设备为主机架，如果对应主机架不存在，则不录入。
	 * 板卡跟板槽为多对多关系，父设备为主机架（主控板位置比较特殊，不能随意指定）
	 * 板卡跟端口为父子关系
	 * device_brand_type表为主机架跟板子的关系
	 * 板槽板卡关系表device_boardsolt_board
	 * 导入时首先应当确定板子跟主机架的关系，如果板子对应的主机架不存在，给予错误提示
	 * 导入完成主机架跟板子的关系以后，导入板子跟板槽的对应关系。特殊的板子如主控板，在这里控制关系
	 * wx
	 */
	public String impDevicesByExcel(){
		String errorInfo = "";
		try {
			//品牌
			List<String> headerList = new ArrayList<String>();
			List<List<String>> rowList = new ArrayList<List<String>>();
			//主机架
			List<String> headerList1 = new ArrayList<String>();
			List<List<String>> rowList1 = new ArrayList<List<String>>();
			//板槽
			List<String> headerList2 = new ArrayList<String>();
			List<List<String>> rowList2 = new ArrayList<List<String>>();
			//板卡
			List<String> headerList3 = new ArrayList<String>();
			List<List<String>> rowList3 = new ArrayList<List<String>>();
			//端口
			List<String> headerList4 = new ArrayList<String>();
			List<List<String>> rowList4 = new ArrayList<List<String>>();
			//板卡与主机架关系
			List<String> headerList5 = new ArrayList<String>();
			List<List<String>> rowList5 = new ArrayList<List<String>>();
			//板槽与板卡对应关系
			List<String> headerList6 = new ArrayList<String>();
			List<List<String>> rowList6 = new ArrayList<List<String>>();

			Workbook workbook = null;
			if (myFileFileName.endsWith(".xlsx")) {
				workbook = new XSSFWorkbook(new FileInputStream(myFile));
			} else {
				// 创建对Excel工作簿文件的引用
				workbook = new HSSFWorkbook(new FileInputStream(myFile));
			}
			// 创建对工作表的引用，得到表的第一页，也就是品牌
			Sheet sheet = workbook.getSheetAt(0);
			// 记录存储数据条数
			int count = 0;
			// 记录读入excel数据条数
			int sum = (sheet.getLastRowNum());
			if(sheet.getLastRowNum()>=1){//有的时候不会录入品牌
				for (short i = 1; i <= sheet.getLastRowNum(); i++) {
					String deviceRandCode="";
					String deviceRandName="";
					String deviceBrandDesc="";
					List<String> errorList = new ArrayList<String>();
					Row row = sheet.getRow(i);
					Cell cell_1 = row.getCell((short) 0);
					Cell cell_2 = row.getCell((short) 1);
					Cell cell_3 = row.getCell((short) 2);
					if((null == cell_1 ||3==cell_1.getCellType()) 
							&&(null == cell_2 ||3==cell_2.getCellType()) 
							&&(null == cell_3 ||3==cell_3.getCellType())){
						sum--;
					}else {
						// 品牌编号(必填)
						if (null == cell_1) {
							errorInfo +=  getI18nText("i18n_DeviceBrandManageAction.impDevicesByExcel.errorInfo1_n81i",i+"");
						} else if (cell_1.getCellType() == Cell.CELL_TYPE_STRING) {
							if ("".equals(cell_1.getStringCellValue())) {
								errorInfo +=  getI18nText("i18n_DeviceBrandManageAction.impDevicesByExcel.errorInfo1_n81i",i+"");
							} else {
								deviceRandCode = cell_1.getStringCellValue().trim();
							}
						}else if(cell_1.getCellType() == Cell.CELL_TYPE_NUMERIC){
							deviceRandCode =String.valueOf((int) cell_1.getNumericCellValue());
						} else {
							errorInfo +=  getI18nText("i18n_DeviceBrandManageAction.impDevicesByExcel.errorInfo3_n81i",i+"");
						}

						// 品牌名称(必填)
						if (null == cell_2) {
							errorInfo +=  getI18nText("i18n_DeviceBrandManageAction.impDevicesByExcel.errorInfo4_n81i",i+"");
						} else if (cell_2.getCellType() == Cell.CELL_TYPE_STRING) {
							if ("".equals(cell_2.getStringCellValue())) {
								errorInfo +=  getI18nText("i18n_DeviceBrandManageAction.impDevicesByExcel.errorInfo4_n81i",i+"");
							} else {
								deviceRandName = cell_2.getStringCellValue().trim();
							}
						} else if(cell_2.getCellType() == Cell.CELL_TYPE_NUMERIC){
							deviceRandName =String.valueOf((int) cell_2.getNumericCellValue());
						} else{
							errorInfo +=  getI18nText("i18n_DeviceBrandManageAction.impDevicesByExcel.errorInfo5_n81i",i+"");
						}					
						// 品牌描述 
						if(null == cell_3 || cell_3.getCellType()==Cell.CELL_TYPE_BLANK){
						}else if (cell_3.getCellType() == Cell.CELL_TYPE_STRING) {
							deviceBrandDesc = cell_3.getStringCellValue().trim();
						} else if(cell_3.getCellType() == Cell.CELL_TYPE_NUMERIC){
							deviceBrandDesc =String.valueOf((int) cell_3.getNumericCellValue());
						} else {
							errorInfo +=  getI18nText("i18n_DeviceBrandManageAction.impDevicesByExcel.errorInfo2_n81i",i+"");
						}
						
						if ("".equals(errorInfo)) {// 保存节点
							errorInfo = this.saveNode(deviceRandCode, deviceRandName,deviceBrandDesc );
						}
						if ("".equals(errorInfo)) {
							count++;
						} else {
							errorList.add(deviceRandCode);
							errorList.add(deviceRandName);
							errorList.add(deviceBrandDesc);
							errorList.add(errorInfo);
							rowList.add(errorList);
							errorInfo = "";

						}
					}
				}
				
			}
			headerList.add(getI18nText("i18n_DeviceBrandManageAction.emportCurrentXls.title.brandId_n81i"));
			headerList.add(getI18nText("i18n_DeviceBrandManageAction.emportCurrentXls.title.brandName_n81i"));
			headerList.add(getI18nText("i18n_DeviceBrandManageAction.emportCurrentXls.title.brandDesc_n81i"));
			headerList.add(getI18nText("i18n_DeviceBrandManageAction.downloadExampleType.errorInfo_n81i"));	
			/*
			 * sheet1到4内容基本类似，都是登记设备的型号，都在同一个表中，只是父子关系需要改变
			 */							
			// 创建对工作表的引用，得到表的第二页，主机架
			Sheet sheet1 = workbook.getSheetAt(1);
			int [] flag1=saveDevicesByExcel("mainframe", sheet1,errorInfo,headerList1, rowList1);				
			// 创建对工作表的引用，得到表的第三页 板槽
			Sheet sheet2 = workbook.getSheetAt(2);
			int [] flag2=saveDevicesByExcel("boardSlot", sheet2,errorInfo,headerList2, rowList2);				
			// 创建对工作表的引用，得到表的第四页
			Sheet sheet3 = workbook.getSheetAt(3);
			int [] flag3=saveDevicesByExcel("board", sheet3,errorInfo,headerList3, rowList3);				
			// 创建对工作表的引用，得到表的第五页
			Sheet sheet4 = workbook.getSheetAt(4);
			int [] flag4=saveDevicesByExcel("port", sheet4,errorInfo,headerList4, rowList4);	
			// 创建对工作表的引用，得到表的第六页
			Sheet sheet5 = workbook.getSheetAt(5);
			// 读取左上端单元

			// 记录存储数据条数
			int count1 = 0;
			// 记录读入excel数据条数
			int sum1 = (sheet5.getLastRowNum());
			for (short i = 1; i <= sheet5.getLastRowNum(); i++) {
				DeviceBrandType deviceBrandType = new DeviceBrandType();
				List<String> errorList = new ArrayList<String>();
				Row row = sheet5.getRow(i);
				Cell cell_1 = row.getCell((short) 0);
				Cell cell_2 = row.getCell((short) 1);
				Cell cell_3 = row.getCell((short) 2);
				if((null == cell_1 ||3==cell_1.getCellType()) 
						&&(null == cell_2 ||3==cell_2.getCellType()) 
						&&(null == cell_3 ||3==cell_3.getCellType())){
					sum1--;
				}else {
					//设备品牌代码（必填）
					if (null == cell_1||cell_1.getCellType()==Cell.CELL_TYPE_BLANK) {
						errorInfo +=  getI18nText("i18n_DeviceBrandManageAction.impDevicesByExcel.errorInfo6_n81i",i+"");
					} else if (cell_1.getCellType() == Cell.CELL_TYPE_STRING) {
						if ("".equals(cell_1.getStringCellValue())) {
							errorInfo +=  getI18nText("i18n_DeviceBrandManageAction.impDevicesByExcel.errorInfo6_n81i",i+"");
						} else {
							deviceBrandType.setDeviceBrandCode(cell_1.getStringCellValue().trim());
						}
					}else if(cell_1.getCellType() == Cell.CELL_TYPE_NUMERIC){
						deviceBrandType.setDeviceBrandCode(String.valueOf((int) cell_1.getNumericCellValue()));
					} else {
						errorInfo +=  getI18nText("i18n_DeviceBrandManageAction.impDevicesByExcel.errorInfo7_n81i",i+"");
					}

					//设备型号（必填）
					if (null == cell_2||cell_2.getCellType()==Cell.CELL_TYPE_BLANK) {
						errorInfo +=  getI18nText("i18n_DeviceBrandManageAction.impDevicesByExcel.errorInfo6_n81i",i+"");
					} else if (cell_2.getCellType() == Cell.CELL_TYPE_STRING) {
						if ("".equals(cell_2.getStringCellValue())) {
							errorInfo +=  getI18nText("i18n_DeviceBrandManageAction.impDevicesByExcel.errorInfo6_n81i",i+"");
						} else {
							deviceBrandType.setParDeviceTypeCode(cell_2.getStringCellValue().trim());
						}
					} else if(cell_2.getCellType() == Cell.CELL_TYPE_NUMERIC){
						deviceBrandType.setParDeviceTypeCode(String.valueOf((int) cell_2.getNumericCellValue()));
					} else{
						errorInfo +=  getI18nText("i18n_DeviceBrandManageAction.impDevicesByExcel.errorInfo7_n81i",i+"");
					}

					//可配父设备（必填）
					if(null == cell_3 || cell_3.getCellType()==Cell.CELL_TYPE_BLANK){
						errorInfo +=  getI18nText("i18n_DeviceBrandManageAction.impDevicesByExcel.errorInfo8_n81i",i+"");
					}else if(cell_3.getCellType() == Cell.CELL_TYPE_NUMERIC){
						deviceBrandType.setSubDeviceTypeCode(String.valueOf((int)cell_3.getNumericCellValue()));
					}else if (cell_3.getCellType() == Cell.CELL_TYPE_STRING) {
						if ("".equals(cell_3.getStringCellValue())) {
							errorInfo +=  getI18nText("i18n_DeviceBrandManageAction.impDevicesByExcel.errorInfo8_n81i",i+"");
						} else {
							deviceBrandType.setSubDeviceTypeCode(cell_3.getStringCellValue().trim());
						}
					} else {
						errorInfo +=  getI18nText("i18n_DeviceBrandManageAction.impDevicesByExcel.errorInfo9_n81i",i+"");
					}
					
					if ("".equals(errorInfo)) {// 保存节点
						errorInfo = this.saveNodeBrandType(deviceBrandType);
					}
					if ("".equals(errorInfo)) {
						count1++;
					} else {
						if(deviceBrandType.getDeviceBrandCode()==null){
							errorList.add("");
						}else{
							errorList.add(deviceBrandType.getDeviceBrandCode());
						}
						if(deviceBrandType.getParDeviceTypeCode()==null){
							errorList.add("");
						}else{
							errorList.add(deviceBrandType.getParDeviceTypeCode());
						}
						if(deviceBrandType.getSubDeviceTypeCode()==null){
							errorList.add("");
						}else{
							errorList.add(deviceBrandType.getSubDeviceTypeCode());
						}						
						errorList.add(errorInfo);
						rowList5.add(errorList);
						errorInfo = "";

					}
				}
				
			}
			headerList5.add(getI18nText("i18n_DeviceBrandManageAction.impDevicesByExcel.deviceBrandCode_n81i"));
			headerList5.add(getI18nText("i18n_DeviceBrandManageAction.impDevicesByExcel.kepeizhujijia_n81i"));
			headerList5.add(getI18nText("i18n_DeviceBrandManageAction.impDevicesByExcel.boardBrand_n81i"));
			headerList5.add(getI18nText("i18n_DeviceBrandManageAction.downloadExampleType.errorInfo_n81i"));
			// 创建对工作表的引用，得到表的第七页
			Sheet sheet6 = workbook.getSheetAt(6);
			
			// 记录存储数据条数
			int count2 = 0;
			// 记录读入excel数据条数
			int sum2 = (sheet6.getLastRowNum());
			for (short i = 1; i <= sheet6.getLastRowNum(); i++) {
				String deviceBrandCode="";//品牌code
				String deviceBoardSoltCode="";//槽位code
				String deviceBoardCode="";//板卡code
				String deviceTypeCode="";//主机架型号
				List<String> errorList = new ArrayList<String>();
				Row row = sheet6.getRow(i);
				Cell cell_1 = row.getCell((short) 0);
				Cell cell_2 = row.getCell((short) 1);
				Cell cell_3 = row.getCell((short) 2);
				Cell cell_4 = row.getCell((short) 3);
				if((null == cell_1 ||3==cell_1.getCellType()) 
						&&(null == cell_2 ||3==cell_2.getCellType()) 
						&&(null == cell_3 ||3==cell_3.getCellType())
						&&(null == cell_4 ||3==cell_4.getCellType())){
					sum2--;
				}else {
					//设备品牌代码（必填）
					if (null == cell_1||cell_1.getCellType()==Cell.CELL_TYPE_BLANK) {
						errorInfo +=  getI18nText("i18n_DeviceBrandManageAction.impDevicesByExcel.errorInfo6_n81i",i+"");
					} else if (cell_1.getCellType() == Cell.CELL_TYPE_STRING) {
						if ("".equals(cell_1.getStringCellValue())) {
							errorInfo +=  getI18nText("i18n_DeviceBrandManageAction.impDevicesByExcel.errorInfo6_n81i",i+"");
						} else {
							deviceBrandCode=cell_1.getStringCellValue().trim();
						}
					}else if(cell_1.getCellType() == Cell.CELL_TYPE_NUMERIC){
						deviceBrandCode=String.valueOf((int) cell_1.getNumericCellValue());
					} else {
						errorInfo +=  getI18nText("i18n_DeviceBrandManageAction.impDevicesByExcel.errorInfo7_n81i",i+"");
					}

					//槽位型号型号（必填）
					if (null == cell_2||cell_2.getCellType()==Cell.CELL_TYPE_BLANK) {
						errorInfo +=  getI18nText("i18n_DeviceBrandManageAction.impDevicesByExcel.errorInfo8_n81i",i+"");
					} else if (cell_2.getCellType() == Cell.CELL_TYPE_STRING) {
						if ("".equals(cell_2.getStringCellValue())) {
							errorInfo +=  getI18nText("i18n_DeviceBrandManageAction.impDevicesByExcel.errorInfo8_n81i",i+"");
						} else {
							deviceBoardSoltCode=cell_2.getStringCellValue().trim();
						}
					} else if(cell_2.getCellType() == Cell.CELL_TYPE_NUMERIC){
						deviceBoardSoltCode=String.valueOf((int) cell_2.getNumericCellValue());
					} else{
						errorInfo +=  getI18nText("i18n_DeviceBrandManageAction.impDevicesByExcel.errorInfo9_n81i",i+"");
					}

					//板卡型号（必填）
					if(null == cell_3 || cell_3.getCellType()==Cell.CELL_TYPE_BLANK){
						errorInfo +=  getI18nText("i18n_DeviceBrandManageAction.impDevicesByExcel.errorInfo10_n81i",i+"");
					}else if(cell_3.getCellType() == Cell.CELL_TYPE_NUMERIC){
						deviceBoardCode=String.valueOf((int)cell_3.getNumericCellValue());
					}else if (cell_3.getCellType() == Cell.CELL_TYPE_STRING) {
						if ("".equals(cell_3.getStringCellValue())) {
							errorInfo +=  getI18nText("i18n_DeviceBrandManageAction.impDevicesByExcel.errorInfo10_n81i",i+"");
						} else {
							deviceBoardCode=cell_3.getStringCellValue().trim();
						}
					} else {
						errorInfo +=  getI18nText("i18n_DeviceBrandManageAction.impDevicesByExcel.errorInfo11_n81i",i+"");
					}
					//主机架型号（必填）
					if(null == cell_4 || cell_4.getCellType()==Cell.CELL_TYPE_BLANK){
						errorInfo +=  getI18nText("i18n_DeviceBrandManageAction.impDevicesByExcel.errorInfo12_n81i",i+"");
					}else if(cell_4.getCellType() == Cell.CELL_TYPE_NUMERIC){
						deviceTypeCode=String.valueOf((int)cell_4.getNumericCellValue());
					}else if (cell_4.getCellType() == Cell.CELL_TYPE_STRING) {
						if ("".equals(cell_4.getStringCellValue())) {
							errorInfo +=  getI18nText("i18n_DeviceBrandManageAction.impDevicesByExcel.errorInfo12_n81i",i+"");
						} else {
							deviceTypeCode=cell_4.getStringCellValue().trim();
						}
					} else {
						errorInfo +=  getI18nText("i18n_DeviceBrandManageAction.impDevicesByExcel.errorInfo13_n81i",i+"");
					}
					if ("".equals(errorInfo)) {// 保存节点						
						errorInfo = this.saveBoardAndBoardSold(deviceBrandCode,deviceBoardSoltCode,deviceBoardCode,deviceTypeCode);
					}
					if ("".equals(errorInfo)) {
						count2++;
					} else {
						if("".equals(deviceBrandCode)){
							errorList.add("");
						}else{
							errorList.add(deviceBrandCode);
						}
						if("".equals(deviceBoardSoltCode)){
							errorList.add("");
						}else{
							errorList.add(deviceBoardSoltCode);
						}
						if("".equals(deviceBoardSoltCode)){
							errorList.add("");
						}else{
							errorList.add(deviceBoardSoltCode);
						}						
						if("".equals(deviceTypeCode)){
							errorList.add("");
						}else{
							errorList.add(deviceTypeCode);
						}						
						errorList.add(errorInfo);
						rowList6.add(errorList);
						errorInfo = "";

					}
				}
				
			}
			headerList6.add(getI18nText("i18n_DeviceBrandManageAction.impDevicesByExcel.deviceBrandCode_n81i"));
			headerList6.add(getI18nText("i18n_DeviceBrandManageAction.impDevicesByExcel.slotBrand_n81i"));
			headerList6.add(getI18nText("i18n_DeviceBrandManageAction.impDevicesByExcel.boardBrand_n81i"));
			headerList6.add(getI18nText("i18n_DeviceBrandManageAction.impDevicesByExcel.mainFrameModel_n81i"));
			headerList6.add(getI18nText("i18n_DeviceBrandManageAction.downloadExampleType.errorInfo_n81i"));
			//品牌录入错误
			this.getRequest().setAttribute("rowList", rowList);
			this.getRequest().setAttribute("headerList", headerList);
			//主机架录入错误
			this.getRequest().setAttribute("rowList1", rowList1);
			this.getRequest().setAttribute("headerList1", headerList1);
			this.getRequest().setAttribute("errorTheme1", getI18nText("i18n_DeviceBrandManageAction.impDevicesByExcel.errorTheme1_n81i"));
			//板槽录入错误
			this.getRequest().setAttribute("rowList2", rowList2);
			this.getRequest().setAttribute("headerList2", headerList2);
			this.getRequest().setAttribute("errorTheme2", getI18nText("i18n_DeviceBrandManageAction.impDevicesByExcel.errorTheme2_n81i"));
			//板卡录入错误
			this.getRequest().setAttribute("rowList3", rowList3);
			this.getRequest().setAttribute("headerList3", headerList3);
			this.getRequest().setAttribute("errorTheme3", getI18nText("i18n_DeviceBrandManageAction.impDevicesByExcel.errorTheme3_n81i"));
			//端口录入错误
			this.getRequest().setAttribute("rowList4", rowList4);
			this.getRequest().setAttribute("headerList4", headerList4);
			this.getRequest().setAttribute("errorTheme4", getI18nText("i18n_DeviceBrandManageAction.impDevicesByExcel.errorTheme4_n81i"));
			//主机架板卡对应关系录入错误
			this.getRequest().setAttribute("rowList5", rowList5);
			this.getRequest().setAttribute("headerList5", headerList5);
			this.getRequest().setAttribute("errorTheme5", getI18nText("i18n_DeviceBrandManageAction.impDevicesByExcel.errorTheme5_n81i"));
			//板卡板槽对应关系录入错误
			this.getRequest().setAttribute("rowList6", rowList6);
			this.getRequest().setAttribute("headerList6", headerList6);
			this.getRequest().setAttribute("errorTheme6", getI18nText("i18n_DeviceBrandManageAction.impDevicesByExcel.errorTheme6_n81i"));
			if ((sum >0||sum1 > 0||sum2 > 0||flag1[1]>0||flag2[1]>0||flag3[1]>0||flag4[1]>0)&&count == sum &&count1 == sum1&&count2 == sum2&&flag1[0]==flag1[1]
					&&flag2[0]==flag2[1]&&flag3[0]==flag3[1]
					&&flag4[0]==flag4[1]) {
				outHtmlString("<script type=\"text/javascript\">alert('i18n_DeviceBrandManageAction.importXls.success_n81i');this.location='deviceBrandManage.do?action=queryDeviceTypeInfo'</script>");
				return null;
			} else if (sum == 0&&sum1 ==0&&sum2==0&&flag1[1]==0&&flag2[1]==0&&flag3[1]==0&&flag4[1]==0) {
				this.outHtmlString("<script>alert('i18n_DeviceBrandManageAction.importXls.selectFileIsNull_n81i！');history.back();</script>");
				return null;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "showError1";
	}
	/**保存板槽与主板主机架之间的关系
	 * deviceBrandCode 品牌，
	 * deviceBoardSoltCode 板槽
	 * deviceBoardCode 板卡
	 * deviceTypeCode 主机架
	 */
	private String saveBoardAndBoardSold(String deviceBrandCode,String deviceBoardSoltCode,String deviceBoardCode,String deviceTypeCode) {
		String desc = "";
		try {
			DeviceTypeInfo device=null;//主机架
			boolean b=false;//设备品牌代码是否存在于数据库
			boolean b1=false;//标志对应板卡是否存在于数据库
			boolean b2=false;//标志对应主机架是否存在于数据库
			boolean b3=false;//标志对应板槽是否存在于数据库
			//判断对应关系中的属性是否在库中
			List<DeviceBrandInfo> DeviceBrandInfolist = commonService.find("from DeviceBrandInfo where deviceRandCode=?",deviceBrandCode);
			if(DeviceBrandInfolist==null||DeviceBrandInfolist.size()==0){
				return getI18nText("i18n_DeviceBrandManageAction.downloadExampleType.deviceBrandCodeNotExists_n81i");
			}else{
				b=true;
			}
			
			List<DeviceTypeInfo> DeviceTypeInfolist = commonService.find("from DeviceTypeInfo where deviceTypeCode=?",deviceBoardSoltCode);
			if(DeviceTypeInfolist==null||DeviceTypeInfolist.size()==0){
				return getI18nText("i18n_DeviceBrandManageAction.impDevicesByExcel.slotBrandIsNull_n81i");
			}else {
				b3=true;
			}
			System.out.println(deviceBoardCode);
			DeviceTypeInfolist = commonService.find("from DeviceTypeInfo where deviceTypeCode=?",deviceBoardCode);
			if(DeviceTypeInfolist==null||DeviceTypeInfolist.size()==0){
				return getI18nText("i18n_DeviceBrandManageAction.impDevicesByExcel.boardBrandIsNull_n81i");
			}else {
				b1=true;				
			}
			DeviceTypeInfolist = commonService.find("from DeviceTypeInfo where deviceTypeCode=?",deviceTypeCode);
			if(DeviceTypeInfolist==null||DeviceTypeInfolist.size()==0){
				return getI18nText("i18n_DeviceBrandManageAction.impDevicesByExcel.zjjBrandIsNull_n81i");
			}else {
				b2=true;
				device=DeviceTypeInfolist.get(0);//获得该主机架型号
			}
			//判断板槽是否对应主机架
			if(b2&&b3&&device!=null){
				System.out.println("判断板槽与主机架是否对应");
				Object[] conditions=new Object[]{deviceBoardSoltCode,device.getId().toString()};
				DeviceTypeInfolist = commonService.find("from DeviceTypeInfo where deviceTypeCode=? and pid=?",conditions);
				if(DeviceTypeInfolist==null||DeviceTypeInfolist.size()==0){
					return getI18nText("i18n_DeviceBrandManageAction.impDevicesByExcel.zjjbdy_n81i");
				}
			}
			if(b&&b1&&b2){//主机架跟板卡都存在于数据库中时判断主机架跟板卡是否对应。在对应表中查找记录device_brand_type；	
				Object[] conditions=new Object[]{deviceBrandCode,deviceTypeCode,deviceBoardCode};
				DeviceTypeInfolist = commonService.find("from DeviceBrandType where deviceBrandCode=? and parDeviceTypeCode= ? and subDeviceTypeCode=?",conditions);
				if(DeviceTypeInfolist==null||DeviceTypeInfolist.size()==0){
					return getI18nText("i18n_DeviceBrandManageAction.impDevicesByExcel.brandZjjSoltBdy_n81i");
				}
			}
			

			List<DeviceBrandType> list = commonService.executeSQL("SELECT T.DEVICE_BRAND_CODE,T.DEVICE_BOARD_SOLT_CODE,T.DEVICE_BOARD_CODE,T.DEVICE_TYPE_CODE FROM DEVICE_BOARDSOLT_BOARD T  WHERE T.DEVICE_BRAND_CODE=? AND T.DEVICE_BOARD_SOLT_CODE=? AND T.DEVICE_BOARD_CODE=? AND T.DEVICE_TYPE_CODE=?",
					deviceBrandCode, deviceBoardSoltCode, deviceBoardCode, deviceTypeCode);
			if(list!=null&&list.size()>0){
				return getI18nText("i18n_DeviceBrandManageAction.impDevicesByExcel.slotBoardMapExists_n81i");
			}
			DeviceBoardsoltBoard deviceBoardsoltBoard=new DeviceBoardsoltBoard();
			deviceBoardsoltBoard.setDeviceBoardCode(deviceBoardCode);
			deviceBoardsoltBoard.setDeviceBoardSoltCode(deviceBoardSoltCode);
			deviceBoardsoltBoard.setDeviceBrandCode(deviceBrandCode);
			deviceBoardsoltBoard.setDeviceTypeCode(deviceTypeCode);
			commonService.save(deviceBoardsoltBoard);
		} catch (Exception e) {
			e.printStackTrace();
			desc = getI18nText("i18n_DeviceBrandManageAction.downloadExampleType.nodeInfoImportErr_n81i")+";";
		}
		return desc;
	}
	//新增槽位设备
	public void addPosDevType() {
		try {
			commonService.beginTransaction();
			if(devType!=null && StringUtils.isNotBlank(devType.getDeviceTypeCode())){
				Integer indexStart = devType.getShowIndexStart();
				Integer indexEnd = devType.getShowIndexEnd();
				if(indexStart!=null && indexEnd!=null ) {
					if(indexStart>indexEnd) {
						int tmp = indexStart;
						indexStart = indexEnd;
						indexEnd = tmp;
					}
					List<DeviceTypeInfo> devList = new ArrayList<DeviceTypeInfo>();
					for(int i=indexStart;i<=indexEnd;i++) {
						DeviceTypeInfo devTmp = new DeviceTypeInfo();
						Date date = new Date();
						devTmp.setAddTime(date);
						devTmp.setAddUserid(this.getUserID());
						devTmp.setLastUpdateTime(date);
						devTmp.setLastUpdateUserid(this.getUserID());
						
						devTmp.setDeviceTypeCode(devType.getDeviceTypeCode().trim()+linkStr+i);
						devTmp.setDeviceRandCode(devType.getDeviceRandCode().trim());
						devTmp.setDeviceDesc(devType.getDeviceDesc().trim()+linkStr+i);
						devTmp.setShowIndex(Long.parseLong(i+""));
						devTmp.setPid(devType.getPid());
						devTmp.setMaxDeviceNum(devType.getMaxDeviceNum());
						devTmp.setIsPositionDev(devType.getIsPositionDev());
						
						//x，y，width，height:空着
						devTmp.setFigureType("image");
						devTmp.setFigureStroke("red");
						devTmp.setFigureStrokeWidth(1l);
						
						devTmp.setStatusValue(devType.getStatusValue()!=null?devType.getStatusValue().trim():"");
						
						//showLevel,isLink,isLeaf
						devTmp.setIsLeaf(0l);//0:位置设备，1：非位置设备
						devTmp.setIsLink(0l);					
						
						//父设备修改为非叶子节点
						String pid = devType.getPid();
						if(StringUtils.isNotBlank(pid)) {		
							DeviceTypeInfo devTypeTmp = (DeviceTypeInfo)this.commonService.get(DeviceTypeInfo.class, Long.parseLong(pid));
							if(devTypeTmp.getIsLeaf()==1l){
								devTypeTmp.setIsLeaf(0l);
								this.commonService.update(devTypeTmp);							
							}
							
							if(devTypeTmp!=null && devTypeTmp.getShowLevel()!=null) {
								devTmp.setShowLevel(devTypeTmp.getShowLevel()+1);			
							}
						}
						
						devTmp.setHasInstance(0l);
						//nodefigureinfo表的nameflag不能为空，所以deviceTypeInfo表里默认的nameformat为deviceTypeCode
						if(StringUtils.isBlank(devType.getNameFormat())) {
							devType.setNameFormat(devType.getDeviceTypeCode());
						}else {
							devType.setNameFormat(devType.getNameFormat());
						}
						devList.add(devTmp);
					}
					this.commonService.saveOrUpdate(devList);
				}
				
				
				// 将添加操作写到操作日志中
				this.addDBOperationRpt(commonService, "DeviceTypeInfo", "INSERT",devType.getId());
				outHtmlString("<script type=\"text/javascript\">alert('i18n_DeviceBrandManageAction.importXls.success_n81i');this.location='deviceBrandManage.do?action=queryDeviceTypeInfo&devTypeCodeForSearch="+devTypeCodeForSearch+"&devRandCodeForSearch="+devRandCodeForSearch+"&parDevId="+parDevId+"'</script>");
			}else {
				outHtmlString("<script type=\"text/javascript\">alert('i18n_DeviceBrandManageAction.toConfDevPos.deviceBrandIsNotNull_n81i');window.history.go(-1);</script>");
			}
			commonService.commit();
		} catch (Exception e) {
			commonService.rollback();
			e.printStackTrace();
			outHtmlString("<script type=\"text/javascript\">alert('i18n_DeviceBrandManageAction.importXls.faild_n81i');this.location='deviceBrandManage.do?action=queryDeviceTypeInfo'</script>");
		}
	}
	
	//批量新增设备型号(一级设备没有批量新增，也不需要)：编号是一个范围，无最大叠加数，需要上传多个图片（图片和设备如何对应呢？？？）:批量插入多条
	public void addBatchDevType() {
		try {
			commonService.beginTransaction();
			if(devType!=null && StringUtils.isNotBlank(devType.getDeviceTypeCode())
					&& StringUtils.isNotBlank(devType.getPid())){
				//设备型号不能重复:不同品牌可以重复吗？
//				List list = this.commonService.find("from DeviceTypeInfo where deviceTypeCode='"+devType.getDeviceTypeCode().trim()+"' and deviceRandCode='"+devType.getDeviceRandCode()+"'");
//				if(list!=null && list.size()>0) {
////					outHtmlString("<script type=\"text/javascript\">alert('品牌编号已存在');this.location='deviceBrandManage.do?action=toAddDevBrand'</script>");
//					outHtmlString("<script type=\"text/javascript\">alert('设备型号已存在');window.history.go(-1);</script>");
//				}else {
					
				Integer indexStart = devType.getShowIndexStart();
				Integer indexEnd = devType.getShowIndexEnd();
				String showIndexRule = devType.getShowIndexRule();//端口编号的规则：0全部，1奇数，2偶数
				if(indexStart!=null && indexEnd!=null && indexStart<=indexEnd) {	
					List<DeviceTypeInfo> devList = new ArrayList<DeviceTypeInfo>();
					if("1".equals(showIndexRule) && indexStart%2==0) {//规则为奇数，当前值为偶数
						indexStart++;
					}else if("2".equals(showIndexRule) && indexStart%2==1) {//规则为偶数，当前值为奇数
						indexStart++;
					}
					for(int i=indexStart;i<=indexEnd;) {
						DeviceTypeInfo devTmp = new DeviceTypeInfo();
						Date date = new Date();
						devTmp.setAddTime(date);
						devTmp.setAddUserid(this.getUserID());
						devTmp.setLastUpdateTime(date);
						devTmp.setLastUpdateUserid(this.getUserID());
						
						devTmp.setDeviceTypeCode(devType.getDeviceTypeCode().trim()+"-"+i);//批量
						devTmp.setDeviceRandCode(devType.getDeviceRandCode().trim());
						devTmp.setDeviceDesc(devType.getDeviceDesc().trim()+"-"+i);//批量
						//showIdex：
						devTmp.setShowIndex(Long.parseLong(i+""));
						
						//x，y，width，height:空着
						devTmp.setFigureType("image");
						devTmp.setFigureStroke("red");
						devTmp.setFigureStrokeWidth(1l);
						//上传设备图片文件
						if(figureFill!=null && StringUtils.isNotBlank(figureFillFileName)) {
							String path = this.getServletContext().getRealPath(uploadSvgPath);//上传路径
							String fileReName = uploadFile(figureFill,path,figureFillFileName);
							devTmp.setFigureFill(figureFillFileName);
						}
						//nodefigureinfo表的nameflag不能为空，所以deviceTypeInfo表里默认的nameformat为deviceTypeCode
						if(StringUtils.isBlank(devType.getNameFormat())) {
							devTmp.setNameFormat(devType.getDeviceTypeCode());
						}else {
							devTmp.setNameFormat(devType.getNameFormat());
						}
						
						//showLevel,isLink,isLeaf
						Long isLeaf = devType.getIsPositionDev()==null?1l:devType.getIsPositionDev();//1:位置设备，0：非位置设备
						devTmp.setIsPositionDev(devType.getIsPositionDev());
						devTmp.setIsLeaf(1l);
						String tabName = devType.getDiTableName();
						devTmp.setDiTableName(tabName);
						devTmp.setIndexFiled(devType.getIndexFiled());
						devTmp.setStatusFiled(devType.getStatusFiled());
						devTmp.setStatusSymbols(devType.getStatusSymbols());
						devTmp.setStatusValue(devType.getStatusValue()!=null?devType.getStatusValue().trim():"");
						
						if(StringUtils.isNotBlank(tabName)&&"DI_SWITCHPORT".equalsIgnoreCase(tabName)) {
							devTmp.setIsLink(1l);						
						}else {
							devTmp.setIsLink(0l);					
						}
						
						String pid = devType.getPid();
						devTmp.setPid(pid);
						devTmp.setMaxDeviceNum(1l);
						
						DeviceTypeInfo devTypeTmp = (DeviceTypeInfo)this.commonService.get(DeviceTypeInfo.class, Long.parseLong(pid));
						if(devTypeTmp.getIsLeaf()==1l){
							devTypeTmp.setIsLeaf(0l);
							this.commonService.update(devTypeTmp);							
						}
						if(devTypeTmp!=null && devTypeTmp.getShowLevel()!=null) {
							devTmp.setShowLevel(devTypeTmp.getShowLevel()+1);								
							//中间表，父设备如果确定了，就没有可配置的父设备了
//							DeviceBrandType devBrandType = new DeviceBrandType();
//							devBrandType.setSubDeviceTypeCode(devTmp.getDeviceTypeCode());
//							devBrandType.setParDeviceTypeCode(devTypeTmp.getDeviceTypeCode());
//							devBrandType.setDeviceBrandCode(devType.getDeviceRandCode());
//							this.commonService.save(devBrandType);
						}
						
						
						//devTmp.setFigureX(10l);
						//devTmp.setFigureY(10l);
						//devTmp.setFigureWidth(35l);
						//devTmp.setFigureHeight(382l);
//						devTmp.setFigureWidth(12l);
//						devTmp.setFigureHeight(8l);
						
						devTmp.setHasInstance(0l);						
						devList.add(devTmp);
						
						if("1".equals(showIndexRule) || "2".equals(showIndexRule) ) {//奇、偶数，则间隔为2
							i = i+2;
						}else {//全部，则间隔为1
							i++;
						}
					}
					// 将添加操作写到操作日志中
					this.addDBOperationRpt(commonService, "DeviceTypeInfo", "INSERT_BATCH");
					this.commonService.saveOrUpdate(devList);
				}
				outHtmlString("<script type=\"text/javascript\">alert('i18n_DeviceBrandManageAction.importXls.success_n81i');this.location='deviceBrandManage.do?action=queryDeviceTypeInfo&devTypeCodeForSearch="+devTypeCodeForSearch+"&devRandCodeForSearch="+devRandCodeForSearch+"&parDevId="+parDevId+"'</script>");
//				}
			}else {
				outHtmlString("<script type=\"text/javascript\">alert('i18n_DeviceBrandManageAction.toConfDevPos.deviceBrandIsNotNull_n81i');window.history.go(-1);</script>");
			}
			commonService.commit();
		} catch (Exception e) {
			commonService.rollback();
			e.printStackTrace();
			outHtmlString("<script type=\"text/javascript\">alert('i18n_DeviceBrandManageAction.importXls.faild_n81i');this.location='deviceBrandManage.do?action=queryDeviceTypeInfo'</script>");
		}
	}
	
	/*
	 * 品牌是否存在
	 */
	public void hasDevBrand() {
		try
		{
			//设备品牌不能重复
			String tipStr = "";
			String result = "fail";
			if(StringUtils.isNotBlank(devRandCodeForSearch)) {
				List list = this.commonService.find("from DeviceBrandInfo where deviceRandCode='"+devRandCodeForSearch.trim()+"'");
				if(list!=null && list.size()>0) {
					tipStr = getI18nText("i18n_DeviceBrandManageAction.importXls.brandIdExists_n81i");
					result = "success";		
				}
			}
			String rngStr = JSONObject.fromObject("{result:'"+result+"';tip:'"+tipStr+"'}").toString();
			outJsonString(rngStr);	
		} catch (Exception e)
		{
			e.printStackTrace();
		}		
	}
	
	public void hasDevBrandForUpdate() {
		try
		{
			//设备品牌不能重复
			String tipStr = "";
			String result = "fail";
			if(StringUtils.isNotBlank(devRandCodeForSearch) && StringUtils.isNotBlank(ids)) {
				List list = this.commonService.find("from DeviceBrandInfo where deviceRandCode='"+devRandCodeForSearch.trim()+"' and id<>"+ids);
				if(list!=null && list.size()>0) {
					tipStr = getI18nText("i18n_DeviceBrandManageAction.importXls.brandIdExists_n81i");
					result = "success";		
				}
			}
			String rngStr = JSONObject.fromObject("{result:'"+result+"';tip:'"+tipStr+"'}").toString();
			outJsonString(rngStr);	
		} catch (Exception e)
		{
			e.printStackTrace();
		}		
	}
	
	public void hasDevType() {
		try
		{
			//设备型号不能重复:不同品牌可以重复吗？
			String tipStr = "";
			String result = "fail";
			if(StringUtils.isNotBlank(devTypeCodeForSearch) && StringUtils.isNotBlank(devRandCodeForSearch)) {
				List list = this.commonService.find("from DeviceTypeInfo where deviceTypeCode='"+devTypeCodeForSearch.trim()+"' and deviceRandCode='"+devRandCodeForSearch.trim()+"'");
				if(list!=null && list.size()>0) {
					tipStr = getI18nText("i18n_DeviceBrandManageAction.impDevicesByExcel.deviceBrandExists_n81i");
					result = "success";		
				}
			}
			String rngStr = JSONObject.fromObject("{result:'"+result+"';tip:'"+tipStr+"'}").toString();
			outJsonString(rngStr);	
		} catch (Exception e)
		{
			e.printStackTrace();
		}		
	}
	
	public String uploadFile(File file, String filePath, String fileName) throws Exception {
		try {
			if(file!=null&&StringUtils.isNotBlank(filePath)&&StringUtils.isNotBlank(fileName)) {
				File upFolder = new File(filePath);// 创建文件上传路径
				if (!upFolder.exists()) {// 有则创建无则不创建
					upFolder.mkdirs();
				}
				
				filePath += "/" + fileName;
				FileUtil.copy(file, new File(filePath), 2048);					
			}
		} catch (RuntimeException e) {
			e.printStackTrace();
			throw new Exception(fileName + getI18nText("i18n_DeviceBrandManageAction.impDevicesByExcel.pictureUploadFaild_n81i"));
		}
		return fileName;
	}
	
	public String deleteDevType()throws Exception{
		try {
			commonService.beginTransaction();
			if(ids!=null&&!"".equals(ids)) {
				//不能删除有设备型号的品牌
				List list = this.commonService.find("from DeviceTypeInfo where pid in( "+ids+")");
				if(list!=null && list.size()>0) {
					outHtmlString("<script type=\"text/javascript\">alert('i18n_DeviceBrandManageAction.impDevicesByExcel.deleteSubDevice_n81i');this.location='deviceBrandManage.do?action=queryDeviceTypeInfo&devTypeCodeForSearch="+devTypeCodeForSearch+"&devRandCodeForSearch="+devRandCodeForSearch+"&parDevId="+parDevId+"';</script>");
				}else {
					//当前设备（可能是多个）的父设备是否有子设备
					String pidSql = "select distinct pid  from device_type_info where id in ("+ ids + ")";//查询要删除设备的pid
					List<String> pidList = (ArrayList<String>)this.commonService.executeSQL(pidSql);
					if(pidList!=null && pidList.size()>0) {
						List<DeviceTypeInfo> parDevList = new ArrayList<DeviceTypeInfo>();
						for(String pid:pidList) {
							String parDevHql = "from DeviceTypeInfo where pid ="+pid+" and id not in("+ids+")";
							List<DeviceTypeInfo> otherSubDevList = (ArrayList<DeviceTypeInfo>)this.commonService.find(parDevHql);
							if(otherSubDevList!=null && otherSubDevList.size()==0) {//当前设备的父设备无子设备，将当前设备的父设备修改为叶子设备
								DeviceTypeInfo parDevTmp = (DeviceTypeInfo)this.commonService.get(DeviceTypeInfo.class,Long.parseLong(pid));
								parDevTmp.setIsLeaf(1l);
								parDevList.add(parDevTmp);
							}
						}
						this.commonService.saveOrUpdate(parDevList);
					}					
					
					//还要删除中间表里的关系：可以删除的都是叶子设备（非叶子设备需要先删除其叶子设备）
					this.commonService.delete("delete from DeviceBrandType where subDeviceTypeCode in(select deviceTypeCode FROM DeviceTypeInfo WHERE ID IN ("+ ids + "))");
					//删除板卡板槽关系表的数据（删除板卡或者板槽的时候都会删除关系表中的关系）
					this.commonService.delete("delete from DeviceBoardsoltBoard where deviceBoardCode in(select deviceTypeCode FROM DeviceTypeInfo WHERE ID IN ("+ ids + ")) or deviceBoardSoltCode in(select deviceTypeCode FROM DeviceTypeInfo WHERE ID IN ("+ ids + "))");
					//删除设备本身
					String hql = "DELETE FROM DeviceTypeInfo WHERE ID IN ("+ ids + ")";
					this.commonService.delete(hql);
					
				}
			}
			outHtmlString("<script type=\"text/javascript\">alert('i18n_DeviceBrandManageAction.importXls.success_n81i');this.location='deviceBrandManage.do?action=queryDeviceTypeInfo&devTypeCodeForSearch="+devTypeCodeForSearch+"&devRandCodeForSearch="+devRandCodeForSearch+"&parDevId="+parDevId+"'</script>");
			commonService.commit();
		} catch (Exception e) {
			commonService.rollback();
			e.printStackTrace();
			outHtmlString("<script type=\"text/javascript\">alert('i18n_DeviceBrandManageAction.importXls.faild_n81i');this.location='deviceBrandManage.do?action=queryDeviceTypeInfo'</script>");
		}
		return null;
	}
	
	public String toUpdateDevType() {
		try {
			if(ids!=null&&!"".equals(ids) ){
				DeviceTypeInfo oldDevType = (DeviceTypeInfo)this.commonService.get(DeviceTypeInfo.class, Long.parseLong(ids));
//				if(oldDevType.getIsLeaf()==1l) {			
					List list = this.commonService.find("from DeviceTypeInfo where id=?", Long.valueOf(ids));
					if(list!=null && list.size()>0){
						devType = (DeviceTypeInfo)list.get(0);
					}
					
					devBrandListInfo = (ArrayList<DeviceBrandInfo>)this.commonService.find("from DeviceBrandInfo");
					devTypeListInfo = (ArrayList<DeviceTypeInfo>)this.commonService.find("from DeviceTypeInfo where id<>"+ids);//父设备型号选择列表
					metadataList = (ArrayList<String>)this.commonService.find("select distinct tableName from Metadata order by tableName");
					fieldList = (ArrayList<Metadata>)this.commonService.find("select distinct tableName,filedName from Metadata");
					//当前品牌是否有型号:1有，0无
	//				List subTypeList = this.commonService.find("from DeviceTypeInfo where deviceRandCode in (select deviceRandCode from DeviceBrandInfo where id="+ids+")");
	//				if(subTypeList!=null && subTypeList.size()>0) {
	//					hasSubType = "1";
	//				}
	//				hasSubType="0";
//				}else {
//					outHtmlString("<script type=\"text/javascript\">alert('只有叶子设备可以修改');window.history.go(-1);</script>");
//				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			outHtmlString("<script type=\"text/javascript\">alert('i18n_DeviceBrandManageAction.importXls.faild_n81i');this.location='deviceBrandManage!execute.do?action=queryDeviceBrandInfo'</script>");
		}
		return null;
	}
	
	public void hasDevTypeForUpdate(){
		if(devType!=null && StringUtils.isNotBlank(devType.getDeviceTypeCode())){
			//设备型号不能重复:不同品牌可以重复吗？
			List list;
			try {
				list = this.commonService.find("from DeviceTypeInfo where deviceTypeCode='"+devType.getDeviceTypeCode().trim()+"' and deviceRandCode='"+devType.getDeviceRandCode()+"' and id<>"+devType.getId());
				if(list!=null && list.size()>0) {
					this.outString("error");
				}
			} catch (Exception e) {
				e.printStackTrace();
				logger.info("设备管理验证失败", e);
				this.outString("exception");
			}
		}
		this.outString("success");
	}
	
	//jsp界面控制：只可以修改叶子设备
	public void updateDevType() {
		try {
			commonService.beginTransaction();
			if(devType!=null && StringUtils.isNotBlank(devType.getDeviceTypeCode())){
				//设备型号不能重复:不同品牌可以重复吗？
				/*List list = this.commonService.find("from DeviceTypeInfo where deviceTypeCode='"+devType.getDeviceTypeCode().trim()+"' and deviceRandCode='"+devType.getDeviceRandCode()+"' and id<>"+devType.getId());
				if(list!=null && list.size()>0) {
					outHtmlString("<script type=\"text/javascript\">alert('设备型号已存在');window.history.go(-1);</script>");
				}else {*///只有叶子设备才可以修改
					DeviceTypeInfo oldDevType = (DeviceTypeInfo)this.commonService.get(DeviceTypeInfo.class, devType.getId());
					
					String deviceRandCode = devType.getDeviceRandCode()==null?"":devType.getDeviceRandCode();
					String oldDeviceRandCode = oldDevType.getDeviceRandCode()==null?"":oldDevType.getDeviceRandCode();
					String deviceTypeCode = devType.getDeviceTypeCode()==null?"":devType.getDeviceTypeCode();
					String oldDeviceTypeCode = oldDevType.getDeviceTypeCode()==null?"":oldDevType.getDeviceTypeCode();
					
					Date date = new Date();
					oldDevType.setLastUpdateTime(date);
					oldDevType.setLastUpdateUserid(this.getUserID());
					
					oldDevType.setDiTableName(devType.getDiTableName());
					oldDevType.setIndexFiled(devType.getIndexFiled());
					oldDevType.setStatusFiled(devType.getStatusFiled());
					oldDevType.setStatusSymbols(devType.getStatusSymbols());
					oldDevType.setStatusValue(devType.getStatusValue()!=null?devType.getStatusValue().trim():"");
					
					//nodefigureinfo表的nameflag不能为空，所以deviceTypeInfo表里默认的nameformat为deviceTypeCode
					if(StringUtils.isBlank(devType.getNameFormat())) {
						oldDevType.setNameFormat(devType.getDeviceTypeCode());
					}else {
						oldDevType.setNameFormat(devType.getNameFormat());
					}
					
					oldDevType.setDeviceTypeCode(devType.getDeviceTypeCode().trim());
					oldDevType.setDeviceRandCode(devType.getDeviceRandCode().trim());
					oldDevType.setDeviceDesc(devType.getDeviceDesc().trim());
					
					oldDevType.setMaxDeviceNum(devType.getMaxDeviceNum());
					
					//x，y，width，height:空着
					oldDevType.setFigureType("image");
					oldDevType.setFigureStroke("red");
					oldDevType.setFigureStrokeWidth(1l);
					
					//上传设备图片文件
					if(figureFill!=null && StringUtils.isNotBlank(figureFillFileName)) {
						String path = this.getServletContext().getRealPath(uploadSvgPath);//上传路径
//						String filePath = path + "\\" + figureFillFileName;
//						File fileTmp = new File(filePath);
						//文件重复了，会进行覆盖
						String fileReName = uploadFile(figureFill,path,figureFillFileName);
						oldDevType.setFigureFill(figureFillFileName);
						
						String svgPathTmp = this.getServletContext().getRealPath(svgPath);//上传路径svg
						String modelPathTmp = this.getServletContext().getRealPath(modelPath);//上传路径model
						uploadFile(figureFill,svgPathTmp,figureFillFileName);//上传到svg目录
						uploadFile(figureFill,modelPathTmp,figureFillFileName);//上传到model目录						
						
						BufferedImage buff = ImageIO.read(new File(path + "/" + figureFillFileName));
						oldDevType.setFigureWidth(Long.parseLong(buff.getWidth()+""));
						oldDevType.setFigureHeight(Long.parseLong(buff.getHeight()+""));
					}
					
					//showLevel,isLink,isLeaf					
//					oldDevType.setIsLeaf(1l);//isLeaf：1					
					String tabName = devType.getDiTableName();
					if(StringUtils.isNotBlank(tabName)&&"DI_SWITCHPORT".equalsIgnoreCase(tabName)) {
						oldDevType.setIsLink(1l);						
					}else {
						oldDevType.setIsLink(0l);					
					}
					
					//showLevel：取决于有无父设备：无父设备：为1，有父设备：parShowLevel+1
					String pid = (devType.getPid()==null||"".equals(devType.getPid()))?"0":devType.getPid();
					String oldPid = (oldDevType.getPid()==null || "".equals(oldDevType.getPid()))?"0":oldDevType.getPid();
					if("0".equals(pid)) {//无父设备 
						
						oldDevType.setShowLevel(1l);
					}else {//有父设备
						DeviceTypeInfo devTypeTmp = (DeviceTypeInfo)this.commonService.get(DeviceTypeInfo.class, Long.parseLong(pid));
						oldDevType.setShowLevel(devTypeTmp.getShowLevel()+1);
					}						
					oldDevType.setPid(pid);
					
					//showIdex：用户输入，pid：界面选择
					if("0".equals(pid) || devType.getShowIndex()==null) {//无父设备：一级设备，默认的shouIndex=1,未指定的也为一级（是否应该查询父设备底下的最大index？）
						oldDevType.setShowIndex(1l);
					}else {
						oldDevType.setShowIndex(devType.getShowIndex());
					}
					
					//品牌改变时：需要修改中间表
					if(!deviceRandCode.equalsIgnoreCase(oldDeviceRandCode)) {//只有叶子设备才可以修改		
						this.commonService.updateByHql("update DeviceBrandType set deviceBrandCode='"+deviceRandCode+"' where subDeviceTypeCode='"+oldDeviceTypeCode+"'");
					}						
					
					//设备型号改变需要修改中间表device_brand_type	
					if(!deviceTypeCode.equalsIgnoreCase(oldDeviceTypeCode)) {//只有叶子设备才可以修改
						this.commonService.updateByHql("update DeviceBrandType set subDeviceTypeCode='"+deviceTypeCode+"' where subDeviceTypeCode='"+oldDeviceTypeCode+"'");
					}
					//因为主机架和板卡pid都为0，所以修改板卡的时候会错误的把板卡的showlevel改为1，这里根据能否在板卡主机架关系表中找到这块板卡的关系数据来把板卡的showlevel改回2
					if ("0".equals(pid)) {
						List<DeviceBrandType> dbtList = this.commonService.find("from DeviceBrandType where subDeviceTypeCode = '"+devType.getDeviceTypeCode()+"'");
						if (dbtList!=null&&dbtList.size()>0) {
							oldDevType.setShowLevel(2l);
						}
					}
					/**
					 * pid改变时（pid不会为空）：showLevel和isLeaf会修改
					 *     1.原来父设备现在是否为叶子设备
					 *	   2.修改新父设备为非叶子设备
					 *     3.pid=0时，需要删除中间表里的记录
					 */
					if(!pid.equalsIgnoreCase(oldPid)) {
						if(!"0".equals(oldPid)) {//0表示没有父设备
							//原来父设备现在是否为叶子设备
							String parDevHql = "from DeviceTypeInfo where pid ="+oldPid+" and id <>"+devType.getId();
							List<DeviceTypeInfo> otherSubDevList = (ArrayList<DeviceTypeInfo>)this.commonService.find(parDevHql);
							if(otherSubDevList!=null && otherSubDevList.size()==0) {//当前设备的父设备无子设备，将当前设备的父设备修改为叶子设备
								DeviceTypeInfo parDevTmp = (DeviceTypeInfo)this.commonService.get(DeviceTypeInfo.class,Long.parseLong(oldPid));
								if(parDevTmp!=null) {
									parDevTmp.setIsLeaf(1l);
									this.commonService.saveOrUpdate(parDevTmp);			
								}
							}
						}
						
						//如果有，则删除中间表之前的记录：有->无 , 有->不同
						this.commonService.delete("delete from DeviceBrandType where subDeviceTypeCode='"+deviceTypeCode+"'");
						
						if(!"0".equals(pid)) {//0表示没有父设备
							//修改新父设备为非叶子设备
							DeviceTypeInfo newParDevTmp = (DeviceTypeInfo)this.commonService.get(DeviceTypeInfo.class, Long.parseLong(pid));
							if(newParDevTmp!=null && newParDevTmp.getIsLeaf()==1l){
								newParDevTmp.setIsLeaf(0l);//将父设备修改为非叶子设备
								this.commonService.update(newParDevTmp);						
							}
							
							//增加中间表记录：由无->有，有->不同
							DeviceBrandType devBrandType = new DeviceBrandType();
							devBrandType.setSubDeviceTypeCode(deviceTypeCode);
							devBrandType.setParDeviceTypeCode(newParDevTmp.getDeviceTypeCode());
							devBrandType.setDeviceBrandCode(deviceRandCode);
							this.commonService.save(devBrandType);

						}
					}
					
					oldDevType.setHasInstance(0l);
					this.commonService.saveOrUpdate(oldDevType);				
					
					// 将添加操作写到操作日志中
					this.addDBOperationRpt(commonService, "DeviceTypeInfo", "UPDATE",devType.getId());
					outHtmlString("<script type=\"text/javascript\">alert('i18n_DeviceBrandManageAction.importXls.success_n81i');this.location='deviceBrandManage.do?action=queryDeviceTypeInfo&devTypeCodeForSearch="+devTypeCodeForSearch+"&devRandCodeForSearch="+devRandCodeForSearch+"&parDevId="+parDevId+"'</script>");
			}
			commonService.commit();
		} catch (Exception e) {
			commonService.rollback();
			e.printStackTrace();
			outHtmlString("<script type=\"text/javascript\">alert('i18n_DeviceBrandManageAction.importXls.faild_n81i');this.location='deviceBrandManage.do?action=queryDeviceTypeInfo'</script>");
		}
	}
	
	public String detailDevType() {
		try {
			if(StringUtils.isNotBlank(devId)) {
				devType = (DeviceTypeInfo)this.commonService.get(DeviceTypeInfo.class,Long.valueOf(devId));
					
//				devBrandListInfo = (ArrayList<DeviceBrandInfo>)this.commonService.find("from DeviceBrandInfo");
				devTypeListInfo = (ArrayList<DeviceTypeInfo>)this.commonService.find("from DeviceTypeInfo ");//父设备型号选择列表
//				metadataList = (ArrayList<String>)this.commonService.find("select distinct tableName from Metadata order by tableName");
//				fieldList = (ArrayList<Metadata>)this.commonService.find("select distinct tableName,filedName from Metadata");
			}
			// 将更新操作写到操作日志中
			this.addDBOperationRpt(commonService, "DeviceTypeInfo", "SELECT",Long.valueOf(devId));
		} catch (Exception e) {
			e.printStackTrace();
			outHtmlString("<script type=\"text/javascript\">alert('i18n_DeviceBrandManageAction.importXls.faild_n81i');this.location='deviceBrandManage.do?action=queryDeviceTypeInfo'</script>");
		}
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

	
	public List<DeviceBrandInfo> getDevBrandListInfo()
	{
		return devBrandListInfo;
	}

	
	public void setDevBrandListInfo(List<DeviceBrandInfo> devBrandListInfo)
	{
		this.devBrandListInfo = devBrandListInfo;
	}

	
	public DeviceBrandInfo getDevBrand()
	{
		return devBrand;
	}

	
	public void setDevBrand(DeviceBrandInfo devBrand)
	{
		this.devBrand = devBrand;
	}

	
	public String getBrandNameForSearch()
	{
		return brandNameForSearch;
	}

	
	public void setBrandNameForSearch(String brandNameForSearch)
	{
		this.brandNameForSearch = brandNameForSearch;
	}

	
	public String getIds()
	{
		return ids;
	}

	
	public void setIds(String ids)
	{
		this.ids = ids;
	}

	
	public String getDeviceRandCode()
	{
		return deviceRandCode;
	}

	
	public void setDeviceRandCode(String deviceRandCode)
	{
		this.deviceRandCode = deviceRandCode;
	}

	
	public String getDevTypeCodeForSearch()
	{
		return devTypeCodeForSearch;
	}

	
	public void setDevTypeCodeForSearch(String devTypeCodeForSearch)
	{
		this.devTypeCodeForSearch = devTypeCodeForSearch;
	}

	
	public String getDevRandCodeForSearch()
	{
		return devRandCodeForSearch;
	}

	
	public void setDevRandCodeForSearch(String devRandCodeForSearch)
	{
		this.devRandCodeForSearch = devRandCodeForSearch;
	}

	
	public List<DeviceTypeInfo> getDevTypeListInfo()
	{
		return devTypeListInfo;
	}

	
	public void setDevTypeListInfo(List<DeviceTypeInfo> devTypeListInfo)
	{
		this.devTypeListInfo = devTypeListInfo;
	}

	
	public DeviceTypeInfo getDevType()
	{
		return devType;
	}

	
	public void setDevType(DeviceTypeInfo devType)
	{
		this.devType = devType;
	}

	
	public List<String> getMetadataList()
	{
		return metadataList;
	}

	
	public void setMetadataList(List<String> metadataList)
	{
		this.metadataList = metadataList;
	}

	public List<Metadata> getFieldList()
	{
		return fieldList;
	}

	
	public void setFieldList(List<Metadata> fieldList)
	{
		this.fieldList = fieldList;
	}

	
	public File getFigureFill()
	{
		return figureFill;
	}

	
	public void setFigureFill(File figureFill)
	{
		this.figureFill = figureFill;
	}

	
	public String getFigureFillFileName()
	{
		return figureFillFileName;
	}

	
	public void setFigureFillFileName(String figureFillFileName)
	{
		this.figureFillFileName = figureFillFileName;
	}

	
	public String getHasSubType()
	{
		return hasSubType;
	}

	
	public void setHasSubType(String hasSubType)
	{
		this.hasSubType = hasSubType;
	}

	
	public String getParDevId()
	{
		return parDevId;
	}

	
	public void setParDevId(String parDevId)
	{
		this.parDevId = parDevId;
	}

	
	public List<DeviceTypeInfo> getDevTypeListForSearch()
	{
		return devTypeListForSearch;
	}

	
	public void setDevTypeListForSearch(List<DeviceTypeInfo> devTypeListForSearch)
	{
		this.devTypeListForSearch = devTypeListForSearch;
	}

	
	public String getDevId()
	{
		return devId;
	}

	
	public void setDevId(String devId)
	{
		this.devId = devId;
	}

	
	public String getPosParDevId()
	{
		return posParDevId;
	}

	
	public void setPosParDevId(String posParDevId)
	{
		this.posParDevId = posParDevId;
	}

	
	public List<DeviceTypeInfo> getDevTypeForPosList()
	{
		return devTypeForPosList;
	}

	
	public void setDevTypeForPosList(List<DeviceTypeInfo> devTypeForPosList)
	{
		this.devTypeForPosList = devTypeForPosList;
	}

	
	public String getDevScrollHeight()
	{
		return devScrollHeight;
	}

	
	public void setDevScrollHeight(String devScrollHeight)
	{
		this.devScrollHeight = devScrollHeight;
	}

	
	public long getRootDeviceX()
	{
		return rootDeviceX;
	}

	
	public void setRootDeviceX(long rootDeviceX)
	{
		this.rootDeviceX = rootDeviceX;
	}

	
	public long getRootDeviceY()
	{
		return rootDeviceY;
	}

	
	public void setRootDeviceY(long rootDeviceY)
	{
		this.rootDeviceY = rootDeviceY;
	}

	public List<DeviceTypeInfo> getDevTypeForBankaList() {
		return devTypeForBankaList;
	}

	public void setDevTypeForBankaList(List<DeviceTypeInfo> devTypeForBankaList) {
		this.devTypeForBankaList = devTypeForBankaList;
	}
	
	public String getPzbkbc() {
		return pzbkbc;
	}

	public void setPzbkbc(String pzbkbc) {
		this.pzbkbc = pzbkbc;
	}
	/**
	 * @return the parDevCode
	 */
	public String getParDevCode() {
		return parDevCode;
	}

	/**
	 * @param parDevCode the parDevCode to set
	 */
	public void setParDevCode(String parDevCode) {
		this.parDevCode = parDevCode;
	}

	public String getJsonStr() {
		return jsonStr;
	}

	public void setJsonStr(String jsonStr) {
		this.jsonStr = jsonStr;
	}

	public List<DeviceBrandType> getDeviceBrandTypeList() {
		return deviceBrandTypeList;
	}

	public void setDeviceBrandTypeList(List<DeviceBrandType> deviceBrandTypeList) {
		this.deviceBrandTypeList = deviceBrandTypeList;
	}

	
	/**
	 * @return the pardevList
	 */
//	public List<Object[]> getPardevList() {
//		return pardevList;
//	}
//
//	/**
//	 * @param pardevList the pardevList to set
//	 */
//	public void setPardevList(List<Object[]> pardevList) {
//		this.pardevList = pardevList;
//	}

	
}
