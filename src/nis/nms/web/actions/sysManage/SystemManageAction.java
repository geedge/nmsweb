package nis.nms.web.actions.sysManage;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import nis.nms.core.Resource;
import nis.nms.domains.GorupSystemTable;
import nis.nms.domains.NodePosition;
import nis.nms.domains.NodeTable;
import nis.nms.domains.NodegroupTable;
import nis.nms.domains.SystemTable;
import nis.nms.domains.XtJsJbxx;
import nis.nms.domains.XtYhJbxx;
import nis.nms.service.CommonService;
import nis.nms.util.BaseAction;
import nis.nms.util.IpCovert;
import nis.nms.util.Page;


import org.apache.log4j.Logger;
import org.apache.struts2.config.Result;
import org.apache.struts2.config.Results;

@SuppressWarnings("unchecked")
@Results( { 
	@Result(name="querySystemInfo", value = "/page/systemManage/systemInfoList.jsp"),
	@Result(name="showSystemList", value = "/page/systemManage/showSystemList.jsp"),
	@Result(name="addSystemInfo", value = "/page/systemManage/addSystemInfo.jsp"),
	@Result(name="updateSystemInfo", value = "/page/systemManage/updateSystemInfo.jsp"),
	@Result(name="detailSystemInfo", value = "/page/systemManage/detailSystemInfo.jsp"),
	@Result(name="detailSystemInfo1", value = "/page/systemManage/detailSystemInfo1.jsp"),
	
	@Result(name="groupNodeList", value = "/page/systemManage/groupNodeList.jsp"),
	@Result(name="groupUserList", value = "/page/systemManage/groupUserList.jsp"),
	@Result(name="groupUserListForGuide", value = "/page/systemManage/groupUserListForGuide.jsp"),
	@Result(name="error", value ="/error.jsp")
})
public class SystemManageAction  extends BaseAction{
	private static final long serialVersionUID = 1L;
	private Logger logger = Logger.getLogger(SystemManageAction.class);
	private CommonService commonService;
	private int pageNo = 1;
	private int pageSize =this.getDefaultPageSize();		//每页显示的记录条数
	private Page page;
	private int pageNoSub = 1;
	private int pageSizeSub =this.getDefaultPageSize();		//每页显示的记录条数
	private Page pageSub;
	
	private String action;//系统操作
	
	private List<SystemTable> systemList;
	private int systemNum;//当前system的数量
	private SystemTable system;
	private Long systemId;
	private Long[] ids;//业务系统id集合
	
	private String flag;//用于标志详情页面转向
	
	//查询条件
	private String sysName;
	private String sysDesc;
	
	private List<NodegroupTable> nodeGroupList;
	private List<XtJsJbxx> userGroupList;
	private List<Resource> nodeResTree;
	private List<Resource> userResTree;
	
	private String mkid; //用户组id
	
	private Long userGroupId;//查看业务系统详情中的用户组ID
	private Long nodeGroupId;//查看业务系统详情中的节点组ID
	private List<XtYhJbxx> userList;
	private List<NodeTable> nodeList;
	
	private String fromWhere;
	private String isComplete;
	
	public String executeAction(){
		String resultPage = "";
		try{
			this.getRequest().setAttribute("fromWhere", fromWhere);
			if(action==null){//查询管理页面
				resultPage = querySystemInfo();
			}else if(action.equals("query")){//查看列表页面，只显示当前用户组可以查看的系统
				resultPage = querySystemInfo();
			}else if(action.equals("show")){//查看列表页面，只显示当前用户组可以查看的系统
				resultPage = showSystemList();
			}else if(action.equals("openAdd")){//转向添加页面
				//查询用户组
				queryAllUsergroupInfo();
				//查询system_table表，看此表中是否有记录，若无，则新增的为主控记录
				queryAllSystem();
				this.getRequest().setAttribute("fromWhere", fromWhere);
				return "addSystemInfo";
			}else if(action.equals("doAdd")){//提交添加信息
				resultPage = addSystemInfo();
			}else if(action.equals("openUpdate")){//转向修改页面
				//查询用户组
				queryAllUsergroupInfo();
				resultPage = openUpdateSystemInfo();
			}else if(action.equals("doUpdate")){//提交修改信息
				resultPage = updateSystemInfo();
			}else if(action.equals("stop")){//停用
				resultPage = stopSystemInfo();
			}else if(action.equals("start")){//启用
				resultPage = startSystemInfo();
			}else if(action.equals("detail")){//查看详情
				resultPage = detailSystemInfo();
			}else if(action.equals("queryGroupUsers")) {//分页查询用户信息
				resultPage = getGroupUser();
			}else if(action.equals("AjaxCheck")){
				ajaxCheck();
				return null;
			}else if(action.equals("updateCheck")){
				updateCheck();
				return null;
			}else {//查询管理页面
				resultPage = querySystemInfo();
			}
		}catch (Exception e){
			e.printStackTrace();
		}
		return resultPage;
	}
	
