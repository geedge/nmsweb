package nis.nms.domains;

/**
 * NmsErrorCode entity.
 * 
 * @author MyEclipse Persistence Tools
 */

public class NmsErrorCode implements java.io.Serializable {

	// Fields

	private Long id;
	private String errorCode;
	private String errorName;
	private String errorDes;
	private Long errorLevel;

	// Constructors

	/** default constructor */
	public NmsErrorCode() {
	}

	/** minimal constructor */
	public NmsErrorCode(Long id, String errorCode, String errorName,
			Long errorLevel) {
		this.id = id;
		this.errorCode = errorCode;
		this.errorName = errorName;
		this.errorLevel = errorLevel;
	}

	/** full constructor */
	public NmsErrorCode(Long id, String errorCode, String errorName,
			String errorDes, Long errorLevel) {
		this.id = id;
		this.errorCode = errorCode;
		this.errorName = errorName;
		this.errorDes = errorDes;
		this.errorLevel = errorLevel;
	}

	// Property accessors

	public Long getId() {
		return this.id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getErrorCode() {
		return this.errorCode;
	}

	public void setErrorCode(String errorCode) {
		this.errorCode = errorCode;
	}

	public String getErrorName() {
		return this.errorName;
	}

	public void setErrorName(String errorName) {
		this.errorName = errorName;
	}

	public String getErrorDes() {
		return this.errorDes;
	}

	public void setErrorDes(String errorDes) {
		this.errorDes = errorDes;
	}

	public Long getErrorLevel() {
		return this.errorLevel;
	}

	public void setErrorLevel(Long errorLevel) {
		this.errorLevel = errorLevel;
	}

}