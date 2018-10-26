package nis.nms.core;

import java.util.Map;
import java.util.ResourceBundle;
import org.apache.commons.lang.StringUtils;

import nis.nms.util.BaseAction;
  
public class Constants {
	/**
	 * 测试用例使用的定义Spring Context 文件集合的字符串.
	 */
	public static final String DEFAULT_CONTEXT = "classpath*:spring/*.xml";

	/**
	 * 测试用例使用的定义Spring在测试时特别设置的Context 文件集合的字符串.
	 */
	public static final String DEFAULT_TEST_CONTEXT = "classpath*:spring/test/*.xml";
	
	/**
	 * 重定向认证服务器地址.
	 */
	public static final String REDIRECT_LOGIN_SERVER_ADDRESS = "http://127.0.0.1/controlService/login.jsp?returnPath=http://127.0.0.1/searchEngineManagement/page/main/index.jsp&sysid=2";

	/**
	 * ip.
	 */
	public static final String REDIRECT_LOGIN_SERVER_IP = "10.99.0.232";

	/**
	 * port.
	 */
	public static final int REDIRECT_LOGIN_SERVER_PORT = 80;
	
	/**
	 * rsid.父资源编码
	 */
	public static final String RESOURCE_ID = "8090";
	
	/**
	 * rsid.业务的编码
	 */
	public static final String RESOURCE_CODE_ID = "8090";
	
