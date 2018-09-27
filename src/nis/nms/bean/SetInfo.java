package nis.nms.bean;

/**
 * 客户端用到的监测设置信息实体
 * 
 */
public class SetInfo {
	/**
	 * 监测设置信息ID
	 */
	private Long id; 
	/**
	 * 检测类型
	 */
	private String checkTypeName;//如：CPU、DISK等
	private String checkTypeName1;//如：CPU、DISK等
	private Long checkTypeId;//检测类型的ID，预留
	/**
	 * 目标IP
	 */
//	private String nodeIp;//
	/**
	 * 最大测试次数
	 */
	private Long checkMaxTimes;
	/**
	 * 节点组ID
	 */
//	private Long groupId;
	/**
	 * 
	 */
	private String nodeGroupsId;
	/**
	 * 最大测试次数
	 */
	private String nodeIpsId;
	/**
	 * 时间间隔(单位:分钟)
	 */
	private Long checkGap;
	/**
	 * 超时时间(单位:秒)
	 */
	private Long checkOutTime;
	/**
	 * 监测状态：0无效；1有效
	 */
	private String checkState;
	/**
	 * 监测方式：0主动，1被动
	 */
	private String checkWay;
	/**
	 * 进程标志
	 */
	private String processIden;
	private String processIdenName;
	/**
	 * 进程执行文件
	 */
	private String processFile;
	/**
	 * 进程执行文件路径
	 */
	private String processPath;
	/**
	 * 是否系统启动（NMSAgent启动/第三方自己启动）；默认0自启动；1NMSAgent启动
	 */
	private String IsControlStart;
/*	*//**
	 * 是否需下发文件：0需要；1不需要 默认1
	 *//*
	private String isIssueFile;
	*//**
	 * 文件下发是否成功;0成功；1不成功 默认1
	 *//*
	private String isIssued;
	*//**
	 * 是否下发设置：0下发；1未下发 默认值为1如新添加或者修改一项设置之后设置为未下发，需要完成其他配置信息后才执行一次下发
	 *//*
	private String isIssue;*/
	/**
	 * 控制启动时间
	 */
	private Long controlStartTime;
	/**
	 *上传数据时间间隔单位分钟：不能为空，默认15分钟。监测数据上传到NMSServer周期。
	 */
	private Long uploadGap;
	
	/**
	 * 计划检测时间:针对当前配置信息首次执行时间
	 */
	private Long planCheckTime;
	
	/**
	 * 是否预置监测
	 * 监测类型： 0预置监测类型，1三方监测类型，2页面不显示（如snmp_trap）
	 */	
	private String isSchedule;
	
//	private String nodeIP2;
	private String singleNodeId;
	
	/**
	 * 是否SNMP检测  0：objectSNMP  1：SNMP4j
	 */	
	private Long isSNMP;
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public String getCheckTypeName() {
		return checkTypeName;
	}
	public void setCheckTypeName(String checkTypeName) {
		this.checkTypeName = checkTypeName;
	}
	public Long getCheckTypeId() {
		return checkTypeId;
	}
	public Long getCheckMaxTimes() {
		return checkMaxTimes;
	}
	public void setCheckMaxTimes(Long checkMaxTimes) {
		this.checkMaxTimes = checkMaxTimes;
	}
	public Long getCheckGap() {
		return checkGap;
	}
	public void setCheckGap(Long checkGap) {
		this.checkGap = checkGap;
	}
	public Long getCheckOutTime() {
		return checkOutTime;
	}
	public void setCheckOutTime(Long checkOutTime) {
		this.checkOutTime = checkOutTime;
	}
	public String getCheckState() {
		return checkState;
	}
	public void setCheckState(String checkState) {
		this.checkState = checkState;
	}
	public String getProcessIden() {
		return processIden;
	}
	public void setProcessIden(String processIden) {
		this.processIden = processIden;
	}
	public String getProcessFile() {
		return processFile;
	}
	public void setProcessFile(String processFile) {
		this.processFile = processFile;
	}
	public String getProcessPath() {
		return processPath;
	}
	public void setProcessPath(String processPath) {
		this.processPath = processPath;
	}
	public void setCheckTypeId(Long checkTypeId) {
		this.checkTypeId = checkTypeId;
	}
	public String getCheckWay() {
		return checkWay;
	}
	public void setCheckWay(String checkWay) {
		this.checkWay = checkWay;
	}
	
	public String toString() {
		return "id=" + id + ", checkTypeName=" + checkTypeName + ", tableName="
				+ ", checkMaxTimes=" + checkMaxTimes
				+ ", checkGap=" + checkGap + ", checkOutTime=" + checkOutTime
				+ ", checkState=" + checkState + ", checkWay=" + checkWay
				+ ", processFile" + processFile + ", processPath="
				+ processPath;
	}
//	public String getNodeIp() {
//		return nodeIp;
//	}
//	public void setNodeIp(String nodeIp) {
//		this.nodeIp = nodeIp;
//	}
	public String getIsControlStart() {
		return IsControlStart;
	}
	public void setIsControlStart(String isControlStart) {
		IsControlStart = isControlStart;
	}
	public Long getControlStartTime() {
		return controlStartTime;
	}
	public void setControlStartTime(Long controlStartTime) {
		this.controlStartTime = controlStartTime;
	}
	public Long getPlanCheckTime() {
		return planCheckTime;
	}
	public void setPlanCheckTime(Long planCheckTime) {
		this.planCheckTime = planCheckTime;
	}
	public Long getUploadGap() {
		return uploadGap;
	}
	public void setUploadGap(Long uploadGap) {
		this.uploadGap = uploadGap;
	}
	public String getIsSchedule() {
		return isSchedule;
	}
	public void setIsSchedule(String isSchedule) {
		this.isSchedule = isSchedule;
	}
//	public Long getGroupId() {
//		return groupId;
//	}
//	public void setGroupId(Long groupId) {
//		this.groupId = groupId;
//	}
	public Long getIsSNMP() {
		return isSNMP;
	}
	public void setIsSNMP(Long isSNMP) {
		this.isSNMP = isSNMP;
	}
	public String getNodeGroupsId() {
		return nodeGroupsId;
	}
	public void setNodeGroupsId(String nodeGroupsId) {
		this.nodeGroupsId = nodeGroupsId;
	}
	public String getNodeIpsId() {
		return nodeIpsId;
	}
	public void setNodeIpsId(String nodeIpsId) {
		this.nodeIpsId = nodeIpsId;
	}
//	public String getNodeIP2() {
//		return nodeIP2;
//	}
//	public void setNodeIP2(String nodeIP2) {
//		this.nodeIP2 = nodeIP2;
//	}
//	
	public String getSingleNodeId() {
		return singleNodeId;
	}
	public void setSingleNodeId(String singleNodeId) {
		this.singleNodeId = singleNodeId;
	}
	public String getCheckTypeName1() {
		return checkTypeName1;
	}
	public void setCheckTypeName1(String checkTypeName1) {
		this.checkTypeName1 = checkTypeName1;
	}
	public String getProcessIdenName() {
		return processIdenName;
	}
	public void setProcessIdenName(String processIdenName) {
		this.processIdenName = processIdenName;
	}
}
