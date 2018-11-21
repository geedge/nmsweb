package nis.nms.web.actions.sysManage;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Enumeration;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;
import org.apache.struts2.config.Result;
import org.apache.struts2.config.Results;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import nis.nms.core.Resource;
import nis.nms.domains.DetectionSetInfo;
import nis.nms.domains.NodeTable;
import nis.nms.domains.NodegroupTable;
import nis.nms.domains.SystemTable;
import nis.nms.domains.TopoInfo;
import nis.nms.domains.TopoManageInfo;
import nis.nms.domains.TopoNodeInfo;
import nis.nms.service.CommonService;
import nis.nms.util.BaseAction;

@SuppressWarnings("unchecked")
@Results( { 
	@Result(name="topoManageIndex", value = "/page/systemManage/topoManage/topoManageIndex.jsp"),
	@Result(name="error", value = "/error.jsp")
})
public class TopoManageAction extends BaseAction{
	private Logger logger=Logger.getLogger(this.getClass());
	private String action;
	private CommonService commonService;
	private List<TopoInfo> topoInfoList;
	private List<TopoInfo> allTopoInfoList;
	private List<SystemTable> sysList;
	private List<TopoNodeInfo> topoNodeList;
	private List<Integer> typeList;
	private NodegroupTable nodegroupTable;
	private NodeTable nodeTable;
	private Long systemId;
	private Long topoInfoId;
	private Long topoNodeId;
	private Long topoNodeType;
	private String groupIdShow;   //节点组名称
	private Long selectTopoInfoId; //节点类型为topo时  选择的topoId
	private DetectionSetInfo detectionSetInfo;
	private TopoNodeInfo topoNodeInfo;
	private TopoManageInfo topoManageInfo;
	private List<TopoManageInfo> topoManageInfos;
	@Override
	public String executeAction() throws Exception {
		String result=null;
		try {
			if(action.equals("query")) {
				result=queryTopoManageIndex();
			}else if(action.equals("modify")){
				modifyTopoManage();
			}
		} catch (Exception e) {
			e.printStackTrace();
			return "error";
		}
		return result;
	}
	