	/**
	 * rsid.
	 */
//	public static final String XML_FILE = "<?xml version='1.0' encoding='UTF-8'?>" +
//			"<resources>" +
//				//系统配置
//				"<resource rsid='1' rsCode='82' rsname='"+BaseAction.getI18nText("i18n_Constants.xmlFile.sysConfig_n81i")+"' rsaddress=''>" +
//					"<resource rsid='10' rsCode='83' rsname='"+BaseAction.getI18nText("i18n_Constants.xmlFile.userInf_n81i")+"' rsaddress='/sysManage/sysPopedomManage!execute.do?action=queryUserInfo'/>" +
//					"<resource rsid='21' rsCode='84' rsname='"+BaseAction.getI18nText("i18n_Constants.xmlFile.userPrivilege_n81i")+"'>" +
//						"<resource rsid='210' rsCode='120' rsname='"+BaseAction.getI18nText("i18n_Constants.xmlFile.mkManage_n81i")+"' rsaddress='/sysManage/sysPopedomManage!execute.do?action=queryMkInfo'/>" +
//						"<resource rsid='211' rsCode='121' rsname='"+BaseAction.getI18nText("i18n_Constants.xmlFile.jsManage_n81i")+"' rsaddress='/sysManage/sysPopedomManage!execute.do?action=queryJsInfo'/>" +
//					"</resource>" +
//				"</resource>" +
//				//业务配置
//				"<resource rsid='2' rsCode='0' rsname='"+BaseAction.getI18nText("i18n_Constants.xmlFile.businessConfig_n81i")+"' >" +
//					"<resource rsid='20' rsCode='1' rsname='"+BaseAction.getI18nText("i18n_Constants.xmlFile.letterInfoConfig_n81i")+"' rsaddress='/taskManage/taskDoc!configList.do'/>" +
//					"<resource rsid='21' rsCode='2' rsname='"+BaseAction.getI18nText("i18n_Constants.xmlFile.htmlInfoConfig_n81i")+"' rsaddress=''/>" +
//					"<resource rsid='22' rsCode='5' rsname='"+BaseAction.getI18nText("i18n_Constants.xmlFile.emailInfoConfig_n81i")+"'>" +
//						"<resource rsid='220' rsCode='120' rsname='"+BaseAction.getI18nText("i18n_Constants.xmlFile.emailInfoConfig_n81i")+"' rsaddress=''/>" +
//						"<resource rsid='221' rsCode='121' rsname='"+BaseAction.getI18nText("i18n_Constants.xmlFile.webEmailInfoConfig_n81i")+"' rsaddress=''/>" +
//					"</resource>" +
//					"<resource rsid='23' rsCode='7' rsname='"+BaseAction.getI18nText("i18n_Constants.xmlFile.communicateConfig_n81i")+"' >" +
//						"<resource rsid='230' rsCode='8' rsname='"+BaseAction.getI18nText("i18n_Constants.xmlFile.msnInfoConfig_n81i")+"' rsaddress=''/>" +
//						"<resource rsid='231' rsCode='9' rsname='"+BaseAction.getI18nText("i18n_Constants.xmlFile.yahooMsgInfoConfig_n81i")+"' rsaddress=''/>" +
//						"<resource rsid='232' rsCode='8' rsname='"+BaseAction.getI18nText("i18n_Constants.xmlFile.feixinInfoConfig_n81i")+"' rsaddress=''/>" +
//						"<resource rsid='233' rsCode='9' rsname='"+BaseAction.getI18nText("i18n_Constants.xmlFile.sinaUCInfoConfig_n81i")+"' rsaddress=''/>" +
//					"</resource>" +
//					"<resource rsid='24' rsCode='10' rsname='"+BaseAction.getI18nText("i18n_Constants.xmlFile.telnetInfoConfig_n81i")+"' rsaddress='' />" +
//					"<resource rsid='25' rsCode='10' rsname='"+BaseAction.getI18nText("i18n_Constants.xmlFile.ftpInfoConfig_n81i")+"' rsaddress='' />" +
//					"<resource rsid='26' rsCode='10' rsname='"+BaseAction.getI18nText("i18n_Constants.xmlFile.srcReportInfoConfig_n81i")+"' rsaddress=''>" +
//						"<resource rsid='260' rsCode='11' rsname='"+BaseAction.getI18nText("i18n_Constants.xmlFile.ipInfoConfig_n81i")+"' rsaddress=''/>" +
//						"<resource rsid='261' rsCode='12' rsname='"+BaseAction.getI18nText("i18n_Constants.xmlFile.tcpInfoConfig_n81i")+"' rsaddress=''/>" +
//						"<resource rsid='262' rsCode='13' rsname='"+BaseAction.getI18nText("i18n_Constants.xmlFile.udpInfoConfig_n81i")+"' rsaddress=''/>" +
//					"</resource>" +
//					"<resource rsid='27' rsCode='10' rsname='"+BaseAction.getI18nText("i18n_Constants.xmlFile.busnessConfigGuide_n81i")+"' rsaddress='' />" +
//					"<resource rsid='28' rsCode='15' rsname='"+BaseAction.getI18nText("i18n_Constants.xmlFile.configState_n81i")+"' rsaddress=''/>" +
//				"</resource>" +
//				//业务审核
//				"<resource rsid='3' rsCode='0' rsname='"+BaseAction.getI18nText("i18n_Constants.xmlFile.businessCheck_n81i")+"' rsaddress=''>" +
//					"<resource rsid='30' rsCode='1' rsname='"+BaseAction.getI18nText("i18n_Constants.xmlFile.letterInfoCheck_n81i")+"' rsaddress=''/>" +
//					"<resource rsid='31' rsCode='2' rsname='"+BaseAction.getI18nText("i18n_Constants.xmlFile.webInfoCheck_n81i")+"' rsaddress=''/>" +
//					"<resource rsid='32' rsCode='5' rsname='"+BaseAction.getI18nText("i18n_Constants.xmlFile.emailInfoCheck_n81i")+"'>" +
//						"<resource rsid='320' rsCode='120' rsname='"+BaseAction.getI18nText("i18n_Constants.xmlFile.emailInfoCheck_n81i")+"' rsaddress=''/>" +
//						"<resource rsid='321' rsCode='121' rsname='"+BaseAction.getI18nText("i18n_Constants.xmlFile.webEmailInfoCheck_n81i")+"' rsaddress=''/>" +
//					"</resource>" +
//					"<resource rsid='33' rsCode='7' rsname='"+BaseAction.getI18nText("i18n_Constants.xmlFile.communicateInfoCheck_n81i")+"' >" +
//						"<resource rsid='330' rsCode='8' rsname='"+BaseAction.getI18nText("i18n_Constants.xmlFile.msnInfoCheck_n81i")+"' rsaddress=''/>" +
//						"<resource rsid='331' rsCode='9' rsname='"+BaseAction.getI18nText("i18n_Constants.xmlFile.yahooMsgInfoCheck_n81i")+"' rsaddress=''/>" +
//						"<resource rsid='332' rsCode='8' rsname='"+BaseAction.getI18nText("i18n_Constants.xmlFile.feixinInfoCheck_n81i")+"' rsaddress=''/>" +
//						"<resource rsid='333' rsCode='9' rsname='"+BaseAction.getI18nText("i18n_Constants.xmlFile.sinaUCInfoCheck_n81i")+"' rsaddress=''/>" +
//					"</resource>" +
//					"<resource rsid='34' rsCode='10' rsname='"+BaseAction.getI18nText("i18n_Constants.xmlFile.telnetInfoCheck_n81i")+"' rsaddress='' />" +
//					"<resource rsid='35' rsCode='10' rsname='"+BaseAction.getI18nText("i18n_Constants.xmlFile.ftpInfoCheck_n81i")+"' rsaddress='' />" +
//					"<resource rsid='36' rsCode='10' rsname='"+BaseAction.getI18nText("i18n_Constants.xmlFile.srcReportInfoCheck_n81i")+"' rsaddress=''>" +
//						"<resource rsid='360' rsCode='11' rsname='"+BaseAction.getI18nText("i18n_Constants.xmlFile.ipInfoCheck_n81i")+"' rsaddress=''/>" +
//						"<resource rsid='361' rsCode='12' rsname='"+BaseAction.getI18nText("i18n_Constants.xmlFile.tcpInfoCheck_n81i")+"' rsaddress=''/>" +
//						"<resource rsid='362' rsCode='13' rsname='"+BaseAction.getI18nText("i18n_Constants.xmlFile.udpInfoCheck_n81i")+"' rsaddress=''/>" +
//					"</resource>" +
//				"</resource>" +
//				//业务结果
//				"<resource rsid='4' rsCode='77' rsname='"+BaseAction.getI18nText("i18n_Constants.xmlFile.businessResult_n81i")+"' rsaddress=''>" +
//					"<resource rsid='40' rsCode='32' rsname='"+BaseAction.getI18nText("i18n_Constants.xmlFile.businessResultView_n81i")+"' rsaddress=''/>" +
//					"<resource rsid='41' rsCode='33' rsname='"+BaseAction.getI18nText("i18n_Constants.xmlFile.hotport_n81i")+"' rsaddress=''/>" +
//					"<resource rsid='42' rsCode='34' rsname='"+BaseAction.getI18nText("i18n_Constants.xmlFile.mission_n81i")+"' rsaddress=''/>" +
//				"</resource>" +
//				//操作审计
//				"<resource rsid='5' rsCode='77' rsname='"+BaseAction.getI18nText("i18n_Constants.xmlFile.operateCheck_n81i")+"' rsaddress=''>" +
//					"<resource rsid='50' rsCode='32' rsname='"+BaseAction.getI18nText("i18n_Constants.xmlFile.userOperateLog_n81i")+"' rsaddress=''/>" +
//				"</resource>" +
//				//报表查看
//				"<resource rsid='6' rsCode='37' rsname='"+BaseAction.getI18nText("i18n_Constants.xmlFile.reportView_n81i")+"' rsaddress=''>" +
//					"<resource rsid='60' rsCode='39' rsname='"+BaseAction.getI18nText("i18n_Constants.xmlFile.businessReportView_n81i")+"' rsaddress=''/>" +
//				"</resource>" +
//			"</resources>";

