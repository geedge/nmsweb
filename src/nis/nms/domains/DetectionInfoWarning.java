package nis.nms.domains;

import java.util.Date;


/**
 * DetectionInfoWarning entity.
 * 
 * @author MyEclipse Persistence Tools
 */

public class DetectionInfoWarning implements java.io.Serializable {

	// Fields

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private Long id;
	private DetectionSetInfo detectionSetInfo;
	private String checkWay;
	private String detectionStateInfo;
	private String performaceData;
	private Long currentTimes;
	private Date startTime;
	private Long waitTime;
	private Long delayTime;
	private Date nextCheckTime;
	private Date offLine;
	private Long policeLevel;
	private Date dataCheckTime;
	private Date dataArriveTime;
	private String noticeFlag;
	private String detectionedState;
	private String noticeInfo;
	private String nodeIp;
	private Date statusChangeTime;
	private Long detectionInfoId;
	private Long seqId;
	private Long valid;
	private String nodeSysType;
	private String nodeType;
	//bgcolor
	private String bgcolor;

	//持续时间
	private String persistTime;
	// Constructors

	/** default constructor */
	public DetectionInfoWarning() {
	}

	/** full constructor */
	public DetectionInfoWarning(DetectionSetInfo detectionSetInfo,
			String checkWay, String detectionStateInfo, String performaceData,
			Long currentTimes, Date startTime, Long waitTime, Long delayTime,
			Date nextCheckTime, Date offLine, Long policeLevel,
			Date dataCheckTime, Date dataArriveTime, String noticeFlag,
			String detectionedState, String noticeInfo, String nodeIp,
			Date statusChangeTime, Long detectionInfoId, Long seqId,
			String nodeSysType, String nodeType) {
		this.detectionSetInfo = detectionSetInfo;
		this.checkWay = checkWay;
		this.detectionStateInfo = detectionStateInfo;
		this.performaceData = performaceData;
		this.currentTimes = currentTimes;
		this.startTime = startTime;
		this.waitTime = waitTime;
		this.delayTime = delayTime;
		this.nextCheckTime = nextCheckTime;
		this.offLine = offLine;
		this.policeLevel = policeLevel;
		this.dataCheckTime = dataCheckTime;
		this.dataArriveTime = dataArriveTime;
		this.noticeFlag = noticeFlag;
		this.detectionedState = detectionedState;
		this.noticeInfo = noticeInfo;
		this.nodeIp = nodeIp;
		this.statusChangeTime = statusChangeTime;
		this.detectionInfoId = detectionInfoId;
		this.seqId=seqId;
		this.nodeSysType = nodeSysType;
		this.nodeType = nodeType;
	}
	public DetectionInfoWarning(Long id, DetectionSetInfo detectionSetInfo,
			String checkWay, String detectionStateInfo, Long currentTimes,
			Date startTime, Long policeLevel, Date dataCheckTime,
			String noticeInfo, String bgcolor, String persistTime,
			String nodeIp, Long seqId, String nodeSysType, String nodeType) {
		this.id= id;
		this.detectionSetInfo = detectionSetInfo;
		this.checkWay = checkWay;
		this.detectionStateInfo = detectionStateInfo;
		this.currentTimes = currentTimes;
		this.startTime = startTime;
		this.policeLevel = policeLevel;
		this.dataCheckTime = dataCheckTime;
		this.noticeInfo = noticeInfo;
		this.bgcolor = bgcolor;
		this.persistTime = persistTime;
		this.nodeIp = nodeIp;
		this.seqId = seqId;
		this.nodeSysType = nodeSysType;
		this.nodeType = nodeType;
	}
	public DetectionInfoWarning(Long id, DetectionSetInfo detectionSetInfo,
			String checkWay, String detectionStateInfo, Long currentTimes,
			Date startTime, Long policeLevel, Date dataCheckTime,
			String noticeInfo, String bgcolor, String persistTime,
			String nodeIp, Long seqId, String nodeSysType, String nodeType,String performaceData) {
		this.id= id;
		this.detectionSetInfo = detectionSetInfo;
		this.checkWay = checkWay;
		this.detectionStateInfo = detectionStateInfo;
		this.currentTimes = currentTimes;
		this.startTime = startTime;
		this.policeLevel = policeLevel;
		this.dataCheckTime = dataCheckTime;
		this.noticeInfo = noticeInfo;
		this.bgcolor = bgcolor;
		this.persistTime = persistTime;
		this.nodeIp = nodeIp;
		this.seqId = seqId;
		this.nodeSysType = nodeSysType;
		this.nodeType = nodeType;
		this.performaceData = performaceData;
	}

