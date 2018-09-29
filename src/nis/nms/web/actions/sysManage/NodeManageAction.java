package nis.nms.web.actions.sysManage;

import java.io.File;
import java.io.FileInputStream;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import nis.nms.core.Resource;
import nis.nms.domains.NodeLatticeTable;
import nis.nms.domains.NodePosition;
import nis.nms.domains.NodeTable;
import nis.nms.domains.NodeTableVo;
import nis.nms.domains.NodegroupTable;
import nis.nms.domains.SystemTable;
import nis.nms.service.CommonService;
import nis.nms.util.BaseAction;
import nis.nms.util.ExportUtils;
import nis.nms.util.IpCovert;
import nis.nms.util.Page;

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
		@Result(name = "queryNodeInfo", value = "/page/systemManage/node/nodeInfoList.jsp"),
		@Result(name = "addNodeInfo", value = "/page/systemManage/node/addNodeInfo.jsp"),
		@Result(name = "updateNodeInfo", value = "/page/systemManage/node/updateNodeInfo.jsp"),
		@Result(name = "detailNodeInfo", value = "/page/systemManage/node/detailNodeInfo.jsp"),
		@Result(name = "showError", value = "/page/systemManage/node/showImportError.jsp"),
		@Result(name = "error", value = "/error.jsp") })
public class NodeManageAction extends BaseAction {
	private CommonService commonService;
	private int pageNo = 1;
	private int pageSize = this.getDefaultPageSize(); // 每页显示的记录条数
	private Page page;
	private String action;// 系统操作

	private List<NodeTable> nodeList;
	private NodeTable nodeTable;
	private Long nodeId;

	// 查询条件
	private String nodeNameVo;
	private String nodeDescVo;
	private Long nodeGroupId;// 指定组ID查找相应的节点

	private Long mkid;// 节点组ID
	private List<Resource> treeList;// 节点组菜单

	// 导入节点文件
	private File myFile;
	private String myFileFileName;

	private String oldNodeIp;
	private String isNone;

	public String executeAction() {
		String resultPage = "";
		try {
			if (action == null) {
				return "";
			}
			if (action.equals("query")) {// 管理页面，显示所有节点信息
				resultPage = queryNodeInfo();
			}
			if (action.equals("openAdd")) {// 转向添加页面
				resultPage = openAddNodeInfo();
			}
			if (action.equals("doAdd")) {// 提交添加信息
				resultPage = addNodeInfo();
			}
			if (action.equals("openUpdate")) {// 转向修改页面
				resultPage = openUpdateNodeInfo();
			}
			if (action.equals("doUpdate")) {// 提交修改信息
				resultPage = updateNodeInfo();
			}
			if (action.equals("stop")) {// 停用
				resultPage = stopNodeInfo();
			}
			if (action.equals("start")) {// 启用
				resultPage = startNodeInfo();
			}
			if (action.equals("detail")) {// 查看详情
				resultPage = detailNodeInfo();
			}
			if (action.equals("downloadExample")) {// 导出模板
				resultPage = this.downloadExample();
			}
			if (action.equals("importXls")) {// 导入
				resultPage = this.importXls();
			}
		} catch (Exception e) {
			e.printStackTrace();
			return "error";
		}
		return resultPage;
	}

