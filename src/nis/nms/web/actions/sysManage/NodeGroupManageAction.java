package nis.nms.web.actions.sysManage;

import java.util.Date;
import java.util.List;

import nis.nms.core.Resource;
import nis.nms.domains.NodePosition;
import nis.nms.domains.NodeTable;
import nis.nms.domains.NodegroupTable;
import nis.nms.domains.SystemTable;
import nis.nms.domains.XtJsJbxx;
import nis.nms.service.CommonService;
import nis.nms.util.BaseAction;
import nis.nms.util.Page;

import org.apache.struts2.config.Result;
import org.apache.struts2.config.Results;

@SuppressWarnings("unchecked")
@Results( { 
	@Result(name="queryNodeGroupInfo", value = "/page/systemManage/nodegroup/nodegroupInfoList.jsp"),
	@Result(name="addNodeGroupInfo", value = "/page/systemManage/nodegroup/addNodegroupInfo.jsp"),
	@Result(name="updateNodeGroupInfo", value = "/page/systemManage/nodegroup/updateNodegroupInfo.jsp"),
	@Result(name="detailNodeGroupInfo", value = "/page/systemManage/nodegroup/detailNodegroupInfo.jsp"),
	
	@Result(name="nodeMgmtList", value = "/page/systemManage/nodegroup/nodeMgmtList.jsp"),
	
	@Result(name="error", value ="/error.jsp")
})
public class NodeGroupManageAction  extends BaseAction{
	private static final long serialVersionUID = 1L;
	private CommonService commonService;
	private int pageNo = 1;
	private int pageSize =this.getDefaultPageSize();		//每页显示的记录条数
	private Page page;
	private String action;//系统操作
	
	private List<NodegroupTable> nodeGroupList;
	private NodegroupTable nodeGroup;
	private Long nodeGroupId;
	private Long[] ids;//用户组id集合
	private List<XtJsJbxx> allUserGroup;//当前用户有权限的用户组
	
	//查询条件
	private String nameVo;
	private String descVo;
	
	private Long mkid;//业务系统ID
	private List<Resource> treeList;//当前用户有权限的业务系统
	private SystemTable system;//当前登录选择的业务系统
	private List<SystemTable> systemList;
	
	private List<NodeTable> nodeList;
	
	public String executeAction(){
		String resultPage = "";
		try{
			if(action==null){//管理页面，显示所有节点信息
				resultPage = queryNodeGroupInfo();
			}else if(action.equals("openAdd")){//转向添加节点组页面
				resultPage = openAddNodeGroupInfo();
			}else if(action.equals("doAdd")){//提交添加节点组信息
				resultPage = addNodeGroupInfo();
			}else if(action.equals("openUpdate")){//转向修改节点组页面
				resultPage = openUpdateNodeGroupInfo();
			}else if(action.equals("doUpdate")){//提交修改节点组信息
				resultPage = updateNodeGroupInfo();
			}else if(action.equals("stop")){//停用节点组
				resultPage = stopNodeGroupInfo();
			}else if(action.equals("start")){//启用节点组
				resultPage = startNodeGroupInfo();
			}else if(action.equals("detail")){//查看详情
				resultPage = detailNodeGroupInfo();
			}else if(action.equals("nodeMgmt")){//转向节点管理页面
				resultPage = nodeMgmtList();
			}else{//管理页面，显示所有节点信息
				resultPage = queryNodeGroupInfo();
			}
		}catch (Exception e){
			e.printStackTrace();
			return "error";
		}
		return resultPage;
	}
	
