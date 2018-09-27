package nis.nms.domains;

import java.util.Date;

/**
 * DetectionInfo entity.
 * 
 * @author MyEclipse Persistence Tools
 */

public class DetectionInfo implements java.io.Serializable {

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
	private String nodeIp;
	private String detectionedState;
	private Date datacheckTime;
	private Date dataArriveTime;
	
	// Constructors

	/** default constructor */
	public DetectionInfo() {
	}

	/** full constructor */
	public DetectionInfo(DetectionSetInfo detectionSetInfo, String checkWay,
			String detectionStateInfo, String performaceData,
			Long currentTimes, Date startTime, Long waitTime, Long delayTime,
			Date nextCheckTime, Date offLine, Long policeLevel,
			Date datacheckTime, Date dataArriveTime,String nodeIp,String detectionedState) {
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
		this.nodeIp = nodeIp;
		this.detectionedState = detectionedState;
		this.datacheckTime = datacheckTime;
		this.dataArriveTime = dataArriveTime;
		
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

	public String getNodeIp() {
		return nodeIp;
	}

	public void setNodeIp(String nodeIp) {
		this.nodeIp = nodeIp;
	}

	public String getDetectionedState() {
		return detectionedState;
	}

	public void setDetectionedState(String detectionedState) {
		this.detectionedState = detectionedState;
	}

	public Date getDatacheckTime() {
		return datacheckTime;
	}

	public void setDatacheckTime(Date datacheckTime) {
		this.datacheckTime = datacheckTime;
	}


}