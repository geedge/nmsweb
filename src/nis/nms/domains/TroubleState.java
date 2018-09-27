package nis.nms.domains;

import java.util.Date;

public class TroubleState implements java.io.Serializable {

	private static final long serialVersionUID = 1L;
	private Long id;
	private Long troubleCode;
	private String troubleInfo;
	private String troubleDescr;
	private SystemTable system;
	private XtYhJbxx createUser;
	private Date createDate;
	private XtYhJbxx lastUpUser;
	private Date lastUpDate;
	private String state;
	
	

	/** default constructor */
	public TroubleState() {
	}

	/** full constructor */
	public TroubleState(Long id,Long troubleCode,String troubleInfo,
			String troubleDescr,SystemTable system,XtYhJbxx createUser,
			Date createDate,XtYhJbxx lastUpUser,Date lastUpDate,String state) {
		this.id = id;
		this.troubleCode = troubleCode;
		this.troubleInfo = troubleInfo;
		this.troubleDescr = troubleDescr;
		this.system = system;
		this.createUser = createUser;
		this.createDate = createDate;
		this.lastUpUser = lastUpUser;
		this.lastUpDate = lastUpDate;
		this.state = state;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public Long getTroubleCode() {
		return troubleCode;
	}

	public void setTroubleCode(Long troubleCode) {
		this.troubleCode = troubleCode;
	}

	public String getTroubleInfo() {
		return troubleInfo;
	}

	public void setTroubleInfo(String troubleInfo) {
		this.troubleInfo = troubleInfo;
	}

	public String getTroubleDescr() {
		return troubleDescr;
	}

	public void setTroubleDescr(String troubleDescr) {
		this.troubleDescr = troubleDescr;
	}

	public Date getCreateDate() {
		return createDate;
	}

	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}

	public Date getLastUpDate() {
		return lastUpDate;
	}

	public void setLastUpDate(Date lastUpDate) {
		this.lastUpDate = lastUpDate;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public SystemTable getSystem() {
		return system;
	}

	public void setSystem(SystemTable system) {
		this.system = system;
	}

	public XtYhJbxx getCreateUser() {
		return createUser;
	}

	public void setCreateUser(XtYhJbxx createUser) {
		this.createUser = createUser;
	}

	public XtYhJbxx getLastUpUser() {
		return lastUpUser;
	}

	public void setLastUpUser(XtYhJbxx lastUpUser) {
		this.lastUpUser = lastUpUser;
	}

}