	//管理业务系统列表
	public String querySystemInfo(){
		try{
			isComplete = this.getRequest().getParameter("isComplete");
			String hql = "from SystemTable where 1=1";
			String sqlCondition = "select * from system_table where 1=1"; 
			if(sysName!=null && !sysName.trim().equals("")){
				hql += " and Upper(systemName) like '%" + sysName.trim().toUpperCase() + "%'"; 
				sqlCondition += " and Upper(system_name) like '%" + sysName.trim().toUpperCase() + "%'";
			}
			if(sysDesc!=null && !sysDesc.trim().equals("")){
				hql += " and Upper(systemDesc) like '%" + sysDesc.trim().toUpperCase() + "%'"; 
				sqlCondition += " and Upper(system_desc) like '%" + sysDesc.trim().toUpperCase() + "%'";
			}
			hql += " order by systemState asc,systemCreatetime desc";
			sqlCondition += " order by system_state asc,systemCreatetime desc";
			
			// 将查询请求记入到操作日志表中
			this.addDBOperationRpt(commonService, sqlCondition, "system_table");
			
			page = this.commonService.findByPage(hql, pageNo, pageSize);
			systemList = (List<SystemTable>)page.getResult();
		}catch (Exception e){
			e.printStackTrace();
		}
		return "querySystemInfo";
	}
	
	//查询所有管理业务系统
	public void queryAllSystem(){
		try{
			
			systemList = (List<SystemTable>)this.commonService.find("from SystemTable");
			systemNum = (systemList==null ? 0 : systemList.size());
		}catch (Exception e){
			e.printStackTrace();
		}
	}
	
	//查看业务系统列表,只显示当前用户所属组可以查看的业务系统
	public String showSystemList(){
		try{
			String hql = "from SystemTable where 1=1" +
					" and systemId in (select systemId from GorupSystemTable" +//当前用户组可以查看的系统
						" where userGroupId in (select jsbh from XtYhJsIndex" + //当前用户组信息
						" where type=1 and yhbh='" + this.getUser().getYhbh() + "'))";//当前用户编号
			String sqlCondition = "select * from system_table where 1=1" +
					" and system_id in (select system_id from gorup_system_table" +
					" where user_group_id in (select jsbh from xt_yh_js_index" +
					" wehre type=1 and yhbh='" + this.getUser().getYhbh() + "'))"; 
			if(sysName!=null && !sysName.trim().equals("")){
				hql += " and Upper(systemName) like '%" + sysName.trim().toUpperCase() + "%'"; 
				sqlCondition += " and Upper(system_name) like '%" + sysName.trim().toUpperCase() + "%'";
			}
			if(sysDesc!=null && !sysDesc.trim().equals("")){
				hql += " and Upper(systemDesc) like '%" + sysDesc.trim().toUpperCase() + "%'"; 
				sqlCondition += " and Upper(system_desc) like '%" + sysDesc.trim().toUpperCase() + "%'";
			}
			hql += " order by systemState asc,systemCreatetime desc";
			sqlCondition += " order by system_state asc,system_createtime desc";
			
			// 将查询请求记入到操作日志表中
			this.addDBOperationRpt(commonService, sqlCondition, "system_table");
			
			page = this.commonService.findByPage(hql, pageNo, pageSize);
			systemList = (List<SystemTable>)page.getResult();
		}catch (Exception e){
			e.printStackTrace();
			return "error";
		}
		return "showSystemList";
	}
	
	
	// 查询所有用户组信息，如果系统ID不为空，则根据系统ID查询用户组信息，并将已经具有的用户组处于选中状态
	public void queryAllUsergroupInfo(){
		try{
			if(ids!=null && ids.length>0){
				systemId = ids[0];
			}
			//记录用户操作用于设置向导
			if(fromWhere!=null && !"".equals(fromWhere)){
				if(fromWhere.equals("formGuide")){
					isComplete = "0";//设置  向导设置的'业务系统' 为已完成状态
				}
			}
			// 查询系统下的用户组
			List userGroups = new ArrayList();
			if(systemId!=null && !systemId.equals("")){
				userGroups = this.commonService.find(
						"from GorupSystemTable where systemId=" + systemId);
			}
					
			//用户组信息
			List<Resource> userGroupTree = new ArrayList<Resource>();
			List<XtJsJbxx> roles = this.commonService
					.find("from XtJsJbxx where zxbz=0 and type=1");
			for (int j = 0; j < roles.size(); j++) {
				XtJsJbxx role = (XtJsJbxx) roles.get(j);
				
				Resource res = new Resource();
				res.setRsid(role.getJsbh().toString());
				res.setRsname(role.getJsmc().toString());
				res.setRsdesc(role.getJsms());
				// 系统的父id设为0
				res.setParRsCode("0");
				res.setRsCode(role.getJsbh().toString());
				
				//设置是否选中
				for (int i = 0; i < userGroups.size(); i++) {
					if(userGroups.get(i)!=null){
						GorupSystemTable groupSys = (GorupSystemTable) userGroups.get(i);
						if (role.getJsbh().equals(groupSys.getUserGroupId())) {
							res.setChecked("checked");
						}
					}
				}
				userGroupTree.add(res);
			}
			this.getRequest().setAttribute("userGroupTree", userGroupTree);
		}catch (Exception e){
			e.printStackTrace();
		}
		
	}
	