	//管理节点组信息列表
	public String queryNodeGroupInfo(){
		try{
			String hql = "from NodegroupTable where 1=1";
			String sqlCondition = "where 1=1";
			boolean ADMFlag = this.getAdminMark();
			this.getRequest().setAttribute("ADMFlag", ADMFlag);
			//当前登录用户非admin时才做查看权限限制
			if(!ADMFlag){
				//权限控制----------------------------------------------------begin
				//如果当前登录选择了业务系统，则只做和本业务系统相关的操作
				if(this.getSystemID()!=null){
					hql += " and systemId = " + this.getSystemID();
					sqlCondition += " and system_id=" + this.getSystemID();
				}
				//1 发布人查看,2 发布人所在组查看,3 系统内全部人员可看
				hql += " and (";
				hql += " (viewLevel=1 and createUserId=" + this.getUserID() + ")";
				hql += " or (viewLevel=2 and createUsergroupId in (select jsbh from XtYhJsIndex " +
									" where type=1 and yhbh='" + this.getUser().getYhbh() + "') )" ;
				if(this.getSystemID()!=null){
					hql += " or (viewLevel=3 and systemId=" + this.getSystemID() + ")";
				}else{
					hql += " or (viewLevel=3 and systemId in" +
						" (select systemId from GorupSystemTable where userGroupId in" +
							" (select jsbh from XtYhJsIndex where type=1 and yhbh='" + this.getUser().getYhbh() + "')" +
						" ) )";
				}
				hql += ")";
				//权限控制----------------------------------------------------end
			}
			if(nameVo!=null && !nameVo.trim().equals("")){
				hql += " and Upper(groupName) like '%" + nameVo.trim().toUpperCase() + "%'"; 
				sqlCondition += " and Upper(group_name) like '%" + nameVo.trim().toUpperCase() + "%'";
			}
			if(descVo!=null && !descVo.trim().equals("")){
				hql += " and Upper(groupDesc) like '%" + descVo.trim().toUpperCase() + "%'"; 
				sqlCondition += " and Upper(group_desc) like '%" + descVo.trim().toUpperCase() + "%'";
			}
			hql += " order by isValid desc,groupCreatetime desc";
			sqlCondition += " order by is_valid asc,Group_createtime desc";
			
			// 将查询请求记入到操作日志表中
			this.addDBOperationRpt(commonService, sqlCondition, "nodegroup_table");
			
			page = this.commonService.findByPage(hql, pageNo, pageSize);
			nodeGroupList = (List<NodegroupTable>)page.getResult();
		}catch (Exception e){
			e.printStackTrace();
			return "error";
		}
		return "queryNodeGroupInfo";
	}
	
	//打开添加节点组页面
	public String openAddNodeGroupInfo(){
		try {
			//查询系统
			/*treeList = new ArrayList();
			String hql = "from SystemTable where  systemState='0'" +//正常0;已删除或停用1
					" and systemId in (select systemId from GorupSystemTable where userGroupId in" +
						" (select jsbh from XtYhJsIndex where type=1 and yhbh='" + this.getUser().getYhbh() + "')" +
					" )";//当前用户所在组有权限的系统
			List<SystemTable> menuList = this.commonService.find(hql);
			for (int i = 0; i < menuList.size(); i++) {
				Resource resource = new Resource();
				resource.setParRsCode("0");
				resource.setRsCode(menuList.get(i).getSystemId().toString());
				resource.setRsid(menuList.get(i).getSystemId().toString());
				resource.setRsname(menuList.get(i).getSystemName().toString());
				treeList.add(resource);
			}*/
			boolean ADMFlag = this.getAdminMark();
			this.getRequest().setAttribute("ADMFlag", ADMFlag);
			if(ADMFlag){//如果是admin登陆则无限制
				String hql = "from SystemTable where systemState='0'";
				systemList = this.commonService.find(hql);
			}else{
				system = (SystemTable)this.commonService.get(SystemTable.class, this.getSystemID());
			}
			//查询当前用户所在的有效用户组
			this.queryAllUserGroup();
			
		} catch (Exception e) {
			e.printStackTrace();
			outHtmlString("<script type=\"text/javascript\">alert('i18n_NodeGroupManageAction.openAddNodeGroupInfo.faild_n81i');" +
			"this.location='nodeGroupManage.do?action=query'</script>");
		}
		return "addNodeGroupInfo";
	}
	
