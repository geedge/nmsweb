package nis.nms.domains;

import java.util.Date;

/**
 * NodeTable entity.
 * 
 * @author MyEclipse Persistence Tools
 */

public class NodeTable implements java.io.Serializable
{
	
	// Fields
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1984053252904108229L;
	private Long nodeId;
	private String nodeIp;
	private Long nodeType;
	private String nodeName;
	private String nodeDesc;
	private Long nodeState;
	private Long systemId;
	private Date nodeCreatetime;
	private Long createUserId;
	private Date nodeStoptime;
	private Long stopUserId;
	private String groupIdName;
	private String systemIdName;
	private Long nodeLatticeId;
	private Long seqId;
	private Long groupId;
	private Long nodeUType;
	private Long snmpVersion;
	private Long ipn;
	private Long nodeSystemType;
	private String nodeMac;
	private String nodeIpInfo;
	private Long nodeBeginUType;
	private String nodeBoxIspn;
	
	private String nodeUserName;
	private String nodePassword;
	private Long networElementType;
	private Long specialServerType;
	private boolean alarm;
	
	// Constructors
	
	public Long getSnmpVersion()
	{
		return snmpVersion;
	}
	
	public void setSnmpVersion(Long snmpVersion)
	{
		this.snmpVersion = snmpVersion;
	}
	
	/** default constructor */
	public NodeTable()
	{
	}
	
	/** minimal constructor */
	public NodeTable(Long nodeId, String nodeName, Long nodeState, Long systemId)
	{
		this.nodeId = nodeId;
		this.nodeName = nodeName;
		this.nodeState = nodeState;
		this.systemId = systemId;
		// this.nodeLatticeId=nodeLatticeId;
	}
	
	/** full constructor */
	public NodeTable(Long nodeId, String nodeIp, Long nodeType, String nodeName, String nodeDesc,
			Long nodeState, Long systemId, Date nodeCreatetime, Long createUserId,
			Date nodeStoptime, Long stopUserId)
	{
		this.nodeId = nodeId;
		this.nodeIp = nodeIp;
		this.nodeType = nodeType;
		this.nodeName = nodeName;
		this.nodeDesc = nodeDesc;
		this.nodeState = nodeState;
		this.systemId = systemId;
		this.nodeCreatetime = nodeCreatetime;
		this.createUserId = createUserId;
		this.nodeStoptime = nodeStoptime;
		this.stopUserId = stopUserId;
		// this.nodeLatticeId = nodeLatticeId;
	}
	
	// Property accessors
	
	public Long getNodeId()
	{
		return this.nodeId;
	}
	
	public void setNodeId(Long nodeId)
	{
		this.nodeId = nodeId;
	}
	
	public String getNodeName()
	{
		return this.nodeName;
	}
	
	public void setNodeName(String nodeName)
	{
		this.nodeName = nodeName;
	}
	
	public String getNodeDesc()
	{
		return this.nodeDesc;
	}
	
	public void setNodeDesc(String nodeDesc)
	{
		this.nodeDesc = nodeDesc;
	}
	
	public Long getNodeState()
	{
		return this.nodeState;
	}
	
	public void setNodeState(Long nodeState)
	{
		this.nodeState = nodeState;
	}
	
	public Long getSystemId()
	{
		return this.systemId;
	}
	
	public void setSystemId(Long systemId)
	{
		this.systemId = systemId;
	}
	
	public String getNodeIp()
	{
		return nodeIp;
	}
	
	public void setNodeIp(String nodeIp)
	{
		this.nodeIp = nodeIp;
	}
	
	public Long getNodeType()
	{
		return nodeType;
	}
	
	public void setNodeType(Long nodeType)
	{
		this.nodeType = nodeType;
	}
	
	public Date getNodeCreatetime()
	{
		return nodeCreatetime;
	}
	
	public void setNodeCreatetime(Date nodeCreatetime)
	{
		this.nodeCreatetime = nodeCreatetime;
	}
	