	public void ajaxCheck(){
		List list;
		try {
			list = this.commonService.find("from SystemTable where systemName=?", system.getSystemName());
			if(list!=null && list.size()>0){
				this.outString("error");
				return ;
			}
		} catch (Exception e) {
			e.printStackTrace();
			logger.info("添加业务系统配置校验异常", e);
			this.outString("exception");
		}
		this.outString("success");		
	}
	
	//添加业务系统
	public String addSystemInfo(){
		try{
			List list =null;
			/*List list = this.commonService.find("from SystemTable where systemName=?", system.getSystemName());
			if(list!=null && list.size()>0){
				this.outHtmlString("<script>alert('系统已存在，请重新输入！');history.back();</script>");
				return null;
			}*/
			//------2013-1-24---hyx----
			Long  isMast= system.getIsMaster();
			if(1!=isMast.intValue()) {//子系统的新增
				list = this.commonService.find("from SystemTable where isMaster=1 order by systemId desc");//查找主控系统
				SystemTable sysTable = new SystemTable();
				if(list!=null&&list.size()>0) {//存在主控系统
					sysTable =  (SystemTable)list.get(0);
				}
				
				//子系统才默认采用主控系统的ip,port
				system.setSystemIp(sysTable.getSystemIp());
				system.setSystemPort(sysTable.getSystemPort());			
			}
			//------2013-1-24---hyx----
			system.setSystemState("0");//设置状态：0 正常
			system.setCreateUserId(this.getUserID());
			system.setSystemCreatetime(new Date());
			this.commonService.save(system);
			
			//将添加操作写到操作日志中
			this.addDBOperationRpt(commonService, "system_table", "INSERT", system.getSystemId());
			
			//保存用户组到关联表
			if(mkid!=null && !mkid.equals("")){
				String[] sMk = mkid.split(",");
				if (sMk != null){
					for (int i = 0; i < sMk.length; i++) {
						GorupSystemTable groupSys= new GorupSystemTable();
						groupSys.setSystemId(system.getSystemId());
						groupSys.setUserGroupId(Long.parseLong(sMk[i].trim()));
						this.commonService.save(groupSys);
					}
			    }
			}
			
			//拓扑图的数据维护
			List nplist = this.commonService.find("from NodePosition where nodeType='system' and nodeId=?", system.getSystemId()+"");
			if(nplist==null || nplist.size()==0){
				NodePosition np = new NodePosition();
				np.setTableName("system_table");
				np.setNodeType("system");
				np.setNodeId(system.getSystemId()+"");
				np.setPositionX(0l);
				np.setPositionY(0l);
				np.setImageUrl("/nmsweb/images/show/sensor.png");
				np.setViewTimeMark(new Date());
				np.setViewType(0l);
				np.setParent_id(0l);
				this.commonService.save(np);
				this.addDBOperationRpt(commonService, "node_position", "INSERT",np.getId());
			}
			
			//记录用户操作用于设置向导
			if(fromWhere!=null && !"".equals(fromWhere)){
				if(fromWhere.equals("formGuide")){
					outHtmlString("<script type=\"text/javascript\">alert('i18n_SystemManageAction.ajaxCheck.success_n81i');this.location='systemManage.do?action=query&isComplete=0'</script>");
				}
			}else{
				outHtmlString("<script type=\"text/javascript\">alert('i18n_SystemManageAction.ajaxCheck.success_n81i');this.location='systemManage.do?action=query'</script>");
			}
		}catch (Exception e){
			e.printStackTrace();
			logger.error(e.getStackTrace());
			outHtmlString("<script type=\"text/javascript\">alert('i18n_SystemManageAction.ajaxCheck.faild_n81i');" +
					"this.location='systemManage.do?action=query&pageNo=" + pageNo +
					"&pageSize=" + pageSize + "'</script>");
		}
		return null;
	}
	
