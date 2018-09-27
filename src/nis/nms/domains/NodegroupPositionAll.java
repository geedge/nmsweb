package nis.nms.domains;

import java.util.List;

/**
 * NodegroupArrowPosition entity.
 * 
 * @author MyEclipse Persistence Tools
 */

public class NodegroupPositionAll implements java.io.Serializable
{
	
	List<NodeGroupPosition> nodeGroupPositionList;
	List<NodegroupArrowPosition> nodegroupArrowPositionList;
	
	// 2018 7-17 新增
	List<TopoNodeInfo> topoNodeInfoList;
	List<TopoLineInfo> topoLineInfoList;
	
	public List<NodeGroupPosition> getNodeGroupPositionList()
	{
		return nodeGroupPositionList;
	}
	
	public void setNodeGroupPositionList(List<NodeGroupPosition> nodeGroupPositionList)
	{
		this.nodeGroupPositionList = nodeGroupPositionList;
	}
	
	public List<NodegroupArrowPosition> getNodegroupArrowPositionList()
	{
		return nodegroupArrowPositionList;
	}
	
	public void setNodegroupArrowPositionList(List<NodegroupArrowPosition> nodegroupArrowPositionList)
	{
		this.nodegroupArrowPositionList = nodegroupArrowPositionList;
	}

	public List<TopoNodeInfo> getTopoNodeInfoList() {
		return topoNodeInfoList;
	}

	public void setTopoNodeInfoList(List<TopoNodeInfo> topoNodeInfoList) {
		this.topoNodeInfoList = topoNodeInfoList;
	}

	public List<TopoLineInfo> getTopoLineInfoList() {
		return topoLineInfoList;
	}

	public void setTopoLineInfoList(List<TopoLineInfo> topoLineInfoList) {
		this.topoLineInfoList = topoLineInfoList;
	}
	
}