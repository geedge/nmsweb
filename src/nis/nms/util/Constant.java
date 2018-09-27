package nis.nms.util;

import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.Map;
import java.util.ResourceBundle;
import java.util.Set;

import org.apache.commons.lang.StringUtils;


public class Constant {
	public static ResourceBundle rb = ResourceBundle.getBundle("myconfig");
	/**
	 *@param args
	 */
	
	public static String converseToXMLStr(String href) {
		Map<String, String> transferMap = Constant.getTransferMap2();
		Set<String> keySet = transferMap.keySet();
		for (String key : keySet) {
			// 将链接中已有实体引用还原为普通字符，避免和号转换时发生错误
			System.out.println(key+""+transferMap.get(key));
			href = href.replace(transferMap.get(key), key);
		}
		for (String key : keySet) {
			href = href.replace(key, transferMap.get(key));
		}
		return href;
	}
	
	public static Map<String, String> getTransferMap2() {
//		Map<String, String> transferMap = new HashMap<String, String>();
		Map<String, String> transferMap = new LinkedHashMap<String, String>();
		transferMap.put("&", "&amp;"); // 转换为实体引用时，和号最先进行转换
		transferMap.put("<", "&lt;");
		transferMap.put(">", "&gt;");
		transferMap.put("'", "&apos");
		// key 为"
		transferMap.put("\"", "&quot;");
		return transferMap;
	}
	
	public static void main(String args[]) {
		// TODO
		System.out.println(Common.converseToNomal("/sysManage/guideManage!execute.do?action=monitor&a=9&b=e>oi"));
		System.out.println(Constant.converseToXMLStr("/sysManage/guideManage!execute.do?action=monitor&a=9&b=e>oi"));
	}
	public static final String IMAGE_PATH = "graph";
	/******************************************** 当前操作员保存在session中的名字 ***********************************************/
	public static final String SESSION_CZY_NAME = "curUser";
	/******************************************** 当前登陆系统保存在session中的名字 ***********************************************/
	public static final String SESSION_SYSTEM_LOGIN = "systemLogin";
	public static final String SESSION_SYSTEM_LOGIN_NAME = "systemLoginName";
	public static final String ADMIN_FLAG = "AdminFlag";//超级管理员权限
	
	/******************************************** 公用参数设置 ***********************************************/
	public static final String[] filterStr = new String[]{"","","","",""};
	/******************************************** 定义特定信息和泛收信息 ***********************************************/
	public static final boolean IP = true;
	public static final boolean PORT = true;
	
	//用户功能类型
	public static final String F_MINUE_TYPE="3";//菜单
	
	public static final String F_BUTTON_TYPE="4";//按钮
	
	public static final boolean F_BUTTON_AUTHER=false;//按钮
	
	// =============菜单树xml的节点===开始==============================
	/**
	 * 根节点.
	 */
	public static final String XML_FILE_ROOT = "resources";

	/**
	 * 子节点.
	 */
	public static final String XML_FILE_NODE = "resource";

	/**
	 * 子节点id.
	 */
	public static final String XML_FILE_NODE_RSID = "rsid";

	/**
	 * 菜单名.
	 */
	public static final String XML_FILE_NODE_RSNAME = "rsname";

	/**
	 * 子节点属性3.
	 */
	public static final String XML_FILE_NODE_NUMBER = "number";

	/**
	 * 子节点.
	 */
	public static final String XML_FILE_NODE_RSDESC = "rsdesc";

	/**
	 * 子节点url.
	 */
	public static final String XML_FILE_NODE_RSADDRESS = "rsaddress";

	/**
	 * 子节点属性6.
	 */
	public static final String XML_FILE_NODE_BUSINESS = "business";

	/**
	 * 节点样式
	 */
	public static final String XML_FILE_NODE_CSSCLASS = "menucss";
	
	/**
	 * 邮件功能
	 * */
	public static final String EMAIL_FLAG="emailFlag";
	
	/**
	 * 用户部门功能
	 * */
	public static final String DEPT_FLAG="deptFlag";
	/** 转义字符集：key为转译之前的值，value为转译之后的值 */
	public static Map<String, String> getTransferMap() {
		Map<String, String> transferMap = new HashMap<String, String>();
		transferMap.put("<", "&lt;");
		transferMap.put(">", "&gt;");
		transferMap.put("&", "&amp;");
		transferMap.put("'", "&apos");
		// key 为"
		transferMap.put("\"", "&quot;");
		return transferMap;
	}

