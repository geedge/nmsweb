package nis.nms.domains;


/**
 * NodeTable entity.
 * 
 * @author MyEclipse Persistence Tools
 */

public class NodeTableVo implements java.io.Serializable {

	// Fields

	private static final long serialVersionUID = 1984053252904108229L;
	private String nodeIp;
	private String nodeMac;
	private String nodeName;
	private String nodeType;
	private Long nodeUType;
	private String nodeBoxIspn;
	private Long nodeBeginUType;
	private Long snmpVersion;
	private String nodeState;
	private String nodeIpInfo;
	private String nodeDesc;
	
	private String nodeUserName;
	private String nodePassword;
	private String networElementType;
	
	//导入结点时，数据错误提示信息
	private String showError;

	// Constructors

	/** default constructor */
	public NodeTableVo() {
	}

	public NodeTableVo(String nodeIp, String nodeMac,String nodeName,String nodeType, 
			Long nodeUType,String nodeBoxIspn,Long nodeBeginUType,Long snmpVersion,String nodeState,
			String nodeIpInfo,String nodeDesc,String showError) {
		super();
		this.nodeIp = nodeIp;
		this.nodeMac = nodeMac;
		this.nodeName = nodeName;
		this.nodeType = nodeType;
		this.nodeUType = nodeUType;
		this.nodeBoxIspn = nodeBoxIspn;
		this.nodeBeginUType = nodeBeginUType;
		this.snmpVersion = snmpVersion;
		this.nodeState = nodeState;
		this.nodeIpInfo = nodeIpInfo;
		this.nodeDesc = nodeDesc;
		this.showError = showError;
	}
	
	public NodeTableVo(String nodeIp, String nodeType, String nodeName,
			String nodeDesc, String nodeState, String showError) {
		super();
		this.nodeIp = nodeIp;
		this.nodeType = nodeType;
		this.nodeName = nodeName;
		this.nodeDesc = nodeDesc;
		this.nodeState = nodeState;
		this.showError = showError;
	}

	public String getNodeIp() {
		return nodeIp;
	}

	public void setNodeIp(String nodeIp) {
		this.nodeIp = nodeIp;
	}

	public String getNodeType() {
		return nodeType;
	}

	public void setNodeType(String nodeType) {
		this.nodeType = nodeType;
	}

	public String getNodeName() {
		return nodeName;
	}

	public void setNodeName(String nodeName) {
		this.nodeName = nodeName;
	}

	public String getNodeDesc() {
		return nodeDesc;
	}

	public void setNodeDesc(String nodeDesc) {
		this.nodeDesc = nodeDesc;
	}

	public String getNodeState() {
		return nodeState;
	}

	public void setNodeState(String nodeState) {
		this.nodeState = nodeState;
	}

	public String getShowError() {
		return showError;
	}

	public void setShowError(String showError) {
		this.showError = showError;
	}

	public String getNodeMac() {
		return nodeMac;
	}

	public void setNodeMac(String nodeMac) {
		this.nodeMac = nodeMac;
	}

	public Long getNodeUType() {
		return nodeUType;
	}

	public void setNodeUType(Long nodeUType) {
		this.nodeUType = nodeUType;
	}

	public String getNodeBoxIspn() {
		return nodeBoxIspn;
	}

	public void setNodeBoxIspn(String nodeBoxIspn) {
		this.nodeBoxIspn = nodeBoxIspn;
	}

	public Long getNodeBeginUType() {
		return nodeBeginUType;
	}

	public void setNodeBeginUType(Long nodeBeginUType) {
		this.nodeBeginUType = nodeBeginUType;
	}

	public Long getSnmpVersion() {
		return snmpVersion;
	}

	public void setSnmpVersion(Long snmpVersion) {
		this.snmpVersion = snmpVersion;
	}

	public String getNodeIpInfo() {
		return nodeIpInfo;
	}

	public void setNodeIpInfo(String nodeIpInfo) {
		this.nodeIpInfo = nodeIpInfo;
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

	
	public String getNetworElementType()
	{
		return networElementType;
	}

	
	public void setNetworElementType(String networElementType)
	{
		this.networElementType = networElementType;
	}

}