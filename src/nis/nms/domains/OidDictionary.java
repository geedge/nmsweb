package nis.nms.domains;

/**
 * Brand entity.
 * 
 * @author MyEclipse Persistence Tools
 */

public class OidDictionary implements java.io.Serializable {

	// Fields

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private Long id;
	private String oid;
	private String oidDesc;
	
	// Constructors

	/** default constructor */
	public OidDictionary() {
	}

	/** full constructor */
	public OidDictionary(Long id, String oid, String oidDesc) {
		this.id = id;
		this.oid = oid;
		this.oidDesc = oidDesc;
	}

	// Property accessors
	
	public Long getId()
	{
		return id;
	}

	
	public void setId(Long id)
	{
		this.id = id;
	}

	public String getOid() {
		return oid;
	}

	public void setOid(String oid) {
		this.oid = oid;
	}

	public String getOidDesc() {
		return oidDesc;
	}

	public void setOidDesc(String oidDesc) {
		this.oidDesc = oidDesc;
	}

}