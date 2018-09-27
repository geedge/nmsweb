package nis.nms.domains;

import java.util.Date;

/**
 * DetectInfoSystemDate entity.
 * 
 * @author MyEclipse Persistence Tools
 */

public class DetectInfoSystemDate implements java.io.Serializable {

	// Fields

	private Long id;
	private DetectionInfo detectionInfo;
	private Date serviceDate;
	private Date detectDate;
	private Long timeDelay;
	private Date dataCheckTime;
	private Date dataArriveTime;

	// Constructors

	/** default constructor */
	public DetectInfoSystemDate() {
	}

	/** full constructor */
	public DetectInfoSystemDate(DetectionInfo detectionInfo, Date serviceDate,
			Date detectDate, Long timeDelay, Date dataCheckTime,
			Date dataArriveTime) {
		this.detectionInfo = detectionInfo;
		this.serviceDate = serviceDate;
		this.detectDate = detectDate;
		this.timeDelay = timeDelay;
		this.dataCheckTime = dataCheckTime;
		this.dataArriveTime = dataArriveTime;
	}

	// Property accessors

	public Long getId() {
		return this.id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public DetectionInfo getDetectionInfo() {
		return this.detectionInfo;
	}

	public void setDetectionInfo(DetectionInfo detectionInfo) {
		this.detectionInfo = detectionInfo;
	}

	public Date getServiceDate() {
		return this.serviceDate;
	}

	public void setServiceDate(Date serviceDate) {
		this.serviceDate = serviceDate;
	}

	public Date getDetectDate() {
		return this.detectDate;
	}

	public void setDetectDate(Date detectDate) {
		this.detectDate = detectDate;
	}

	public Long getTimeDelay() {
		return this.timeDelay;
	}

	public void setTimeDelay(Long timeDelay) {
		this.timeDelay = timeDelay;
	}

	public Date getDataCheckTime() {
		return this.dataCheckTime;
	}

	public void setDataCheckTime(Date dataCheckTime) {
		this.dataCheckTime = dataCheckTime;
	}

	public Date getDataArriveTime() {
		return this.dataArriveTime;
	}

	public void setDataArriveTime(Date dataArriveTime) {
		this.dataArriveTime = dataArriveTime;
	}

}