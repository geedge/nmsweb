package nis.nms.bean;

import java.util.Date;

/**
 * DiSysteminfoNet entity.
 * 
 * @author MyEclipse Persistence Tools
 */

public class DiSysteminfoNet implements java.io.Serializable {

	// Fields

	private Long detectionInfoId;
	private String netName;
	private String netState;
	private Long netSpeed;
	private String netIp;
	private String netSubmask;
	private String netGateway;
	private String netMac;
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
	public String getNetName() {
		return netName;
	}
	public void setNetName(String netName) {
		this.netName = netName;
	}
	public String getNetState() {
		return netState;
	}
	public void setNetState(String netState) {
		this.netState = netState;
	}
	public Long getNetSpeed() {
		return netSpeed;
	}
	public void setNetSpeed(Long netSpeed) {
		this.netSpeed = netSpeed;
	}
	public String getNetIp() {
		return netIp;
	}
	public void setNetIp(String netIp) {
		this.netIp = netIp;
	}
	public String getNetSubmask() {
		return netSubmask;
	}
	public void setNetSubmask(String netSubmask) {
		this.netSubmask = netSubmask;
	}
	public String getNetGateway() {
		return netGateway;
	}
	public void setNetGateway(String netGateway) {
		this.netGateway = netGateway;
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
	public String getNetMac() {
		return netMac;
	}
	public void setNetMac(String netMac) {
		this.netMac = netMac;
	}

}