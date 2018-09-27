package nis.nms.domains;

import java.util.Date;

/**
 * LoopmissionStateTable entity.
 * 
 * @author MyEclipse Persistence Tools
 */

public class LoopmissionStateTable implements java.io.Serializable {

	// Fields

	private Long curMissionId;
	private Long missionId;
	private Long missionState;
	private Date startTime;
	private Date endTime;
	private String failDesc;

	// Constructors

	/** default constructor */
	public LoopmissionStateTable() {
	}

	/** minimal constructor */
	public LoopmissionStateTable(Long curMissionId, Long missionId,
			Long missionState) {
		this.curMissionId = curMissionId;
		this.missionId = missionId;
		this.missionState = missionState;
	}

	/** full constructor */
	public LoopmissionStateTable(Long curMissionId, Long missionId,
			Long missionState, Date startTime, Date endTime, String failDesc) {
		this.curMissionId = curMissionId;
		this.missionId = missionId;
		this.missionState = missionState;
		this.startTime = startTime;
		this.endTime = endTime;
		this.failDesc = failDesc;
	}

	// Property accessors

	public Long getCurMissionId() {
		return this.curMissionId;
	}

	public void setCurMissionId(Long curMissionId) {
		this.curMissionId = curMissionId;
	}

	public Long getMissionId() {
		return this.missionId;
	}

	public void setMissionId(Long missionId) {
		this.missionId = missionId;
	}

	public Long getMissionState() {
		return this.missionState;
	}

	public void setMissionState(Long missionState) {
		this.missionState = missionState;
	}

	public Date getStartTime() {
		return this.startTime;
	}

	public void setStartTime(Date startTime) {
		this.startTime = startTime;
	}

	public Date getEndTime() {
		return this.endTime;
	}

	public void setEndTime(Date endTime) {
		this.endTime = endTime;
	}

	public String getFailDesc() {
		return this.failDesc;
	}

	public void setFailDesc(String failDesc) {
		this.failDesc = failDesc;
	}

}