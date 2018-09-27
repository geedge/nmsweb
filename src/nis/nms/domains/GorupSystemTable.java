package nis.nms.domains;

/**
 * GorupSystemTable entity.
 * 
 * @author MyEclipse Persistence Tools
 */

public class GorupSystemTable implements java.io.Serializable {

	// Fields

	/**
	 * 
	 */
	private static final long serialVersionUID = 7564412208331909546L;
	private Long id;
	private Long userGroupId;
	private Long systemId;

	// Constructors

	/** default constructor */
	public GorupSystemTable() {
	}

	/** full constructor */
	public GorupSystemTable(Long userGroupId, Long systemId) {
		this.userGroupId = userGroupId;
		this.systemId = systemId;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public Long getUserGroupId() {
		return userGroupId;
	}

	public void setUserGroupId(Long userGroupId) {
		this.userGroupId = userGroupId;
	}

	public Long getSystemId() {
		return systemId;
	}

	public void setSystemId(Long systemId) {
		this.systemId = systemId;
	}

	// Property accessors



}