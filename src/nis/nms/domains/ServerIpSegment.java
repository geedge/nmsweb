package nis.nms.domains;

/**
 * ServerIpSegment entity.
 * 
 * @author MyEclipse Persistence Tools
 */

public class ServerIpSegment implements java.io.Serializable {

	// Fields

	private Long id;
	private ServerTable serverTable;
	private String startIp;
	private Long startIpn;
	private String endIp;
	private Long endIpn;

	// Constructors

	/** default constructor */
	public ServerIpSegment() {
	}

	/** minimal constructor */
	public ServerIpSegment(ServerTable serverTable) {
		this.serverTable = serverTable;
	}

	/** full constructor */
	public ServerIpSegment(ServerTable serverTable, String startIp,
			Long startIpn, String endIp, Long endIpn) {
		this.serverTable = serverTable;
		this.startIp = startIp;
		this.startIpn = startIpn;
		this.endIp = endIp;
		this.endIpn = endIpn;
	}

	// Property accessors

	public Long getId() {
		return this.id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public ServerTable getServerTable() {
		return this.serverTable;
	}

	public void setServerTable(ServerTable serverTable) {
		this.serverTable = serverTable;
	}

	public String getStartIp() {
		return this.startIp;
	}

	public void setStartIp(String startIp) {
		this.startIp = startIp;
	}

	public Long getStartIpn() {
		return this.startIpn;
	}

	public void setStartIpn(Long startIpn) {
		this.startIpn = startIpn;
	}

	public String getEndIp() {
		return this.endIp;
	}

	public void setEndIp(String endIp) {
		this.endIp = endIp;
	}

	public Long getEndIpn() {
		return this.endIpn;
	}

	public void setEndIpn(Long endIpn) {
		this.endIpn = endIpn;
	}

}