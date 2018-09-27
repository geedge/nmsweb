package nis.nms.domains;


/**
 * NodePosition entity.
 * 
 * @author MyEclipse Persistence Tools
 */

public class NodeInBoxModule implements java.io.Serializable {

	// Fields Module

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private Long nodeId;		//节点ID
	private String tableName;	//实体节点表表名
	private String nodeType;	//实体节点类型
	private String nodeName;	//节点名称
	private String nodeDesc;	//节点描述
	private String imageUrl;	//展示图片URL
	private String latticePosition;//节点在机柜位置
	private Long boxId;
	private String boxDescription;//机柜描述
	private String ispn;		  //机柜编号
	private Long seqId;
	private String nodeIp;
	private String isDragg;  //是否可以被拖拽
	
	private Long nodeTypeName;
	private Long nodeUType;
	
	/** default constructor */
	public NodeInBoxModule() {
		
	}

	public NodeInBoxModule(Long nodeId,String tableName,String nodeType,String nodeName,String nodeDesc,String imageUrl,
			String latticePosition,Long boxId,String boxDescription,String nodeIp,String ispn,String isDragg,Long nodeTypeName,
			Long nodeUType,Long seqId) {
		this.nodeId = nodeId;
		this.tableName = tableName;
		this.nodeType = nodeType;
		this.nodeName = nodeName;
		this.nodeDesc = nodeDesc;
		this.imageUrl = imageUrl;
		this.latticePosition = latticePosition;
		this.boxId = boxId;
		this.boxDescription = boxDescription;
		this.nodeIp = nodeIp;
		this.ispn = ispn;
		this.isDragg = isDragg;
		this.nodeTypeName = nodeTypeName;
		this.nodeUType =nodeUType;
		this.seqId = seqId;
	}
	
	
	
	/** full constructor */
	public NodeInBoxModule(Long nodeId,String tableName,String nodeType,String nodeName,String nodeDesc,String imageUrl,
			String latticePosition,Long boxId,String boxDescription,String nodeIp,String ispn,String isDragg) {
		this.nodeId = nodeId;
		this.tableName = tableName;
		this.nodeType = nodeType;
		this.nodeName = nodeName;
		this.nodeDesc = nodeDesc;
		this.imageUrl = imageUrl;
		this.latticePosition = latticePosition;
		this.boxId = boxId;
		this.boxDescription = boxDescription;
		this.nodeIp = nodeIp;
		this.ispn = ispn;
		this.isDragg = isDragg;
	}
	/** full constructor */
	public NodeInBoxModule(Long nodeId,String tableName,String nodeType,String nodeName,String nodeDesc,String imageUrl,
			String latticePosition,Long boxId,String boxDescription,Long seqId,String nodeIp,Long nodeUType) {
		this.nodeId = nodeId;
		this.tableName = tableName;
		this.nodeType = nodeType;
		this.nodeName = nodeName;
		this.nodeDesc = nodeDesc;
		this.imageUrl = imageUrl;
		this.latticePosition = latticePosition;
		this.boxId = boxId;
		this.boxDescription = boxDescription;
		this.seqId = seqId;
		this.nodeIp = nodeIp;
		this.nodeUType = nodeUType;
	}

	public Long getNodeId() {
		return nodeId;
	}

	public void setNodeId(Long nodeId) {
		this.nodeId = nodeId;
	}

	public String getNodeName() {
		return nodeName;
	}

	public void setNodeName(String nodeName) {
		this.nodeName = nodeName;
	}

	public String getNodeDesc() {
		return nodeDesc;
	}

	public void setNodeDesc(String nodeDesc) {
		this.nodeDesc = nodeDesc;
	}

	public String getLatticePosition() {
		return latticePosition;
	}

	public void setLatticePosition(String latticePosition) {
		this.latticePosition = latticePosition;
	}

	public String getBoxDescription() {
		return boxDescription;
	}

	public void setBoxDescription(String boxDescription) {
		this.boxDescription = boxDescription;
	}

	public Long getBoxId() {
		return boxId;
	}

	public void setBoxId(Long boxId) {
		this.boxId = boxId;
	}

	public String getTableName() {
		return tableName;
	}

	public void setTableName(String tableName) {
		this.tableName = tableName;
	}

	public String getNodeType() {
		return nodeType;
	}

	public void setNodeType(String nodeType) {
		this.nodeType = nodeType;
	}

	public String getImageUrl() {
		return imageUrl;
	}

	public void setImageUrl(String imageUrl) {
		this.imageUrl = imageUrl;
	}

	public Long getSeqId() {
		return seqId;
	}

	public void setSeqId(Long seqId) {
		this.seqId = seqId;
	}

	public String getNodeIp() {
		return nodeIp;
	}

	public void setNodeIp(String nodeIp) {
		this.nodeIp = nodeIp;
	}

	public String getIsDragg() {
		return isDragg;
	}

	public void setIsDragg(String isDragg) {
		this.isDragg = isDragg;
	}

	public String getIspn() {
		return ispn;
	}

	public void setIspn(String ispn) {
		this.ispn = ispn;
	}

	public Long getNodeTypeName() {
		return nodeTypeName;
	}

	public void setNodeTypeName(Long nodeTypeName) {
		this.nodeTypeName = nodeTypeName;
	}

	public Long getNodeUType() {
		return nodeUType;
	}

	public void setNodeUType(Long nodeUType) {
		this.nodeUType = nodeUType;
	}
	
}