	//添加节点组
	public String addNodeGroupInfo(){
		try{
			List list = this.commonService.find("from NodegroupTable where groupName=?", nodeGroup.getGroupName());
			if(list!=null && list.size()>0){
				this.outHtmlString("<script>alert('i18n_NodeGroupManageAction.addNodeGroupInfo.nodeGroupExists_n81i');history.back();</script>");
				return null;
			}
			
			nodeGroup.setCreateUserId(this.getUserID());
			nodeGroup.setSystemId(mkid);
			nodeGroup.setGroupCreatetime(new Date());
			nodeGroup.setParentGroupId(new Long(0l));
			nodeGroup.setLeafGroup(new Long(0l));
			nodeGroup.setGroupLevel(new Long(1l));
			
			//获得新增节点组的显示序号
			Long showNum = new Long(0l);
			String indexSql = "select max(t.show_index) from nodegroup_table t where t.parent_group_id = 0";
			List subNodeGroup =  this.commonService.executeSQL(indexSql);
			if(subNodeGroup.size()>0) {
				Object showNumTemp = subNodeGroup.get(0);
				if(showNumTemp!=null) {
					showNum =  new Long(showNumTemp.toString())+1l;
				}
			}
			nodeGroup.setShowIndex(showNum);
			this.commonService.save(nodeGroup);
			
			//拓扑图的数据维护
			List nplist = this.commonService.find(
					"from NodePosition where nodeType='system' and nodeId=?",
					nodeGroup.getSystemId()+"");//查找父ID
			if (nplist != null && nplist.size() > 0) {
				NodePosition parent = (NodePosition) nplist.get(0);
				//查找是否有相同记录存在，不存在再添加
				nplist = this.commonService
						.find(
								"from NodePosition where nodeType='nodeGroup' and nodeId=? and parent_id=?",
								nodeGroup.getGroupId()+"", parent.getParent_id());
				if (nplist == null || nplist.size() == 0) {
					NodePosition np = new NodePosition();
					np.setTableName("nodegroup_table");
					np.setNodeType("nodeGroup");
					np.setNodeId(nodeGroup.getGroupId() + "");
					np.setPositionX(0l);
					np.setPositionY(0l);
					np.setImageUrl("/nmsweb/images/show/topic.png");
					np.setViewTimeMark(new Date());
					np.setViewType(1l);
					np.setParent_id(parent.getId());
					this.commonService.save(np);
					this.addDBOperationRpt(commonService, "node_position", "INSERT",np.getId());
				}
			}
			
			//将添加操作写到操作日志中
			this.addDBOperationRpt(commonService, "nodegroup_table", "INSERT", nodeGroup.getGroupId());
			this.sendNodeAndGroupId(nodeGroup.getGroupId(), null,commonService);	//通知NMSServer更新节点组的监控信息
			this.getRequest().setAttribute("MSG", 1);
		}catch (Exception e){
			e.printStackTrace();
			outHtmlString("<script type=\"text/javascript\">alert('i18n_NodeGroupManageAction.openAddNodeGroupInfo.faild_n81i');" +
					"this.location='nodeGroupManage.do?action=query'</script>");
		}
		return queryNodeGroupInfo();
	}
	
	//打开修改节点组信息页面
	public String openUpdateNodeGroupInfo(){
		try{
			if(ids!=null && ids.length>0){
				nodeGroupId = ids[0];
			}
			
			List list = this.commonService.find(
					"from NodegroupTable where groupId=?", nodeGroupId);
			if(list!=null && list.size()>0){
				nodeGroup = (NodegroupTable)list.get(0);
			}
			
			/*treeList = new ArrayList<Resource>();
			String hql = "from SystemTable where  systemState='0'" +//正常0;已删除或停用1
				" and systemId in (select systemId from GorupSystemTable where userGroupId in" +
					" (select jsbh from XtYhJsIndex where type=1 and yhbh='" + this.getUser().getYhbh() + "')" +
				" )";//当前用户所在组有权限的系统
			List<SystemTable> menuList = this.commonService.find(hql);
			// 查询用户组属于的nms系统
			for (SystemTable systable : menuList) {
				Resource re = new Resource();
				// 如果本节点组属于这个系统将其选中
				if (nodeGroup!=null && systable.getSystemId()
							.equals(nodeGroup.getSystemId())) {
						re.setChecked("checked");
				}
				re.setRsid(systable.getSystemId().toString().trim());
				re.setRsname(systable.getSystemName());
				re.setRsdesc(systable.getSystemDesc());
				// 系统的父id设为0
				re.setParRsCode("0");
				re.setRsCode(systable.getSystemId().toString());
				treeList.add(re);// 添加系统结束
			}*/
			boolean ADMFlag = this.getAdminMark();
			this.getRequest().setAttribute("ADMFlag", ADMFlag);
			if(ADMFlag){//如果是admin登陆则无限制
				String hql = "from SystemTable where systemState='0'";
				systemList = this.commonService.find(hql);
			}else{
				system = (SystemTable)this.commonService.get(SystemTable.class, this.getSystemID());
			}
			
			//查询当前用户所在的有效用户组
			this.queryAllUserGroup();
			
		}catch (Exception e){
			e.printStackTrace();
			outHtmlString("<script type=\"text/javascript\">alert('i18n_NodeGroupManageAction.openAddNodeGroupInfo.faild_n81i');" +
			"this.location='nodeGroupManage.do?action=query'</script>");
		}
		return "updateNodeGroupInfo";
	}
	
