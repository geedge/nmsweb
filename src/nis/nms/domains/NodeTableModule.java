package nis.nms.domains;


/**
 * NodeTable entity.
 * 
 * @author MyEclipse Persistence Tools
 */

public class NodeTableModule implements java.io.Serializable {

	// Fields

	private static final long serialVersionUID = 1984053252904108229L;
	private Long nodeId;
	private String nodeIp;
	private String nodeName;
	private Long seqId;
	
	private Long nodeType;
	private Long nodeState;
	private Long systemId;
	private Long nodeLatticeId;
	private Long groupId;
	private Long nodeUType;
	
	private String tableName;	//实体节点表表名
	private String nodeTypeName;//实体节点名
	private String imageUrl;
	
	/** default constructor */
	public NodeTableModule() {
	}

	public NodeTableModule(Long nodeId, String nodeIp, String nodeName,
			Long seqId) {
		this.nodeId = nodeId;
		this.nodeIp = nodeIp;
		this.nodeName = nodeName;
		this.seqId = seqId;
	}	
	
	public NodeTableModule(Long nodeId, String tableName,String nodeTypeName,String nodeIp, String nodeName,
			Long nodeType,Long nodeState,Long seqId,Long systemId,
			Long groupId,Long nodeLatticeId,Long nodeUType,String imageUrl) {
		this.nodeId = nodeId;
		this.tableName = tableName;
		this.nodeTypeName = nodeTypeName;
		this.nodeIp = nodeIp;
		this.nodeName = nodeName;
		this.nodeType = nodeType;
		this.nodeState = nodeState;
		this.seqId = seqId;
		this.systemId = systemId;
		this.groupId = groupId;
		this.nodeLatticeId = nodeLatticeId;
		this.nodeUType = nodeUType;
		this.imageUrl = imageUrl;
	}	
	

	public String getNodeIp() {
		return nodeIp;
	}

	public void setNodeIp(String nodeIp) {
		this.nodeIp = nodeIp;
	}


	public String getNodeName() {
		return nodeName;
	}

	public void setNodeName(String nodeName) {
		this.nodeName = nodeName;
	}

	public Long getSeqId() {
		return seqId;
	}

	public void setSeqId(Long seqId) {
		this.seqId = seqId;
	}

	public Long getNodeId() {
		return nodeId;
	}

	public void setNodeId(Long nodeId) {
		this.nodeId = nodeId;
	}

	public Long getNodeType() {
		return nodeType;
	}

	public void setNodeType(Long nodeType) {
		this.nodeType = nodeType;
	}

	public Long getNodeState() {
		return nodeState;
	}

	public void setNodeState(Long nodeState) {
		this.nodeState = nodeState;
	}

	public Long getSystemId() {
		return systemId;
	}

	public void setSystemId(Long systemId) {
		this.systemId = systemId;
	}

	public Long getNodeLatticeId() {
		return nodeLatticeId;
	}

	public void setNodeLatticeId(Long nodeLatticeId) {
		this.nodeLatticeId = nodeLatticeId;
	}

	public Long getGroupId() {
		return groupId;
	}

	public void setGroupId(Long groupId) {
		this.groupId = groupId;
	}

	public Long getNodeUType() {
		return nodeUType;
	}

	public void setNodeUType(Long nodeUType) {
		this.nodeUType = nodeUType;
	}

	public String getTableName() {
		return tableName;
	}

	public void setTableName(String tableName) {
		this.tableName = tableName;
	}

	public String getNodeTypeName() {
		return nodeTypeName;
	}

	public void setNodeTypeName(String nodeTypeName) {
		this.nodeTypeName = nodeTypeName;
	}

	public String getImageUrl() {
		return imageUrl;
	}

	public void setImageUrl(String imageUrl) {
		this.imageUrl = imageUrl;
	}

}