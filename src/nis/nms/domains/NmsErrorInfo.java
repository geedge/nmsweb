package nis.nms.domains;

import java.util.Date;

/**
 * NmsErrorInfo entity.
 * 
 * @author MyEclipse Persistence Tools
 */

public class NmsErrorInfo implements java.io.Serializable {

	// Fields

	private Long id;
	private String errorCode;
	private Date errorTime;
	private String errortGetip;
	private String errortIp;
	private Long errorState;
	private String errorDesc;
	private Date stateUpdateTime;
	private Long stateUpdateUserid;

	// Constructors

	/** default constructor */
	public NmsErrorInfo() {
	}

	/** minimal constructor */
	public NmsErrorInfo(Long id) {
		this.id = id;
	}

	/** full constructor */
	public NmsErrorInfo(Long id, String errorCode, Date errorTime,
			String errortGetip, String errortIp, Long errorState,
			Date stateUpdateTime, Long stateUpdateUserid) {
		this.id = id;
		this.errorCode = errorCode;
		this.errorTime = errorTime;
		this.errortGetip = errortGetip;
		this.errortIp = errortIp;
		this.errorState = errorState;
		this.stateUpdateTime = stateUpdateTime;
		this.stateUpdateUserid = stateUpdateUserid;
	}
	
	/** full constructor */
	public NmsErrorInfo(String errorCode, Date errorTime,
			String errortGetip, String errortIp, Long errorState,
			Date stateUpdateTime, Long stateUpdateUserid) {
		this.errorCode = errorCode;
		this.errorTime = errorTime;
		this.errortGetip = errortGetip;
		this.errortIp = errortIp;
		this.errorState = errorState;
		this.stateUpdateTime = stateUpdateTime;
		this.stateUpdateUserid = stateUpdateUserid;
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

	public Date getErrorTime() {
		return this.errorTime;
	}

	public void setErrorTime(Date errorTime) {
		this.errorTime = errorTime;
	}

	public String getErrortGetip() {
		return this.errortGetip;
	}

	public void setErrortGetip(String errortGetip) {
		this.errortGetip = errortGetip;
	}

	public String getErrortIp() {
		return this.errortIp;
	}

	public void setErrortIp(String errortIp) {
		this.errortIp = errortIp;
	}

	public Long getErrorState() {
		return this.errorState;
	}

	public void setErrorState(Long errorState) {
		this.errorState = errorState;
	}

	public Date getStateUpdateTime() {
		return this.stateUpdateTime;
	}

	public void setStateUpdateTime(Date stateUpdateTime) {
		this.stateUpdateTime = stateUpdateTime;
	}

	public Long getStateUpdateUserid() {
		return this.stateUpdateUserid;
	}

	public void setStateUpdateUserid(Long stateUpdateUserid) {
		this.stateUpdateUserid = stateUpdateUserid;
	}

	public String getErrorDesc() {
		return errorDesc;
	}

	public void setErrorDesc(String errorDesc) {
		this.errorDesc = errorDesc;
	}

}