	//修改节点组
	public String updateNodeGroupInfo(){
		try{
			List list = this.commonService.find("from NodegroupTable where groupName=? and groupId<>?", 
					nodeGroup.getGroupName(),nodeGroup.getGroupId());
			if(list!=null && list.size()>0){
				this.outHtmlString("<script>alert('i18n_NodeGroupManageAction.addNodeGroupInfo.nodeGroupExists_n81i');history.back();</script>");
				return null;
			}
			
			List noList = this.commonService.find("from NodegroupTable where groupId=?", nodeGroup.getGroupId());
			NodegroupTable group = (NodegroupTable) this.commonService.get(NodegroupTable.class, nodeGroup.getGroupId());
			boolean flag = false;
			if(group != null){
//				NodegroupTable group = (NodegroupTable)noList.get(0);
				
				if(!group.getIsValid().equals(nodeGroup.getIsValid())){
					flag = true;
				}
				group.setGroupName(nodeGroup.getGroupName());
				group.setGroupType(nodeGroup.getGroupType());
				group.setGroupDesc(nodeGroup.getGroupDesc());
				group.setIsValid(nodeGroup.getIsValid());
				group.setViewLevel(nodeGroup.getViewLevel());
				group.setSystemId(mkid);
				group.setCreateUsergroupId(nodeGroup.getCreateUsergroupId());
				this.commonService.update(group);
				
				//将更新操作写到操作日志中
				this.addDBOperationRpt(commonService, "nodegroup_table", "UPDATE", nodeGroup.getGroupId());
			}
			if(flag){
				this.sendNodeAndGroupId(group.getGroupId(), null,commonService);	//通知NMSServer更新节点组的监控信息
			}
			this.getRequest().setAttribute("MSG", 1);
		}catch (Exception e){
			e.printStackTrace();
			outHtmlString("<script type=\"text/javascript\">alert('i18n_NodeGroupManageAction.openAddNodeGroupInfo.faild_n81i');" +
			"this.location='nodeGroupManage.do?action=query'</script>");
		}
		return queryNodeGroupInfo();
	}
	
	//停用节点组
	public String stopNodeGroupInfo(){
		try{
			if(ids!=null && ids.length>0){
				for(int i=0; i<ids.length; i++){
					this.commonService.updateByHql(
							"update NodegroupTable set isValid=0 where groupId=?", ids[i]);
					this.sendNodeAndGroupId(ids[i], null,commonService);	//通知NMSServer更新节点组的监控信息
					//将更新操作写到操作日志中
					this.addDBOperationRpt(commonService, "nodegroup_table", "UPDATE", ids[i]);
				}
			}
			
			//this.getRequest().setAttribute("MSG", 1);
		}catch (Exception e){ 
			e.printStackTrace();
			outHtmlString("<script type=\"text/javascript\">alert('i18n_NodeGroupManageAction.openAddNodeGroupInfo.faild_n81i');" +
			"this.location='nodeGroupManage.do?action=query'</script>");
		}
		outHtmlString("<script type=\"text/javascript\">alert('i18n_NodeGroupManageAction.startNodeGroupInfo.faild_n81i');" +
				"this.location='nodeGroupManage.do?action=query&pageNo=" + pageNo +
				"&pageSize=" + pageSize + "'</script>");
		return null;
		//return queryNodeGroupInfo();
	}
	
	//启用节点组
	public String startNodeGroupInfo(){
		try{
			if(ids!=null && ids.length>0){
				for(int i=0; i<ids.length; i++){
					this.commonService.updateByHql(
							"update NodegroupTable set isValid=1 where groupId=?", ids[i]);
					this.sendNodeAndGroupId(ids[i], null,commonService);	//通知NMSServer更新节点组的监控信息
					//将更新操作写到操作日志中
					this.addDBOperationRpt(commonService, "nodegroup_table", "UPDATE", ids[i]);
				}
			}
		}catch (Exception e){ 
			e.printStackTrace();
			outHtmlString("<script type=\"text/javascript\">alert('i18n_NodeGroupManageAction.openAddNodeGroupInfo.faild_n81i');" +
			"this.location='nodeGroupManage.do?action=query'</script>");
		}
		
		outHtmlString("<script type=\"text/javascript\">alert('i18n_NodeGroupManageAction.startNodeGroupInfo.faild_n81i');" +
				"this.location='nodeGroupManage.do?action=query&pageNo=" + pageNo +
				"&pageSize=" + pageSize + "'</script>");
		return null;
		//this.getRequest().setAttribute("MSG", 1);
		//return queryNodeGroupInfo();
	}
	
