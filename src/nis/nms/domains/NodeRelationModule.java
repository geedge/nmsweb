package nis.nms.domains;

/**
 * NodePosition entity.
 * 
 * @author MyEclipse Persistence Tools
 */

public class NodeRelationModule implements java.io.Serializable {

	// Fields Module

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String fatherId;	//实体节点表表名
	private String childId;	//实体节点类型
	private String state;		//实体节点ID
	// Constructors

	/** default constructor */
	public NodeRelationModule() {
		
	}

	/** full constructor */
	public NodeRelationModule(String fatherId, String childId, String state) {
		this.fatherId = fatherId;
		this.childId = childId;
		this.state = state;
	}

	public String getFatherId() {
		return fatherId;
	}

	public void setFatherId(String fatherId) {
		this.fatherId = fatherId;
	}

	public String getChildId() {
		return childId;
	}

	public void setChildId(String childId) {
		this.childId = childId;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

}