	/**
	 * 用户集合.
	 */
	public static final String USER_LIST = "userListSession";
	
	/**
	 * 根节点.
	 */
	public static final String XML_FILE_ROOT = "resources";
	
	/**
	 * 子节点.
	 */
	public static final String XML_FILE_NODE = "resource";
	
	/**
	 * 子节点属性1.
	 */
	public static final String XML_FILE_NODE_RSID = "rsid";

	/**
	 * 子节点属性2.
	 */
	public static final String XML_FILE_NODE_RSNAME = "rsname";
	
	/**
	 * 子节点属性3.
	 */
	public static final String XML_FILE_NODE_NUMBER = "number";
	
	/**
	 * 子节点属性4.
	 */
	public static final String XML_FILE_NODE_RSDESC = "rsdesc";
	
	/**
	 * 子节点属性5.
	 */
	public static final String XML_FILE_NODE_RSADDRESS = "rsaddress";
	
	/**
	 * 子节点属性6.
	 */
	public static final String XML_FILE_NODE_BUSINESS = "business";
	
	/**
	 * 子节点属性7.
	 */
	public static final String XML_FILE_NODE_RSCODE = "rsid";	
	
	//===========================================================数据加密===============================================================//
	
	public static final String Algorithm = "DESede"; //定义 加密算法,可用 DES,DESede,Blowfish
	
