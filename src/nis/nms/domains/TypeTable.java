package nis.nms.domains;

/**
 * Brand entity.
 * 
 * @author MyEclipse Persistence Tools
 */

public class TypeTable implements java.io.Serializable {

	// Fields

	private Long id;
	private Long showNum;
	private Long typeState;
	private String typeDesc;
	private String typeName;
	private String typeIdentity;
	
	// Constructors

	/** default constructor */
	public TypeTable() {
	}

	/** full constructor */
	public TypeTable(Long id, Long showNum, Long typeState,String typeDesc, String typeName, String typeIdentity) {
		this.id = id;
		this.showNum = showNum;
		this.typeState = typeState;
		this.typeDesc = typeDesc;
		this.typeName = typeName;
		this.typeIdentity = typeIdentity;
	}

	// Property accessors
	
	public String getTypeIdentity() {
		return typeIdentity;
	}

	public void setTypeIdentity(String typeIdentity) {
		this.typeIdentity = typeIdentity;
	}

	public Long getId()
	{
		return id;
	}

	
	public void setId(Long id)
	{
		this.id = id;
	}

	
	public Long getShowNum()
	{
		return showNum;
	}

	
	public void setShowNum(Long showNum)
	{
		this.showNum = showNum;
	}

	
	public Long getTypeState()
	{
		return typeState;
	}

	
	public void setTypeState(Long typeState)
	{
		this.typeState = typeState;
	}

	
	public String getTypeDesc()
	{
		return typeDesc;
	}

	
	public void setTypeDesc(String typeDesc)
	{
		this.typeDesc = typeDesc;
	}

	
	public String getTypeName()
	{
		return typeName;
	}

	
	public void setTypeName(String typeName)
	{
		this.typeName = typeName;
	}

	
}