package nis.nms.domains;

import java.util.Date;

/**
 * DetectInfoPing entity.
 * 
 * @author MyEclipse Persistence Tools
 */

public class DetectInfoPing implements java.io.Serializable {

	// Fields

	private Long id;
	private DetectionInfo detectionInfo;
	private Long packetsSend;
	private Long packetsReceived;
	private Long packetsLost;
	private Long packetsLostRate;
	private Long timeConsumingMin;
	private Long timeConsumingMax;
	private Long timeConsumingAver;
	private Date dataCheckTime;
	private Date dataArriveTime;

	// Constructors

	/** default constructor */
	public DetectInfoPing() {
	}

	/** full constructor */
	public DetectInfoPing(DetectionInfo detectionInfo, Long packetsSend,
			Long packetsReceived, Long packetsLost, Long packetsLostRate,
			Long timeConsumingMin, Long timeConsumingMax,
			Long timeConsumingAver, Date dataCheckTime, Date dataArriveTime) {
		this.detectionInfo = detectionInfo;
		this.packetsSend = packetsSend;
		this.packetsReceived = packetsReceived;
		this.packetsLost = packetsLost;
		this.packetsLostRate = packetsLostRate;
		this.timeConsumingMin = timeConsumingMin;
		this.timeConsumingMax = timeConsumingMax;
		this.timeConsumingAver = timeConsumingAver;
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

	public Long getPacketsSend() {
		return this.packetsSend;
	}

	public void setPacketsSend(Long packetsSend) {
		this.packetsSend = packetsSend;
	}

	public Long getPacketsReceived() {
		return this.packetsReceived;
	}

	public void setPacketsReceived(Long packetsReceived) {
		this.packetsReceived = packetsReceived;
	}

	public Long getPacketsLost() {
		return this.packetsLost;
	}

	public void setPacketsLost(Long packetsLost) {
		this.packetsLost = packetsLost;
	}

	public Long getPacketsLostRate() {
		return this.packetsLostRate;
	}

	public void setPacketsLostRate(Long packetsLostRate) {
		this.packetsLostRate = packetsLostRate;
	}

	public Long getTimeConsumingMin() {
		return this.timeConsumingMin;
	}

	public void setTimeConsumingMin(Long timeConsumingMin) {
		this.timeConsumingMin = timeConsumingMin;
	}

	public Long getTimeConsumingMax() {
		return this.timeConsumingMax;
	}

	public void setTimeConsumingMax(Long timeConsumingMax) {
		this.timeConsumingMax = timeConsumingMax;
	}

	public Long getTimeConsumingAver() {
		return this.timeConsumingAver;
	}

	public void setTimeConsumingAver(Long timeConsumingAver) {
		this.timeConsumingAver = timeConsumingAver;
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