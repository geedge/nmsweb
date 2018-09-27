package nis.nms.util;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.FilenameFilter;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.io.Serializable;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.ResourceBundle;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.jxls.transformer.XLSTransformer;
import nis.nms.bean.SetInfo;
import nis.nms.domains.DetectionSetInfo;
import nis.nms.domains.EventRecordLibrary;
import nis.nms.domains.ServerTable;
import nis.nms.domains.SystemTable;
import nis.nms.domains.TableDBOperationRpt;
import nis.nms.domains.TableLoginRpt;
import nis.nms.domains.XtYhJbxx;
import nis.nms.filter.I18n;
import nis.nms.service.CommonService;

import org.apache.commons.io.FileUtils;
import org.apache.commons.io.filefilter.FalseFileFilter;
import org.apache.commons.io.filefilter.FileFilterUtils;
import org.apache.commons.io.filefilter.PrefixFileFilter;
import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.struts2.ServletActionContext;

import com.nms.thread.socket.SocketClientServeice;
import com.opensymphony.xwork2.ActionSupport;


public abstract  class  BaseAction extends ActionSupport implements Serializable {
	
	Logger logger = Logger.getLogger(BaseAction.class);
	/**
	 * 监控设置信息变更请求命令
	 */
	private String WEB_NOTICE_SET_INFO_ALERT = "char:setInfoAlert";
	/**
	 * 节点或节点组状态变更请求命令
	 */
	private String WEB_NOTICE_NODE_AND_GROUP_STATE_ALERT = "char:nodeAndGroupAlert";
	/**
	 * 监控类别信息变更包括字段告警的变更请求命令
	 */
	private String WEB_NOTICE_CHECK_TYPE_ALERT = "char:checkTypeIdAlert";
	/**
	 * 任务信息变更请求命令
	 */
	private String WEB_NOTICE_MISSION_INFO_ALERT = "char:missionInfoAlert";
	
	/**
	 * 任务信息变更请求命令
	 */
	private String WEB_NOTICE_DATACONTROLLER = "char:Datacontroller";
	
	/**
	 * 节点是否报主动告警变更请求命令
	 */
	private String WEB_NOTICE_ACTIVE_ALARM_START_ALERT = "char:isActiveAlarmStart";
	
	/**
	 * 监控设置，下发第三方脚本
	 */
	private String SEND_PLUGIN_SCRIPT_FILE = "char:sendPluginScriptFile";
	
	
	@SuppressWarnings("unchecked")
	private CommonService commonService;
	
	@SuppressWarnings("unchecked")
	public CommonService getCommonService() {
		return commonService;
	}

	public void setCommonService(CommonService commonService) {
		this.commonService = commonService;
	}
	
