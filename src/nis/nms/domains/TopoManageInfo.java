package nis.nms.domains;

import java.io.Serializable;
/**
 * 配置topo图节点以及topo图与业务相关内容实体
 * @author Administrator
 *
 */
public class TopoManageInfo implements Serializable{
	private TopoNodeInfo topoNodeInfo;
	private String nodeGroupName;
	private Long nodeGroupId;
	private String nodeName;
	private Long nodeId;
	private Long topoInfoId;
	private Long nodeType;  // 对应 topoNodeInfo中的type 单独提出来 方便使用
	private Long nodeTypeId;  // 对应 topoNodeInfo中的typeId 单独提出来 方便使用
	public TopoNodeInfo getTopoNodeInfo() {
		return topoNodeInfo;
	}
	public void setTopoNodeInfo(TopoNodeInfo topoNodeInfo) {
		this.topoNodeInfo = topoNodeInfo;
	}
	public String getNodeGroupName() {
		return nodeGroupName;
	}
	public void setNodeGroupName(String nodeGroupName) {
		this.nodeGroupName = nodeGroupName;
	}
	public Long getNodeGroupId() {
		return nodeGroupId;
	}
	public void setNodeGroupId(Long nodeGroupId) {
		this.nodeGroupId = nodeGroupId;
	}
	public String getNodeName() {
		return nodeName;
	}
	public void setNodeName(String nodeName) {
		this.nodeName = nodeName;
	}
	public Long getNodeId() {
		return nodeId;
	}
	public void setNodeId(Long nodeId) {
		this.nodeId = nodeId;
	}
	public void setTopoInfoId(Long topoInfoId) {
		this.topoInfoId = topoInfoId;
	}
	public Long getTopoInfoId() {
		return topoInfoId;
	}
	public Long getNodeTypeId() {
		return nodeTypeId;
	}
	public void setNodeTypeId(Long nodeTypeId) {
		this.nodeTypeId = nodeTypeId;
	}
	public Long getNodeType() {
		return nodeType;
	}
	public void setNodeType(Long nodeType) {
		this.nodeType = nodeType;
	}
}
