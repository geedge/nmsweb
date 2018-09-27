package nis.nms.domains;

/**
 * Brand entity.
 * 
 * @author MyEclipse Persistence Tools
 */

public class SortInfo implements java.io.Serializable {

	// Fields

	private Long id;
	private String sortName;
	private String sortDesc;
	
	// Constructors

	/** default constructor */
	public SortInfo() {
	}

	/** full constructor */
	public SortInfo(Long id, String sortName, String sortDesc) {
		this.id = id;
		this.sortName = sortName;
		this.sortDesc = sortDesc;
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
	
	
	public String getSortName()
	{
		return sortName;
	}

	
	public void setSortName(String sortName)
	{
		this.sortName = sortName;
	}

	
	public String getSortDesc()
	{
		return sortDesc;
	}

	
	public void setSortDesc(String sortDesc)
	{
		this.sortDesc = sortDesc;
	}	
	
}