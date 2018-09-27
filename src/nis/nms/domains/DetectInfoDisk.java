package nis.nms.domains;

import java.util.Date;

/**
 * DetectInfoDisk entity.
 * 
 * @author MyEclipse Persistence Tools
 */

public class DetectInfoDisk implements java.io.Serializable {

	// Fields

	private Long id;
	private DetectionInfo detectionInfo;
	private String diskRange;
	private Long totalDiskSize;
	private Long freeDiskSize;
	private Long usedDiskPerc;
	private Date dataCheckTime;
	private Date dataArriveTime;

	// Constructors

	/** default constructor */
	public DetectInfoDisk() {
	}

	/** full constructor */
	public DetectInfoDisk(DetectionInfo detectionInfo, String diskRange,
			Long totalDiskSize, Long freeDiskSize, Long usedDiskPerc,
			Date dataCheckTime, Date dataArriveTime) {
		this.detectionInfo = detectionInfo;
		this.diskRange = diskRange;
		this.totalDiskSize = totalDiskSize;
		this.freeDiskSize = freeDiskSize;
		this.usedDiskPerc = usedDiskPerc;
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

	public String getDiskRange() {
		return this.diskRange;
	}

	public void setDiskRange(String diskRange) {
		this.diskRange = diskRange;
	}

	public Long getTotalDiskSize() {
		return this.totalDiskSize;
	}

	public void setTotalDiskSize(Long totalDiskSize) {
		this.totalDiskSize = totalDiskSize;
	}

	public Long getFreeDiskSize() {
		return this.freeDiskSize;
	}

	public void setFreeDiskSize(Long freeDiskSize) {
		this.freeDiskSize = freeDiskSize;
	}

	public Long getUsedDiskPerc() {
		return this.usedDiskPerc;
	}

	public void setUsedDiskPerc(Long usedDiskPerc) {
		this.usedDiskPerc = usedDiskPerc;
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