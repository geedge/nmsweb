package nis.nms.domains;

import java.util.Date;

/**
 * ServerTable entity.
 * 
 * @author MyEclipse Persistence Tools
 */

public class ServerTable implements java.io.Serializable {

	// Fields

	private Long id;
	private String serverName;
	private String serverDesc;
	private Long serverState;
	private String serverIp;
	private Long serverIpn;
	private Date createTime;
	// Constructors

	/** default constructor */
	public ServerTable() {
	}

	/** full constructor */
	public ServerTable(String serverName, Long serverState, String serverIp,
			Long serverIpn,Date createTime) {
		this.serverName = serverName;
		this.serverState = serverState;
		this.serverIp = serverIp;
		this.serverIpn = serverIpn;
		this.createTime = createTime;
	}

	// Property accessors

	public Long getId() {
		return this.id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getServerName() {
		return this.serverName;
	}

	public void setServerName(String serverName) {
		this.serverName = serverName;
	}

	public Long getServerState() {
		return this.serverState;
	}

	public void setServerState(Long serverState) {
		this.serverState = serverState;
	}

	public String getServerIp() {
		return this.serverIp;
	}

	public void setServerIp(String serverIp) {
		this.serverIp = serverIp;
	}

	public Long getServerIpn() {
		return this.serverIpn;
	}

	public void setServerIpn(Long serverIpn) {
		this.serverIpn = serverIpn;
	}

	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	public String getServerDesc() {
		return serverDesc;
	}

	public void setServerDesc(String serverDesc) {
		this.serverDesc = serverDesc;
	}
}