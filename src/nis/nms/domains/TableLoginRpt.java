package nis.nms.domains;

import java.util.Date;

/**
 * TableLoginRpt entity.
 * 
 * @author MyEclipse Persistence Tools
 */

public class TableLoginRpt implements java.io.Serializable {

	// Fields

	private Long logid;
	private String username;
	private String ip;
	private Date time;
	private String action;
	private String status;

	// Constructors

	/** default constructor */
	public TableLoginRpt() {
	}

	/** minimal constructor */
	public TableLoginRpt(Long logid, String username) {
		this.logid = logid;
		this.username = username;
	}

	/** full constructor */
	public TableLoginRpt(Long logid, String username, String ip, Date time,
			String action, String status) {
		this.logid = logid;
		this.username = username;
		this.ip = ip;
		this.time = time;
		this.action = action;
		this.status = status;
	}

	// Property accessors

	public Long getLogid() {
		return this.logid;
	}

	public void setLogid(Long logid) {
		this.logid = logid;
	}

	public String getUsername() {
		return this.username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getIp() {
		return this.ip;
	}

	public void setIp(String ip) {
		this.ip = ip;
	}

	public Date getTime() {
		return this.time;
	}

	public void setTime(Date time) {
		this.time = time;
	}

	public String getAction() {
		return this.action;
	}

	public void setAction(String action) {
		this.action = action;
	}

	public String getStatus() {
		return this.status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

}