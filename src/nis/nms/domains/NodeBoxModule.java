package nis.nms.domains;

/**
 * NodeTable entity.
 * 
 * @author MyEclipse Persistence Tools
 */

public class NodeBoxModule implements java.io.Serializable {

	// Fields
	private static final long serialVersionUID = 1984053252904108229L;
	private Long id;
	private Long nodeId;
	private String tableName;	//实体节点表表名
	private String nodeType;	//实体节点类型
	private String nodeDesc;	//实体节点描述
	private Long positionX;	//机柜横坐标
	private Long positionY;	//机柜纵坐标
	private String imageUrl;//机柜图片	
	private Long monthMark;
	private Long viewType;
	private String linkSplit;//关联匹配式
	private String ispn;
	private Long parent_id;
	private String isWrining;
	
	public NodeBoxModule() {
	}

	public NodeBoxModule(Long id,Long nodeId,String tableName,String nodeType, String ispn,String nodeDesc,Long positionX,
			Long positionY,String imageUrl,Long monthMark,Long viewType,String linkSplit,Long parent_id) {
		this.id=id;
		this.nodeId = nodeId;
		this.tableName = tableName;
		this.nodeType = nodeType;
		this.ispn = ispn;
		this.nodeDesc = nodeDesc;
		this.positionX = positionX;
		this.positionY = positionY;
		this.imageUrl = imageUrl;
		this.monthMark = monthMark;
		this.viewType = viewType;
		this.linkSplit = linkSplit;
		this.parent_id = parent_id;
	}
	
	public NodeBoxModule(Long nodeId,String tableName,String nodeType, String ispn,String nodeDesc,Long positionX,
			Long positionY,String imageUrl,Long monthMark,Long viewType,String linkSplit) {
		
		this.nodeId = nodeId;
		this.tableName = tableName;
		this.nodeType = nodeType;
		this.ispn = ispn;
		this.nodeDesc = nodeDesc;
		this.positionX = positionX;
		this.positionY = positionY;
		this.imageUrl = imageUrl;
		this.monthMark = monthMark;
		this.viewType = viewType;
		this.linkSplit = linkSplit;
	}
	
	public NodeBoxModule(Long id,Long nodeId,String tableName,String nodeType, String ispn,String nodeDesc,Long positionX,
			Long positionY,String imageUrl,Long monthMark,Long viewType,String linkSplit,Long parent_id,String isWrining) {
		this.id=id;
		this.nodeId = nodeId;
		this.tableName = tableName;
		this.nodeType = nodeType;
		this.ispn = ispn;
		this.nodeDesc = nodeDesc;
		this.positionX = positionX;
		this.positionY = positionY;
		this.imageUrl = imageUrl;
		this.monthMark = monthMark;
		this.viewType = viewType;
		this.linkSplit = linkSplit;
		this.parent_id = parent_id;
		this.isWrining = isWrining;
	}
	
	
	
	public Long getNodeId() {
		return nodeId;
	}

	public void setNodeId(Long nodeId) {
		this.nodeId = nodeId;
	}

	public String getNodeDesc() {
		return nodeDesc;
	}

	public void setNodeDesc(String nodeDesc) {
		this.nodeDesc = nodeDesc;
	}

	public String getImageUrl() {
		return imageUrl;
	}

	public void setImageUrl(String imageUrl) {
		this.imageUrl = imageUrl;
	}

	public Long getPositionX() {
		return positionX;
	}

	public void setPositionX(Long positionX) {
		this.positionX = positionX;
	}

	public Long getPositionY() {
		return positionY;
	}

	public void setPositionY(Long positionY) {
		this.positionY = positionY;
	}

	public Long getViewType() {
		return viewType;
	}

	public void setViewType(Long viewType) {
		this.viewType = viewType;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public Long getMonthMark() {
		return monthMark;
	}

	public void setMonthMark(Long monthMark) {
		this.monthMark = monthMark;
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

	public String getLinkSplit() {
		return linkSplit;
	}

	public void setLinkSplit(String linkSplit) {
		this.linkSplit = linkSplit;
	}

	public String getIspn() {
		return ispn;
	}

	public void setIspn(String ispn) {
		this.ispn = ispn;
	}

	public Long getParent_id() {
		return parent_id;
	}

	public void setParent_id(Long parentId) {
		parent_id = parentId;
	}

	public String getIsWrining() {
		return isWrining;
	}

	public void setIsWrining(String isWrining) {
		this.isWrining = isWrining;
	}

}