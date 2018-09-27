package nis.nms.domains;


/**
 * Metadata entity.
 * 
 * @author MyEclipse Persistence Tools
 */

public class TableGuide implements java.io.Serializable {

	private static final long serialVersionUID = 1L;
	private Long id;
	private Long userId;
	private Long guideId;
	private String guideName;
	private Long systemId;
	
	// Constructors

	/** default constructor */
	public TableGuide() {
	}

	/** full constructor */
	public TableGuide(Long id,Long userId,Long guideId,String guideName,Long systemId) {
		this.id = id;
		this.userId = userId;
		this.guideId = guideId;
		this.guideName = guideName;
		this.systemId = systemId;
	}

	// Property accessors

	public Long getId() {
		return this.id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public Long getUserId() {
		return userId;
	}

	public void setUserId(Long userId) {
		this.userId = userId;
	}

	public Long getGuideId() {
		return guideId;
	}

	public void setGuideId(Long guideId) {
		this.guideId = guideId;
	}

	public String getGuideName() {
		return guideName;
	}

	public void setGuideName(String guideName) {
		this.guideName = guideName;
	}

	public Long getSystemId() {
		return systemId;
	}

	public void setSystemId(Long systemId) {
		this.systemId = systemId;
	}
}