	private String prevPageUrl;
	private String thisPageUrl;
	/**
	 * struts配置的默认调用的方法 Method execute
	 */
	@SuppressWarnings("unchecked")
	public String execute() {
		String result = "";
		String fsrc = this.getRequest().getRequestURI().replace("//", "/");
//		Map  paramsMap = this.getRequest().getParameterMap();
//		Iterator iter  = paramsMap.entrySet().iterator();
//		while (iter.hasNext()) {
//			Entry elem = (Entry) iter.next();
//			System.out.println("----- "+elem.getKey()+" = "+elem.getValue());
//		}
		String actionValue = this.getRequest().getParameter("action");
		if(StringUtils.isNotBlank(actionValue)){
			fsrc+="?action="+actionValue;
		}
		
//		System.out.println("-----fsrc "+fsrc);
//		String fsrc = uri.split(this.getRequest().getContextPath()+"/")[1];
		@SuppressWarnings("unused")
		String fid = null;
		try {
			this.getRequest().getServletPath();
			HttpSession session = this.getRequest().getSession();
			// 用户所要的功能包括按钮
			List<Map<String, Object>> userfunctionList = (List<Map<String, Object>>) session
					.getAttribute("userfunctionList");
			String requestSource=this.getRequest().getParameter("requestSource");
			if(requestSource!=null && !"".equals(requestSource)){
				result = this.executeAction();
			}else if(this.getRequest().getRequestURI().equalsIgnoreCase(this.getRequest().getContextPath()+"/sysManage/configureTheDiffusion.do")){
				//跳过第三方验证token信息 不校验其session直接访问action
				result=this.executeAction();
			}
			else if (userfunctionList == null || userfunctionList.isEmpty()) {// 如果没有权限调回登录页面
				result = this.logout();
			} else {
				// 3为功能节点 5为不显示的能节点
				for (Map<String, Object> hashMap : userfunctionList) {
					// 3为功能节点 5为不显示的能节点
						String temp = (String) hashMap.get("MKURL");
//						System.out.println("-----temp"+temp);
						if (temp != null && temp.indexOf("?") > -1){

							if ((hashMap.get("MKTYPE")==null||"0".equals(hashMap.get("MKTYPE").toString()))&&fsrc.equals((this.getRequest().getContextPath()+"/"+temp).replace("//", "/"))) {
									fid = (String) hashMap.get("ID");
//									System.out.println("-----fid "+fid);
									getRequest().getSession().setAttribute("prevPageUrl", (String) hashMap.get("MKURL"));
									getRequest().getSession().setAttribute("thisPageUrl", (String) hashMap.get("MKURL"));
									break;
							}
						}
				}
				
				// 查询菜单下面的功能节点
				List<ButtonBean> btnArrs = new ArrayList();
				for (Map<String, Object> hashMap : userfunctionList) {
					ButtonBean buttonbean = null;
					if (fid != null && fid.equals(hashMap.get("PID"))) {
						buttonbean = new ButtonBean();
						// 判断是否是按钮
						if ("1".equals((String) hashMap.get("MKTYPE"))) {
							buttonbean.setIstype(true);
						}
						buttonbean.setFext((String) hashMap.get("MKMC"));
						buttonbean.setFsrc((String) hashMap.get("MKURL"));
						buttonbean.setFunc((String) hashMap.get("HANDLER"));
						buttonbean.setFtype((String) hashMap.get("MKTYPE"));
						btnArrs.add(buttonbean);
					}
				}
				this.getRequest().setAttribute("buttonBean", btnArrs);
				result = this.executeAction();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	
	public Map<Long,Map<Long, String>> getTroubles(){
		return (Map<Long,Map<Long, String>>)this.getRequest().getSession().getServletContext().getAttribute("troubles");
	}
	public String logout(){
		HttpSession session = this.getRequest().getSession(false);
		if (session.isNew())
			System.out.println("session被重新创建了！");
		if (session != null) {
			XtYhJbxx user = (XtYhJbxx) session.getAttribute(Constant.SESSION_CZY_NAME);
			if (user != null) {
				XtYhJbxx.LONGIN_USER.remove(user.getYhbh());
				XtYhJbxx.LOGIN_SESSION.remove(user.getYhbh());
//				OnlineListener online = new OnlineListener();
//				online.sessionDestroyed(new HttpSessionEvent(session));
				// 使用户session失效
				session.invalidate();		
				this.saveLoginRpt("i18n_BaseAction.logout.susscess_n81i","i18n_BaseAction.logout.logout_n81i",user.getYhmc());//记录登陆日志
			}else{
				System.out.println("从session中没有取得人员信息！");
				//this.saveLoginRpt("session可能已过期","登出",user.getYhmc());//记录登陆日志
			}
		}
		
		return "logout";
	}
	
	/**
	 * @param status,login状态
	 * @param event,login行为
	 */
	public void saveLoginRpt(String status,String event,String yhmc){
		try {
			TableLoginRpt login = new TableLoginRpt();
			login.setAction(event);
			login.setStatus(status);
			login.setTime(new Date());
			login.setUsername(yhmc);
			login.setIp(this.getRequest().getRemoteAddr());
			this.commonService.save(login);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// 子类action需要重写的方法名称
	public abstract String executeAction() throws Exception;

	
	
//	private CommonService commonService;
	private static final long serialVersionUID = 7414962517552053966L;

	public static ResourceBundle rb = ResourceBundle.getBundle("myconfig");
	
	private String downLoadPath;//下载文件路径

	public int getDefaultPageSize(){
		return Integer.parseInt(rb.getString("defaultPageSize"));
//		rb.
	}
	
	public int getIsSingleLogin(){
		return Integer.parseInt(rb.getString("defaultSingleLogin"));
	}
	/**
	 * 判断当前登陆用户是否是超级管理员
	 * @time Feb 7, 2012-3:49:57 PM
	 * @return
	 */
	public boolean getAdminMark(){
		if(StringUtils.isNotEmpty(rb.getString("common.admin.mark")) && getUser()!=null){
			if(rb.getString("common.admin.mark").equals(getUser().getYhbh()) 
					|| getSystemID().equals(-1L)
					||"admin".equalsIgnoreCase(getUser().getYhbh())){
				return true;
			}else return false;
		}else
			return false;
	}
	/**
	 * 客户端Sorket 端口
	 * @time Aug 4, 2011-1:56:54 PM
	 * @return
	 */
	public String getClientSorketPort(){
		return rb.getString("nmsClientSorketPort").trim();
	}
	/**
	 * 字符编码
	 * @time Aug 4, 2011-1:56:54 PM
	 * @return
	 */
	public String getSSLSorketEncoding(){
		return rb.getString("ssl.sorket.encoding").trim();
	}
	/**
	 * 服务端Ip
	 * @time Aug 4, 2011-1:56:54 PM
	 * @return
	 */
	public String getServerIp(){
		return rb.getString("nmsServerIp").trim();
	}
	/**
	 * 服务端Sorket 端口
	 * @time Aug 4, 2011-1:56:54 PM
	 * @return
	 */
	public String getServerSorketPort(){
		return rb.getString("nmsServerSorketPort").trim();
	}
	public String getValue(String key){
		return rb.getString(key);
	}
	public ServletContext getServletContext() {
		return ServletActionContext.getServletContext();
	}
	public HttpServletRequest getRequest() {
		return ServletActionContext.getRequest();
	}

	public HttpServletResponse getResponse() {
		return ServletActionContext.getResponse();
	}

	public String object2Json(Object obj) {
		return JSONObject.fromObject(obj).toString();
	}

	public void outJson(Object obj) {
		outJsonString(JSONObject.fromObject(obj).toString());
	}

	public void outJsonArray(Object array) {
		/**
		 * 修改前 代码 
		 * 死循环
		 * outJsonArray(JSONArray.fromObject(array).toString());
		 */
		
		// 修改后代码
		outJsonString(JSONArray.fromObject(array).toString());
	}

	public void outJsonArray(List<?> list) {
		outJsonArray(JSONArray.fromObject(list).toString());
	}
	
	public void outString(String str) {
		try {
			PrintWriter out = getResponse().getWriter();
			out.write(str);
			out.flush();
			out.close();
		} catch (IOException e) {
		}
	}
	
	public void outTxt(String str) {
		try {
			PrintWriter out = getResponse().getWriter();
			out.println(str);
			out.flush();
			out.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	public void outHtmlString(String str) {
		getResponse().setContentType("text/html;charset=UTF-8");
		outString(str);
	}
	
	public void outJsonString(String str) {
		getResponse().setContentType("text/javascript;charset=UTF-8");
		outString(str);
	}

	public void outXMLString(String xmlStr) {
		getResponse().setContentType("application/xml");
		getResponse().setCharacterEncoding("utf-8");
		getResponse().setHeader("Cache-Control", "no-cache");
		outString(xmlStr);
	}
	public Long getUserID(){
		HttpSession session = getRequest().getSession(true);
		XtYhJbxx user = (XtYhJbxx)session.getAttribute(Constant.SESSION_CZY_NAME);
		//如果登录用户为空 ，则验证请求来源是否为空，不为空表示来自外部的请求，返回admin的ID
		if(user==null){
			String requestSource=this.getRequest().getParameter("requestSource");
			if(requestSource!=null && !"".equals(requestSource)){
				return 1l;
			}
		}
		return user.getYhid();
	}
	//获取当前业务系统ID
	public Long getSystemID(){
		HttpSession session = getRequest().getSession(true);
		Long systemId = (Long)session.getAttribute(Constant.SESSION_SYSTEM_LOGIN);
		return systemId;
	}
	
	//管理业务系统列表
	public List<SystemTable> getAllSystemInfo(CommonService commonService){
		List<SystemTable> sysList = null;
		try{
			String hql = "from SystemTable where systemState =0";
			sysList = commonService.find(hql);
		}catch (Exception e){
			e.printStackTrace();
		}
		return sysList;
	}
	
	/**
	 * 监测，任务 查看权限过滤 条件
	 * @param alias
	 * @return
	 */
	public String missionAuthHqlParams(String alias){
		String result = " 1=1 ";
		if(StringUtils.isNotBlank(alias)){
			alias = alias +".";
		}
		if (!this.getAdminMark()) { // 非管理员权限查看限制条件
			result = " (" + " ("+alias+"viewLevel=1 and "+alias+"userId=" + this.getUserID() + " and "+alias+"systemId= "+this.getSystemID() + "  )"
					+ " or ("+alias+"viewLevel=2 and "+alias+"systemId= "+this.getSystemID() + " and "+alias+"groupId in (select  x.jsbh from  XtYhJsIndex  x  where x.yhbh='"
					+ this.getUser().getYhbh() + "' and x.type = 1)) " + " or ("+alias+"viewLevel=3 and "+alias+"systemId= "+this.getSystemID() + ") or "+alias+"viewLevel = 4) ";
		}
		return result;
	}
	
	
	public XtYhJbxx getUser(){ 
		HttpSession session = getRequest().getSession(true);
		XtYhJbxx user = (XtYhJbxx)session.getAttribute(Constant.SESSION_CZY_NAME);
		return user;
	}
	public String getExp(List list,String name,String tem,List... lists) {
	    InputStream in = null;
	    OutputStream out = null;
		try {
		//导出excel时文件名带一个小尾巴
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH-mm-ss");
		//设置一下相应的文件格式和文件名
		HttpServletResponse response = getResponse();
	    response.reset();
	    response.setContentType("application/vnd.ms-excel;charset=GBK");
	    String filePath = name + "_" + format.format(new Date()) + ".xls";
	    response.setHeader("Content-Disposition","attachment; filename=\"" + new String(filePath.getBytes("GBK"),"ISO8859-1") + "\"");

	    HSSFWorkbook workbook;
	    //取得导出用的excel模板的绝对路径
	    String templateFileName = getServletContext().getRealPath("/") + "/Excel/templates/"+tem;
	    //得到导出的excel文件
	    in = new BufferedInputStream(new FileInputStream(templateFileName));
	    XLSTransformer transformer = new XLSTransformer();
	    Map map = new HashMap();
	    
	    map.put("list",list);
	    if(null!=lists&&lists.length>0){
	    	map.put("titleList",lists[0]);
	    } 
    	//封装对象
    	workbook = transformer.transformXLS(in,map);
    	//输出excel
    	out = response.getOutputStream();
    	workbook.write(out);
    	out.flush();
	    	
	    
	    
		} catch (Exception e) {
			e.printStackTrace();
			return "error";
		}finally {
		    //无论如何得关闭这个,节约用水...
		    if (in != null) {
		    try {
		      in.close();
			} catch (IOException ioe) {
				ioe.printStackTrace();
				return "error";
			}
		    }
		    if (out != null) {
			    try {
			      out.close();
				} catch (IOException ioe) {
					ioe.printStackTrace();
					return "error";
				}
			    }
		 }
		return null;
	}
	

	  /** 导出为txt文档 */
		public String expTxt(String content, String name) {
			try {
				// 导出excel时文件名带一个小尾巴
				SimpleDateFormat format = new SimpleDateFormat(
						"yyyy-MM-dd HH-mm-ss");
				// 设置一下相应的文件格式和文件名
				HttpServletResponse response = getResponse();
				response.reset();
				response.setContentType("application/msword;charset=UTF-8");
				String filePath = name + "_" + format.format(new Date()) + ".txt";
				//导出为xls文件
//				response.setContentType("application/vnd.ms-excel;charset=GBK");
//				String filePath = name + "_" + format.format(new Date()) + ".xls";
				response.setHeader("Content-Disposition", "attachment;filename=\""
						+ URLEncoder.encode(filePath, "UTF-8") + "\"");

				// 输出TXT
				outTxt(content);

			} catch (Exception e) {
				e.printStackTrace();
				return "error";
			}
			return null;
	}
		
		
	public void exportXls(List list,List nameList,List set,String name,String tem,List... lists)throws Exception{
		 
		OutputStream out = null;
		
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH-mm-ss");
		//设置一下相应的文件格式和文件名
		HttpServletResponse response = getResponse();
	    response.reset();
	    response.setContentType("application/vnd.ms-excel;charset=GBK");
	    String filePath = name + "_" + format.format(new Date()) + ".xls";
	    response.setHeader("Content-Disposition","attachment; filename=\"" + new String(filePath.getBytes("GBK"),"ISO8859-1") + "\"");

	    //取得导出用的excel模板的绝对路径
	    String templateFileName = getServletContext().getRealPath("/") + "/Excel/templates/"+tem;
	
		FileOutputStream fos = null;
		HSSFWorkbook wb = new HSSFWorkbook();
		
		try{
			fos = new FileOutputStream(new File(templateFileName));
			
			HSSFSheet statistic = wb.createSheet();
			HSSFRow row0 = statistic.createRow(0);
			row0.createCell((short)0).setCellValue(getI18nText("i18n_BaseAction.exportXls.date_n81i"));
			for(int t = 0 ; t < nameList.size() ; t++){
				Object  titlename = ((Object[])nameList.get(t))[1];
				row0.createCell((short)(t+1)).setCellValue((String)titlename);
			}
			for(int i=0;i<set.size();i++){
					String riq1=set.get(i).toString();
					HSSFRow row = statistic.createRow(i+1);
					row.createCell((short)(0)).setCellValue(riq1);
					for(int j=0;j<nameList.size();j++){
						Object  idname = ((Object[])nameList.get(j))[0];
						boolean boo=false;
						for(int o=0;o<list.size();o++){
							Object  sssssd = ((Object[])list.get(o))[0];
							Object  wewe = ((Object[])list.get(o))[1];
							Object  sdsds = ((Object[])list.get(o))[2];
							if((riq1).equals(sssssd+"")){
								if((idname.toString()).equals(wewe+"")){
										row.createCell((short)(j+1)).setCellValue((String)(sdsds+""));
										boo=true;
										continue;
										}	
							}
							
						}
						if(!boo){
							row.createCell((short)(j+1)).setCellValue("0");
						}
						
					}
				
			}
			out = response.getOutputStream();
			wb.write(out);
		}
		catch(IOException e){
			e.printStackTrace();
		}
		finally{
			fos.close();
		}
	}
	public void exportXls(List list,String nametitle,String name,String tem,List... lists)throws Exception{
		 
		OutputStream out = null;
		
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH-mm-ss");
		//设置一下相应的文件格式和文件名
		HttpServletResponse response = getResponse();
	    response.reset();
	    response.setContentType("application/vnd.ms-excel;charset=GBK");
	    String filePath = name + "_" + format.format(new Date()) + ".xls";
	    response.setHeader("Content-Disposition","attachment; filename=\"" + new String(filePath.getBytes("GBK"),"ISO8859-1") + "\"");

	    //取得导出用的excel模板的绝对路径
	    String templateFileName = getServletContext().getRealPath("/") + "/Excel/templates/"+tem;
	
		FileOutputStream fos = null;
		HSSFWorkbook wb = new HSSFWorkbook();
		
		try{
			fos = new FileOutputStream(new File(templateFileName));
			
			HSSFSheet statistic = wb.createSheet();
			HSSFRow row0 = statistic.createRow(0);
			row0.createCell((short)0).setCellValue(getI18nText("i18n_BaseAction.exportXls.date_n81i"));
			row0.createCell((short)(1)).setCellValue(nametitle+getI18nText("i18n_BaseAction.exportXls.num_n81i"));
			
			for(int i=0;i<list.size();i++){
				HSSFRow row = statistic.createRow(i+1);

				Object  sssssd = ((Object[])list.get(i))[0];
				Object  wewe = ((Object[])list.get(i))[1];
				row.createCell((short)(0)).setCellValue(sssssd+"");
				row.createCell((short)(1)).setCellValue(wewe+"");
					
			}
						
			out = response.getOutputStream();
			wb.write(out);
		}
		catch(IOException e){
			e.printStackTrace();
		}
		finally{
			fos.close();
		}
	}		
	//用户操作日志记录到数据库
	public void addDBOperationRpt(CommonService commonService,String sqlCondition,String tableName){
		
		try {
			TableDBOperationRpt log = new TableDBOperationRpt();
			
			log.setAction("SELECT");
			log.setObjtable(tableName);
			log.setTime(new Date());
			log.setSqlCondition(sqlCondition);
			if(this.getUser()==null){
				HttpSession session = getRequest().getSession();
				XtYhJbxx user = (XtYhJbxx)session.getAttribute(Constant.SESSION_CZY_NAME);
				log.setUsername(user.getYhmc());
			}else{
				log.setUsername(this.getUser().getYhmc());
			}			
			commonService.save(log);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	//用户操作日志记录到数据库，commonService，表名，setAction，之前插入/更新/删除的那个id
	public void addDBOperationRpt(CommonService commonService,String tableName,String action,Long id){
		
		try {
			TableDBOperationRpt log = new TableDBOperationRpt();
			
			log.setAction(action);
			log.setObjtable(tableName);
			log.setTime(new Date());
			log.setObjid(id);
			if(this.getUser()==null){
				HttpSession session = getRequest().getSession();
				XtYhJbxx user = (XtYhJbxx)session.getAttribute(Constant.SESSION_CZY_NAME);
				log.setUsername(user.getYhmc());
			}else{
				log.setUsername(this.getUser().getYhmc());
			}			
			commonService.save(log);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	//用户操作日志记录到数据库，commonService，表名，setAction，之前插入/更新/删除的那个id,sqlCondition
	public void addDBOperationRpt(CommonService commonService,String tableName,String action,Long id,String sqlCondition){
		
		try {
			TableDBOperationRpt log = new TableDBOperationRpt();
			
			log.setAction(action);
			log.setObjtable(tableName);
			log.setTime(new Date());
			log.setObjid(id);
			log.setSqlCondition(sqlCondition);
			if(this.getUser()==null){
				HttpSession session = getRequest().getSession();
				XtYhJbxx user = (XtYhJbxx)session.getAttribute(Constant.SESSION_CZY_NAME);
				log.setUsername(user.getYhmc());
			}else{
				log.setUsername(this.getUser().getYhmc());
			}			
			commonService.save(log);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	//用户操作日志记录到本地文件
	public void addUserLogToLocal(String sql) throws IOException{
		OutputStream fos = null;
		FileInputStream in = null;
		String date = new   SimpleDateFormat("yyyy-MM-dd").format(new   Date());
		String path = getServletContext().getRealPath("/")+"/userlog/";
		sql ="\n\r"+new   SimpleDateFormat("yyyy-MM-dd hh:mm:ss").format(new   Date())+"\t"+sql;
		try {
			if(new Boolean(rb.getString("isWriteLocalLog"))){
				System.out.println("写日志");
				File file = new File(path);
				if(file.exists()){
					path+="/"+date+"_log.txt";
					file = new File(path);
					if(!file.exists()){
						file.createNewFile();
					}				
					byte[] br = sql.getBytes();	
					fos = new BufferedOutputStream(new FileOutputStream(file,true));
					fos.write(br);	
					
					
				}else{
					file.mkdirs();
					path+="/"+date+"_log.txt";
					file = new File(path);
					if(!file.exists()){
						file.createNewFile();
					}
					fos = new BufferedOutputStream(new FileOutputStream(file,true));
					byte[] br = sql.getBytes();
					fos.write(br);				
				}			
			}			
		
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		}finally{
			if(fos!=null){
				fos.close();
			}
		}
	}
	/**
	 * 分隔形式的字符串转成Long[]
	 * 
	 * @param str
	 * @return
	 */
	public Long[] stringsToLong(String strSplit) {
		if (strSplit != null && strSplit.trim().length() > 0) {
			String[] strItems = strSplit.split(",");
			List longList = new ArrayList();
			for (int i = 0; i < strItems.length; i++) {
				String strItm = strItems[i];
				try {
					Long longItem = toLong(strItm);
					longList.add(longItem);
				} catch (Exception ex) {

				}

			}
			Long[] ls = new Long[longList.size()];
			longList.toArray(ls);
			return ls;
		}
		return new Long[] {};
	}
	
	/**
	 * String 转Long
	 * 
	 * @param str
	 * @return
	 */
	public Long toLong(String str) {
		try {
			if (isNotNull(str)) {
				long n = Long.parseLong(str.trim());
				return new Long(n);
			}
		} catch (Exception ex) {
			ex.printStackTrace();
			Float f = toFloat(str);
			if (f != null) {
				return new Long(f.longValue());
			}
		}
		return null;
	}
	
	/**
	 * String 转Long
	 * 
	 * @param str
	 * @return
	 */
	public Float toFloat(String str) {
		try {
			if (isNotNull(str)) {
				float f = Float.parseFloat(str.trim());
				return new Float(f);
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return null;
	}
	
	/**
	 * 判断字符串是否为空对象或空字符串，如果是则返回 False.
	 * 
	 * @param msg
	 *            字符串
	 * @return boolean 字符串为空则为False.
	 */
	public boolean isNotNull(String msg) {
		return !isNull(msg);
	}
	
	/**
	 * 判断字符串是否为空对象或空字符串，如果是则返回 True.
	 * 
	 * @param msg
	 *            字符串
	 * @return boolean 字符串为空则为True.
	 */
	public boolean isNull(String msg) {
		return (msg != null && msg.trim().length() > 0) ? false : true;
	}
	
	/**
	 * 分隔形式的字符串分隔为字符串集合
	 * @param 字符串
	 * @return
	 */
	public List stringsSplitToStringList(String strSplit) {
		List strList = new ArrayList();
		if (strSplit != null && strSplit.trim().length() > 0) {
			String[] strItems = strSplit.split("&");
			for (int i = 0; i < strItems.length; i++) {
				String str = strItems[i];
				if (!isNull(str)) {
					strList.add(str.trim());
				}
			}
		}
		return strList;
	}

	/**
	 * 分隔形式的字符串分隔为字符串数组
	 * 
	 * @param strSplit
	 * @return
	 */
	public String[] stringsSplitToStrings(String strSplit) {
		List strList = stringsSplitToStringList(strSplit);
		String[] strs = new String[strList.size()];
		strList.toArray(strs);
		return strs;
	}
	public String getConfigValue(String configName) {
		return rb.getString(configName);
	}
	// 将上传文件从零时文件夹复制到制定目录
	public static void copy(File srcTemp, File dest) {
		InputStream in = null;
		OutputStream out = null;
		try {
			in = new BufferedInputStream(new FileInputStream(srcTemp),100);
			out = new BufferedOutputStream(new FileOutputStream(dest),100);
			byte[] buffer = new byte[100];
			int len = 0;
			while ((len = in.read(buffer)) != -1) {
				out.write(buffer, 0, len);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (in != null) {
					in.close();
				}
				if (out != null) {
					out.close();
				}
			} catch (Exception e) {
				System.out.println(e);
			}
		}
	}
//	//下载文件
//	public String downLoad(){
//		try{
//			String path = ServletActionContext.getServletContext().getRealPath("/");
//			path = path.replace("\\", "/")+"/tool/";
//			downLoadPath = path + downLoadPath;
//			String fileName = downLoadPath.substring(downLoadPath.lastIndexOf("/")+1);
//			fileName = fileName.replace("\\", "/");
//			
//			File uploadFile = new File(downLoadPath);
//			FileInputStream fis = new FileInputStream(uploadFile);
//			BufferedInputStream bis = new BufferedInputStream(fis);
//			OutputStream fos = this.getResponse().getOutputStream();
//			this.getResponse().setContentType("application/octec-stream");
//			this.getResponse().setHeader("Content-disposition", "attachment;filename="
//					+ URLEncoder.encode(fileName, "utf-8"));
//			// 同上传类似使用输入输出流这里用的是缓冲输入输出流		
//			byte[] buffer = new byte[20480];
//			int len = 0;
//			while((len = bis.read(buffer)) !=-1){
//				fos.write(buffer, 0, len);
//			}
//			fos.close();
//			bis.close();		
//		}
//		catch (Exception e){
//			System.out.println(e);
//		}
//		return null;
//	}

	// 下载文件，上传文件时添加的URL上为http://******，将其用本地文件路径替换，并下载
	public String downLoad(String downLoadPath,String path) {
		System.out.println("原downLoadPath:"+downLoadPath);
		OutputStream out = null;
		BufferedInputStream br = null;
		try {
			String urlPath = getConfigValue("uploadServerPath");
			// String downLoadPathConfig = getConfigValue("downLoadPath");
			// downLoadPath = downLoadPath.replace(downLoadPathConfig, urlPath);
			// modify by zx 2010-12-23 修改下载路径替换机制，改为截取拼接
			if(downLoadPath
					.indexOf("downLoad/") != -1){
				downLoadPath = downLoadPath.substring( downLoadPath
						.indexOf("downLoad/"));
				downLoadPath = downLoadPath
				.substring(downLoadPath.indexOf("/") + 1);
			}
			/*downLoadPath = downLoadPath.substring(downLoadPath
					.indexOf("downLoad/") == -1 ? 0 : downLoadPath
					.indexOf("downLoad/"));
			downLoadPath = downLoadPath
					.substring(downLoadPath.indexOf("/") + 1);*/
			// downLoadPath=URLDecoder.decode(downLoadPath,"utf-8");
			// System.out.println("downloadPath11\t"+downLoadPath);
			String fileName = downLoadPath;
			String fileNameChange = fileName;
			// add by zx
			// 如果是抓包文件名。包含了抓包文件夹的名字，且和实际文件名一样。所以不用再做处理
			fileNameChange = Common.removeTimeTagForDownLoad(fileName);

			downLoadPath = urlPath + File.separator + fileName;

			System.out.println("完整后的downLoadPath:"+downLoadPath);
			File downLoadFile = new File(downLoadPath);
			if (!downLoadFile.exists()) {
				 this.outHtmlString("<script>alert('i18n_BaseAction.exportXls.fileNotExists_n81i');this.location='"+path+"';</script>");
			 return null;
			}
			// 防止中文乱码
			HttpServletResponse response = getResponse();
			response.setContentType("application/octet-stream");
			response.setHeader("Content-Disposition", "attachment;filename=\""
					+ URLEncoder.encode(fileNameChange, "UTF-8") + "\"");
			response.setContentLength((int) downLoadFile.length());
			out = response.getOutputStream();
			br = new BufferedInputStream(new FileInputStream(downLoadFile),
					100);
			byte[] buffer = new byte[100];
			int len = 0;
			while ((len = br.read(buffer)) != -1) {
				out.write(buffer, 0, len);
			}
			out.flush();
			// out.close();
			// br.close();
		} catch (Exception e) {
//			e.printStackTrace();
			System.out.println(e);
		} finally {
			try {
				if (br != null) {
					br.close();
				}
				if (out != null) {
					out.close();
				}
			} catch (Exception e) {
				System.out.println(e);
			}
		}
		return null;
	}	
	public void outAjaxString(String xmlStr) {
		try {
			getResponse().setContentType("application/xml");
			getResponse().setCharacterEncoding("utf-8");
			getResponse().setHeader("Cache-Control", "no-cache");
			PrintWriter out = getResponse().getWriter();
			out.println(xmlStr);
			out.close();
			// outString(xmlStr);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	public Long getVersion() {
//		commonService.get(id)
		return null;
	}
	/** 下载系统自己带的一些文件 */
	public String downLoadLocal(String downLoadPath) {
		OutputStream out = null;
		BufferedInputStream br = null;
		try {
			HttpServletResponse response = getResponse();
			response.setContentType("application/octet-stream");
			String fileName = downLoadPath.substring(downLoadPath
					.lastIndexOf("/") + 1, downLoadPath.length());
			// 防止中文乱码
			response.setHeader("Content-Disposition", "attachment;filename=\""
					+ URLEncoder.encode(fileName, "UTF-8") + "\"");

			File downLoadFile = new File(downLoadPath);
			response.setContentLength((int) downLoadFile.length());
			out = response.getOutputStream();
			br = new BufferedInputStream(new FileInputStream(downLoadFile),
					100);
			byte[] buffer = new byte[100];
			int len = 0;
			while ((len = br.read(buffer)) != -1) {
				out.write(buffer, 0, len);
			}
			out.flush();
			/*
			 * out.close(); br.close();
			 */
		} catch (Exception e) {
			System.out.println(e);
		} finally {
			try {
				if (out != null) {
					out.close();
				}
				if (br != null) {
					br.close();
				}
			} catch (Exception e) {
				System.out.println(e);
			}
		}
		return null;
	}
	
	/**
	 * Socket 发送监控设置变更信息
	 * 将需要变更的监控设置发送给NMSServer
	 * 如果old不为空，则先取消old监控设置
	 * 再添加news 监控设置
	 * @time Aug 4, 2011-5:27:39 PM
	 * @param old	可以为空
	 * @param news	不能为空
	 */
	public boolean sendSetInfo(DetectionSetInfo old,DetectionSetInfo news ,final CommonService commonService){
		if(news==null){
			return false;
		}
		//--old 不为空时，填入old信息
		SetInfo o = null;
		if(old != null){
			o = new SetInfo();
			o.setId(old.getId());
			o.setCheckTypeId(old.getCheckTypeInfo().getId());
			o.setCheckTypeName(old.getCheckTypeInfo().getCheckTypeName());
			o.setProcessIden(old.getProcessIden());
			o.setNodeGroupsId(old.getNodeGroupsId());
			o.setNodeIpsId(old.getNodeIpsId());
//			o.setGroupId(old.getNodegroup()==null?null:old.getNodegroup().getGroupId());
//			o.setNodeIp(old.getNodeIp());
			o.setCheckWay(old.getCheckWay());
		}
		//--news 填入
		SetInfo n = new SetInfo();
		n.setId(news.getId());
		n.setCheckTypeId(news.getCheckTypeInfo().getId());
		n.setCheckTypeName(news.getCheckTypeInfo().getCheckTypeName());
		n.setProcessIden(news.getProcessIden());
		n.setNodeGroupsId(news.getNodeGroupsId());
		n.setNodeIpsId(news.getNodeIpsId());
//		n.setGroupId(news.getNodegroup()==null?null:news.getNodegroup().getGroupId());
//		n.setNodeIp(news.getNodeIp());
		n.setCheckWay(news.getCheckWay());
		try {
			final JSONObject jObject = new JSONObject();
			jObject.put("old", o);
			jObject.put("new", n);
				List<ServerTable> stList = getALlNMSServerList(commonService);
				if(stList!= null && stList.size()>0){
					for(final ServerTable st : stList){
							new Thread(new Runnable(){

								@Override
								public void run() {
									
									try {
										new SocketClientServeice(st.getServerIp()).sendInfoToServer(WEB_NOTICE_SET_INFO_ALERT,jObject.toString());
									} catch (Exception e) {
										EventRecordLibrary library = new EventRecordLibrary();
										library.setRecordCommand(WEB_NOTICE_SET_INFO_ALERT);
										library.setRecordContent(jObject.toString());
										library.setRecordType("W2S");
										library.setState(1l);
										library.setNmsserverId(st.getId());
										library.setCreateTime(new Date());
										try {
											commonService.save(library);
										} catch (Exception e1) {
											e1.printStackTrace();
										}
										logger.error("Monitoring setting to change communication anomalies: " + e.getMessage());
									}
								}
								
							}).start();
					}
				}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return true;
	}
	
	/**
	 * 根据检测设置获取对应脚本文件
	 * 
	 * @param setInfo
	 * @return
	 * @throws Exception
	 */
	protected File getPluginFilesBySetInfo(DetectionSetInfo setInfo) {
		
		String uploadFilePath = getConfigValue("uploadServerPath");
		File pluginScriptDir = new File(uploadFilePath, "pluginDetecScript");
		if (!pluginScriptDir.exists()) {
			pluginScriptDir.mkdirs();
		}
		
		final String keyword = "_" + setInfo.getProcessIden() + ".";
		Collection<?> files = FileUtils.listFiles(pluginScriptDir, 
				FileFilterUtils.asFileFilter(new FilenameFilter() {
					@Override
					public boolean accept(File dir, String name) {
						return name.contains(keyword);
					}
				}),
				FalseFileFilter.FALSE);

		if (files.isEmpty()) {
			logger.info("未找到监测设置对应的脚本文件！");
			return null;
		}
		File file = (File) files.iterator().next();
		return file;
	}
	
	/**
	 * @param scriptName
	 * @return
	 * @throws Exception
	 */
	protected File getPluginFilesBySetInfo(final String scriptName) {
		
		String uploadFilePath = getConfigValue("uploadServerPath");
		File pluginScriptDir = new File(uploadFilePath, "pluginDetecScript");
		if (!pluginScriptDir.exists()) {
			pluginScriptDir.mkdirs();
		}
		
		Collection<?> files = FileUtils.listFiles(pluginScriptDir, 
				FileFilterUtils.asFileFilter(new FilenameFilter() {
					@Override
					public boolean accept(File dir, String name) {
						return name.contains(scriptName);
					}
				}),
				FalseFileFilter.FALSE);

		if (files.isEmpty()) {
			return null;
		}
		File file = (File) files.iterator().next();
		return file;
	}
	
	/**
	 * Socket 发送第三方监测脚本文件
	 * @param myFile 
	 */
	protected void sendPluginFile(DetectionSetInfo old, DetectionSetInfo news, File myFile, final CommonService<?> commonService) {
		
		try {
			final List<File> pluginFiles = new ArrayList<File>();
			
			// NC周期启动，有效监测，上传脚本非空
			if ("2".equals(news.getIsControlStart())
					&& (StringUtils.isBlank(news.getDetectionSetState()) || "1".equals(news.getDetectionSetState()))
					) {

				if (old == null // 新增
						|| "0".equals(old.getDetectionSetState()) // 无效改为有效
						|| "0".equals(old.getIsControlStart()) // 手动改为NC启动
						|| (!StringUtils.equalsIgnoreCase(news.getNodeGroupsId(), old.getNodeGroupsId())) // 节点组范围变更
						|| (!StringUtils.equalsIgnoreCase(news.getNodeIpsId(), old.getNodeIpsId())) // 节点范围变更
						|| myFile != null	// 页面上传脚本文件
				) {
					File pluginFile = getPluginFilesBySetInfo(news);
					if(pluginFile != null) {
						pluginFiles.add(pluginFile);
					}
				}
			}
			
			// 脚本列表非空时下发脚本
			if(!pluginFiles.isEmpty()) {
				List<ServerTable> stList = getALlNMSServerList(commonService);
				if (stList != null && stList.size() > 0) {
					for (final ServerTable st : stList) {
						new Thread(new Runnable() {
							@Override
							public void run() {
								try {
									new SocketClientServeice(st.getServerIp()).
											sendFilesToServer(SEND_PLUGIN_SCRIPT_FILE, pluginFiles);
								} catch (Exception e) {
									logger.error("Script send failure, " + e.getMessage());
									
									Map<String, String> recordContent = new HashMap<String, String>();
									HashSet<String> pluginFileNames = new HashSet<String>();
									for (File pluginFile : pluginFiles) {
										pluginFileNames.add(pluginFile.getName());
									}
									String content = StringUtils.join(pluginFileNames.iterator(), "，");
									recordContent.put("scriptNames", content);
									EventRecordLibrary library = new EventRecordLibrary();
									library.setRecordType("W2S");
									library.setRecordCommand(SEND_PLUGIN_SCRIPT_FILE);
									library.setRecordContent(JSONObject.fromObject(recordContent).toString());
									library.setState(1L);
									library.setNmsserverId(st.getId());
									library.setCreateTime(new Date());
									try {
										commonService.save(library);
									} catch (Exception e1) {
										e1.printStackTrace();
									}
									
								}
							}
						}).start();
					}
				}
			}
		} catch (Exception e) {
			logger.error("Script send failure", e);
		}
	}
	
	/**
	 * Socket 发送第三方监测脚本文件
	 */
	@SuppressWarnings("unchecked")
	protected void sendPluginFile(Long nodeGroupId, Long nodeId, final CommonService<?> commonService) {
		try {
		String sql = "select distinct id||'_' from("
					+ " select dsi.ID,"
					+ " dsi.process_iden, dsi.is_control_start,"
					+ " dsi.NODE_IPS_ID, dsi.NODE_GROUPS_ID,"
					+ " ngt.group_id node_group_id"
				+ " from detection_set_info dsi"
				+ " left join nodegroup_table ngt"
					+ " on ('0,' || dsi.node_groups_id || ',0' like '%,' || ngt.group_id || ',%')"
				+ " left join node_table nt"
					+ " on ('0,' || dsi.node_ips_id || ',0' like '%,' || nt.node_id || ',%')"
				+ " where and dsi.detection_set_state = 1 and dsi.is_control_start = 2"
				+ ")t"
			+ " where 1<>1";
			if(nodeId!=null) {
				sql += " or(','||t.node_ips_id||',' like '%,"+nodeId+",%')";
			}
			//@2018-3-9 fang 修改 首先查询符合条件的id，在拼接sql，适配mysql
			String groupIdSql = "select group_id from nodegroup_table t where 1=1 ";
			String ids = this.commonService.getGroupIdStartWith(groupIdSql, "t.group_id = " +nodeGroupId);
			/*sql += " or(t.node_ips_id is null and t.node_group_id in(select group_id"
					+ " from nodegroup_table t"
					+ " start with t.group_id = " +nodeGroupId+ " connect by prior t.group_id = parent_group_id))"*/
			sql += " or ( t.node_ips_id is null and t.node_group_id in("+ids+")"
			+ " or(t.node_ips_id is null and t.node_groups_id is null)"
			;
		
			List<?> SetInfoIdList = commonService.executeSQL(sql);
			String uploadFilePath = getConfigValue("uploadServerPath");
			File pluginScriptDir = new File(uploadFilePath, "pluginDetecScript");
			Collection<?> files = FileUtils.listFiles(pluginScriptDir, new PrefixFileFilter(SetInfoIdList),
					FalseFileFilter.FALSE);
			final List<File> pluginFiles = new ArrayList<File>();
			pluginFiles.addAll((Collection<? extends File>) files);
			
			// 脚本列表非空时下发脚本
			if(!pluginFiles.isEmpty()) {
				List<ServerTable> stList = getALlNMSServerList(commonService);
				if (stList != null && stList.size() > 0) {
					for (final ServerTable st : stList) {
						new Thread(new Runnable() {
							@Override
							public void run() {
								try {
									new SocketClientServeice(st.getServerIp()).
											sendFilesToServer(SEND_PLUGIN_SCRIPT_FILE, pluginFiles);
								} catch (Exception e) {
									logger.error("Script send failure, " + e.getMessage());
									
									Map<String, String> recordContent = new HashMap<String, String>();
									HashSet<String> pluginFileNames = new HashSet<String>();
									for (File pluginFile : pluginFiles) {
										pluginFileNames.add(pluginFile.getName());
									}
									String content = StringUtils.join(pluginFileNames.iterator(), "，");
									recordContent.put("scriptNames", content);
									
									EventRecordLibrary library = new EventRecordLibrary();
									library.setRecordType("W2S");
									library.setRecordCommand(SEND_PLUGIN_SCRIPT_FILE);
									library.setRecordContent(JSONArray.fromObject(recordContent).toString());
									library.setState(1L);
									library.setNmsserverId(st.getId());
									library.setCreateTime(new Date());
									try {
										commonService.save(library);
									} catch (Exception e1) {
										e1.printStackTrace();
									}
									
								}
							}
						}).start();
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public List<ServerTable> getALlNMSServerList(CommonService commonService) {
		String hql = "from ServerTable st where st.serverState=0";
		try {
			return commonService.find(hql);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	/**
	 * Socket 发送节点和节点组状态变更的ID
	 * 将需要变更信息的ID发送给NMSServer
	 * @time Aug 4, 2011-5:27:39 PM
	 * @param nodeGroupId	不能为空
	 * @param nodeId	可以为空 表示是组状态变更
	 */
	public boolean sendNodeAndGroupId(Long nodeGroupId,Long nodeId,final CommonService commonService){
		if(nodeGroupId==null){
			return false;
		}
		try {
			final String str = (nodeGroupId == null ? "" : nodeGroupId.longValue()) + ":"	+ (nodeId == null ? "" : nodeId.longValue());
				List<ServerTable> stList = getALlNMSServerList(commonService);
				if(stList!= null && stList.size()>0){
					for(final ServerTable st : stList){
							new Thread(new Runnable(){

								@Override
								public void run() {
									try {
									new SocketClientServeice(st.getServerIp()).sendInfoToServer(WEB_NOTICE_NODE_AND_GROUP_STATE_ALERT,str);
									} catch (Exception e) {
										e.printStackTrace();
										EventRecordLibrary library = new EventRecordLibrary();
										library.setRecordCommand(WEB_NOTICE_NODE_AND_GROUP_STATE_ALERT);
										library.setRecordContent(str);
										library.setRecordType("W2S");
										library.setState(1l);
										library.setNmsserverId(st.getId());
										library.setCreateTime(new Date());
										try {
											commonService.save(library);
										} catch (Exception e1) {
											e1.printStackTrace();
										}
									}
								}
								
							}).start();
					}
				}
		} catch (Exception e) {
			logger.error("Node state change communication exception",e);
		}
		return true;
	}
	
	/**
	 * 
	 * Socket 发送NC端是否报主动告警
	 * 将NC是否报主动告警发送给NMSServer（即DC），NMSServer再发送给管理的NC
	 * @author Administrator May 26, 2014
	 * @version 1.0 
	 * @param startActiveAlarmState：true：NC报主动告警，false：NC不报主动告警
	 * @param commonService
	 * @return
	 */
	public boolean sendStartActiveAlarmState(Boolean startActiveAlarmState,final CommonService commonService){
		try {
			
			final JSONObject jObject = new JSONObject();
			jObject.put("showAutoAlarm", startActiveAlarmState == null ? false : startActiveAlarmState);
			jObject.put("webHandleTime", DateUtil.getCurDateStr());
				
			
			List<ServerTable> stList = getALlNMSServerList(commonService);
			if(stList!= null && stList.size()>0){
				for(final ServerTable st : stList){//循环给所有的DC发送信息（一个DC开启一个线程）
					new Thread(new Runnable(){
						
						@Override
						public void run() {
							try {
								new SocketClientServeice(st.getServerIp()).sendInfoToServer(WEB_NOTICE_ACTIVE_ALARM_START_ALERT,jObject.toString());
							} catch (Exception e) {
								e.printStackTrace();
								
								try {
									List list = commonService.find("from EventRecordLibrary where recordType='W2S' and recordCommand='"+WEB_NOTICE_ACTIVE_ALARM_START_ALERT+"' and nmsserverId="+st.getId());
									EventRecordLibrary library = new EventRecordLibrary();
									if (list != null && list.size() > 0) {
										library = (EventRecordLibrary)list.get(0);
										
										library.setRecordCommand(WEB_NOTICE_ACTIVE_ALARM_START_ALERT);
										library.setRecordContent(jObject.toString());
										library.setRecordType("W2S");
										library.setState(1l);
										library.setNmsserverId(st.getId());
										library.setCreateTime(new Date());
										
										commonService.update(library);
									}else {										
										library.setRecordCommand(WEB_NOTICE_ACTIVE_ALARM_START_ALERT);
										library.setRecordContent(jObject.toString());
										library.setRecordType("W2S");
										library.setState(1l);
										library.setNmsserverId(st.getId());
										library.setCreateTime(new Date());
										commonService.save(library);
									}
									
								} catch (Exception e1) {
									e1.printStackTrace();
								}
							}
						}
						
					}).start();
				}
			}
		} catch (Exception e) {
			logger.error("Whether the node reports the exception of the active alarm communication ",e);
		}
		return true;
	}
	
	/**
	 * Socket 发送监控设置类别ID
	 * 当监控设置类别及其相关信息变更时
	 * 此通讯方法实现NMSServer端对应监控设置类别及相关信息的更新
	 * @time Aug 4, 2011-5:27:39 PM
	 * @param checkTypeId
	 */
	public boolean sendCheckTypeId(final String checkTypeId,final CommonService commonService){
		if(StringUtils.isEmpty(checkTypeId)){
			return false;
		}
		try {
				List<ServerTable> stList = getALlNMSServerList(commonService);
				if(stList!= null && stList.size()>0){
					for(final ServerTable st : stList){
							new Thread(new Runnable(){

								@Override
								public void run() {
									try {
										new SocketClientServeice(st.getServerIp()).sendInfoToServer(WEB_NOTICE_CHECK_TYPE_ALERT,checkTypeId);
									} catch (Exception e) {
										e.printStackTrace();
										EventRecordLibrary library = new EventRecordLibrary();
										library.setRecordCommand(WEB_NOTICE_CHECK_TYPE_ALERT);
										library.setRecordContent(checkTypeId);
										library.setRecordType("W2S");
										library.setState(1l);
										library.setCreateTime(new Date());
										library.setNmsserverId(st.getId());
										try {
											commonService.save(library);
										} catch (Exception e1) {
											e1.printStackTrace();
										}
									}
									
								}
								
							}).start();
					}
				}
		} catch (Exception e) {
			logger.error("Monitor category change communication exception",e);
		}
		return true;
	}
	
	/**
	 * Socket 发送信息
	 * 将socket信息发送给NMSServer端
	 * @time Aug 4, 2011-5:27:39 PM
	 * @param old
	 * @param news
	 */
	public boolean sendMissionInfoId(Long missionId,Long rollback,final CommonService commonService){
		try {
			final String str = missionId.longValue() + ":"+ (rollback == null ? "" : rollback.longValue());
			try {
				List<ServerTable> stList = getALlNMSServerList(commonService);
				if(stList!= null && stList.size()>0){
					for(final ServerTable st : stList){
							new Thread(new Runnable(){
								@Override
								public void run() {
									try {
										new SocketClientServeice(st.getServerIp()).sendInfoToServer(WEB_NOTICE_MISSION_INFO_ALERT,str);
									} catch (Exception e) {
										e.printStackTrace();
										EventRecordLibrary library = new EventRecordLibrary();
										library.setRecordCommand(WEB_NOTICE_MISSION_INFO_ALERT);
										library.setRecordContent(str);
										library.setRecordType("W2S");
										library.setState(1l);
										library.setCreateTime(new Date());
										library.setNmsserverId(st.getId());
										try {
											commonService.save(library);
										} catch (Exception e1) {
											e1.printStackTrace();
										}
									}
								}
							}).start();
					}
				}
			} catch (Exception e) {
				logger.error("Mission"+missionId+"information change communication exception",e);
			}
		} catch (Exception e) {
			logger.error("Mission"+missionId+"information change communication exception",e);
		}
		return true;
	}
	/**
	 * Socket 发送信息
	 * 将socket信息发送给NMSServer端
	 * 用户NMSServer更新NMSServerParameters
	 * @time Aug 4, 2011-5:27:39 PM
	 * @param old
	 * @param news
	 */
	public boolean sendDataControllerReset(final Long dcId,final String ip,final CommonService commonService){
/*		try {
//			List<ServerTable> stList = getALlNMSServerList(commonService);
			
		} catch (Exception e) {
			logger.error("信息变更 通讯异常",e);
		}*/
			try {
				new Thread(new Runnable(){
					@Override
					public void run() {
						String content =  "1";
						try {
							new SocketClientServeice(ip).sendInfoToServer(WEB_NOTICE_DATACONTROLLER,content);
						} catch (Exception e) {
							e.printStackTrace();
							EventRecordLibrary library = new EventRecordLibrary();
							library.setRecordCommand(WEB_NOTICE_DATACONTROLLER);
							library.setRecordContent(content);
							library.setRecordType("W2S");
							library.setState(1l);
							library.setCreateTime(new Date());
							library.setNmsserverId(dcId);
							try {
								commonService.save(library);
							} catch (Exception e1) {
								e1.printStackTrace();
							}
						}
					}
				}).start();
				logger.debug("变更DC信息 ");
			} catch (Exception e) {
				logger.error("Information change communication anomaly",e);
			}
		return true;
	}
	
	/**
	 * i18n 替换
	 */
	public static String getI18nText(String content,String ...params){
		Locale l  = (Locale)ServletActionContext.getRequest().getSession().getAttribute("i18n_lang");
		return I18n.trans(content, l,params);
	}
	
	public Long getDeptFlag(){
		Long deptFlag =(Long)this.getRequest().getSession().getAttribute(Constant.DEPT_FLAG);
		return deptFlag;
	}
	public static void main(String[] args) {
//		BaseAction ba = new BaseAction();
//		String str = "a=aaa b=bbb c=ccc d=ddd";
//		String[] s = {"a", "c"};
//		System.out.println(ba.readFileForArray(str, s));		
	}
	public String getDownLoadPath() {
		return downLoadPath;
	}
	public void setDownLoadPath(String downLoadPath) {
		this.downLoadPath = downLoadPath;
	}
	public static ResourceBundle getRb() {
		return rb;
	}
	public static void setRb(ResourceBundle rb) {
		BaseAction.rb = rb;
	}

	public String getPrevPageUrl() {
		return prevPageUrl;
	}

	public void setPrevPageUrl(String prevPageUrl) {
		this.prevPageUrl = prevPageUrl;
	}

	public String getThisPageUrl() {
		return thisPageUrl;
	}

	public void setThisPageUrl(String thisPageUrl) {
		this.thisPageUrl = thisPageUrl;
	}
}