	public String queryTopoManageIndex(){
		try {
			//查询所有业务系统列表
			sysList = this.commonService.find("from SystemTable where 1=1");
			
			//查询所有topo图列表
			allTopoInfoList=this.commonService.find("from TopoInfo where 1=1");
			
			//节点设置的几个状态属性
			//1.节点 2.节点组 3.无任何操作 4.topo图  
			typeList=new ArrayList<Integer>(){{add(1);add(2);add(4);add(3);}};
			
			//查询当前业务系统topo图列表
			if(systemId==null){
				systemId=sysList.get(0).getSystemId();
			}
			topoInfoList=this.commonService.find("from TopoInfo where 1=1 and systemId=?",systemId);			
			
			//查询所有节点内容
			if(topoInfoList!=null&&topoInfoList.size()>0){
				//判断用户选择的拓扑图是否为当前系统的拓扑图
				boolean flag=true;
				if(topoInfoId==null){
					topoInfoId=topoInfoList.get(0).getId();
				}else{
					flag=topoInfoId.equals(topoInfoList.get(0).getId());
				}
				if(flag){
					topoNodeList=this.commonService.find("from TopoNodeInfo where 1=1 and topoInfo.id=?",topoInfoId);
					if(topoNodeList!=null&&topoNodeList.size()>0){
						topoManageInfos=new ArrayList<TopoManageInfo>();
						for (TopoNodeInfo topoInfo : topoNodeList) {
							topoManageInfo=new TopoManageInfo();
							topoManageInfo.setTopoNodeInfo(topoInfo);
							if(topoInfo.getType()==2L){
								List nodeTables = this.commonService.find("from NodeTable where 1=1 and id=?",topoInfo.getTypeId());
								nodeTable = (NodeTable)nodeTables.get(0);
								List find = this.commonService.find("from NodegroupTable where 1=1 and id=?",nodeTable.getGroupId());
								nodegroupTable = (NodegroupTable) find.get(0);
								topoManageInfo.setNodeGroupName(nodegroupTable.getGroupName());
								topoManageInfo.setNodeGroupId(nodeTable.getGroupId());
								topoManageInfo.setNodeId(nodeTable.getNodeId());
								topoManageInfo.setNodeName(nodeTable.getNodeIp());
							}else if(topoInfo.getType()==1L){
								List find = this.commonService.find("from NodegroupTable where 1=1 and id=?",topoInfo.getTypeId());
								nodegroupTable = (NodegroupTable) find.get(0);
								topoManageInfo.setNodeGroupName(nodegroupTable.getGroupName());
								topoManageInfo.setNodeGroupId(nodegroupTable.getGroupId());
							}else if(topoInfo.getType()==4L){
								topoManageInfo.setTopoInfoId(topoInfo.getTypeId());
							}
							topoManageInfos.add(topoManageInfo);
						}
					}
				}else{
					topoNodeList=this.commonService.find("from TopoNodeInfo where 1=1 and topoInfo.id=?",topoInfoId);
					if(topoNodeList!=null&&topoNodeList.size()>0){
						topoManageInfos=new ArrayList<TopoManageInfo>();
						for (TopoNodeInfo topoInfo : topoNodeList) {
							topoManageInfo=new TopoManageInfo();
							topoInfo.setType(3L);
							topoInfo.setTypeId(null);
							topoManageInfo.setTopoNodeInfo(topoInfo);
							topoManageInfos.add(topoManageInfo);
						}
					}
				}
			}else if(topoInfoId!=null){
				topoNodeList=this.commonService.find("from TopoNodeInfo where 1=1 and topoInfo.id=?",topoInfoId);
				if(topoNodeList!=null&&topoNodeList.size()>0){
					topoManageInfos=new ArrayList<TopoManageInfo>();
					for (TopoNodeInfo topoInfo : topoNodeList) {
						topoManageInfo=new TopoManageInfo();
						topoInfo.setType(3L);
						topoInfo.setTypeId(null);
						topoManageInfo.setTopoNodeInfo(topoInfo);
						topoManageInfos.add(topoManageInfo);
					}
				}
			}
		} catch (Exception e) {
			logger.error(e.getStackTrace());
			e.printStackTrace();
			return null;
		}
		return "topoManageIndex";
	}
	
	public void modifyTopoManage(){
		String parameter = this.getRequest().getParameter("datas");
		JSONArray fromObject = JSONArray.fromObject(parameter);
		List<TopoManageInfo> results = (List) JSONArray.toCollection(fromObject, TopoManageInfo.class);
		try {
			commonService.beginTransaction();
			TopoInfo topoInfo = (TopoInfo) this.commonService.get(TopoInfo.class, topoInfoId);
			if(!topoInfo.getSystemId().equals(systemId)){	
				//将之前的topotu指向业务系统设为null
				List<TopoInfo> find = this.commonService.find("from TopoInfo where 1=1 and systemId=?", systemId);
				if(find!=null&&find.size()>0){
					TopoInfo topoInfo2 = find.get(0);
					topoInfo2.setSystemId(null);
					this.commonService.update(topoInfo2);
				}
				//判断当前修改拓扑图是否为当前系统所有拓扑图 如果当前系统拓扑图发生改变 修改topoInfo中指向新业务系统
				topoInfo.setSystemId(systemId);
				this.commonService.update(topoInfo);
			}
			for (TopoManageInfo data : results) {
				List find = this.commonService.find("from TopoNodeInfo where id=?", data.getNodeId());
				TopoNodeInfo topoNodeInfo = (TopoNodeInfo) find.get(0);
				topoNodeInfo.setType(data.getNodeType());
				topoNodeInfo.setTypeId(data.getNodeTypeId());
				this.commonService.update(topoNodeInfo);
			}
			commonService.commit();
		}catch (Exception e) {
			commonService.rollback();
			try {
				this.getResponse().sendError(500);
			} catch (IOException e1) {
				e1.printStackTrace();
			}
			e.printStackTrace();
		}
	}
	
