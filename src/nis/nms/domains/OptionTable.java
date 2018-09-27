package nis.nms.domains;

/**
 * OptionTable entity.
 * 
 * @author MyEclipse Persistence Tools
 */

public class OptionTable implements java.io.Serializable {

	// Fields

	private Long id;
	private String typeIdentity;
	private String typeCode;
	private String typeValue;
	private Long showNum;
	private Long typeState;
	private String delayTime;

	// Constructors

	/** default constructor */
	public OptionTable() {
	}

	/** minimal constructor */
	public OptionTable(String typeIdentity, String typeCode, String typeValue) {
		this.typeIdentity = typeIdentity;
		this.typeCode = typeCode;
		this.typeValue = typeValue;
	}

	/** full constructor */
	public OptionTable(String typeIdentity, String typeCode, String typeValue,
			Long showNum, Long typeState) {
		this.typeIdentity = typeIdentity;
		this.typeCode = typeCode;
		this.typeValue = typeValue;
		this.showNum = showNum;
		this.typeState = typeState;
	}

	// Property accessors

	public Long getId() {
		return this.id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	
	public String getTypeIdentity() {
		return typeIdentity;
	}

	public void setTypeIdentity(String typeIdentity) {
		this.typeIdentity = typeIdentity;
	}

	public String getTypeCode()
	{
		return typeCode;
	}

	
	public void setTypeCode(String typeCode)
	{
		this.typeCode = typeCode;
	}

	public String getTypeValue() {
		return this.typeValue;
	}

	public void setTypeValue(String typeValue) {
		this.typeValue = typeValue;
	}

	public Long getShowNum() {
		return this.showNum;
	}

	public void setShowNum(Long showNum) {
		this.showNum = showNum;
	}

	public Long getTypeState() {
		return this.typeState;
	}

	public void setTypeState(Long typeState) {
		this.typeState = typeState;
	}

	public String getDelayTime() {
		return delayTime;
	}

	public void setDelayTime(String delayTime) {
		this.delayTime = delayTime;
	}

}