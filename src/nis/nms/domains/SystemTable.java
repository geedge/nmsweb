package nis.nms.domains;

import java.util.Date;

/**
 * SystemTable entity.
 * 
 * @author MyEclipse Persistence Tools
 */

public class SystemTable implements java.io.Serializable {

	// Fields

	private Long systemId;
	private String systemName;
	private String systemDesc;
	private String systemState;//正常0;已删除或停用1
	private Date systemCreatetime;
	private Long createUserId;
	private Date systemStoptime;
	private Long stopUserId;
	private String systemIp;
	private Long systemIpn;
	private Long systemPort;
	private Long systemStartState;
	private Long isMaster;
	// Constructors

	/** default constructor */
	public SystemTable() {
	}

	/** minimal constructor */
	public SystemTable(String systemName, String systemState) {
		this.systemName = systemName;
		this.systemState = systemState;
	}

	/** full constructor */
	public SystemTable(String systemName, String systemDesc,
			String systemState, Date systemCreatetime, Long createUserId,
			Date systemStoptime, Long stopUserId) {
		this.systemName = systemName;
		this.systemDesc = systemDesc;
		this.systemState = systemState;
		this.systemCreatetime = systemCreatetime;
		this.createUserId = createUserId;
		this.systemStoptime = systemStoptime;
		this.stopUserId = stopUserId;
	}

	// Property accessors

	public Long getSystemId() {
		return this.systemId;
	}

	public void setSystemId(Long systemId) {
		this.systemId = systemId;
	}

	public String getSystemName() {
		return this.systemName;
	}

	public void setSystemName(String systemName) {
		this.systemName = systemName;
	}

	public String getSystemDesc() {
		return this.systemDesc;
	}

	public void setSystemDesc(String systemDesc) {
		this.systemDesc = systemDesc;
	}

	public String getSystemState() {
		return this.systemState;
	}

	public void setSystemState(String systemState) {
		this.systemState = systemState;
	}

	public Date getSystemCreatetime() {
		return this.systemCreatetime;
	}

	public void setSystemCreatetime(Date systemCreatetime) {
		this.systemCreatetime = systemCreatetime;
	}

	public Long getCreateUserId() {
		return this.createUserId;
	}

	public void setCreateUserId(Long createUserId) {
		this.createUserId = createUserId;
	}

	public Date getSystemStoptime() {
		return this.systemStoptime;
	}

	public void setSystemStoptime(Date systemStoptime) {
		this.systemStoptime = systemStoptime;
	}

	public Long getStopUserId() {
		return this.stopUserId;
	}

	public void setStopUserId(Long stopUserId) {
		this.stopUserId = stopUserId;
	}

	public String getSystemIp() {
		return systemIp;
	}

	public void setSystemIp(String systemIp) {
		this.systemIp = systemIp;
	}

	public Long getSystemIpn() {
		return systemIpn;
	}

	public void setSystemIpn(Long systemIpn) {
		this.systemIpn = systemIpn;
	}

	public Long getSystemPort() {
		return systemPort;
	}

	public void setSystemPort(Long systemPort) {
		this.systemPort = systemPort;
	}

	public Long getSystemStartState() {
		return systemStartState;
	}

	public void setSystemStartState(Long systemStartState) {
		this.systemStartState = systemStartState;
	}

	public Long getIsMaster() {
		return isMaster;
	}

	public void setIsMaster(Long isMaster) {
		this.isMaster = isMaster;
	}

}