	public static final byte[] keyBytes = {0x11, 0x22, 0x4F, 0x58, (byte)0x88, 0x10, 0x40, 0x38                               
												, 0x28, 0x25, 0x79, 0x51, (byte)0xCB, (byte)0xDD, 0x55, 0x66                               
													, 0x77, 0x29, 0x74, (byte)0x98, 0x30, 0x40, 0x36, (byte)0xE2};	//24字节的密钥
//	public static final byte[] keyBytes = {
//		0x31,0x31,0x31,0x31,0x31,0x31,
//		0x31,0x31,0x31,0x31,0x31,0x31,
//		0x31,0x31,0x31,0x31,0x31,0x31,
//		0x31,0x31,0x31,0x31,0x31,0x31};	//24字节的密钥
	
	public static Map aqzcMap ;
	
	public static final String DETECTION_INFO_TABLE_NAME = "detection_info_new";//监测数据表名
	public static final String DETECTION_WARNING_TABLE_NAME = "detection_info_warning";//告警数据表名
	
	public static final String DI_SWITCHPORT_TABLE_NAME = "di_switchport";//交换机端口监测信息表名
	public static final String DI_SYSTEM_TABLE_NAME = "di_system";//交换机系统监测信息表名
	
	public static final int DEL_SVG_BEFORE_HOUR = 2;//删除当前时间前120分钟的svg文件
	public static final String SVG_IMAGES_PATH = "images/svg/";//svg展示图片的路径
	
	public static final String TOPO_SVG_IMAGES_PATH = "images/toposvg/";//拓扑图svg展示图片的路径

	public static final String DETEC_WARNING_LEVEL_FLAG = "detecWarningLevel";//配置告警信息列表显示告警级别的字典名称
	
	//--异常监测数据列表过滤配置菜单编码
	public static final String MENU_CODE_LOGIC_TOPO= "logicTopo";//业务逻辑拓扑
	public static final String MENU_CODE_ALL_WARNING_INFO = "allWarningInfo";//告警信息
	public static final String MENU_CODE_SERVER_WARNING_INFO = "serverWarningInfo";//异常服务器
	public static final String MENU_CODE_NE_WARNING_INFO = "netEleWarningInfo";//异常网元
	public static final String MENU_CODE_EMERGENT_WARNING_INFO = "emergentwarningInfo";//报警信息
	public static final String MENU_CODE_3DROOM_WARNING_INFO = "3DroomWarningInfo";//3d机房
	public static final String WARN_TYPE_LEFT_WARN = "leftWarn";//报警类型：左下角报警 or 告警信息列表
	public static final String WARN_TYPE_WARN_MENU = "warnMenu";//报警类型：左下角报警 or 告警信息列表
	
	//超周期告警默认的紧急状态
	public static final String DETEC_TIMEOUT_POLICE_EMERGENT;
	//超周期告警默认的告警级别
	public static final String DETEC_TIMEOUT_POLICE_LEVEL;
	
	
	public static ResourceBundle rb = ResourceBundle.getBundle("myconfig");
	// #---Email-------
	public static final String EMAIL_ADDRESS ;
	public static final String EMAIL_USERNAME ;
	public static final String EMAIL_PASSWORD;
	public static final String EMAIL_HOST ;
	
	public static final String NMS_CLIENT_CHECKTYPENAME;//握手监测 监测类别名称
	
	public static final String ALARM_SET_MARKER_SEPARATOR;//2014-5-20 :暂时未用。监测数据设置告警时，对于指定多个标识符（如多个盘符、多个CPU、多个网卡）的分隔符 
	
	public static final String DETEC_STATE_INFO_FORMATE_POINT = "$@$";//用于监测数据的状态信息web界面显示的格式化的连接符
	
	public static final String SHOW_AUTO_ALARM_FLAG = "showAutoAlarm";//是否显示主动告警的启动开关标识
	
	public static int DEFAULT_SEARCH_DAY = 2;//默认查询历史监测数据的时间：单位天,2天
	public static int DEFAULT_SEARCH_WARNINFO_HOUR = 2;//默认查询异常监测数据的时间：单位小时,2小时
	
