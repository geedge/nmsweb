package nis.nms.domains;

import java.util.Date;

/**
 * DetectionSetInfo entity.
 * 
 * @author MyEclipse Persistence Tools
 */

public class DetectionSetInfo implements java.io.Serializable {

	// Fields

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private Long id;
	private CheckTypeInfo checkTypeInfo;
	private DetectionInfoNew detectionInfoNew;
	private NodegroupTable nodegroup;
	private String nodeIp;
	private Long checkGap;
	private String checkWay;
	private Long checkOutTime;
	private Long checkMaxTimes;
	private String processIden;//监测使用的设置名（英文）
	private String processIdenName;//展示使用的设置名（可汉语）
	private String detectionSetState;
	private String processFile;
	private String processPath;
	private String isIssue;
	private String isIssued;
	private String isIssueFile;
	private String isControlStart;
	private String oid;
	private Long uploadGap;
	private Date controlStartTime;
	private Date planCheckTime;
	private Long viewLevel;
	private Long createUserId;
	private Long createUserGroupId;
	private Long systemId;
	private String contactUserIds;
	private String nodeGroupsId;//所选节点组id
	private String nodeIpsId;//所选节点id
	private String nodeGroupsName;//所选节点组id
	private String nodeIpsName;//所选节点id
	private String processSearchCode;
	// Constructors

	/** default constructor */
	public DetectionSetInfo() {
	}

	/** full constructor */
	public DetectionSetInfo(CheckTypeInfo checkTypeInfo,String nodeIp,
			Long checkGap, String checkWay, Long checkOutTime,
			Long checkMaxTimes, String processIden, String detectionSetState,
			String processFile, String processPath, String isIssue,
			String isIssued, String isIssueFile, String isControlStart,
			String oid, NodegroupTable nodegroup,Long uploadGap,
			Date controlStartTime,Date planCheckTime,String nodeGroupsId,String nodeIpsId,String processSearchCode) {
		this.checkTypeInfo = checkTypeInfo;
		this.nodeIp = nodeIp;
		this.checkGap = checkGap;
		this.checkWay = checkWay;
		this.checkOutTime = checkOutTime;
		this.checkMaxTimes = checkMaxTimes;
		this.processIden = processIden;
		this.detectionSetState = detectionSetState;
		this.processFile = processFile;
		this.processPath = processPath;
		this.isIssue = isIssue;
		this.isIssued = isIssued;
		this.isIssueFile = isIssueFile;
		this.isControlStart = isControlStart;
		this.oid = oid;
		this.nodegroup=nodegroup;
		this.uploadGap = uploadGap;
		this.controlStartTime = controlStartTime;
		this.planCheckTime = planCheckTime;
		this.nodeGroupsId = nodeGroupsId;
		this.nodeIpsId = nodeIpsId;
		this.processSearchCode = processSearchCode;
	}

	// Property accessors

	public Long getId() {
		return this.id;
	}

	public DetectionInfoNew getDetectionInfoNew() {
		return detectionInfoNew;
	}