	//打开修改业务系统页面
	public String openUpdateSystemInfo(){
		try{
			if(ids!=null && ids.length>0){
				List list = this.commonService.find(
						"from SystemTable where systemId=?", ids[0]);
				if(list!=null && list.size()>0){
					system = (SystemTable)list.get(0);
				}
			}
		}catch (Exception e){
			e.printStackTrace();
			return "error";
		}
		return "updateSystemInfo";
	}
	
	
	public void updateCheck(){
		List list;
		try {
			list = this.commonService.find(
					"from SystemTable where systemName=? and systemId<>?",
					system.getSystemName(), system.getSystemId());
			if(list!=null && list.size()>0){
				this.outString("error");
				return ;
			}
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("SystemManageAction.ajaxCheck.sysConfigValidateFaild", e);
			this.outString("exception");
		}
		this.outString("success");
	}
	
	//修改业务系统
	public String updateSystemInfo(){
		try{
			/*List list = this.commonService.find(
					"from SystemTable where systemName=? and systemId<>?",
					system.getSystemName(), system.getSystemId());
			if(list!=null && list.size()>0){
				this.outHtmlString("<script>alert('系统已存在，请重新输入！');history.back();</script>");
				return null;
			}*/
			
			List sysList = this.commonService.find(
					"from SystemTable where systemId=?", system.getSystemId());
			
			if(sysList!=null && sysList.size()>0){
				SystemTable sys = (SystemTable)sysList.get(0);
				sys.setSystemName(system.getSystemName());
				sys.setSystemIp(system.getSystemIp());
				sys.setSystemIpn(IpCovert.ipToLong(system.getSystemIp()));
				sys.setSystemPort(system.getSystemPort());
				sys.setIsMaster(system.getIsMaster());
				sys.setSystemDesc(system.getSystemDesc());
				sys.setSystemState(system.getSystemState());
				
				this.commonService.update(sys);
				
				//将更新操作写到操作日志中
				this.addDBOperationRpt(commonService, "system_table", "UPDATE", sys.getSystemId());
				
				//删除旧的用户组与系统关联信息
				this.commonService.delete("delete from GorupSystemTable where systemId =" + system.getSystemId());
				//保存新的用户组到关联表
				if(mkid!=null && !mkid.equals("")){
					String[] sMk = mkid.split(",");
					if (sMk != null){
						for (int i = 0; i < sMk.length; i++) {
							GorupSystemTable groupSys= new GorupSystemTable();
							groupSys.setSystemId(system.getSystemId());
							groupSys.setUserGroupId(Long.parseLong(sMk[i].trim()));
							this.commonService.save(groupSys);
						}
				    }
				}
			}
			
			outHtmlString("<script type=\"text/javascript\">alert('i18n_SystemManageAction.ajaxCheck.success_n81i');" +
					"this.location='systemManage.do?action=query&pageNo=" + pageNo +
					"&pageSize=" + pageSize + "'</script>");
		}catch (Exception e){
			e.printStackTrace();
			logger.error(e.getStackTrace());
			outHtmlString("<script type=\"text/javascript\">alert('i18n_SystemManageAction.ajaxCheck.faild_n81i');" +
					"this.location='systemManage.do?action=query&pageNo=" + pageNo +
					"&pageSize=" + pageSize + "'</script>");
		}
		//return querySystemInfo();
		return null;
	}
	
	//停用业务系统
	public String stopSystemInfo(){
		try{
			if(ids!=null && ids.length>0){
				for(int i=0; i<ids.length; i++){
					List sysList = this.commonService.find(
							"from SystemTable where systemId=?", ids[i]);
					
					if(sysList!=null && sysList.size()>0){
						SystemTable sys = (SystemTable)sysList.get(0);
						sys.setSystemState("1");
						sys.setStopUserId(this.getUserID());
						sys.setSystemStoptime(new Date());
						
						this.commonService.update(sys);
						
						//将更新操作写到操作日志中
						this.addDBOperationRpt(commonService, "system_table", "UPDATE", sys.getSystemId());
					}
				}
			}
			//this.getRequest().setAttribute("MSG", 1);
			outHtmlString("<script type=\"text/javascript\">alert('i18n_SystemManageAction.ajaxCheck.success_n81i');" +
					"this.location='systemManage.do?action=query&pageNo=" + pageNo +
					"&pageSize=" + pageSize + "'</script>");
		}catch (Exception e){ 
			e.printStackTrace();
			logger.error(e.getStackTrace());
			outHtmlString("<script type=\"text/javascript\">alert('i18n_SystemManageAction.ajaxCheck.faild_n81i');" +
					"this.location='systemManage.do?action=query&pageNo=" + pageNo +
					"&pageSize=" + pageSize + "'</script>");
		}
		return null;
	}
	