	public Long getCreateUserId()
	{
		return createUserId;
	}
	
	public void setCreateUserId(Long createUserId)
	{
		this.createUserId = createUserId;
	}
	
	public Date getNodeStoptime()
	{
		return nodeStoptime;
	}
	
	public void setNodeStoptime(Date nodeStoptime)
	{
		this.nodeStoptime = nodeStoptime;
	}
	
	public Long getStopUserId()
	{
		return stopUserId;
	}
	
	public void setStopUserId(Long stopUserId)
	{
		this.stopUserId = stopUserId;
	}
	
	public static long getSerialVersionUID()
	{
		return serialVersionUID;
	}
	
	public String getGroupIdName()
	{
		return groupIdName;
	}
	
	public void setGroupIdName(String groupIdName)
	{
		this.groupIdName = groupIdName;
	}
	
	public String getSystemIdName()
	{
		return systemIdName;
	}
	
	public void setSystemIdName(String systemIdName)
	{
		this.systemIdName = systemIdName;
	}
	
	public Long getNodeLatticeId()
	{
		return nodeLatticeId;
	}
	
	public void setNodeLatticeId(Long nodeLatticeId)
	{
		this.nodeLatticeId = nodeLatticeId;
	}
	
	public Long getSeqId()
	{
		return seqId;
	}
	
	public void setSeqId(Long seqId)
	{
		this.seqId = seqId;
	}
	
	public Long getGroupId()
	{
		return groupId;
	}
	
	public void setGroupId(Long groupId)
	{
		this.groupId = groupId;
	}
	
	public Long getNodeUType()
	{
		return nodeUType;
	}
	
	public void setNodeUType(Long nodeUType)
	{
		this.nodeUType = nodeUType;
	}
	
	public Long getIpn()
	{
		return ipn;
	}
	
	public void setIpn(Long ipn)
	{
		this.ipn = ipn;
	}
	
	public Long getNodeSystemType()
	{
		return nodeSystemType;
	}
	
	public void setNodeSystemType(Long nodeSystemType)
	{
		this.nodeSystemType = nodeSystemType;
	}
	
	public String getNodeMac()
	{
		return nodeMac;
	}
	
	public void setNodeMac(String nodeMac)
	{
		this.nodeMac = nodeMac;
	}
	
	public String getNodeIpInfo()
	{
		return nodeIpInfo;
	}
	
	public void setNodeIpInfo(String nodeIpInfo)
	{
		this.nodeIpInfo = nodeIpInfo;
	}
	
	public Long getNodeBeginUType()
	{
		return nodeBeginUType;
	}
	
	public void setNodeBeginUType(Long nodeBeginUType)
	{
		this.nodeBeginUType = nodeBeginUType;
	}
	
	public String getNodeBoxIspn()
	{
		return nodeBoxIspn;
	}
	
	public void setNodeBoxIspn(String nodeBoxIspn)
	{
		this.nodeBoxIspn = nodeBoxIspn;
	}
	
	public String getNodeUserName()
	{
		return nodeUserName;
	}
	
	public void setNodeUserName(String nodeUserName)
	{
		this.nodeUserName = nodeUserName;
	}
	
	public String getNodePassword()
	{
		return nodePassword;
	}
	
	public void setNodePassword(String nodePassword)
	{
		this.nodePassword = nodePassword;
	}
	
	public Long getNetworElementType()
	{
		return networElementType;
	}
	
	public void setNetworElementType(Long networElementType)
	{
		this.networElementType = networElementType;
	}

	
	public boolean isAlarm()
	{
		return alarm;
	}

	
	public void setAlarm(boolean alarm)
	{
		this.alarm = alarm;
	}

	public Long getSpecialServerType() {
		return specialServerType;
	}

	public void setSpecialServerType(Long specialServerType) {
		this.specialServerType = specialServerType;
	}
	
}