	public String getAction() {
		return action;
	}
	public void setAction(String action) {
		this.action = action;
	}

	public CommonService getCommonService() {
		return commonService;
	}

	public void setCommonService(CommonService commonService) {
		this.commonService = commonService;
	}

	public List<TopoInfo> getTopoInfoList() {
		return topoInfoList;
	}

	public void setTopoInfoList(List<TopoInfo> topoInfoList) {
		this.topoInfoList = topoInfoList;
	}

	public List<SystemTable> getSysList() {
		return sysList;
	}

	public void setSysList(List<SystemTable> sysList) {
		this.sysList = sysList;
	}

	public List<TopoNodeInfo> getTopoNodeList() {
		return topoNodeList;
	}

	public void setTopoNodeList(List<TopoNodeInfo> topoNodeList) {
		this.topoNodeList = topoNodeList;
	}

	public List<Integer> getTypeList() {
		return typeList;
	}

	public void setTypeList(List<Integer> typeList) {
		this.typeList = typeList;
	}

	public NodegroupTable getNodegroupTable() {
		return nodegroupTable;
	}

	public void setNodegroupTable(NodegroupTable nodegroupTable) {
		this.nodegroupTable = nodegroupTable;
	}

	public NodeTable getNodeTable() {
		return nodeTable;
	}

	public void setNodeTable(NodeTable nodeTable) {
		this.nodeTable = nodeTable;
	}

	public Long getSystemId() {
		return systemId;
	}

	public void setSystemId(Long systemId) {
		this.systemId = systemId;
	}

	public Long getTopoInfoId() {
		return topoInfoId;
	}

	public void setTopoInfoId(Long topoInfoId) {
		this.topoInfoId = topoInfoId;
	}

	public Long getTopoNodeId() {
		return topoNodeId;
	}

	public void setTopoNodeId(Long topoNodeId) {
		this.topoNodeId = topoNodeId;
	}
	
	public Long getTopoNodeType() {
		return topoNodeType;
	}

	public void setTopoNodeType(Long topoNodeType) {
		this.topoNodeType = topoNodeType;
	}

	public String getGroupIdShow() {
		return groupIdShow;
	}

	public void setGroupIdShow(String groupIdShow) {
		this.groupIdShow = groupIdShow;
	}

	public DetectionSetInfo getDetectionSetInfo() {
		return detectionSetInfo;
	}

	public void setDetectionSetInfo(DetectionSetInfo detectionSetInfo) {
		this.detectionSetInfo = detectionSetInfo;
	}

	public List<TopoInfo> getAllTopoInfoList() {
		return allTopoInfoList;
	}

	public void setAllTopoInfoList(List<TopoInfo> allTopoInfoList) {
		this.allTopoInfoList = allTopoInfoList;
	}

	public Long getSelectTopoInfoId() {
		return selectTopoInfoId;
	}

	public void setSelectTopoInfoId(Long selectTopoInfoId) {
		this.selectTopoInfoId = selectTopoInfoId;
	}

	public TopoNodeInfo getTopoNodeInfo() {
		return topoNodeInfo;
	}

	public void setTopoNodeInfo(TopoNodeInfo topoNodeInfo) {
		this.topoNodeInfo = topoNodeInfo;
	}

	public TopoManageInfo getTopoManageInfo() {
		return topoManageInfo;
	}

	public void setTopoManageInfo(TopoManageInfo topoManageInfo) {
		this.topoManageInfo = topoManageInfo;
	}

	public List<TopoManageInfo> getTopoManageInfos() {
		return topoManageInfos;
	}

	public void setTopoManageInfos(List<TopoManageInfo> topoManageInfos) {
		this.topoManageInfos = topoManageInfos;
	}
}
