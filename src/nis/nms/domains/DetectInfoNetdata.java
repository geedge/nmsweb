package nis.nms.domains;

import java.util.Date;

/**
 * DetectInfoNetdata entity.
 * 
 * @author MyEclipse Persistence Tools
 */

public class DetectInfoNetdata implements java.io.Serializable {

	// Fields

	private Long id;
	private DetectionInfo detectionInfo;
	private Long rxPackets;
	private Long txPackets;
	private Long rxBytes;
	private Long txBytes;
	private Long rxErrors;
	private Long txErrors;
	private Long rxDropped;
	private Long txDropped;
	private Date dataCheckTime;
	private Date dataArriveTime;

	// Constructors

	/** default constructor */
	public DetectInfoNetdata() {
	}

	/** minimal constructor */
	public DetectInfoNetdata(DetectionInfo detectionInfo) {
		this.detectionInfo = detectionInfo;
	}

	/** full constructor */
	public DetectInfoNetdata(DetectionInfo detectionInfo, Long rxPackets,
			Long txPackets, Long rxBytes, Long txBytes, Long rxErrors,
			Long txErrors, Long rxDropped, Long txDropped, Date dataCheckTime,
			Date dataArriveTime) {
		this.detectionInfo = detectionInfo;
		this.rxPackets = rxPackets;
		this.txPackets = txPackets;
		this.rxBytes = rxBytes;
		this.txBytes = txBytes;
		this.rxErrors = rxErrors;
		this.txErrors = txErrors;
		this.rxDropped = rxDropped;
		this.txDropped = txDropped;
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

	public Long getRxPackets() {
		return this.rxPackets;
	}

	public void setRxPackets(Long rxPackets) {
		this.rxPackets = rxPackets;
	}

	public Long getTxPackets() {
		return this.txPackets;
	}

	public void setTxPackets(Long txPackets) {
		this.txPackets = txPackets;
	}

	public Long getRxBytes() {
		return this.rxBytes;
	}

	public void setRxBytes(Long rxBytes) {
		this.rxBytes = rxBytes;
	}

	public Long getTxBytes() {
		return this.txBytes;
	}

	public void setTxBytes(Long txBytes) {
		this.txBytes = txBytes;
	}

	public Long getRxErrors() {
		return this.rxErrors;
	}

	public void setRxErrors(Long rxErrors) {
		this.rxErrors = rxErrors;
	}

	public Long getTxErrors() {
		return this.txErrors;
	}

	public void setTxErrors(Long txErrors) {
		this.txErrors = txErrors;
	}

	public Long getRxDropped() {
		return this.rxDropped;
	}

	public void setRxDropped(Long rxDropped) {
		this.rxDropped = rxDropped;
	}

	public Long getTxDropped() {
		return this.txDropped;
	}

	public void setTxDropped(Long txDropped) {
		this.txDropped = txDropped;
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