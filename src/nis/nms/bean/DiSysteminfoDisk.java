package nis.nms.bean;

import java.util.Date;

/**
 * DiSysteminfoDisk entity.
 * 
 * @author MyEclipse Persistence Tools
 */

public class DiSysteminfoDisk implements java.io.Serializable {

	// Fields
	private Long detectionInfoId;
	private String diskRang;
	private Double diskSize;
	private Date dataCheckTime;
	private Date dataArriveTime;
	private Long dataCheckTimeDigital;
	private Long dataArriveTimeDigital;
	public Long getDetectionInfoId() {
		return detectionInfoId;
	}
	public void setDetectionInfoId(Long detectionInfoId) {
		this.detectionInfoId = detectionInfoId;
	}
	public String getDiskRang() {
		return diskRang;
	}
	public void setDiskRang(String diskRang) {
		this.diskRang = diskRang;
	}
	public Double getDiskSize() {
		return diskSize;
	}
	public void setDiskSize(Double diskSize) {
		this.diskSize = diskSize;
	}
	public Date getDataCheckTime() {
		return dataCheckTime;
	}
	public void setDataCheckTime(Date dataCheckTime) {
		this.dataCheckTime = dataCheckTime;
	}
	public Date getDataArriveTime() {
		return dataArriveTime;
	}
	public void setDataArriveTime(Date dataArriveTime) {
		this.dataArriveTime = dataArriveTime;
	}
	public Long getDataCheckTimeDigital() {
		return dataCheckTimeDigital;
	}
	public void setDataCheckTimeDigital(Long dataCheckTimeDigital) {
		this.dataCheckTimeDigital = dataCheckTimeDigital;
	}
	public Long getDataArriveTimeDigital() {
		return dataArriveTimeDigital;
	}
	public void setDataArriveTimeDigital(Long dataArriveTimeDigital) {
		this.dataArriveTimeDigital = dataArriveTimeDigital;
	}

}