	// Property accessors

	public Long getId() {
		return this.id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public DetectionSetInfo getDetectionSetInfo() {
		return this.detectionSetInfo;
	}

	public void setDetectionSetInfo(DetectionSetInfo detectionSetInfo) {
		this.detectionSetInfo = detectionSetInfo;
	}

	public String getCheckWay() {
		return this.checkWay;
	}

	public void setCheckWay(String checkWay) {
		this.checkWay = checkWay;
	}

	public String getDetectionStateInfo() {
		return this.detectionStateInfo;
	}

	public void setDetectionStateInfo(String detectionStateInfo) {
		this.detectionStateInfo = detectionStateInfo;
	}

	public String getPerformaceData() {
		return this.performaceData;
	}

	public void setPerformaceData(String performaceData) {
		this.performaceData = performaceData;
	}

	public Long getCurrentTimes() {
		return this.currentTimes;
	}

	public void setCurrentTimes(Long currentTimes) {
		this.currentTimes = currentTimes;
	}

	public Date getStartTime() {
		return this.startTime;
	}

	public void setStartTime(Date startTime) {
		this.startTime = startTime;
	}

	public Long getWaitTime() {
		return this.waitTime;
	}

	public void setWaitTime(Long waitTime) {
		this.waitTime = waitTime;
	}

	public Long getDelayTime() {
		return this.delayTime;
	}

	public void setDelayTime(Long delayTime) {
		this.delayTime = delayTime;
	}

	public Date getNextCheckTime() {
		return this.nextCheckTime;
	}

	public void setNextCheckTime(Date nextCheckTime) {
		this.nextCheckTime = nextCheckTime;
	}

	public Date getOffLine() {
		return this.offLine;
	}

	public void setOffLine(Date offLine) {
		this.offLine = offLine;
	}

	public Long getPoliceLevel() {
		return this.policeLevel;
	}

	public void setPoliceLevel(Long policeLevel) {
		this.policeLevel = policeLevel;
	}

	public Date getDataArriveTime() {
		return this.dataArriveTime;
	}

	public void setDataArriveTime(Date dataArriveTime) {
		this.dataArriveTime = dataArriveTime;
	}

	public String getNoticeFlag() {
		return this.noticeFlag;
	}

	public void setNoticeFlag(String noticeFlag) {
		this.noticeFlag = noticeFlag;
	}

	public Date getDataCheckTime() {
		return dataCheckTime;
	}

	public void setDataCheckTime(Date dataCheckTime) {
		this.dataCheckTime = dataCheckTime;
	}

	public String getDetectionedState() {
		return detectionedState;
	}

	public void setDetectionedState(String detectionedState) {
		this.detectionedState = detectionedState;
	}

	public String getNoticeInfo() {
		return noticeInfo;
	}

	public void setNoticeInfo(String noticeInfo) {
		this.noticeInfo = noticeInfo;
	}

	public String getNodeIp() {
		return nodeIp;
	}

	public void setNodeIp(String nodeIp) {
		this.nodeIp = nodeIp;
	}

	public Date getStatusChangeTime() {
		return statusChangeTime;
	}

	public void setStatusChangeTime(Date statusChangeTime) {
		this.statusChangeTime = statusChangeTime;
	}

	public String getPersistTime() {
		return persistTime;
	}

	public void setPersistTime(String persistTime) {
		this.persistTime = persistTime;
	}

	public String getBgcolor() {
		return bgcolor;
	}

	public void setBgcolor(String bgcolor) {
		this.bgcolor = bgcolor;
	}

	public Long getDetectionInfoId() {
		return detectionInfoId;
	}

	public void setDetectionInfoId(Long detectionInfoId) {
		this.detectionInfoId = detectionInfoId;
	}

	public Long getSeqId() {
		return seqId;
	}

	public void setSeqId(Long seqId) {
		this.seqId = seqId;
	}

	public String getNodeSysType() {
		return nodeSysType;
	}

	public void setNodeSysType(String nodeSysType) {
		this.nodeSysType = nodeSysType;
	}

	
	public Long getValid()
	{
		return valid;
	}

	
	public void setValid(Long valid)
	{
		this.valid = valid;
	}

	public String getNodeType() {
		return nodeType;
	}

	public void setNodeType(String nodeType) {
		this.nodeType = nodeType;
	}


}