	public void setDetectionInfoNew(DetectionInfoNew detectionInfoNew) {
		this.detectionInfoNew = detectionInfoNew;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public CheckTypeInfo getCheckTypeInfo() {
		return this.checkTypeInfo;
	}

	public void setCheckTypeInfo(CheckTypeInfo checkTypeInfo) {
		this.checkTypeInfo = checkTypeInfo;
	}

	public String getNodeIp() {
		return this.nodeIp;
	}

	public void setNodeIp(String nodeIp) {
		this.nodeIp = nodeIp;
	}

	public Long getCheckGap() {
		return this.checkGap;
	}

	public void setCheckGap(Long checkGap) {
		this.checkGap = checkGap;
	}

	public String getCheckWay() {
		return this.checkWay;
	}

	public void setCheckWay(String checkWay) {
		this.checkWay = checkWay;
	}

	public Long getCheckOutTime() {
		return this.checkOutTime;
	}

	public void setCheckOutTime(Long checkOutTime) {
		this.checkOutTime = checkOutTime;
	}

	public Long getCheckMaxTimes() {
		return this.checkMaxTimes;
	}

	public void setCheckMaxTimes(Long checkMaxTimes) {
		this.checkMaxTimes = checkMaxTimes;
	}

	public String getProcessIden() {
		return this.processIden;
	}

	public void setProcessIden(String processIden) {
		this.processIden = processIden;
	}

	public String getDetectionSetState() {
		return this.detectionSetState;
	}

	public void setDetectionSetState(String detectionSetState) {
		this.detectionSetState = detectionSetState;
	}

	public String getProcessFile() {
		return this.processFile;
	}

	public void setProcessFile(String processFile) {
		this.processFile = processFile;
	}

	public String getProcessPath() {
		return this.processPath;
	}

	public void setProcessPath(String processPath) {
		this.processPath = processPath;
	}

	public String getIsIssue() {
		return isIssue;
	}

	public void setIsIssue(String isIssue) {
		this.isIssue = isIssue;
	}

	public String getIsIssued() {
		return isIssued;
	}

	public void setIsIssued(String isIssued) {
		this.isIssued = isIssued;
	}

	public String getIsIssueFile() {
		return isIssueFile;
	}

	public void setIsIssueFile(String isIssueFile) {
		this.isIssueFile = isIssueFile;
	}

	public String getIsControlStart() {
		return isControlStart;
	}

	public void setIsControlStart(String isControlStart) {
		this.isControlStart = isControlStart;
	}

	public String getOid() {
		return oid;
	}

	public void setOid(String oid) {
		this.oid = oid;
	}

	public Long getUploadGap() {
		return uploadGap;
	}

	public void setUploadGap(Long uploadGap) {
		this.uploadGap = uploadGap;
	}

	public NodegroupTable getNodegroup() {
		return nodegroup;
	}

	public void setNodegroup(NodegroupTable nodegroup) {
		this.nodegroup = nodegroup;
	}

	public Date getControlStartTime() {
		return controlStartTime;
	}

	public Date getPlanCheckTime() {
		return planCheckTime;
	}

	public void setPlanCheckTime(Date planCheckTime) {
		this.planCheckTime = planCheckTime;
	}

	public void setControlStartTime(Date controlStartTime) {
		this.controlStartTime = controlStartTime;
	}
	public Long getViewLevel() {
		return viewLevel;
	}

	public void setViewLevel(Long viewLevel) {
		this.viewLevel = viewLevel;
	}

	public String getContactUserIds() {
		return contactUserIds;
	}

	public void setContactUserIds(String contactUserIds) {
		this.contactUserIds = contactUserIds;
	}

	public Long getCreateUserId() {
		return createUserId;
	}

	public void setCreateUserId(Long createUserId) {
		this.createUserId = createUserId;
	}

	public Long getCreateUserGroupId() {
		return createUserGroupId;
	}

	public void setCreateUserGroupId(Long createUserGroupId) {
		this.createUserGroupId = createUserGroupId;
	}

	public Long getSystemId() {
		return systemId;
	}

	public void setSystemId(Long systemId) {
		this.systemId = systemId;
	}

	
	public String getNodeGroupsId()
	{
		return nodeGroupsId;
	}

	
	public void setNodeGroupsId(String nodeGroupsId)
	{
		this.nodeGroupsId = nodeGroupsId;
	}

	
	public String getNodeIpsId()
	{
		return nodeIpsId;
	}

	
	public void setNodeIpsId(String nodeIpsId)
	{
		this.nodeIpsId = nodeIpsId;
	}

	
	public String getNodeGroupsName()
	{
		return nodeGroupsName;
	}

	
	public void setNodeGroupsName(String nodeGroupsName)
	{
		this.nodeGroupsName = nodeGroupsName;
	}

	
	public String getNodeIpsName()
	{
		return nodeIpsName;
	}

	
	public void setNodeIpsName(String nodeIpsName)
	{
		this.nodeIpsName = nodeIpsName;
	}

	public String getProcessIdenName() {
		return processIdenName;
	}

	public void setProcessIdenName(String processIdenName) {
		this.processIdenName = processIdenName;
	}

	public String getProcessSearchCode() {
		return processSearchCode;
	}

	public void setProcessSearchCode(String processSearchCode) {
		this.processSearchCode = processSearchCode;
	}
}