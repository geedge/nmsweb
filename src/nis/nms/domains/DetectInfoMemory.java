package nis.nms.domains;

import java.util.Date;

/**
 * DetectInfoMemory entity.
 * 
 * @author MyEclipse Persistence Tools
 */

public class DetectInfoMemory implements java.io.Serializable {

	// Fields

	private Long id;
	private DetectionInfo detectionInfo;
	private Long freeSpaceInpagingFiles;
	private Long sizeStoredinpagingFiles;
	private Long totalMenmorySize;
	private Long usedMenmorySize;
	private Long freeMemorySize;
	private Long usedMemoryPerc;
	private Date dataCheckTime;
	private Date dataArriveTime;

	// Constructors

	/** default constructor */
	public DetectInfoMemory() {
	}

	/** full constructor */
	public DetectInfoMemory(DetectionInfo detectionInfo,
			Long freeSpaceInpagingFiles, Long sizeStoredinpagingFiles,
			Long totalMenmorySize, Long usedMenmorySize, Long freeMemorySize,
			Long usedMemoryPerc, Date dataCheckTime, Date dataArriveTime) {
		this.detectionInfo = detectionInfo;
		this.freeSpaceInpagingFiles = freeSpaceInpagingFiles;
		this.sizeStoredinpagingFiles = sizeStoredinpagingFiles;
		this.totalMenmorySize = totalMenmorySize;
		this.usedMenmorySize = usedMenmorySize;
		this.freeMemorySize = freeMemorySize;
		this.usedMemoryPerc = usedMemoryPerc;
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

	public Long getFreeSpaceInpagingFiles() {
		return this.freeSpaceInpagingFiles;
	}

	public void setFreeSpaceInpagingFiles(Long freeSpaceInpagingFiles) {
		this.freeSpaceInpagingFiles = freeSpaceInpagingFiles;
	}

	public Long getSizeStoredinpagingFiles() {
		return this.sizeStoredinpagingFiles;
	}

	public void setSizeStoredinpagingFiles(Long sizeStoredinpagingFiles) {
		this.sizeStoredinpagingFiles = sizeStoredinpagingFiles;
	}

	public Long getTotalMenmorySize() {
		return this.totalMenmorySize;
	}

	public void setTotalMenmorySize(Long totalMenmorySize) {
		this.totalMenmorySize = totalMenmorySize;
	}

	public Long getUsedMenmorySize() {
		return this.usedMenmorySize;
	}

	public void setUsedMenmorySize(Long usedMenmorySize) {
		this.usedMenmorySize = usedMenmorySize;
	}

	public Long getFreeMemorySize() {
		return this.freeMemorySize;
	}

	public void setFreeMemorySize(Long freeMemorySize) {
		this.freeMemorySize = freeMemorySize;
	}

	public Long getUsedMemoryPerc() {
		return this.usedMemoryPerc;
	}

	public void setUsedMemoryPerc(Long usedMemoryPerc) {
		this.usedMemoryPerc = usedMemoryPerc;
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