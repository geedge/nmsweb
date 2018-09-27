package nis.nms.web.actions;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.LinkedList;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionEvent;

import org.apache.commons.lang.StringUtils;
import org.apache.struts2.config.Result;
import org.apache.struts2.config.Results;

import com.nis.util.StringUtil;

import nis.nms.core.Constants;
import nis.nms.core.Resource;
import nis.nms.domains.TableDepartment;
import nis.nms.domains.TableLoginRpt;
import nis.nms.domains.TableUserDepartment;
import nis.nms.domains.XtJsJbxx;
import nis.nms.domains.XtYhJbxx;
import nis.nms.domains.XtYhJsIndex;
import nis.nms.service.CommonService;
import nis.nms.util.BaseAction;
import nis.nms.util.Constant;
import nis.nms.util.MD5;
import nis.nms.util.OnlineListener;



@SuppressWarnings("unchecked")
@Results( {    
	@Result(name="ok", value = "/main.jsp"),
	//updateUserPassword.jsp
	///modifyPwd.jsp
	@Result(name="modifyPwd", value="/page/system/fourceModifyUserPwd.jsp"),
	@Result(name="systemSelect", value = "systemSelect.jsp"),
	@Result(name="back", value = "/login.jsp"),
	@Result(name="logout", value = "/login.jsp?i18n_lang=${i18n_lang}"),
	@Result(name="test", value = "2.jsp"),
	@Result(name = "error", value = "/error.jsp")
})
public class LoginAction extends BaseAction {
	
	private static final long serialVersionUID = 1L;
	private CommonService commonService;
	private XtYhJbxx logInInfo;
	private List<XtYhJbxx> userInfoList = new ArrayList();
	

	public String executeAction() throws Exception {
		return login();
	}
	