	//启用业务系统
	public String startSystemInfo(){
		try{
			if(ids!=null && ids.length>0){
				for(int i=0; i<ids.length; i++){
					this.commonService.updateByHql(
							"update SystemTable set systemState='0' where systemId=?", ids[i]);
					
					//将更新操作写到操作日志中
					this.addDBOperationRpt(commonService, "system_table", "UPDATE", ids[i]);
				}
			}

			outHtmlString("<script type=\"text/javascript\">alert('i18n_SystemManageAction.ajaxCheck.success_n81i');" +
					"this.location='systemManage.do?action=query&pageNo=" + pageNo +
					"&pageSize=" + pageSize + "'</script>");
		}catch (Exception e){ 
			e.printStackTrace();
			logger.error(e.getStackTrace());
			outHtmlString("<script type=\"text/javascript\">alert('i18n_SystemManageAction.ajaxCheck.faild_n81i');" +
					"this.location='systemManage.do?action=query&pageNo=" + pageNo +
					"&pageSize=" + pageSize + "'</script>");
		}
		return null;
	}
	
	//查看业务系统详情
	public String detailSystemInfo(){
		try{
			List list = this.commonService.find(
					"from SystemTable where systemId=?", systemId);
			if(list!=null && list.size()>0){
				system = (SystemTable)list.get(0);
				
				//用户组树与节点树的父结点
				Resource topRes = new Resource();
				topRes.setRsid(system.getSystemId().toString());
				topRes.setRsname(system.getSystemName());
				topRes.setRsdesc(system.getSystemDesc());
				topRes.setParRsCode("0");// 系统的父id设为0
				topRes.setRsCode("0_" + system.getSystemId().toString());
				
				//查看业务系统的下的用户组及用户组下的用户与模块
				userGroupList = this.commonService.find("from XtJsJbxx where type=1 and jsbh in" +
						" (select userGroupId from GorupSystemTable where systemId=?)", system.getSystemId());
				userResTree = new ArrayList();
				//添加业务系统为Tree的头结点
				userResTree.add(topRes);
				//将业务系统下的所有用户组与业务系统关联
				for(int i=0; i<userGroupList.size(); i++){
					XtJsJbxx userGroup = userGroupList.get(i);
					Resource userGroupRes = new Resource();
					userGroupRes.setRsid(userGroup.getJsbh().toString());
					//2012年3月26日，hyx添加--开始
					if("1".equals(userGroup.getZxbz())) {//此业务系统无效（已注销）
						userGroupRes.setRsname(userGroup.getJsmc()+"（"+getI18nText("i18n_SystemManageAction.ajaxCheck.invalid_n81i")+"）");
					} else {//业务系统有效
						userGroupRes.setRsname(userGroup.getJsmc());
					}
					//2012年3月26日，hyx添加--结束
					userGroupRes.setRsdesc(userGroup.getJsms());
					userGroupRes.setParRsCode("0_" + system.getSystemId());// 组的父id设为系统Id
					userGroupRes.setRsCode("1_" + userGroup.getJsbh());
					userResTree.add(userGroupRes);
					
					//查询用户组下面的所有用户并将其添加到用户组的用户下面
					//每一用户组下的子结点======用户
					Resource user = new Resource();
					user.setRsid("2_0" + (i+1));
					user.setRsname(getI18nText("i18n_SystemManageAction.ajaxCheck.user_n81i"));
					user.setRsdesc(getI18nText("i18n_SystemManageAction.ajaxCheck.user_n81i"));
					user.setParRsCode("1_" + userGroup.getJsbh());// 用户的父id设为用户组Id（角色编号）
					user.setRsCode("2_0" + (i+1));
					if("0".equals(userGroup.getZxbz())) {//此业务系统有效时有链接，无效时则无链接且置灰（2012年3月26日，hyx添加）
						user.setRsaddress("/sysManage/systemManage!getGroupUser.do?userGroupId=" + userGroup.getJsbh());
					}
					userResTree.add(user);
					
					/*List<XtYhJbxx> userList = this.commonService.find(
							 "from XtYhJbxx where yhId in (select yhId from XtYhJsIndex where jsbh=?)", userGroup.getJsbh());
					for(XtYhJbxx yh:userList){
						 Resource yhRes = new Resource();
						 yhRes.setRsid(yh.getYhid().toString());
						 yhRes.setRsname(yh.getYhbh());
						 yhRes.setRsdesc(yh.getYhmc());
						 yhRes.setParRsCode("2_0" + (i+1));//设置父id为用户结点
						 yhRes.setRsCode("3_0" + yh.getYhid().toString());
						 userResTree.add(yhRes);
					}
					userList = null;*/
					//查询用户组下面的所有模块并将其添加到用户组的模块下面
					//用户组树的两个子结点======模块
//					Resource module = new Resource();
//					module.setRsid("2_1" + (i+1));
//					module.setRsname("模块");
//					module.setRsdesc("模块");
//					module.setParRsCode("1_" + userGroup.getJsbh());// 用户的父id设为用户组Id（角色编号）
//					module.setRsCode("2_1" + (i+1));
//					userResTree.add(module);
//					
//					List<XtMkJbxx> mkList = this.commonService.find(
//							 "from XtMkJbxx where id in (select mkbh from XtJsMkIndex where jsbh=?)", userGroup.getJsbh());
//					for(XtMkJbxx mk:mkList){
//						 Resource mkRes = new Resource();
//						 mkRes.setRsid(mk.getId().toString());
//						 mkRes.setRsname(mk.getMkmc());
//						 mkRes.setRsdesc(mk.getMkms());
//						 if(mk.getPid()==0){//如果是一级模块设置父id为模块结点
//							 mkRes.setParRsCode("2_1" + (i+1));
//						 }else{//如果不是一级模块设置父id为该模块的父id
//							 mkRes.setParRsCode("3_" + mk.getPid().toString());
//						 }
//						 mkRes.setRsCode("3_" + mk.getId().toString());
//						 userResTree.add(mkRes);
//					}
				}
				
				//查询业务系统下的所有节点组
				//nodeResTree = this.queryNodeGroupInfo(systemId);
				
				String hql = "from NodegroupTable where 1=1";
				//如果当前登录选择了业务系统，则只做和本业务系统相关的操作
				if(system.getSystemId()!=null){
					hql += " and systemId = " + system.getSystemId();
				}
				boolean ADMFlag = this.getAdminMark();
				this.getRequest().setAttribute("ADMFlag", ADMFlag);
				//当前登录用户非admin时才做查看权限限制
				if(!ADMFlag){
					//权限控制----------------------------------------------------begin
					//1 发布人查看,2 发布人所在组查看,3 系统内全部人员可看
					hql += " and (";
					hql += " (viewLevel=1 and createUserId=" + this.getUserID() + ")";
					hql += " or (viewLevel=2 and createUsergroupId in (select jsbh from XtYhJsIndex " +
										" where type=1 and yhbh='" + this.getUser().getYhbh() + "') )" ;
					if(this.getSystemID()!=null){
						hql += " or (viewLevel=3 and systemId=" + system.getSystemId() + ")";
					}else{
						hql += " or (viewLevel=3 and systemId in" +
							" (select systemId from GorupSystemTable where userGroupId in" +
								" (select jsbh from XtYhJsIndex where type=1 and yhbh='" + this.getUser().getYhbh() + "')" +
							" ) )";
					}
					hql += ")";
					//权限控制----------------------------------------------------end
				}
				System.out.println(hql);
				nodeGroupList = this.commonService.find(hql);
				nodeResTree = new ArrayList();
				//添加业务系统为Tree的头结点
				nodeResTree.add(topRes);
				//将业务系统下的所有节点组与业务系统关联
				for(NodegroupTable nodegrouptable:nodeGroupList){
					 Resource nodegroup = new Resource();
					 nodegroup.setRsid(nodegrouptable.getGroupId().toString());
					 nodegroup.setRsname(nodegrouptable.getGroupName());
					 nodegroup.setRsdesc(nodegrouptable.getGroupDesc());
					 if(nodegrouptable.getParentGroupId().toString().equals("0")){
						 nodegroup.setParRsCode(topRes.getRsCode());// 组的父id设为系统Id
					 }else{
						 nodegroup.setParRsCode(nodegrouptable.getParentGroupId().toString());
					 }
					 nodegroup.setRsCode(nodegrouptable.getGroupId().toString());
					 nodegroup.setRsaddress("/sysManage/systemManage!getGroupNode.do?nodeGroupId=" + nodegrouptable.getGroupId());
					 nodeResTree.add(nodegroup);
				 }//添加节点组结束
			}
			
		}catch (Exception e){
			e.printStackTrace();
			logger.error(e.getStackTrace());
			outHtmlString("<script type=\"text/javascript\">alert('i18n_SystemManageAction.ajaxCheck.faild_n81i');" +
					"this.location='systemManage.do?action=query&pageNo=" + pageNo +
					"&pageSize=" + pageSize + "'</script>");
		}
		if(flag!=null && flag.equals("show")){
			return "detailSystemInfo1";
		}
		return "detailSystemInfo";
	}
	
