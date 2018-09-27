package nis.nms.bean;

import java.util.Date;

/**
 * DiSysteminfo entity.
 * 
 * @author MyEclipse Persistence Tools
 */

public class DiSysteminfo implements java.io.Serializable {

	// Fields

	private Long detectionInfoId;
	private String hostName;
	private String operateSystem;
	private Long cpuCnt;
	private Long cpuMhz;
	private Double memorySize;
	private Double swapSize;
	private Double diskSize;
	private Long netCnt;
	private Date dataCheckTime;
	private Date dataArriveTime;
	private String dataCheckTimeStr;
	private String dataArriveTimeStr;
	private Long dataCheckTimeDigital;
	private Long dataArriveTimeDigital;

	// Constructors

	/** default constructor */
	public DiSysteminfo() {
	}

	/** minimal constructor */
	public DiSysteminfo(Long detectionInfoId) {
		this.detectionInfoId = detectionInfoId;
	}

	/** full constructor */
	public DiSysteminfo(Long detectionInfoId,
			String hostName, String operateSystem, Long cpuCnt, Long cpuMhz,
			Double memorySize, Double swapSize, Double diskSize, Long netCnt,
			Date dataCheckTime, Date dataArriveTime, Long dataCheckTimeDigital,
			Long dataArriveTimeDigital) {
		this.detectionInfoId = detectionInfoId;
		this.hostName = hostName;
		this.operateSystem = operateSystem;
		this.cpuCnt = cpuCnt;
		this.cpuMhz = cpuMhz;
		this.memorySize = memorySize;
		this.swapSize = swapSize;
		this.diskSize = diskSize;
		this.netCnt = netCnt;
		this.dataCheckTime = dataCheckTime;
		this.dataArriveTime = dataArriveTime;
		this.dataCheckTimeDigital = dataCheckTimeDigital;
		this.dataArriveTimeDigital = dataArriveTimeDigital;
	}

	// Property accessors

	public Long getDetectionInfoId() {
		return this.detectionInfoId;
	}

	public void setDetectionInfoId(Long detectionInfoId) {
		this.detectionInfoId = detectionInfoId;
	}
	public String getHostName() {
		return this.hostName;
	}

	public void setHostName(String hostName) {
		this.hostName = hostName;
	}

	public String getOperateSystem() {
		return this.operateSystem;
	}

	public void setOperateSystem(String operateSystem) {
		this.operateSystem = operateSystem;
	}

	public Long getCpuCnt() {
		return this.cpuCnt;
	}

	public void setCpuCnt(Long cpuCnt) {
		this.cpuCnt = cpuCnt;
	}

	public Long getCpuMhz() {
		return this.cpuMhz;
	}

	public void setCpuMhz(Long cpuMhz) {
		this.cpuMhz = cpuMhz;
	}


	public Double getMemorySize() {
		return memorySize;
	}

	public void setMemorySize(Double memorySize) {
		this.memorySize = memorySize;
	}

	public Double getSwapSize() {
		return swapSize;
	}

	public void setSwapSize(Double swapSize) {
		this.swapSize = swapSize;
	}

	public Double getDiskSize() {
		return diskSize;
	}

	public void setDiskSize(Double diskSize) {
		this.diskSize = diskSize;
	}

	public Long getNetCnt() {
		return this.netCnt;
	}

	public void setNetCnt(Long netCnt) {
		this.netCnt = netCnt;
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

	public Long getDataCheckTimeDigital() {
		return this.dataCheckTimeDigital;
	}

	public void setDataCheckTimeDigital(Long dataCheckTimeDigital) {
		this.dataCheckTimeDigital = dataCheckTimeDigital;
	}

	public Long getDataArriveTimeDigital() {
		return this.dataArriveTimeDigital;
	}

	public void setDataArriveTimeDigital(Long dataArriveTimeDigital) {
		this.dataArriveTimeDigital = dataArriveTimeDigital;
	}

	public String getDataCheckTimeStr() {
		return dataCheckTimeStr;
	}

	public void setDataCheckTimeStr(String dataCheckTimeStr) {
		this.dataCheckTimeStr = dataCheckTimeStr;
	}

	public String getDataArriveTimeStr() {
		return dataArriveTimeStr;
	}

	public void setDataArriveTimeStr(String dataArriveTimeStr) {
		this.dataArriveTimeStr = dataArriveTimeStr;
	}


}