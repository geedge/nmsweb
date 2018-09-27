package nis.nms.domains;


/**
 * NodePosition entity.
 * 
 * @author MyEclipse Persistence Tools
 */

public class NodePositionModule implements java.io.Serializable {

	// Fields Module

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private Long id;		//节点坐标ID
	private String tableName;	//实体节点表表名
	private String nodeType;	//实体节点类型
	private Long nodeId;		//实体节点ID
	private String nodeName;	//实体节点名称
	private String nodeDesc;	//实体节点描述
	private Long positionX;	//节点横坐标
	private Long positionY;	//节点纵坐标
	private String imageUrl;	//展示图片URL
	private Long parent_id;		//父级npId
	/*
	 * "tableName@$@needFlag@$@linkeSize,tableName@$@needFlag@$@linkeSize"
	 * 每组解析式逗号间隔“,”
	 * tableName	:  表名
	 * needFlag		: 需求标志 0>非必须 1>必须
	 * linkeSize	: 关联数量限制 0>无限制 1>关联数1
	 * 整个匹配式为空时无关联限制
	 * 匹配式的目的是存在通过，及需要写出该节点可关联的其他节点匹配式，可同类节点关联
	 * */	
	private String linkSplit;//关联匹配式
	
	/*2011-07-28 新增*/
	private Long monthMark;
	private Long viewType;
	
	private Long childNum;
	
	private NodeWaringModuleTree nwmt;
	private Long nodeNum;
	// Constructors

	/** default constructor */
	public NodePositionModule() {
		
	}
	
	/** full constructor */
	public NodePositionModule(Long id,Long nodeId,String nodeName,String nodeDesc,String tableName, String nodeType,
			Long positionX, Long positionY, String imageUrl, String linkSplit,Long monthMark,Long viewType,
			Long parent_id,Long childNum,NodeWaringModuleTree nwmt) {
		this.id = id;
		this.nodeId = nodeId;
		this.nodeName = nodeName;
		this.nodeDesc = nodeDesc;
		this.tableName = tableName;
		this.nodeType = nodeType;
		this.positionX = positionX;
		this.positionY = positionY;
		this.imageUrl = imageUrl;
		this.linkSplit = linkSplit;
		this.monthMark = monthMark;
		this.viewType = viewType;
		this.parent_id = parent_id;
		this.childNum = childNum;
		this.nwmt = nwmt;
	}
	
	/** full constructor */
	public NodePositionModule(Long id,Long nodeId,String nodeName,String nodeDesc,String tableName, String nodeType,
			Long positionX, Long positionY, String imageUrl, String linkSplit,Long monthMark,Long viewType,
			Long parent_id) {
		this.id = id;
		this.nodeId = nodeId;
		this.nodeName = nodeName;
		this.nodeDesc = nodeDesc;
		this.tableName = tableName;
		this.nodeType = nodeType;
		this.positionX = positionX;
		this.positionY = positionY;
		this.imageUrl = imageUrl;
		this.linkSplit = linkSplit;
		this.monthMark = monthMark;
		this.viewType = viewType;
		this.parent_id = parent_id;
	}
	
	/** full constructor */
	public NodePositionModule(Long id,String tableName, String nodeType, Long nodeId,String nodeName,String fatherId,String nodeDesc,
			Long positionX, Long positionY, String imageUrl, String linkSplit) {
		this.id = id;
		this.nodeName = nodeName;
		this.nodeDesc = nodeDesc;
		this.tableName = tableName;
		this.nodeType = nodeType;
		this.nodeId = nodeId;
		this.positionX = positionX;
		this.positionY = positionY;
		this.imageUrl = imageUrl;
		this.linkSplit = linkSplit;
	}
	
	public NodePositionModule(Long id,Long nodeId,String nodeName,String nodeDesc,String tableName, String nodeType,
			Long positionX, Long positionY, String imageUrl, String linkSplit,Long monthMark,Long viewType,
			Long parent_id,Long childNum,Long nodeNum) {
		this.id = id;
		this.nodeId = nodeId;
		this.nodeName = nodeName;
		this.nodeDesc = nodeDesc;
		this.tableName = tableName;
		this.nodeType = nodeType;
		this.positionX = positionX;
		this.positionY = positionY;
		this.imageUrl = imageUrl;
		this.linkSplit = linkSplit;
		this.monthMark = monthMark;
		this.viewType = viewType;
		this.parent_id = parent_id;
		this.childNum = childNum;
		this.nodeNum = nodeNum;
	}
	

	public String getTableName() {
		return this.tableName;
	}

	public void setTableName(String tableName) {
		this.tableName = tableName;
	}

	public String getNodeType() {
		return this.nodeType;
	}

	public void setNodeType(String nodeType) {
		this.nodeType = nodeType;
	}

	public Long getNodeId() {
		return this.nodeId;
	}

	public void setNodeId(Long nodeId) {
		this.nodeId = nodeId;
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

	public String getImageUrl() {
		return this.imageUrl;
	}

	public void setImageUrl(String imageUrl) {
		this.imageUrl = imageUrl;
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

	public String getLinkSplit() {
		return linkSplit;
	}

	public void setLinkSplit(String linkSplit) {
		this.linkSplit = linkSplit;
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

	public Long getViewType() {
		return viewType;
	}

	public void setViewType(Long viewType) {
		this.viewType = viewType;
	}

	public Long getParent_id() {
		return parent_id;
	}

	public void setParent_id(Long parentId) {
		parent_id = parentId;
	}

	public Long getChildNum() {
		return childNum;
	}

	public void setChildNum(Long childNum) {
		this.childNum = childNum;
	}

	public NodeWaringModuleTree getNwmt() {
		return nwmt;
	}

	public void setNwmt(NodeWaringModuleTree nwmt) {
		this.nwmt = nwmt;
	}

	public Long getNodeNum() {
		return nodeNum;
	}

	public void setNodeNum(Long nodeNum) {
		this.nodeNum = nodeNum;
	}
	
}