	// 管理节点信息列表
	public String queryNodeInfo() {
		try {
			String hql = "from NodeTable where 1=1";
			String sqlCondition = "select * from node_table where 1=1";
			if (nodeNameVo != null && !nodeNameVo.trim().equals("")) {
				hql += " and Upper(nodeName) like '%" + nodeNameVo.trim().toUpperCase() + "%'";
				sqlCondition += " and Upper(node_name) like '%" + nodeNameVo.trim().toUpperCase()
						+ "%'";
			}
			if (nodeDescVo != null && !nodeDescVo.trim().equals("")) {
				hql += " and Upper(nodeDesc) like '%" + nodeDescVo.trim().toUpperCase() + "%'";
				sqlCondition += " and Upper(node_desc) like '%" + nodeDescVo.trim().toUpperCase()
						+ "%'";
			}

			if (nodeGroupId != null) {// 指定组ID查找相应的节点
				hql += " and groupId ="	+ nodeGroupId + "";
			}
			hql += " order by nodeState asc,nodeCreatetime desc";
			sqlCondition += " order by node_state asc,Node_createtime desc";

			// 将查询请求记入到操作日志表中
			this.addDBOperationRpt(commonService, sqlCondition, "node_table");

			page = this.commonService.findByPage(hql, pageNo, pageSize);
			nodeList = (List<NodeTable>) page.getResult();

			for (NodeTable node : nodeList) {
				List syslist = this.commonService
						.find("from SystemTable where systemId = " + node.getSystemId());
				if (syslist != null && syslist.size() > 0) {
					node.setSystemIdName(((SystemTable) syslist.get(0))
							.getSystemName());
				}
				NodegroupTable nodegroupTable = (NodegroupTable) this.commonService.get(NodegroupTable.class, node.getGroupId());
				if(nodegroupTable!=null){
					node.setGroupIdName(nodegroupTable.getGroupName());
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			return "error";
		}
		return "queryNodeInfo";
	}

	// 打开添加节点页面
	public String openAddNodeInfo() {
		try {
			// 如果没有指定具体的节点组，即不在节点组查看详情页面点击新增
			if (nodeGroupId == null || nodeGroupId.equals("")) {
				// 查询节点组
				treeList = new ArrayList();
				String hql = "from NodegroupTable where isValid=1";// 0是失效，1是生效
				// 1 发布人查看,2 发布人所在组查看,3 系统内全部人员可看
				hql += " and (";
				hql += " (viewLevel=1 and createUserId=" + this.getUserID()
						+ ")";
				hql += " or (viewLevel=2 and createUsergroupId in (select jsbh from XtYhJsIndex "
						+ " where type=1 and yhbh='"
						+ this.getUser().getYhbh()
						+ "') )";
				hql += " or (viewLevel=3 and systemId in"
						+ " (select systemId from GorupSystemTable where userGroupId in"
						+ " (select jsbh from XtYhJsIndex where type=1 and yhbh='"
						+ this.getUser().getYhbh() + "')" + " ) )";
				hql += ")";
				List<NodegroupTable> menuList = this.commonService.find(hql);
				for (int i = 0; i < menuList.size(); i++) {
					Resource resource = new Resource();
					resource.setParRsCode("0");
					resource.setRsCode(menuList.get(i).getGroupId().toString());
					resource.setRsid(menuList.get(i).getGroupId().toString());
					resource.setRsname(menuList.get(i).getGroupName());
					treeList.add(resource);
				}
				this.getRequest().setAttribute("treeList", treeList);
				String sqlCondition = "where is_valid=0";// 将查询条件记录到操作日志中
				// 将查询请求记入到操作日志表中
				this.addDBOperationRpt(commonService, sqlCondition,
						"nodegroup_table");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return "addNodeInfo";
	}

	// 添加节点
	public String addNodeInfo() {
		try {
			if (nodeGroupId != null && !nodeGroupId.equals("")) {
				mkid = nodeGroupId;
			}
			//IP在同一节点组下不重复
			if(!groupNodeIpIsRepeat(nodeTable.getNodeIp(),mkid)){
				commonService.beginTransaction();
				NodegroupTable group = (NodegroupTable) this.commonService.get(NodegroupTable.class, mkid);
				if (group != null ) {
					//处理节点类型与节点U位，为了保证拓扑图的正常显示
					long seqId = this.getNodeSeqID(nodeTable.getNodeIp());
					boolean yes = this.checkNodeTypeAndU(seqId, nodeTable.getNodeType(), nodeTable.getNodeUType(),null);
					if(!yes){
						this.outHtmlString("<script>alert('i18n_NodeManageAction.addNodeInfo.nodeTypeInvalid_n81i');history.back();</script>");
						return null;
					}
					// 保存节点信息
					nodeTable.setSystemId(group.getSystemId());
					nodeTable.setCreateUserId(this.getUserID());
					nodeTable.setNodeCreatetime(new Date());
					nodeTable.setGroupId(group.getGroupId());
					nodeTable.setIpn(IpCovert.ipToLong(nodeTable.getNodeIp()));
					//seqId与机柜格子Id的处理
					List<NodeLatticeTable> nltList = this.commonService.find("from NodeLatticeTable where nodeSeqId=?", seqId);
					if(nltList!=null && nltList.size()>0){
						nodeTable.setNodeLatticeId(nltList.get(0).getId());
					}
					nodeTable.setSeqId(seqId);
					nodeTable.setNodeSystemType(this.getNodeSystemType(seqId));
					
					this.commonService.save(nodeTable);
					
					//拓扑图的数据维护
					if (nltList != null && nltList.size() > 0) {
						String boxId = nltList.get(0).getNodeBoxId() + "";
						//查找父记录
						List nplist = this.commonService.find(
								"from NodePosition where nodeType='nodeGroup' and nodeId=?",
								nodeTable.getGroupId()+"");
						if (nplist != null && nplist.size() > 0) {
							NodePosition parent = (NodePosition) nplist.get(0);
							//查找是否有相同记录存在，不存在再添加
							nplist = this.commonService.find(
									"from NodePosition where nodeType='nodeBox' and nodeId=? and parent_id=?",
									boxId, parent.getId());
							if (nplist == null || nplist.size() == 0) {
								NodePosition np = new NodePosition();
								np.setTableName("node_box_table");
								np.setNodeType("nodeBox");
								np.setNodeId(boxId);
								np.setPositionX(0l);
								np.setPositionY(0l);
								np.setImageUrl("/nmsweb/images/show/nm.png");
								np.setViewTimeMark(new Date());
								np.setViewType(2l);
								np.setParent_id(parent.getId());
								
								this.commonService.save(np);
								this.addDBOperationRpt(commonService, "node_position", "INSERT",np.getId());
							}
						}
					}
					// 将添加操作写到操作日志中
					this.addDBOperationRpt(commonService, "node_table", "INSERT",nodeTable.getNodeId());
					commonService.commit();
					if(new Long(1).equals(group.getIsValid())){		//节点组有效
						this.sendNodeAndGroupId(nodeTable.getGroupId(), nodeTable.getNodeId(),commonService);	//通知NMSServer更新节点组的监控信息
					}
					
				}
				this.getRequest().setAttribute("MSG", 1);
				
			}else{
				this.outHtmlString("<script>alert('i18n_NodeManageAction.addNodeInfo.nodeGroupHadIp_n81i');history.back();</script>");
				return null;
			}
		} catch (Exception e) {
			commonService.rollback();
			e.printStackTrace();
			return "error";
		}
		return queryNodeInfo();
	}
	
	/**
	 * 根据节点的唯一标识判断同一节点的节点类型和U位是否一致
	 * @param seqId 节点唯一标识
	 * @param nodeType 节点类型
	 * @param uType 节点U位类型
	 * @return
	 */
	public boolean checkNodeTypeAndU(Long seqId, Long nodeType, Long uType, Long nodeId){
		boolean flag = true;
		try {
			String sql = "from NodeTable where seqId=" + seqId;
			if(nodeId!=null && !"".equals(nodeId)){
				sql += " and nodeId<>" + nodeId;
			}
			sql += " order by nodeUType";
			List list = this.commonService.find(sql);
			if(list!=null && list.size()>0){
				NodeTable nt = (NodeTable)list.get(0);
				if(nt.getNodeType()!=null && nodeType!=null && nt.getNodeType().intValue()!=nodeType.intValue()){
					flag = false;
				}
				if(nt.getNodeUType()!=null && uType!=null && nt.getNodeUType().intValue()!=uType.intValue()){
					flag = false;
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			flag = false;
		}
		
		return flag;
	}
	
	/**
	 * 根据新旧ip获取节点唯一标识
	 * @param nodeIp 节点ip
	 * @return		 节点唯一标识
	 */
	public Long getNodeSeqID(String nodeIp){
		List<Object> list = new ArrayList();
			try {
				list = this.commonService.executeSQL("select nt.seq_id from node_table nt where nt.node_ip = '"+nodeIp+"'");
				if(list!=null && list.size()>0){	//已存在
					if(list.get(0) != null && !"".equals(list.get(0))){
						return Long.parseLong(list.get(0).toString());
					}else{
						list = this.commonService.executeSQL("select seq_seq_id.nextval seq_id from dual");
						if(list.get(0) != null && !"".equals(list.get(0))){
							return Long.parseLong(list.get(0).toString());//跳过
						}else{
							return null;
						}
					}
				}else{
					list = this.commonService.executeSQL("select seq_seq_id.nextval seq_id from dual");
					if(list.get(0) != null && !"".equals(list.get(0))){
						return Long.parseLong(list.get(0).toString());//跳过
					}else{
						return null;
					}
				}
			} catch (Exception e) {
				e.printStackTrace();
				return null;
			}		
	}

	/**
	 * 根据节点唯一标识seqId获取节点操作系统类型
	 * @param seqId 节点唯一标识
	 * @return		 节点操作系统类型
	 */
	public Long getNodeSystemType(Long seqId) {
		try {
			if (seqId != null) {
				List<Object> list = this.commonService
						.executeSQL("select nt.node_system_type from node_table nt where nt.node_system_type is not null and nt.seq_id = " + seqId+"");
				if (list != null && list.size() > 0) { // 已存在
					if (list.get(0) != null && !"".equals(list.get(0))) {
						return Long.parseLong(list.get(0).toString());
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
		return null;
	}

	/**
	 * 根据节点ip判断是否是新ip
	 * @param nodeIp
	 * @return
	 */
	public boolean nodeIpIsNew(String nodeIp){
		boolean retFlag = true;
		List<Object[]> list = new ArrayList();
		if(nodeIp!=null && !"".equals(nodeIp)){
			try {
				list = this.commonService.executeSQL("select nt.node_ip,nt.seq_id from node_table nt where nt.node_ip = '"+nodeIp+"'");
				if(list!=null && list.size()>0){	//已存在
					retFlag = false;
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return retFlag;
	}
	
	/**
	 * 根据节点ip判断是否是是多重IP记录
	 * @param nodeIp
	 * @return
	 */
	public boolean nodeIpIsRepeat(String nodeIp,Long nodeId){
		boolean retFlag = false;
		List<Object[]> list = new ArrayList();
		if(nodeIp!=null && !"".equals(nodeIp)){
			try {
				list = this.commonService.executeSQL("select nt.node_ip,nt.seq_id from node_table nt where nt.node_ip = '"+nodeIp+"' and nt.node_id <> "+nodeId);
				if(list!=null && list.size()>0){	//已存在
					retFlag = true;
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return retFlag;
	}
	
	/**
	 * 判断新节点在ip节点组中是否重复
	 * @param nodeIp 	节点IP
	 * @param groupId 	节点组ID
	 * @return 是true否false
	 */
	public boolean groupNodeIpIsRepeat(String nodeIp,Long groupId){
		boolean retFlag = false;
		List<Object[]> list = new ArrayList();
		if(nodeIp!=null && !"".equals(nodeIp)){
			try {
				list = this.commonService.executeSQL("select nt.node_id  from node_table nt where nt.node_ip = '"+nodeIp+"' and nt.node_group_id = "+groupId);
				if(list!=null && list.size()>0){	//已存在
					retFlag = true;
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return retFlag;
	}
	/**
	 * 判断新节点在ip节点组中是否重复
	 * @param nodeIp 	节点IP
	 * @param groupId 	节点组ID
	 * @return 是true否false
	 */
	public boolean groupNodeIpIsRepeat(String nodeIp,Long groupId,Long nodeId){
		boolean retFlag = false;
		List<Object[]> list = new ArrayList();
		if(nodeIp!=null && !"".equals(nodeIp)){
			try {
				list = this.commonService.executeSQL("select nt.node_id  from node_table nt where nt.node_id <> "+nodeId+" and nt.node_ip = '"+nodeIp+"' and nt.node_group_id = "+groupId);
				if(list!=null && list.size()>0){	//已存在
					retFlag = true;
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return retFlag;
	}
	
	/**
	 * 根据节点的seqId获取节点的boxId
	 * @param seqId 节点的seqId
	 * @return		节点的boxId
	 *//*
	public Long getNodeBoxID(Long seqId) {
		Long boxId = null;
		List<Object> list = new ArrayList();
		try {
			list = this.commonService
					.executeSQL("select mt.box_id from nodegroup_mem_table mt where mt.box_id is not null and mt.node_id in (select nt.node_id from node_table nt where nt.seq_id = "
							+ seqId + ")");
			if (list != null && list.size() > 0) { // 已存在
				if (list.get(0) != null && !"".equals(list.get(0))) {
					boxId = Long.parseLong(list.get(0).toString());
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
		return boxId;
	}*/
	
	// 打开修改节点信息页面
	public String openUpdateNodeInfo() {
		try {
			List list = this.commonService.find(
					"from NodeTable where nodeId=?", nodeId);
			if (list != null && list.size() > 0) {
				nodeTable = (NodeTable) list.get(0);
				//判断U位是否为空
				if(!"".equals(nodeTable.getNodeUType()) && nodeTable.getNodeUType()!=null){
					isNone = "block";
				}else{
					isNone = "none";
				}
				// 如果没有指定具体的节点组，即不在节点组查看详情页面点击修改
				if (nodeGroupId == null || nodeGroupId.equals("")) {
					// 查询节点组
					treeList = new ArrayList();
					String hql = "from NodegroupTable where isValid=1";// 0是失效，1是生效
					// 1 发布人查看,2 发布人所在组查看,3 系统内全部人员可看
					hql += " and (";
					hql += " (viewLevel=1 and createUserId=" + this.getUserID()
							+ ")";
					hql += " or (viewLevel=2 and createUsergroupId in (select jsbh from XtYhJsIndex "
							+ " where type=1 and yhbh='"
							+ this.getUser().getYhbh() + "') )";
					hql += " or (viewLevel=3 and systemId in"
							+ " (select systemId from GorupSystemTable where userGroupId in"
							+ " (select jsbh from XtYhJsIndex where type=1 and yhbh='"
							+ this.getUser().getYhbh() + "')" + " ) )";
					hql += ")";
					List<NodegroupTable> menuList = this.commonService
							.find(hql);
					for (int i = 0; i < menuList.size(); i++) {
						Resource resource = new Resource();
						// 如果本节点属于这个节点组将其选中
						if (menuList.get(i).getGroupId().equals(nodeGroupId)) {
							resource.setChecked("checked");
						}
						resource.setParRsCode("0");
						resource.setRsCode(menuList.get(i).getGroupId()
								.toString());
						resource.setRsid(menuList.get(i).getGroupId()
								.toString());
						resource.setRsname(menuList.get(i).getGroupName());
						treeList.add(resource);
					}
					this.getRequest().setAttribute("treeList", treeList);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			return "error";
		}
		return "updateNodeInfo";
	}

	// 修改节点
	public String updateNodeInfo() {
		try {
			if (nodeGroupId != null && !nodeGroupId.equals("")) {
				mkid = nodeGroupId;
			}
			//IP在同一节点组下不重复
			if(!groupNodeIpIsRepeat(nodeTable.getNodeIp(),mkid,nodeTable.getNodeId())){	
				commonService.beginTransaction();
				NodeTable nt = (NodeTable) this.commonService.get(NodeTable.class, nodeTable.getNodeId());
				if (nt != null ) {
					boolean flag =false;
					Long seqId = nt.getSeqId();
					if(oldNodeIp!=null && !"".equals(oldNodeIp)){
						//新旧节点IP不一致，节点IP变更
						if(!oldNodeIp.equals(nodeTable.getNodeIp().trim())){
							//不是新IP
							if(!nodeIpIsNew(nodeTable.getNodeIp().trim())){
								seqId = this.getNodeSeqID(nodeTable.getNodeIp().trim());
								nt.setSeqId(seqId);
								nt.setNodeSystemType(this.getNodeSystemType(seqId));
							}else if(nodeIpIsRepeat(oldNodeIp,nt.getNodeId())){
								//是新IP判断oldNodeIP已存在重复记录
								//如果oldNodeIP已存在重复记录则需要变更该记录的SEQID
								//如果oldNodeIP不存在重复记录则无需变更该记录的SEQID
								seqId = this.getNodeSeqID(nodeTable.getNodeIp().trim());
								nt.setSeqId(seqId);
								nt.setNodeSystemType(this.getNodeSystemType(seqId));
							}
						}
					}
					//处理节点类型与节点U位，为了保证拓扑图的正常显示
					boolean yes = this.checkNodeTypeAndU(seqId, nodeTable.getNodeType(), nodeTable.getNodeUType(),nodeTable.getNodeId());
					if(!yes){
						this.outHtmlString("<script>alert('i18n_NodeManageAction.addNodeInfo.nodeTypeInvalid_n81i');history.back();</script>");
						return null;
					}
					if(!nt.getNodeState().equals(nodeTable.getNodeState())){
						flag = true;
					}
					nt.setNodeIp(nodeTable.getNodeIp().trim());
					nt.setNodeName(nodeTable.getNodeName().trim());
					nt.setNodeDesc(nodeTable.getNodeDesc().trim());
					nt.setNodeState(nodeTable.getNodeState());
					nt.setNodeUType(nodeTable.getNodeUType());
					nt.setSnmpVersion(nodeTable.getSnmpVersion());
					// 节点组成员相关操作
					NodegroupTable group = (NodegroupTable) this.commonService.get(NodegroupTable.class, mkid);
					if (group != null) {
						// 设置节点信息的系统ID
						nt.setSystemId(group.getSystemId());
						nt.setGroupId(group.getGroupId());
					}
	
					this.commonService.update(nt);
					// 将更新操作写到操作日志中
					this.addDBOperationRpt(commonService, "node_table", "UPDATE",
							nodeTable.getNodeId());
					commonService.commit();
					if(flag){
						if(new Long(1).equals(group.getIsValid())){		//节点组有效
							this.sendNodeAndGroupId(nt.getGroupId(), nt.getNodeId(),commonService);	//通知NMSServer更新节点组的监控信息
						}
					}
				
				}
	
				this.getRequest().setAttribute("MSG", 1);
				
			}else{
				this.outHtmlString("<script>alert('i18n_NodeManageAction.addNodeInfo.nodeGroupHadIp_n81i');history.back();</script>");
				return null;
			}
		} catch (Exception e) {
			commonService.rollback();
			e.printStackTrace();
			return "error";
		}
		return queryNodeInfo();
	}

	// 停用节点
	public String stopNodeInfo() {
		try {
			commonService.beginTransaction();
			List noList = this.commonService.find(
					"from NodeTable where nodeId=?", nodeId);

			if (noList != null && noList.size() > 0) {
				NodeTable nd = (NodeTable) noList.get(0);
				nd.setNodeState(1l);
				nd.setStopUserId(this.getUserID());
				nd.setNodeStoptime(new Date());

				this.commonService.update(nd);
				
				// 将更新操作写到操作日志中
				this.addDBOperationRpt(commonService, "node_table", "UPDATE",
						nd.getNodeId());
				commonService.commit();
				NodegroupTable group = (NodegroupTable) this.commonService.get(NodegroupTable.class, nd.getGroupId());
				if(new Long(1).equals(group.getIsValid())){		//节点组有效
					this.sendNodeAndGroupId(nd.getGroupId(), nd.getNodeId(),commonService);	//通知NMSServer更新节点组的监控信息
				}
				
				
			}

			this.getRequest().setAttribute("MSG", 1);
			
		} catch (Exception e) {
			commonService.rollback();
			e.printStackTrace();
			return "error";
		}
		return queryNodeInfo();
	}

	// 启用节点
	public String startNodeInfo() {
		try {
			commonService.beginTransaction();
			this.commonService.updateByHql(
					"update NodeTable set nodeState=0 where nodeId=?", nodeId);
			NodeTable nd = (NodeTable) this.commonService.get(NodeTable.class, nodeId);
			NodegroupTable group = (NodegroupTable) this.commonService.get(NodegroupTable.class, nd.getGroupId());
			// 将更新操作写到操作日志中
			this.addDBOperationRpt(commonService, "node_table", "UPDATE",
					nodeId);
			commonService.commit();
			if(new Long(1).equals(group.getIsValid())){		//节点组有效
				this.sendNodeAndGroupId(nd.getGroupId(), nd.getNodeId(),commonService);	//通知NMSServer更新节点组的监控信息
			}
			
		} catch (Exception e) {
			commonService.rollback();
			e.printStackTrace();
			return "error";
		}

		this.getRequest().setAttribute("MSG", 1);
		return queryNodeInfo();
	}

	// 查看节点详情
	public String detailNodeInfo() {
		try {
			List list = this.commonService.find(
					"from NodeTable where nodeId=?", nodeId);
			if (list != null && list.size() > 0) {
				nodeTable = (NodeTable) list.get(0);
				List syslist = this.commonService
						.find("from SystemTable where systemId = "
								+ nodeTable.getSystemId());
				if (syslist != null && syslist.size() > 0) {
					nodeTable.setSystemIdName(((SystemTable) syslist.get(0))
							.getSystemName());
				}
				NodegroupTable ngt = (NodegroupTable) this.commonService.get(NodegroupTable.class, nodeTable.getGroupId());
				if (ngt != null) {
					nodeTable.setGroupIdName(ngt.getGroupName());
				}
			}

		} catch (Exception e) {
			e.printStackTrace();
			return "error";
		}
		return "detailNodeInfo";
	}

	// 模板下载
	public String downloadExample() {
		try {
			String s = null;

			Page p = this.commonService.findByPage("from NodeTable", 1, 3);
			List<NodeTable> st = (List<NodeTable>) p.getResult();

			String[] title = { getI18nText("i18n_NodeManageAction.downloadExample.title.nodeIp_n81i"),
								getI18nText("i18n_NodeManageAction.downloadExample.title.nodeName_n81i"), 
								getI18nText("i18n_NodeManageAction.downloadExample.title.nodeDesc_n81i"),
								getI18nText("i18n_NodeManageAction.downloadExample.title.nodeType_n81i"),
								getI18nText("i18n_NodeManageAction.downloadExample.title.nodeState_n81i") };
			String[] colu = { "nodeIp", "nodeName", "nodeDesc", "nodeType",
					"nodeState" };
			ExportUtils m = new ExportUtils();
			m.setAutoSizeColumn(true);
			m.exportExcel(getI18nText("i18n_NodeManageAction.downloadExample.nodeTable_n81i"), st, title, colu,"downloadExample");
			return null;

		} catch (Exception e) {
			e.printStackTrace();
			return "error";
		}

	}

	// 导入
	public String importXls() {
		String errorInfo = "";
		try {
			NodegroupTable group = null;
			if (nodeGroupId != null && !nodeGroupId.equals("")) {
				group = (NodegroupTable) this.commonService.get(
						NodegroupTable.class, nodeGroupId);
			}
			List<NodeTableVo> list = new ArrayList<NodeTableVo>();
			
			Workbook workbook = null;
			if(myFileFileName.endsWith(".xlsx")){
				workbook = new XSSFWorkbook(new FileInputStream(myFile));
			}else{
				// 创建对Excel工作簿文件的引用
				/*POIFSFileSystem fs = new POIFSFileSystem(
						new FileInputStream(myFile));*/
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
				NodeTableVo nodeVo = new NodeTableVo();
				Row row = sheet.getRow(i);
				// "节点IP","节点名称","节点描述","节点类型（0 计算机）","节点状态（0 正常、1 已删除或停用）"
				Cell cell_1 = row.getCell((short) 0);
				Cell cell_2 = row.getCell((short) 1);
				Cell cell_3 = row.getCell((short) 2);
				Cell cell_4 = row.getCell((short) 3);
				Cell cell_5 = row.getCell((short) 4);
				if ((null == cell_1 || 3 == cell_1.getCellType())
						&& (null == cell_2 || 3 == cell_2.getCellType())
						&& (null == cell_3 || 3 == cell_3.getCellType())
						&& (null == cell_4 || 3 == cell_4.getCellType())
						&& (null == cell_5 || 3 == cell_5.getCellType())) {
					sum--;
				} else {
					if (null == cell_1) {
						errorInfo += getI18nText("i18n_NodeManageAction.downloadExample.line_n81i",i+"")+getI18nText("i18n_NodeManageAction.downloadExample.errorInfo1_n81i","1");
					} else if (cell_1.getCellType() == Cell.CELL_TYPE_STRING) {
						String nodeIp = cell_1.getStringCellValue().trim();
						nodeVo.setNodeIp(nodeIp);

						Pattern patt = Pattern
								.compile("\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}");
						Matcher mat = patt.matcher(nodeIp);
						if (!mat.matches()) {
							errorInfo +=  getI18nText("i18n_NodeManageAction.downloadExample.errorInfo2_n81i",i+"");
						}
					}
					if (null == cell_2) {
						errorInfo +=  getI18nText("i18n_NodeManageAction.downloadExample.line_n81i",i+"")+getI18nText("i18n_NodeManageAction.downloadExample.errorInfo1_n81i","2");
					} else if (cell_2.getCellType() == Cell.CELL_TYPE_STRING) {
						String nodeName = cell_2.getStringCellValue().trim();
						nodeVo.setNodeName(nodeName);

						if (nodeName.equals("")) {
							errorInfo +=  getI18nText("i18n_NodeManageAction.downloadExample.line_n81i",i+"")+getI18nText("i18n_NodeManageAction.downloadExample.errorInfo1_n81i","2");
						}
					}
					if (null != cell_3
							&& cell_3.getCellType() == Cell.CELL_TYPE_STRING) {
						String nodeDesc = cell_3.getStringCellValue().trim();
						nodeVo.setNodeDesc(nodeDesc);
					}

					if (null == cell_4) {
						errorInfo +=  getI18nText("i18n_NodeManageAction.downloadExample.line_n81i",i+"")+getI18nText("i18n_NodeManageAction.downloadExample.errorInfo1_n81i","4");
					} else {
						if (cell_4.getCellType() == Cell.CELL_TYPE_NUMERIC) {
							int nodeType = (int) cell_4.getNumericCellValue();
							nodeVo.setNodeType(nodeType + "");
							if ((nodeType + "").equals("")) {
								errorInfo +=  getI18nText("i18n_NodeManageAction.downloadExample.errorInfo3_n81i",i+"");
							}
						} else if (cell_4.getCellType() == Cell.CELL_TYPE_STRING) {// ^[0-9]*$
							String nodeType = cell_4.getStringCellValue()
									.trim();
							nodeVo.setNodeType(nodeType + "");

							Pattern patt = Pattern.compile("^[0-9]*$");
							Matcher mat = patt.matcher(nodeType);
							if (!mat.matches()) {
								errorInfo +=  getI18nText("i18n_NodeManageAction.downloadExample.errorInfo4_n81i",i+"");
							}
							if (!nodeType.equals("0")) {// 目前为止只有一种类型
								errorInfo +=  getI18nText("i18n_NodeManageAction.downloadExample.errorInfo3_n81i",i+"");
							}
						}
					}

					if (null == cell_5) {
						errorInfo +=  getI18nText("i18n_NodeManageAction.downloadExample.line_n81i",i+"")+getI18nText("i18n_NodeManageAction.downloadExample.errorInfo1_n81i","5");
					} else {
						if (cell_5.getCellType() == Cell.CELL_TYPE_NUMERIC) {
							int nodeState = (int) cell_5.getNumericCellValue();
							nodeVo.setNodeState(nodeState + "");
							if (nodeState != 0 && nodeState != 1) {
								errorInfo +=  getI18nText("i18n_NodeManageAction.downloadExample.errorInfo5_n81i",i+"");
							}
						} else if (cell_5.getCellType() == Cell.CELL_TYPE_STRING) {// ^[0-9]*$
							String nodeState = cell_5.getStringCellValue()
									.trim();
							nodeVo.setNodeState(nodeState + "");
							if (!nodeState.equals("0")
									&& !nodeState.equals("1")) {
								errorInfo +=  getI18nText("i18n_NodeManageAction.downloadExample.errorInfo5_n81i",i+"");
							}
						}
					}

					if ("".equals(errorInfo)) {
						errorInfo = this.saveNode(nodeVo, group);
					}
					if ("".equals(errorInfo)){
						count++;
					} else {
						nodeVo.setShowError(errorInfo);
						errorInfo = "";
						list.add(nodeVo);

					}
				}
			}

			this.getRequest().setAttribute("errorList", list);
			if (count == sum && sum>0) {
				this.getRequest().setAttribute("MSG", 1);
				return this.queryNodeInfo();
			}else if(sum == 0){
				this.outHtmlString("<script>alert('i18n_NodeManageAction.downloadExample.selectFileIsNull_n81i');history.back();</script>");
				return null;
			}

		} catch (Exception e) {
			e.printStackTrace();
			return "error";
		}

		return "showError";

	}

	private String saveNode(NodeTableVo vo, NodegroupTable group) {
		String desc = "";
		try {
			commonService.beginTransaction();
			if (group != null) {
				// IP在同一节点组下不重复
				if (!groupNodeIpIsRepeat(vo.getNodeIp(), group
						.getGroupId())) {
					// 保存节点信息
					NodeTable nodeT = new NodeTable();
					nodeT.setNodeIp(vo.getNodeIp());
					nodeT.setNodeName(vo.getNodeName());
					nodeT.setNodeDesc(vo.getNodeDesc());
					nodeT.setNodeType(new Long(vo.getNodeType()));
					nodeT.setNodeState(new Long(vo.getNodeState()));
					nodeT.setSystemId(group.getSystemId());
					nodeT.setCreateUserId(this.getUserID());
					nodeT.setNodeCreatetime(new Date());
					nodeT.setSeqId(this.getNodeSeqID(nodeT.getNodeIp()));
					nodeT.setNodeSystemType(this.getNodeSystemType(nodeT.getSeqId()));
					nodeT.setGroupId(group.getGroupId());
					// nodeT.setNodeUType(nodeUType);
					this.commonService.save(nodeT);
					// 将添加操作写到操作日志中
					this.addDBOperationRpt(commonService, "node_table",
							"INSERT", nodeT.getNodeId());
				} else {
					desc = getI18nText("nageAction.downloadExample.nodegroupHadIp_n81i");
				}
			}else {
				desc = getI18nText("i18n_NodeManageAction.downloadExample.nodeGroupIsNull_n81i");
			}
			commonService.commit();
		} catch (Exception e) {
			commonService.rollback();
			e.printStackTrace();
			desc =getI18nText("i18n_NodeManageAction.downloadExample.nodeInfoImportErr_n81i");
		}
		return desc;
	}

	public NodeManageAction() {
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

	public List<NodeTable> getNodeList() {
		return nodeList;
	}

	public void setNodeList(List<NodeTable> nodeList) {
		this.nodeList = nodeList;
	}

	public NodeTable getNodeTable() {
		return nodeTable;
	}

	public void setNodeTable(NodeTable nodeTable) {
		this.nodeTable = nodeTable;
	}

	public Long getNodeId() {
		return nodeId;
	}

	public void setNodeId(Long nodeId) {
		this.nodeId = nodeId;
	}

	public String getNodeNameVo() {
		return nodeNameVo;
	}

	public void setNodeNameVo(String nodeNameVo) {
		this.nodeNameVo = nodeNameVo;
	}

	public String getNodeDescVo() {
		return nodeDescVo;
	}

	public void setNodeDescVo(String nodeDescVo) {
		this.nodeDescVo = nodeDescVo;
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

	public Long getNodeGroupId() {
		return nodeGroupId;
	}

	public void setNodeGroupId(Long nodeGroupId) {
		this.nodeGroupId = nodeGroupId;
	}

	public File getMyFile() {
		return myFile;
	}

	public void setMyFile(File myFile) {
		this.myFile = myFile;
	}

	public String getOldNodeIp() {
		return oldNodeIp;
	}

	public void setOldNodeIp(String oldNodeIp) {
		this.oldNodeIp = oldNodeIp;
	}

	public String getIsNone() {
		return isNone;
	}

	public void setIsNone(String isNone) {
		this.isNone = isNone;
	}

	public String getMyFileFileName() {
		return myFileFileName;
	}

	public void setMyFileFileName(String myFileFileName) {
		this.myFileFileName = myFileFileName;
	}

}
