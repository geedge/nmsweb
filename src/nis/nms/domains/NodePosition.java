package nis.nms.domains;

import java.util.Date;

/**
 * NodePosition entity.
 * 
 * @author MyEclipse Persistence Tools
 */

public class NodePosition implements java.io.Serializable {

	// Fields

	private Long id;		//节点坐标ID
	private String tableName;	//实体节点表表名
	private String nodeType;	//实体节点类型
	private String nodeId;		//实体节点ID
	private Long positionX;	//节点横坐标
	private Long positionY;	//节点纵坐标
	private String imageUrl;	//展示图片URL
	private Date viewTimeMark;
	private Long viewType;
	private Long parent_id;

	// Constructors

	/** default constructor */
	public NodePosition() {
	}

	/** full constructor */
	public NodePosition(String tableName, String nodeType, String nodeId,
			Long positionX, Long positionY, String imageUrl, 
			Date viewTimeMark, Long viewType, Long parent_id) {
		this.tableName = tableName;
		this.nodeType = nodeType;
		this.nodeId = nodeId;
		this.positionX = positionX;
		this.positionY = positionY;
		this.imageUrl = imageUrl;
		this.viewTimeMark = viewTimeMark;
		this.viewType = viewType;
		this.parent_id = parent_id;
	}
	
	//for Box temp
	public NodePosition(String tableName, String nodeType, 
			Long positionX, Long positionY, String imageUrl, 
			 Long viewType) {
		this.tableName = tableName;
		this.nodeType = nodeType;
		this.positionX = positionX;
		this.positionY = positionY;
		this.imageUrl = imageUrl;
		this.viewType = viewType;
	}

	// Property accessors

	public Long getId() {
		return this.id;
	}

	public void setId(Long id) {
		this.id = id;
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

	public String getNodeId() {
		return this.nodeId;
	}

	public void setNodeId(String nodeId) {
		this.nodeId = nodeId;
	}

	public Long getPositionX() {
		return this.positionX;
	}

	public void setPositionX(Long positionX) {
		this.positionX = positionX;
	}

	public Long getPositionY() {
		return this.positionY;
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

	public Date getViewTimeMark() {
		return this.viewTimeMark;
	}

	public void setViewTimeMark(Date viewTimeMark) {
		this.viewTimeMark = viewTimeMark;
	}

	public Long getViewType() {
		return this.viewType;
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
}