	//查询节点组信息列表
	public List<Resource> queryNodeGroupInfo(Long sysId){
		List<Resource> treeList = null;
		try{
			String hql = "from NodegroupTable where 1=1";
			String sqlCondition = "where 1=1";
			boolean ADMFlag = this.getAdminMark();
			this.getRequest().setAttribute("ADMFlag", ADMFlag);
			//当前登录用户非admin时才做查看权限限制
			if(!ADMFlag){
				//权限控制----------------------------------------------------begin
				//如果当前登录选择了业务系统，则只做和本业务系统相关的操作
				if(sysId!=null){
					hql += " and systemId = " + sysId;
					sqlCondition += " and system_id=" + sysId;
				}
				//1 发布人查看,2 发布人所在组查看,3 系统内全部人员可看
				hql += " and (";
				hql += " (viewLevel=1 and createUserId=" + this.getUserID() + ")";
				hql += " or (viewLevel=2 and createUsergroupId in (select jsbh from XtYhJsIndex " +
									" where type=1 and yhbh='" + this.getUser().getYhbh() + "') )" ;
				if(this.getSystemID()!=null){
					hql += " or (viewLevel=3 and systemId=" + sysId + ")";
				}else{
					hql += " or (viewLevel=3 and systemId in" +
						" (select systemId from GorupSystemTable where userGroupId in" +
							" (select jsbh from XtYhJsIndex where type=1 and yhbh='" + this.getUser().getYhbh() + "')" +
						" ) )";
				}
				hql += ")";
				//权限控制----------------------------------------------------end
			}
			
			hql += " order by groupLevel asc,showIndex asc";
			sqlCondition += " order by groupLevel asc,showIndex asc";
			
			// 将查询请求记入到操作日志表中
			this.addDBOperationRpt(commonService, sqlCondition, "nodegroup_table");
			
//			page = this.commonService.findByPage(hql, pageNo, pageSize);
//			nodeGroupList = (List<NodegroupTable>)page.getResult();
			List<NodegroupTable> ngList = (List<NodegroupTable>)this.commonService.find(hql);
			
			//获取业务系统名称
			for(NodegroupTable nodeGroup:ngList) {
				List syslist = this.commonService.find("from SystemTable where systemId=?", nodeGroup.getSystemId());
				if(syslist!=null && syslist.size()>0){
					SystemTable sys = (SystemTable)syslist.get(0);
					nodeGroup.setSystemIdName(sys.getSystemName());
				}
			}	
			
			//获得树对象列表
			treeList = new ArrayList<Resource>();
			String sql = "select parentGroupId,groupId,groupName,groupLevel,isValid " + hql;
			System.out.println("treeSql:"+sql);
			List menuList = this.commonService.find(sql);
			
//			Resource nodegroup = new Resource();
//			nodegroup.setRsid(nodegrouptable.getGroupId().toString());
//			nodegroup.setRsname(nodegrouptable.getGroupName());
//			nodegroup.setRsdesc(nodegrouptable.getGroupDesc());
//			nodegroup.setParRsCode("0_" + system.getSystemId());// 组的父id设为系统Id
//			nodegroup.setRsCode("1_" + nodegrouptable.getGroupId());
//			nodegroup.setRsaddress("/sysManage/systemManage!getGroupNode.do?nodeGroupId=" + nodegrouptable.getGroupId());
//			nodeResTree.add(nodegroup);
			
			for (int i = 0; i < menuList.size(); i++) {
				Object[] obj = (Object[]) menuList.get(i);// 0为pid,1为id,2为deptname,3为级别,4是否生效				
				Resource resource = new Resource();
				if(obj[0]!=null&&obj[1]!=null&&obj[4]!=null&&obj[2]!=null&&obj[3]!=null) {
					if(obj[0].toString().equals("0")){
						resource.setParRsCode("0_" + sysId);// 组的父id设为系统Id
						resource.setRsCode("1_" + obj[1].toString());
					}else{//如果不是一级模块设置父id为该模块的父id
						resource.setParRsCode("1_" + obj[0].toString());
						resource.setRsCode("2_" + obj[1].toString());
					}
					
					//resource.setParRsCode(obj[0].toString());
					//resource.setRsCode(obj[1].toString());
					resource.setRsid(obj[1].toString());
					if("0".equals(obj[4].toString())) {//0:失效
						resource.setRsname("<font color=\"gray\">"+obj[2].toString()+"</font>");
					} else if ("1".equals(obj[4].toString())){//1:生效
						resource.setRsname(obj[2].toString());
					}
					resource.setRsaddress("/sysManage/systemManage!getGroupNode.do?nodeGroupId=" + obj[1]);
					treeList.add(resource);
					
					
					
					resource.setParRsCode(obj[0].toString());
					resource.setRsCode(obj[1].toString());
					resource.setRsid(obj[1].toString());
					if("0".equals(obj[4].toString())) {//0:失效
						resource.setRsname("<font color=\"gray\">"+obj[2].toString()+"</font>");
					} else if ("1".equals(obj[4].toString())){//1:生效
						resource.setRsname(obj[2].toString());
					}
					resource.setRsaddress("/sysManage/systemManage!getGroupNode.do?nodeGroupId=" + obj[1]);
					treeList.add(resource);
				}
			}
		}catch (Exception e){
			e.printStackTrace();
			logger.error(e.getStackTrace());
		}
		return treeList;
	}
	
	
	