	public String login() {
		try {
			if(logInInfo!=null){
				MD5 md5 = new MD5();
				//用户使用用户代码和用户密码登陆
				String sql = " from XtYhJbxx where yhbh = '" + logInInfo.getYhmc().trim() + "' and yhmm = '" + md5.getMD5Code(logInInfo.getYhmm().trim()) +"' ";
				userInfoList = this.commonService.find(sql);
				if(userInfoList != null && userInfoList.size() > 0){
					XtYhJbxx userInfo = (XtYhJbxx)userInfoList.get(0);
					if(userInfo.getZxbz().equals("1")){
						outHtmlString("<script type=\"text/javascript\">alert('i18n_LoginAction.login.userLocked_n81i');this.location='login.jsp'</script>");
						return null;
					}
					
					//判断部门
					/*2018-09-19新增根据deptflag判断是否启用用户部门管理 0:启用 1：不启用*/
					Long deptflag =(Long) this.getRequest().getSession().getAttribute(Constant.DEPT_FLAG);
					try {
						if(deptflag==null){
							sql="select t.type_state from type_table t where t.type_identity = ?";
							List list = this.commonService.executeSQL(sql, "deptflag");
							if(list!=null&&list.size()>0){
								deptflag = ((BigDecimal) list.get(0)).longValue();
							}else{
								deptflag=1L;
							}
							System.out.println("是否启用部门管理功能："+(deptflag==0?"启用":"关闭"));
							this.getRequest().getSession().setAttribute(Constant.DEPT_FLAG, deptflag);
						}
						
					} catch (Exception e) {
						System.out.println("get dept flag faild"+e);
					}
						
					
					if(!"admin".equalsIgnoreCase(userInfo.getYhbh())&&deptflag==0){
						XtYhJbxx checkDeptUser = this.getYhJbxx(userInfo);
						List ll = checkDeptUser.getUserDeptList();
						boolean isDeptstate = false;
						if(ll!=null && ll.size()>0){
							for(int g=0;g<ll.size();g++){
								TableDepartment td = (TableDepartment)ll.get(g);
								if(td.getDeptstate().equals("0")){
									isDeptstate = true;
									break;
								}
							}
						}
						
						if(!isDeptstate){//false说明此用户所在部门全部无效，故禁止登录
							outHtmlString("<script type=\"text/javascript\">alert('i18n_LoginAction.login.deptLocked_n81i');this.location='login.jsp'</script>");
							return null;
						}
					}
					
					
					HttpSession session = getRequest().getSession(true);  // true
					this.getRequest().getSession().removeAttribute(Constant.SESSION_SYSTEM_LOGIN);
					this.getRequest().getSession().removeAttribute(Constant.SESSION_SYSTEM_LOGIN_NAME);
					
					try {
						/*2018-08-30将 是否启用邮件标识 加入session*/
						Long emailFlag = (Long)this.getRequest().getSession().getAttribute(Constant.EMAIL_FLAG);
						
						if(emailFlag==null){
							sql="select t.type_state from type_table t where t.type_identity = ?";
							List list = this.commonService.executeSQL(sql, "emailflag");
							if(list!=null&&list.size()>0){
								emailFlag = ((BigDecimal) list.get(0)).longValue();
							}else{
								emailFlag=1L;
							}
							System.out.println("是否启用邮件功能："+(emailFlag==0?"启用":"关闭"));
							this.getRequest().getSession().setAttribute(Constant.EMAIL_FLAG, emailFlag);
						}
						
					} catch (Exception e) {
						System.out.println("get email flag faild"+e);
					}
					
					/*2018-09-12新增配置属性NATION_ROLE，标识管理角色*/
					this.getRequest().getSession().setAttribute("nationRole", Constants.NATION_ROLE);
					// 判断重复登陆
					if (XtYhJbxx.LONGIN_USER != null)
					{// 存在在线用户
						boolean isLogin = false;
						if (XtYhJbxx.LONGIN_USER.contains(userInfo.getYhid()))
							isLogin = true;
						if (isLogin)//在线用户中包括正在登陆的用户
						{
//							if(this.getIsSingleLogin()==0){//启用单点登录
//								outHtmlString("<script type=\"text/javascript\">alert('此用户已登录,请选择其他用户登录');this.location='login.html'</script>");
//								this.saveLoginRpt("重复登录,失败","登入",userInfo.getYhmc());//记录登陆日志
//								return null;
//							}
							HttpSession sessionold = (HttpSession) XtYhJbxx.LOGIN_SESSION
									.get(userInfo.getYhid());// 如果用户已经登录，则取出之前登录的session信息
							try
							{
								if (sessionold != null)
								{
									if(!session.getId().equals(sessionold.getId())){//如果新的sessionid不等于旧的sessionid(新打开浏览器)
										if(this.getIsSingleLogin()==0){//启用单点登录
											sessionold.invalidate();// 将旧的session信息销毁
										}
									}else {//处理登录登出异常操作
										XtYhJbxx user = (XtYhJbxx) session.getAttribute(Constant.SESSION_CZY_NAME);//获取之前登录用户的session
										if(!userInfo.getYhid().equals(user.getYhid())){//对比之前登录的用户与当前登录用户是否相同
											XtYhJbxx.LOGIN_SESSION.remove(user.getYhid());// 从session列表信息中移除
											XtYhJbxx.LONGIN_USER.remove(user.getYhid());// 将之前的用户信息从登录用户信息列表中移除
										}else{
											//新增是否首次使用密码判断如果是首次使用密码则必须先修改密码才可进入操作系统
											int ischeck = checkPwdState(userInfo.getYhbh());
											if(ischeck == 0){
												logInInfo.setYhid(userInfo.getYhid());
												logInInfo.setYhbh(userInfo.getYhbh());
												logInInfo.setYhmc(userInfo.getYhmc());
												return "modifyPwd";
											}else if(ischeck == 1){		
												if(session.getAttribute(Constant.SESSION_SYSTEM_LOGIN)!=null){
													//进入系统界面
													return "ok";
												}else{
													//获取可访问的业务系统
													toSystemSelect(userInfo.getYhbh());
												}
											}
										}
										
									}
								}
								//if(this.getIsSingleLogin()==0){//启用单点登录
									XtYhJbxx.LOGIN_SESSION.remove(userInfo.getYhid());// 从session列表信息中移除
									XtYhJbxx.LONGIN_USER.remove(userInfo.getYhid());// 将之前的用户信息从登录用户信息列表中移除
								//}
							} catch (Exception e)
							{
								e.printStackTrace();
								System.out.println("sessionold已经过期");
								XtYhJbxx.LOGIN_SESSION.remove(userInfo.getYhid());// 从session列表信息中移除
								XtYhJbxx.LONGIN_USER.remove(userInfo.getYhid());// 将之前的用户信息从登录用户信息列表中移除
							}
						}
						XtYhJbxx.LONGIN_USER.add(userInfo.getYhid());// 将新用户写入在线用户信息中
					} else
					{// 没有在线用户
						XtYhJbxx.LONGIN_USER = new ArrayList();
						XtYhJbxx.LONGIN_USER.add(userInfo.getYhid());//将新用户写入在线用户信息中
					}
					
					session.setAttribute("loginYhid", userInfo.getYhid());
					session.setAttribute("userBgColor", userInfo.getBgColor());
					session.setAttribute("YHBH", userInfo.getYhbh());
					if(!StringUtil.isBlank(userInfo.getLanguage())){//将用户的语言存入session中
						String lang=userInfo.getLanguage();
						String[] split = lang.split("_");
						Locale locale = new Locale(split[0], split[1]);
						session.setAttribute("i18n_lang", locale);
					}
					session.setAttribute(Constant.SESSION_CZY_NAME, this.getYhJbxx(userInfo));
					XtYhJbxx.LOGIN_SESSION.put(userInfo.getYhid(),session);//将session保存起来
					//把session加入监听器
					OnlineListener.createsession(new HttpSessionEvent(session));
					session.setAttribute("treeList", this.getYhJsMk(userInfo.getYhbh()));
					//System.out.println("sessionid = " + this.getRequest().getSession().getId());
					//记录登陆日志
					this.saveLoginRpt("i18n_LoginAction.login.success_n81i","i18n_LoginAction.login.in_n81i",userInfo.getYhmc());
					// 查询菜单树
					QueryMenuTreeAction query = new QueryMenuTreeAction(commonService);
					List<Map<String, Object>> userfunctionList = null;
					if (logInInfo.getYhmc() != null	&& "admin".equals(logInInfo.getYhmc().trim())){
						userfunctionList = query.queryMenuTree(logInInfo.getYhmc().trim(), null);
					} else {
						if (userInfo != null) {
							userfunctionList = query.queryMenuTree(null,this.getUser().getYhbh());
						}else{
							return "error";
						}
					}
					if(userfunctionList==null || userfunctionList.size()==0){
						this.saveLoginRpt("i18n_LoginAction.login.noPermission_n81i","i18n_LoginAction.login.in_n81i",logInInfo.getYhmc());//记录登陆日志
						outHtmlString("<script type=\"text/javascript\">alert('i18n_LoginAction.login.noPermission_n81i');this.location='login.jsp'</script>");
						//outHtmlString("<script type='text/javascript' src='js/ymPrompt.js'></script><link rel='stylesheet' href='js/ski/qq/ymPrompt.css' type='text/css'></link><script type=\"text/javascript\">ymPrompt.alert('操作失败');</script>");
						return null;
					}
					// 用户所要功能权限 add by ghh
					session.setAttribute("userfunctionList", userfunctionList);
					LinkedList<Map<String,Object>> userfunctionList2  = new LinkedList<Map<String,Object>>();
					userfunctionList2.addAll(userfunctionList);
//					List<Map<String, Object>> userfunctionList2 = (List<Map<String, Object>>) ((LinkedList<Map<String,Object>>)userfunctionList).clone();
					String treeStr = query.makeMenuTree(userfunctionList2);
					//System.out.println(userInfoTemp.getNickname()+":treeXML\t" + treeStr);
					if(session.getAttribute("treeStr")!=null){
						session.removeAttribute("treeStr");
					}
					session.setAttribute("treeStr", treeStr);
					session.setAttribute("treeHtml", query.getMenuHtml(treeStr));
					//新增是否首次使用密码判断如果是首次使用密码则必须先修改密码才可进入操作系统
					int ischeck = checkPwdState(userInfo.getYhbh());
					if(ischeck == 0){
						logInInfo.setYhid(userInfo.getYhid());
						logInInfo.setYhbh(userInfo.getYhbh());
						logInInfo.setYhmc(userInfo.getYhmc());
						return "modifyPwd";
					}else if(ischeck == 1){						
						//新增业务系统登陆判断systemLogin
						if(session.getAttribute(Constant.SESSION_SYSTEM_LOGIN)==null){//跳转到业务系统选择页面
							
							return toSystemSelect(userInfo.getYhbh());
						}else {//进入系统界面
							return "ok";
						}
					}else{
						session.invalidate();
					}
				}
			}else{
				return "back";
			}
			
		} catch (Exception e) {
//			e.printStackTrace();
//			outHtmlString("<script type=\"text/javascript\">alert('操作失败');this.location='index.jsp'</script>");
			this.saveLoginRpt("i18n_LoginAction.login.unpredictableErr_n81i","i18n_LoginAction.login.in_n81i",logInInfo.getYhmc());//记录登陆日志
			outHtmlString("<script type=\"text/javascript\">alert('i18n_LoginAction.checkPwdState.faild_n81i');this.location='login.jsp'</script>");
			//outHtmlString("<script type='text/javascript' src='js/ymPrompt.js'></script><link rel='stylesheet' href='js/ski/qq/ymPrompt.css' type='text/css'></link><script type=\"text/javascript\">ymPrompt.alert('操作失败');</script>");
			return null;
		}
		this.saveLoginRpt("用户名或密码错误","i18n_LoginAction.login.in_n81i",logInInfo.getYhmc());//记录登陆日志
		outHtmlString("<script type=\"text/javascript\">alert('i18n_LoginAction.login.usernameOrPwdErr_n81i');this.location='login.jsp'</script>");
		//outHtmlString("<script type='text/javascript' src='js/ymPrompt.js'></script><link rel='stylesheet' href='js/ski/qq/ymPrompt.css' type='text/css'></link><script type=\"text/javascript\">ymPrompt.alert('操作失败');</script>");
		return null;
	}
	private String toSystemSelect(String yhbh){
		try {
		List<Object []> stList = new ArrayList<Object[]>();
		if(yhbh != null && !"".equals(yhbh)){
				if("admin".equals(yhbh.trim())){
					this.getRequest().getSession().setAttribute(Constant.SESSION_SYSTEM_LOGIN, -1l);
					this.getRequest().getSession().setAttribute(Constant.SESSION_SYSTEM_LOGIN_NAME, "ALL");
					return "ok";
				}else{
					
					stList = this.commonService
						.executeSQL("select DISTINCT(st.system_Id),st.system_Name,st.is_master " +
								"from system_table st " +
								"left join Gorup_System_Table gst on gst.system_Id = st.system_Id " +
								"left join Xt_Yh_Js_Index xyji on xyji.jsbh = gst.user_Group_Id " +
								"left join XT_JS_JBXX xjj on xjj.jsbh = xyji.jsbh " + 
								"where xyji.yhbh='" + yhbh.trim() +
								"' and st.system_state = 0 and xyji.type=1 and xjj.zxbz=0 " +//业务系统启用+角色类型为用户组+用户组有效
								"order by st.system_Id");
					//国家中心人员具有 查看所有业务系统 数据的权限
					List<String> list = this.commonService.executeSQL("SELECT jsbh FROM xt_yh_js_index where yhbh = ?", yhbh.trim());
					if(list != null && list.size() > 0){
						for(String obj : list){
							if(StringUtils.isNotBlank(obj)){
								if((Constants.NATION_ROLE.trim()).equals(obj.trim())){
									Object[] all = new Object[3];
									all[0] = -1;
									all[1] = "ALL";
									all[2] = 1;
									stList.add(0, all);
									break;
								}
							}
						}
					}
					
					if(stList!=null && stList.size()==1){

						this.getRequest().getSession().setAttribute(Constant.SESSION_SYSTEM_LOGIN, Long.parseLong(stList.get(0)[0].toString()));
						this.getRequest().getSession().setAttribute(Constant.SESSION_SYSTEM_LOGIN_NAME, stList.get(0)[1].toString());

//						System.out.println(stList.get(0)[1]+"-=-=-=-=-=-=--=-=-=-=-=-==============--- Only One "+this.getRequest().getSession().getAttribute(Constant.SESSION_SYSTEM_LOGIN));
						return "ok";
					}
				}
		}
		this.getRequest().setAttribute("stList", stList);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "systemSelect";
	}
	/**
	 * 判断用户是否首次使用密码如果是首次返回到密码修改页面
	 * @param yhbh
	 * @return 0要修改密码；1无需修改密码继续；2用户不存在
	 */
	private int checkPwdState(String yhbh){
		//默认要修改密码
		int ischeck = 0;
		try {
			List<Object []> stList = new ArrayList<Object[]>();
			if(yhbh != null && !"".equals(yhbh)){				
				stList = this.commonService
					.executeSQL("select xyj.PWDSTATE from xt_yh_jbxx xyj where xyj.yhbh = '"+yhbh+"' AND xyj.ZXBZ = 0 ");
				if(stList == null){					
					outHtmlString("<script type=\"text/javascript\">alert('i18n_LoginAction.checkPwdState.userIsNotExists_n81i！');this.location='login.jsp'</script>");
					ischeck = 2;
				}else if(stList.size()==1){// && stList.size()==1
					//如果密码正常状态则直接放行	
					ischeck =Integer.parseInt(String.valueOf(stList.get(0)));
				}else{
					outHtmlString("<script type=\"text/javascript\">alert('i18n_LoginAction.checkPwdState.userInfoErr_n81i');this.location='login.jsp'</script>");
					ischeck = 2;
				}
		}
		this.getRequest().setAttribute("stList", stList);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return ischeck;
	}

	// 更新用户密码信息
	public String forceModifyPassword() {
		String yhid = this.getRequest().getParameter("yhid");
		String yhbh = this.getRequest().getParameter("yhbh");
		try {
			MD5 md5 = new MD5();
			XtYhJbxx userNew = (XtYhJbxx) this.commonService.get(
					XtYhJbxx.class, Long.parseLong(yhid.trim()));
			userNew.setYhmm(md5.getMD5Code(logInInfo.getYhmm().trim()));
			//让管理员重置密码之后，修改密码状态未必须修改状态0
			userNew.setPwdState("1");
			this.commonService.update(userNew);
			// //将删除操作写到操作日志中
			this.addDBOperationRpt(commonService, "XT_YH_JBXX", "UPDATE",
					userNew.getYhid());
			this.getRequest().setAttribute("MSG", 1);
		} catch (Exception e) {
			this.getRequest().setAttribute("MSG", 2);
			e.printStackTrace();
		}
		return toSystemSelect(yhbh);
	}
	public String systemSelect(){
		if("yes".equals(this.getRequest().getParameter("SytemChange"))){
			if(this.getRequest().getSession().getAttribute("YHBH")!=null){
				return toSystemSelect(this.getRequest().getSession().getAttribute("YHBH").toString());
			}else {
				outHtmlString("<script type=\"text/javascript\">alert('i18n_LoginAction.checkPwdState.selectSys_n81i');window.history.go(-1);</script>");
				return null;
			}
		}else{
			if(this.getRequest().getParameter("systemId")!=null && !"".equals(this.getRequest().getParameter("systemId"))){
				Long systemId = Long.parseLong(this.getRequest().getParameter("systemId"));
				this.getRequest().getSession().setAttribute(Constant.SESSION_SYSTEM_LOGIN, systemId);
				if(systemId == -1){//管理员权限，查看所有数据
					this.getRequest().getSession().setAttribute(Constant.SESSION_SYSTEM_LOGIN_NAME, "ALL");	
					this.getRequest().getSession().setAttribute(Constant.ADMIN_FLAG, true);	
				}else{
					this.getRequest().getSession().setAttribute(Constant.ADMIN_FLAG, false);	
					List<Object> stList = new ArrayList<Object>();
					try{
						stList = this.commonService.executeSQL("select st.system_Name from system_table st where st.system_Id = "+Long.parseLong(this.getRequest().getParameter("systemId")));
						if(stList!=null && stList.size()==1){
							this.getRequest().getSession().setAttribute(Constant.SESSION_SYSTEM_LOGIN_NAME, stList.get(0).toString());	
						}
					} catch (Exception e) {
						e.printStackTrace();
					}
				}
				//刷新菜单树---------------------------2013-1-8 新增
				QueryMenuTreeAction query = new QueryMenuTreeAction(commonService);
				List<Map<String, Object>> userfunctionList = null;
				userfunctionList = query.queryMenuTree(null,this.getUser().getYhbh());
					
				if(userfunctionList==null || userfunctionList.size()==0){
					this.saveLoginRpt("i18n_LoginAction.login.noPermission_n81i","i18n_LoginAction.login.in_n81i",logInInfo.getYhmc());//记录登陆日志
					outHtmlString("<script type=\"text/javascript\">alert('i18n_LoginAction.login.noPermission_n81i');this.location='login.jsp'</script>");
					//outHtmlString("<script type='text/javascript' src='js/ymPrompt.js'></script><link rel='stylesheet' href='js/ski/qq/ymPrompt.css' type='text/css'></link><script type=\"text/javascript\">ymPrompt.alert('操作失败');</script>");
					return null;
				}
				// 用户所要功能权限 add by ghh
				this.getRequest().getSession().setAttribute("userfunctionList", userfunctionList);
				LinkedList<Map<String,Object>> userfunctionList2  = new LinkedList<Map<String,Object>>();
				userfunctionList2.addAll(userfunctionList);
//				List<Map<String, Object>> userfunctionList2 = (List<Map<String, Object>>) ((LinkedList<Map<String,Object>>)userfunctionList).clone();
				String treeStr = query.makeMenuTree(userfunctionList2);
				//System.out.println(userInfoTemp.getNickname()+":treeXML\t" + treeStr);
				if(this.getRequest().getSession().getAttribute("treeStr")!=null){
					this.getRequest().getSession().removeAttribute("treeStr");
				}
				this.getRequest().getSession().setAttribute("treeStr", treeStr);
				//---------------------------2013-1-8 新增--------end-------------
				return "ok";
			}else{
				outHtmlString("<script type=\"text/javascript\">alert('i18n_LoginAction.checkPwdState.selectSys_n81i');window.history.go(-1);</script>");
				return null;
			}
		}
	}
	public String logout(){
		System.out.println("用户退出@@@@@@@@@@@@@@@@@@@@@@");
		HttpSession session = this.getRequest().getSession(false);
		if (session.isNew())
			System.out.println("session被重新创建了！");
		if (session != null) {
			XtYhJbxx user = (XtYhJbxx) session.getAttribute(Constant.SESSION_CZY_NAME);
			if (user != null) {
				XtYhJbxx.LONGIN_USER.remove(user.getYhbh());
				XtYhJbxx.LOGIN_SESSION.remove(user.getYhbh());
				Locale lang = (Locale) session.getAttribute("i18n_lang");
//				OnlineListener online = new OnlineListener();
//				online.sessionDestroyed(new HttpSessionEvent(session));
				// 使用户session失效
				session.invalidate();		
				this.saveLoginRpt("i18n_LoginAction.login.success_n81i","i18n_LoginAction.checkPwdState.out_n81i",user.getYhmc());//记录登陆日志
			}else{
				System.out.println("从session中没有取得人员信息！");
				this.saveLoginRpt("i18n_LoginAction.checkPwdState.sessionOutTime_n81i","i18n_LoginAction.checkPwdState.out_n81i",user.getYhmc());//记录登陆日志
			}
		}
		
		return "logout";
	}
	public List getYhJsMk(String yhbh){
		List treeList = new ArrayList();
		try {
//			String sql="select substr(mkbh,0,length(mkbh)-5) as pid,mkbh,mkmc,mkms,mkurl,mktb from XtMkJbxx where mkbh in " +
//			"(select mkbh from XtJsMkIndex where jsbh in" +
//			"(select a.jsbh from XtJsJbxx a where  a.jsbh in(" +
//			"select jsbh from XtYhJsIndex where yhbh = '"+yhbh+"') and a.zxbz='0')) and zxbz='0'";
			String sql="select pid,id,mkmc,mkms,mkurl,mktb,iconimage,mktype from XtMkJbxx where id in " +
			"(select mkbh from XtJsMkIndex where jsbh in" +
			"(select a.jsbh from XtJsJbxx a where  a.jsbh in(" +
			"select jsbh from XtYhJsIndex where yhbh = '"+yhbh+"') and a.zxbz='0')) and zxbz='0' order by showlevel,showorder";
			List menuList = this.commonService.find(sql);
			for(int i=0;i<menuList.size();i++){
				Object[] obj = (Object[])menuList.get(i);//0为pid,1为mkbh,2为mkmc,3为mkms,4为mkurl,5为mktb
				Resource resource = new Resource();
				resource.setParRsCode(obj[0].toString());
				resource.setRsCode(obj[1].toString());
				resource.setRsid(obj[1].toString());
				resource.setRsname(obj[2].toString());				
				resource.setRsaddress(obj[4]==null?"":obj[4].toString());
				resource.setIconshow(obj[6]==null?"":obj[6].toString());
				resource.setMktype(obj[7]==null?"":obj[7].toString());
				treeList.add(resource);				
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return treeList;
	}
	public XtYhJbxx getYhJbxx(XtYhJbxx user){
		try {
			List userRoleList = this.commonService.find("from XtYhJsIndex where yhbh=?",user.getYhbh());
			List roleList = this.commonService.find("from XtJsJbxx order by jsbh");
			for(int j = 0;j<roleList.size();j++){
				XtJsJbxx role = (XtJsJbxx)roleList.get(j);
				for(int k =0;k<userRoleList.size();k++){
					XtYhJsIndex jbxx = (XtYhJsIndex)userRoleList.get(k);	
					if(role.getJsbh().equals(jbxx.getJsbh())){
						user.getUserRoleList().add(role);
					}
				}				
			}
			//获取用户部门信息
			Long deptFlag =(Long) this.getRequest().getSession().getAttribute(Constant.DEPT_FLAG);
			if(deptFlag!=null&&deptFlag==0){
				List userDeptList = this.commonService.find("from TableUserDepartment where userid=?", user.getYhid());
				List deptList = this.commonService.find("from TableDepartment order by deptid");
				for(int j = 0;j<deptList.size();j++){
					TableDepartment dept = (TableDepartment)deptList.get(j);
					for(int k = 0;k<userDeptList.size();k++){
						TableUserDepartment userDepartment = (TableUserDepartment)userDeptList.get(k);
						if(dept.getDeptid().equals(userDepartment.getDeptid())){
							user.getUserDeptList().add(dept);
						}
					}
				}
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return user;
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
	public CommonService getCommonService() {
		return commonService;
	}

	public void setCommonService(CommonService commonService) {
		this.commonService = commonService;
	}
	public XtYhJbxx getLogInInfo() {
		return logInInfo;
	}
	public void setLogInInfo(XtYhJbxx logInInfo) {
		this.logInInfo = logInInfo;
	}
	public List<XtYhJbxx> getUserInfoList() {
		return userInfoList;
	}
	public void setUserInfoList(List<XtYhJbxx> userInfoList) {
		this.userInfoList = userInfoList;
	}
}
