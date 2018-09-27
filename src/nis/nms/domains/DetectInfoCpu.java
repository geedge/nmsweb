package nis.nms.domains;

/**
 * DetectInfoCpu entity.
 * 
 * @author MyEclipse Persistence Tools
 */

public class DetectInfoCpu implements java.io.Serializable {

	// Fields

	private Long id;
	private DetectionInfo detectionInfo;
	private Long userUsedCpuPerc;
	private Long sysUsedCpuPerc;
	private Long waitCpuPerc;
	private Long freeCpuPerc;
	private Long totalUsedPerc;
	private Long nicePerc;

	// Constructors

	/** default constructor */
	public DetectInfoCpu() {
	}

	/** minimal constructor */
	public DetectInfoCpu(DetectionInfo detectionInfo) {
		this.detectionInfo = detectionInfo;
	}

	/** full constructor */
	public DetectInfoCpu(DetectionInfo detectionInfo, Long userUsedCpuPerc,
			Long sysUsedCpuPerc, Long waitCpuPerc, Long freeCpuPerc,
			Long totalUsedPerc, Long nicePerc) {
		this.detectionInfo = detectionInfo;
		this.userUsedCpuPerc = userUsedCpuPerc;
		this.sysUsedCpuPerc = sysUsedCpuPerc;
		this.waitCpuPerc = waitCpuPerc;
		this.freeCpuPerc = freeCpuPerc;
		this.totalUsedPerc = totalUsedPerc;
		this.nicePerc = nicePerc;
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

	public Long getUserUsedCpuPerc() {
		return this.userUsedCpuPerc;
	}

	public void setUserUsedCpuPerc(Long userUsedCpuPerc) {
		this.userUsedCpuPerc = userUsedCpuPerc;
	}

	public Long getSysUsedCpuPerc() {
		return this.sysUsedCpuPerc;
	}

	public void setSysUsedCpuPerc(Long sysUsedCpuPerc) {
		this.sysUsedCpuPerc = sysUsedCpuPerc;
	}

	public Long getWaitCpuPerc() {
		return this.waitCpuPerc;
	}

	public void setWaitCpuPerc(Long waitCpuPerc) {
		this.waitCpuPerc = waitCpuPerc;
	}

	public Long getFreeCpuPerc() {
		return this.freeCpuPerc;
	}

	public void setFreeCpuPerc(Long freeCpuPerc) {
		this.freeCpuPerc = freeCpuPerc;
	}

	public Long getTotalUsedPerc() {
		return this.totalUsedPerc;
	}

	public void setTotalUsedPerc(Long totalUsedPerc) {
		this.totalUsedPerc = totalUsedPerc;
	}

	public Long getNicePerc() {
		return this.nicePerc;
	}

	public void setNicePerc(Long nicePerc) {
		this.nicePerc = nicePerc;
	}

}