	public static final String ADMIN_ROLE_BH;//管理员角色编号,默认初始化编号为1
	
	public static final String NATION_ROLE;
	
	public static final String DEPT_MK_ID;
	
	public static final String PREFABRICATE_VIEW;
	
	public static final String REGION_ROLE;
	static {
		if(rb.containsKey("region.role.jsbh")){
			REGION_ROLE=rb.getString("region.role.jsbh");
		}else{
			REGION_ROLE="-1";
		}
		
		if(rb.containsKey("prefabricate.view")){
			PREFABRICATE_VIEW=rb.getString("prefabricate.view");
		}else{
			PREFABRICATE_VIEW="";
		}
		
		if(rb.containsKey("dept.mk.id")){
			DEPT_MK_ID=rb.getString("dept.mk.id");
		}else{
			DEPT_MK_ID="-1";
		}
		
		
		if(rb.containsKey("nation.role.jsbh")){
			NATION_ROLE=rb.getString("nation.role.jsbh");
		}else{
			NATION_ROLE="-1";
		}
		
		if(rb.containsKey("jsbh")){
			ADMIN_ROLE_BH = StringUtils.isBlank(rb.getString("jsbh"))?"1":rb.getString("jsbh").trim();
		}else {
			ADMIN_ROLE_BH = "1";
		}
			
		
		if(rb.containsKey("email.address")) {
			EMAIL_ADDRESS = rb.getString("email.address");
		}else {
			EMAIL_ADDRESS = "";
		}
		
		if(rb.containsKey("email.userName")) {
			EMAIL_USERNAME = rb.getString("email.userName");
		}else {
			EMAIL_USERNAME = "";
		}
		
		if(rb.containsKey("email.password")) {
			EMAIL_PASSWORD = rb.getString("email.password");
		}else {
			EMAIL_PASSWORD = "";
		}
		
		if(rb.containsKey("email.host")) {
			EMAIL_HOST = rb.getString("email.host");
		}else {
			EMAIL_HOST = rb.getString("email.host");
		}
		
		if(rb.containsKey("detec.nmsclient.str")) {
			NMS_CLIENT_CHECKTYPENAME = rb.getString("detec.nmsclient.str");
		}else {
			NMS_CLIENT_CHECKTYPENAME = "nmsclient";
		}
		
		if(rb.containsKey("detec.timeout.police.emergent")) {
			DETEC_TIMEOUT_POLICE_EMERGENT = rb.getString("detec.timeout.police.emergent");
		}else {
			DETEC_TIMEOUT_POLICE_EMERGENT = "0";//紧急
		}
		
		if(rb.containsKey("detec.timeout.police.level")) {
			DETEC_TIMEOUT_POLICE_LEVEL = rb.getString("detec.timeout.police.level");
		}else {
			DETEC_TIMEOUT_POLICE_LEVEL = "0";//0级
		}
		
		if(rb.containsKey("alarm.set.marker.separator")) {
			ALARM_SET_MARKER_SEPARATOR = rb.getString("alarm.set.marker.separator");
		}else {
			ALARM_SET_MARKER_SEPARATOR = "|";
		}
		
		if(rb.containsKey("default.search.history.detect.data.day")) {
			String defaultSearchDayStr = rb.getString("default.search.history.detect.data.day");
			try {
				if(StringUtils.isNotBlank(defaultSearchDayStr)) {
					DEFAULT_SEARCH_DAY = Integer.parseInt(defaultSearchDayStr.trim());
				}
			} catch (Exception e){
				e.printStackTrace();
			}
		}else {
			DEFAULT_SEARCH_DAY = 2;
		}
		if(rb.containsKey("default.search.warn.data.hour")) {
			String defaultSearchDayStr = rb.getString("default.search.warn.data.hour");
			try {
				if(StringUtils.isNotBlank(defaultSearchDayStr)) {
					DEFAULT_SEARCH_WARNINFO_HOUR = Integer.parseInt(defaultSearchDayStr.trim());
				}
			} catch (Exception e){
				e.printStackTrace();
			}
		}else {
			DEFAULT_SEARCH_WARNINFO_HOUR = 2;
		}
	}
	
	public static String DETECT_TIMEOUT_ALARMINFO = "i18n_Constants.xmlFile.monitorInfo1_n81i"+" %d "+"i18n_Constants.xmlFile.monitorInfo2_n81i";
}