	//查看节点组详情
	public String detailNodeGroupInfo(){
		try{
			List list = this.commonService.find(
					"from NodegroupTable where groupId=?", nodeGroupId);
			if(list!=null && list.size()>0){
				nodeGroup = (NodegroupTable)list.get(0);
				List syslist = this.commonService.find("from SystemTable where systemId=?", nodeGroup.getSystemId());
				if(syslist!=null && syslist.size()>0){
					SystemTable sys = (SystemTable)syslist.get(0);
					nodeGroup.setSystemIdName(sys.getSystemName());
				}
				if (nodeGroup.getCreateUsergroupId()!=null && nodeGroup.getCreateUsergroupId().intValue()!=0) {
					XtJsJbxx xtjsjbxx = (XtJsJbxx) this.commonService.get(
							XtJsJbxx.class, nodeGroup.getCreateUsergroupId());
					if (xtjsjbxx != null) {
						nodeGroup.setUserGroupIdName(xtjsjbxx.getJsmc());
					}
				}
				
				String hql = "from NodeTable where groupId = " + nodeGroup.getGroupId() + "";
				nodeList = (List<NodeTable>)this.commonService.find(hql);
			}
			
		}catch (Exception e){
			e.printStackTrace();
			outHtmlString("<script type=\"text/javascript\">alert('i18n_NodeGroupManageAction.openAddNodeGroupInfo.faild_n81i');" +
			"this.location='nodeGroupManage.do?action=query'</script>");
		}
		return "detailNodeGroupInfo";
	}
	

	//查询当前用户所在的用户组
	private void queryAllUserGroup(){
		try {
			//查询当前用户所在的有效用户组
			String hql2 = "from XtJsJbxx where zxbz=0 and jsbh in" +//zxbz注销标志，0是有效，1是无效
					" (select jsbh from XtYhJsIndex where type=1 and yhbh='" + this.getUser().getYhbh() + "')";
			allUserGroup = this.commonService.find(hql2);
		} catch (Exception e) {
			e.printStackTrace();
			outHtmlString("<script type=\"text/javascript\">alert('i18n_NodeGroupManageAction.openAddNodeGroupInfo.faild_n81i');" +
			"this.location='nodeGroupManage.do?action=query'</script>");
		}
	}
	
	
/**==========================================节点操作开始=========================	==========**/
	//打开节点管理页面
	public String nodeMgmtList(){
		try{
			if(ids!=null && ids.length>0){
				nodeGroupId = ids[0];
			}
			
			List list = this.commonService.find(
					"from NodegroupTable where groupId=?", nodeGroupId);
			if(list!=null && list.size()>0){
				nodeGroup = (NodegroupTable)list.get(0);
			}
			
		}catch (Exception e){
			e.printStackTrace();
			outHtmlString("<script type=\"text/javascript\">alert('i18n_NodeGroupManageAction.openAddNodeGroupInfo.faild_n81i');" +
			"this.location='nodeGroupManage.do?action=query'</script>");
		}
		return "nodeMgmtList";
	}

	public NodeGroupManageAction() {
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

	public List<NodegroupTable> getNodeGroupList() {
		return nodeGroupList;
	}

	public void setNodeGroupList(List<NodegroupTable> nodeGroupList) {
		this.nodeGroupList = nodeGroupList;
	}

	public NodegroupTable getNodeGroup() {
		return nodeGroup;
	}

	public void setNodeGroup(NodegroupTable nodeGroup) {
		this.nodeGroup = nodeGroup;
	}

	public Long getNodeGroupId() {
		return nodeGroupId;
	}

	public void setNodeGroupId(Long nodeGroupId) {
		this.nodeGroupId = nodeGroupId;
	}

	public String getNameVo() {
		return nameVo;
	}

	public void setNameVo(String nameVo) {
		this.nameVo = nameVo;
	}

	public String getDescVo() {
		return descVo;
	}

	public void setDescVo(String descVo) {
		this.descVo = descVo;
	}

	public Long getMkid() {
		return mkid;
	}

	public void setMkid(Long mkid) {
		this.mkid = mkid;
	}

	public List<Resource> getTreeList() {
		return treeList;
	}

	public void setTreeList(List<Resource> treeList) {
		this.treeList = treeList;
	}

	public List<XtJsJbxx> getAllUserGroup() {
		return allUserGroup;
	}

	public void setAllUserGroup(List<XtJsJbxx> allUserGroup) {
		this.allUserGroup = allUserGroup;
	}

	public List<NodeTable> getNodeList() {
		return nodeList;
	}

	public void setNodeList(List<NodeTable> nodeList) {
		this.nodeList = nodeList;
	}

	public Long[] getIds() {
		return ids;
	}

	public void setIds(Long[] ids) {
		this.ids = ids;
	}

	public SystemTable getSystem() {
		return system;
	}

	public void setSystem(SystemTable system) {
		this.system = system;
	}

	public List<SystemTable> getSystemList() {
		return systemList;
	}

	public void setSystemList(List<SystemTable> systemList) {
		this.systemList = systemList;
	}

}
