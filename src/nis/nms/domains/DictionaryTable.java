package nis.nms.domains;

/**
 * DictionaryTable entity.
 * 
 * @author MyEclipse Persistence Tools
 */

public class DictionaryTable implements java.io.Serializable {

	// Fields

	private Long id;
	private String typeNmae;
	private String typeDesc;
	private Long typeState;

	// Constructors

	/** default constructor */
	public DictionaryTable() {
	}

	/** minimal constructor */
	public DictionaryTable(String typeNmae) {
		this.typeNmae = typeNmae;
	}

	/** full constructor */
	public DictionaryTable(String typeNmae, String typeDesc, Long typeState) {
		this.typeNmae = typeNmae;
		this.typeDesc = typeDesc;
		this.typeState = typeState;
	}

	// Property accessors

	public Long getId() {
		return this.id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getTypeNmae() {
		return this.typeNmae;
	}

	public void setTypeNmae(String typeNmae) {
		this.typeNmae = typeNmae;
	}

	public String getTypeDesc() {
		return this.typeDesc;
	}

	public void setTypeDesc(String typeDesc) {
		this.typeDesc = typeDesc;
	}

	public Long getTypeState() {
		return this.typeState;
	}

	public void setTypeState(Long typeState) {
		this.typeState = typeState;
	}

}