	public String getGroupUser(){
		try{
			if(userGroupId!=null && !userGroupId.equals("")){
				String hql = "from XtYhJbxx where yhId in (select yhId from XtYhJsIndex where jsbh=?) order by ctime desc";
				page = this.commonService.findByPage(hql, pageNo, pageSize, userGroupId);
				userList = (List<XtYhJbxx>)page.getResult();
			}
			
		}catch (Exception e){
			e.printStackTrace();
			logger.error(e.getStackTrace());
		}
		return "groupUserList";
	}
	
	public String getGroupUserForGuide(){
		try{
			if(userGroupId!=null && !userGroupId.equals("")){
				String hql = "from XtYhJbxx where yhId in (select yhId from XtYhJsIndex where jsbh=?) order by ctime desc";
				pageSub = this.commonService.findByPage(hql, pageNoSub, pageSizeSub, userGroupId);
				userList = (List<XtYhJbxx>)pageSub.getResult();
			}
			
		}catch (Exception e){
			e.printStackTrace();
			logger.error(e.getStackTrace());
		}
		return "groupUserListForGuide";
	}
	
	public String getGroupNode(){
		try{
			if(nodeGroupId!=null && !nodeGroupId.equals("")){
				String hql = "from NodeTable where groupId =?";
				page = this.commonService.findByPage(hql, pageNo, pageSize, nodeGroupId);
				nodeList = (List<NodeTable>)page.getResult();
			}
		}catch (Exception e){
			e.printStackTrace();
			logger.error(e.getStackTrace());
		}
		return "groupNodeList";
	}

