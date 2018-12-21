package nis.nms.web.actions.sysManage;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.Enumeration;
import java.util.HashMap;
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
import nis.nms.domains.TopoImg;
import nis.nms.domains.TopoInfo;
import nis.nms.domains.TopoLineInfo;
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
	private List<TopoLineInfo> topoLineList;
	private List<TopoImg> topoImgList;
	private List<Integer> typeList;
	private NodegroupTable nodegroupTable;
	private NodeTable nodeTable;
	private Long systemId;
	private Long topoInfoId;
	private Long topoNodeId;
	private Long topoNodeType;
	private Long topoLineId;
	private String groupIdShow;   //节点组名称
	private Long selectTopoInfoId; //节点类型为topo时  选择的topoId
	private DetectionSetInfo detectionSetInfo;
	private TopoNodeInfo topoNodeInfo;
	private TopoLineInfo topoLineInfo;
	private TopoManageInfo topoManageInfo;
	private List<TopoManageInfo> topoManageInfos;
	private Integer diffTopoFlag; //不同topo图标记 如果为0代表当前topo不是该业务系统的
	@Override
	public String executeAction() throws Exception {
		String result=null;
		try {
			if(action.equals("query")) {
				result=queryTopoManageIndex();
			}else if(action.equals("removeTopoNode")){
				removeTopoNode();
			}else if(action.equals("removeTopoLine")) {
				removeTopoLine();
			}else if(action.equals("addTopoNode")) {
				addTopoNode();
			}else if(action.equals("addTopoLine")) {
				addTopoLine();
			}else if(action.equals("modifyTopoLine")) {
				modifyTopoLine();
			}else if(action.equals("modifyTopoNode")) {
				modifyTopoNode();
			}else if(action.equals("coverTopoManage")) {
				coverTopoManage();
			}else if(action.equals("copyTopoManage")) {
				copyTopoManage();
			}
		} catch (Exception e) {
			e.printStackTrace();
			return "error";
		}
		return result;
	}
	
	/*public String queryTopoManageIndex(){
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
	}*/
	
	public String queryTopoManageIndex(){
		try {
			//查询所有业务系统列表
			sysList = this.commonService.find("from SystemTable where 1=1");
			
			//查询所有topo图列表
			allTopoInfoList=this.commonService.find("from TopoInfo where 1=1");
			
			//节点设置的几个状态属性
			//1.节点 2.节点组 3.无任何操作 4.topo图  
			typeList=new ArrayList<Integer>(){{add(1);add(2);add(4);add(3);}};
			
			//查询所有topo图片信息 展示在左侧拖拽栏
			topoImgList=this.commonService.find("from TopoImg where 1=1");
			
			//查询当前业务系统topo图列表
			if(systemId==null){
				systemId=sysList.get(0).getSystemId();
			}
			topoInfoList=this.commonService.find("from TopoInfo where 1=1 and systemId=?",systemId);			
			
			if(null != topoInfoList && topoInfoList.size()>0) {
				if(topoInfoId==null){
					topoInfoId=topoInfoList.get(0).getId();
				}else if(!topoInfoId.equals(topoInfoList.get(0).getId())){
					diffTopoFlag=0;
				}
			}else if(topoInfoId!=null) {
				diffTopoFlag=0;
			}
			if(topoInfoId!=null) {
				//查询当前业务下所有的topo节点
				topoNodeList=this.commonService.find("from TopoNodeInfo where 1=1 and topoInfo.id=?", topoInfoId);
				if(null!=topoNodeList&&topoNodeList.size()>0) {
					topoManageInfos=new ArrayList<TopoManageInfo>();
					for(TopoNodeInfo topoNodeInfo:topoNodeList) {
						topoManageInfo=new TopoManageInfo();
						topoManageInfo.setTopoNodeInfo(topoNodeInfo);
						if(topoNodeInfo.getType()==2L){
							List nodeTables = this.commonService.find("from NodeTable where 1=1 and node_id=?",topoNodeInfo.getTypeId());
							nodeTable = (NodeTable)nodeTables.get(0);
							List find = this.commonService.find("from NodegroupTable where 1=1 and id=?",nodeTable.getGroupId());
							nodegroupTable = (NodegroupTable) find.get(0);
							topoManageInfo.setNodeGroupName(nodegroupTable.getGroupName());
							topoManageInfo.setNodeGroupId(nodeTable.getGroupId());
							topoManageInfo.setNodeId(nodeTable.getNodeId());
							topoManageInfo.setNodeName(nodeTable.getNodeIp());
						}else if(topoNodeInfo.getType()==1L){
							List find = this.commonService.find("from NodegroupTable where 1=1 and id=?",topoNodeInfo.getTypeId());
							nodegroupTable = (NodegroupTable) find.get(0);
							topoManageInfo.setNodeGroupName(nodegroupTable.getGroupName());
							topoManageInfo.setNodeGroupId(nodegroupTable.getGroupId());
						}else if(topoNodeInfo.getType()==4L){
							topoManageInfo.setTopoInfoId(topoNodeInfo.getTypeId());
						}
						topoManageInfos.add(topoManageInfo);
					}
				}
				//查询当前业务下所有的topo连线
				topoLineList=this.commonService.find("from TopoLineInfo where 1=1 and topoInfo.id=?", topoInfoId);
			}
		} catch (Exception e) {
			logger.error(e.getStackTrace());
			e.printStackTrace();
			return null;
		}
		return "topoManageIndex";
	}
	
	// topo图拷贝
	public void copyTopoManage() {
		try {
			String topoName = this.getRequest().getParameter("newTopoName");
			TopoInfo newTopo=null;
			List<TopoInfo> topoInfos = this.commonService.find("from TopoInfo where 1=1 and systemId=?", systemId);
			if(null!=topoInfos&&topoInfos.size()>0) {
				newTopo=(TopoInfo) topoInfos.get(0);
				newTopo.setName(topoName);
				this.commonService.update(newTopo);
				//如果原业务系统有内容则清空
				this.commonService.delete("delete from TopoNodeInfo where topoInfo.id="+newTopo.getId());
				this.commonService.delete("delete from TopoLineInfo where topoInfo.id="+newTopo.getId());
			}else {
				newTopo=new TopoInfo();
				newTopo.setFlag(1L);
				newTopo.setName(topoName);
				newTopo.setWidth(800L);
				newTopo.setHeight(800L);
				newTopo.setSystemId(systemId);
				newTopo.setTopoInfoClass("");
				newTopo.setCreateTime(new Date());
				newTopo.setCreateUser(getUser().getYhid());
				newTopo.setUpdateTime(new Date());
				newTopo.setUpdateUser(getUser().getYhid());
				this.commonService.save(newTopo);
			}
			//存放拷贝前node的id和拷贝后新生成的nodeId
			Map<Long,TopoNodeInfo> nodePara=new HashMap<Long,TopoNodeInfo>();
			List<TopoLineInfo> topoLineInfos = this.commonService.find("from TopoLineInfo where 1=1 and topoInfo.id=?", topoInfoId);
			List<TopoNodeInfo> topoNodeInfos = this.commonService.find("from TopoNodeInfo where 1=1 and topoInfo.id=?", topoInfoId);
			if(null!=topoNodeInfos&&topoNodeInfos.size()>0) {
				for (int i=0;i<topoNodeInfos.size();i++) {
					TopoNodeInfo topoNodeInfo2 = topoNodeInfos.get(i);
					TopoNodeInfo newTopoNode = new TopoNodeInfo();
					newTopoNode.setTopoInfo(newTopo);
					newTopoNode.setType(3L);
					newTopoNode.setHeight(topoNodeInfo2.getHeight());
					newTopoNode.setWidth(topoNodeInfo2.getWidth());
					newTopoNode.setText(topoNodeInfo2.getText());
					newTopoNode.setThresholdValue(80.0);
					newTopoNode.setTopoImg(topoNodeInfo2.getTopoImg());
					newTopoNode.setTopoNodeInfoClass(topoNodeInfo2.getTopoNodeInfoClass());
					newTopoNode.setX(topoNodeInfo2.getX());
					newTopoNode.setY(topoNodeInfo2.getY());
					newTopoNode.setCreateTime(new Date());
					newTopoNode.setCreateUser(getUser().getYhid());
					newTopoNode.setUpdateTime(new Date());
					newTopoNode.setUpdateUser(getUser().getYhid());
					this.commonService.save(newTopoNode);
					nodePara.put(topoNodeInfo2.getId(),newTopoNode);
				}
			}
			
			if(null!=topoLineInfos&&topoLineInfos.size()>0) {
				for (TopoLineInfo topoLineInfo : topoLineInfos) {
					TopoLineInfo newTopoLine=new TopoLineInfo();
					newTopoLine.setTopoInfo(newTopo);
					newTopoLine.setFlag(1L);
					newTopoLine.setCreateTime(new Date());
					newTopoLine.setCreateUser(getUser().getYhid());
					newTopoLine.setFlag(1L);
					/*TopoNodeInfo topoNodeInfo1 = new TopoNodeInfo();
					TopoNodeInfo topoNodeInfo2 = new TopoNodeInfo();
					Long long1 = nodePara.get(topoNodeInfo1.getId());
					Long long2 = nodePara.get(topoNodeInfo2.getId());
					topoNodeInfo1.setId(long1);
					topoNodeInfo2.setId(long2);*/
					Long id = topoLineInfo.getTopoNodeInfo1().getId();
					Long id2 = topoLineInfo.getTopoNodeInfo2().getId();
					TopoNodeInfo topoNodeInfo1 = nodePara.get(id);
					TopoNodeInfo topoNodeInfo2 = nodePara.get(id2);
					newTopoLine.setTopoNodeInfo1(topoNodeInfo1);
					newTopoLine.setTopoNodeInfo2(topoNodeInfo2);
					newTopoLine.setUpdateTime(new Date());
					newTopoLine.setUpdateUser(getUser().getYhid());
					newTopoLine.setTopoLineInfoClass(topoLineInfo.getTopoLineInfoClass());
					this.commonService.save(newTopoLine);
				}
			}
		} catch (Exception e) {
			commonService.rollback();
			try {
				this.getResponse().sendError(500);
			} catch (IOException e1) {
				e1.printStackTrace();
			}
			e.printStackTrace();
		}
	}
	
	// topo图覆盖
	public void coverTopoManage() {
		try {
			List<TopoInfo> find = this.commonService.find("from TopoInfo where 1=1 and id=?", topoInfoId);
			if(null!=find&&find.size()>0) {
				TopoInfo topoInfo = find.get(0);
				topoInfo.setSystemId(systemId);
				//将当前业务系统的topo图设置为空 确保一个业务系统只有一个topo图
				this.commonService.delete("delete from TopoInfo where systemId="+systemId);
				//将当前的topo图绑定给当前的业务系统
				this.commonService.update(topoInfo);
			}else {
				throw new RuntimeException("覆盖失败");
			}
		} catch (Exception e) {
			commonService.rollback();
			try {
				this.getResponse().sendError(500);
			} catch (IOException e1) {
				e1.printStackTrace();
			}
			e.printStackTrace();
		}
	}
	/*public void modifyTopoManage(){
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
	}*/
	
	public void removeTopoNode() {
		// 根据节点ID删除节点 同时删除与之想关联的连线信息
		try {
			this.commonService.delete("delete from TopoNodeInfo where id="+topoNodeId);
			this.commonService.delete("delete from TopoLineInfo where src="+topoNodeId+" or dest="+topoNodeId);
		} catch (Exception e) {
			commonService.rollback();
			try {
				this.getResponse().sendError(500);
			} catch (IOException e1) {
				e1.printStackTrace();
			}
			e.printStackTrace();
		}
	}
	
	public void removeTopoLine() {
		// 根据连线ID删除连线信息
		try {
			this.commonService.delete("delete from TopoLineInfo where id="+topoLineId);
		} catch (Exception e) {
			commonService.rollback();
			try {
				this.getResponse().sendError(500);
			} catch (IOException e1) {
				e1.printStackTrace();
			}
			e.printStackTrace();
		}
	}
	
	public void addTopoNode() {
		//添加拓扑图节点
		try {
			String parameter = this.getRequest().getParameter("topoNodeData");
			JSONObject fromObject = JSONObject.fromObject(parameter);
			TopoNodeInfo node = (TopoNodeInfo) JSONObject.toBean(fromObject, TopoNodeInfo.class);
			this.commonService.save(node);
			this.outAjaxString(node.getId().toString());
		} catch (Exception e) {
			commonService.rollback();
			try {
				this.getResponse().sendError(500);
			} catch (IOException e1) {
				e1.printStackTrace();
			}
			e.printStackTrace();
		}
	}
	
	public void addTopoLine() {
		//添加拓扑图连线
		try {
			String parameter = this.getRequest().getParameter("topoLineData");
			JSONObject fromObject = JSONObject.fromObject(parameter);
			TopoLineInfo line = (TopoLineInfo) JSONObject.toBean(fromObject, TopoLineInfo.class);
			this.commonService.save(line);
			this.outAjaxString(line.getId().toString());
		} catch (Exception e) {
			commonService.rollback();
			try {
				this.getResponse().sendError(500);
			} catch (IOException e1) {
				e1.printStackTrace();
			}
			e.printStackTrace();
		}
	}
	
	public void modifyTopoNode() {
		// 修改topo图节点信息
		try {
			String parameter = this.getRequest().getParameter("topoNodeData");
			JSONObject fromObject = JSONObject.fromObject(parameter);
			TopoNodeInfo node = (TopoNodeInfo) JSONObject.toBean(fromObject, TopoNodeInfo.class);
			node.setTopoNodeInfoClass("["+node.getTopoNodeInfoClass()+"]");
			this.commonService.update(node);
		} catch (Exception e) {
			commonService.rollback();
			try {
				this.getResponse().sendError(500);
			} catch (IOException e1) {
				e1.printStackTrace();
			}
			e.printStackTrace();
		}
	}
	
	public void modifyTopoLine() {
		//修改topo图连线信息
		try {
			String parameter = this.getRequest().getParameter("topoLineData");
			JSONObject fromObject = JSONObject.fromObject(parameter);
			TopoLineInfo line = (TopoLineInfo) JSONObject.toBean(fromObject, TopoLineInfo.class);
			this.commonService.update(line);
		} catch (Exception e) {
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

	public List<TopoLineInfo> getTopoLineList() {
		return topoLineList;
	}

	public void setTopoLineList(List<TopoLineInfo> topoLineList) {
		this.topoLineList = topoLineList;
	}

	public List<TopoImg> getTopoImgList() {
		return topoImgList;
	}

	public void setTopoImgList(List<TopoImg> topoImgList) {
		this.topoImgList = topoImgList;
	}

	public Long getTopoLineId() {
		return topoLineId;
	}

	public void setTopoLineId(Long topoLineId) {
		this.topoLineId = topoLineId;
	}

	public TopoLineInfo getTopoLineInfo() {
		return topoLineInfo;
	}

	public void setTopoLineInfo(TopoLineInfo topoLineInfo) {
		this.topoLineInfo = topoLineInfo;
	}

	public Integer getDiffTopoFlag() {
		return diffTopoFlag;
	}

	public void setDiffTopoFlag(Integer diffTopoFlag) {
		this.diffTopoFlag = diffTopoFlag;
	}
	
}