	// =============菜单树xml的节点===结束==============================
	// =============权限树xml的节点===开始==============================
	/**
	 * 根节点.
	 */
	public static final String ROLE_XML_FILE_ROOT = "resources";

	/**
	 * 子节点.
	 */
	public static final String ROLE_XML_FILE_NODE = "resource";

	/**
	 * 权限节点.
	 */
	public static final String ROLE_XML_FILE_NODE_ROLE = "role";
	/**
	 * 权限节点的ID属性.
	 */
	public static final String ROLE_XML_FILE_NODE_ROLE_ID = "id";

	/**
	 * 菜单节点.
	 */
	public static final String ROLE_XML_FILE_NODE_MENU = "menuId";
	// =============权限树xml的节点======结束===========================
	
	public static final String PACKAGE_NAME  = rb.getString("packName").trim();//生成的javaBean的package
	public static final String JAVABEAN_PATH = rb.getString("toPath").trim();	//生成的javaBean存放路径
	public static final String COMMON_DATE_FORMAT = rb.getString("common.date.format").trim();	//公用日期格式化标准格式DEFAULT_DATE_FORMAT
	public static final String CLASS_DIR_PATH = rb.getString("snmpDir").trim();	//生成的class文件路径
	
	public static final int MAX_ROOM_ROWS = Integer.parseInt(rb.getString("defaultRoomMaxRows").trim());//默认机房最大行数
	public static final int MAX_ROOM_Cols = Integer.parseInt(rb.getString("defaultRoomMaxCols").trim());//默认机房最大列数
	// =============错误信息代码库 关键字===========================	
	
/*	14	21	ProcessNotExist	进程不存在	目标进程不存在，用于Web、DC、NC、第三方监测线程、执行线程不存在等	1
	15	22	ThreadRuntimeError	执行异常	各程序代码执行异常，适用于Web、DC、NC、各部分程序线程执行错误	3
	16	23	HandShakeError	通讯握手失败	通讯握手失败，适用于web与DC握手，DC与NC握手	2
	17	24	ProtListenerError	端口监听失败	端口监听失败，适用于通讯服务端口监听和snmp服务端口监听失败情况	2
	18	25	DeamonNotExist	守护进程不存在	守护进程不存在，适用于NC守护进程未启动、DC守护进程未启动	2
	19	26	DataResoveError	数据解析错误	数据解析错误，适用于DC端各类信息解析异常情况	3
	20	27	SocketError	通讯失败	通讯过程中异常导致失败，适用于web、DC、NC 通讯线程异常情况	3
*/
	public static final String PROCESSS_NOT_EXIST = "ProcessNotExist";		//进程不存在
	public static final String HANDSHAKE_ERROR = "HandShakeError";			//握手失败
	public static final String THREAD_RUNTIME_ERROR = "ThreadRuntimeError";		//执行异常
	public static final String PROT_LISTENER_ERROR = "ProtListenerError";		//端口监听失败
	public static final String DEAMON_NOT_EXIST = "DeamonNotExist";			//守护进程不存在
	public static final String DATA_RESOVE_ERROR = "DataResoveError";		//数据解析错误
	public static final String SOCKET_ERROR = "SocketError";				//通讯失败
	
	public static final String NE_SYSTEM_INFO_CHECKTYPENAME = "system";//网元(newwork element)系统基础信息 监测类别名称
	//数据库类型：oracle、mysql
	public static final String DB_TYPE = rb.getString("db_type").trim();//数据库类型
	//当数据库类型为mysql时 wei true
	public static final boolean IS_MYSQL = "mysql".equalsIgnoreCase(Constant.DB_TYPE);
	
	public static final String NEXTVAL_FUNCTION_NAME = StringUtils.isNotBlank(rb.getString("nextval_function_name"))?rb.getString("nextval_function_name"):"nextval";
	public static final String CURRVAL_FUNCTION_NAME = StringUtils.isNotBlank(rb.getString("currval_function_name"))?rb.getString("currval_function_name"):"currval";
	
	
}
