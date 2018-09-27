package nis.nms.domains;

/**
 * Brand entity.
 * 
 * @author MyEclipse Persistence Tools
 */

public class Brand implements java.io.Serializable {

	// Fields

	private Long id;
	private String brandName;
	private String brandDesc;
	private String brandOid;
	
	// Constructors

	/** default constructor */
	public Brand() {
	}

	/** full constructor */
	public Brand(Long id, String brandName, String brandDesc, String brandOid) {
		this.id = id;
		this.brandName = brandName;
		this.brandDesc = brandDesc;
		this.brandOid = brandOid;
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

	
	public String getBrandName()
	{
		return brandName;
	}

	
	public void setBrandName(String brandName)
	{
		this.brandName = brandName;
	}

	
	public String getBrandDesc()
	{
		return brandDesc;
	}

	
	public void setBrandDesc(String brandDesc)
	{
		this.brandDesc = brandDesc;
	}

	
	public String getBrandOid()
	{
		return brandOid;
	}

	
	public void setBrandOid(String brandOid)
	{
		this.brandOid = brandOid;
	}
}