	public SystemManageAction() {
		// TODO Auto-generated constructor stub
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

	public List<SystemTable> getSystemList() {
		return systemList;
	}

	public void setSystemList(List<SystemTable> systemList) {
		this.systemList = systemList;
	}

	public SystemTable getSystem() {
		return system;
	}

	public void setSystem(SystemTable system) {
		this.system = system;
	}


	public Long getSystemId() {
		return systemId;
	}

	public void setSystemId(Long systemId) {
		this.systemId = systemId;
	}

	public String getSysName() {
		return sysName;
	}

	public void setSysName(String sysName) {
		this.sysName = sysName;
	}

	public String getSysDesc() {
		return sysDesc;
	}

	public void setSysDesc(String sysDesc) {
		this.sysDesc = sysDesc;
	}

	public String getFlag() {
		return flag;
	}

	public void setFlag(String flag) {
		this.flag = flag;
	}

	public List<NodegroupTable> getNodeGroupList() {
		return nodeGroupList;
	}

	public void setNodeGroupList(List<NodegroupTable> nodeGroupList) {
		this.nodeGroupList = nodeGroupList;
	}

	public List<XtJsJbxx> getUserGroupList() {
		return userGroupList;
	}

	public void setUserGroupList(List<XtJsJbxx> userGroupList) {
		this.userGroupList = userGroupList;
	}

	public List<Resource> getNodeResTree() {
		return nodeResTree;
	}

	public void setNodeResTree(List<Resource> nodeResTree) {
		this.nodeResTree = nodeResTree;
	}

	public String getMkid() {
		return mkid;
	}

	public void setMkid(String mkid) {
		this.mkid = mkid;
	}

	public List<Resource> getUserResTree() {
		return userResTree;
	}

	public void setUserResTree(List<Resource> userResTree) {
		this.userResTree = userResTree;
	}

	public Long[] getIds() {
		return ids;
	}

	public void setIds(Long[] ids) {
		this.ids = ids;
	}

	public Long getUserGroupId() {
		return userGroupId;
	}

	public void setUserGroupId(Long userGroupId) {
		this.userGroupId = userGroupId;
	}

	public Long getNodeGroupId() {
		return nodeGroupId;
	}

	public void setNodeGroupId(Long nodeGroupId) {
		this.nodeGroupId = nodeGroupId;
	}

	public List<XtYhJbxx> getUserList() {
		return userList;
	}

	public void setUserList(List<XtYhJbxx> userList) {
		this.userList = userList;
	}

	public List<NodeTable> getNodeList() {
		return nodeList;
	}

	public void setNodeList(List<NodeTable> nodeList) {
		this.nodeList = nodeList;
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

	
	public int getSystemNum()
	{
		return systemNum;
	}

	
	public void setSystemNum(int systemNum)
	{
		this.systemNum = systemNum;
	}

	
	public int getPageNoSub()
	{
		return pageNoSub;
	}

	
	public void setPageNoSub(int pageNoSub)
	{
		this.pageNoSub = pageNoSub;
	}

	
	public int getPageSizeSub()
	{
		return pageSizeSub;
	}

	
	public void setPageSizeSub(int pageSizeSub)
	{
		this.pageSizeSub = pageSizeSub;
	}

	
	public Page getPageSub()
	{
		return pageSub;
	}

	
	public void setPageSub(Page pageSub)
	{
		this.pageSub = pageSub;
	}

	
}
