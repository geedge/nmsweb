package nis.nms.domains;

import java.util.Date;

/**
 * MissionParameterDefaults entity.
 * 
 * @author MyEclipse Persistence Tools
 */

public class MissionParameterDefaults implements java.io.Serializable {

	// Fields

	private Long id;
	private String missionTypeName;
	private Long missionType;
	private Long viewLevel;
	private Long groupId;
	private Long nodeListId;
	private Long systemId;
	private String targetPath;
	private String checkValue;
	private Date startTime;
	private Date endTime;
	private Long maxReturn;
	private String startFlag;
	private String endFlag;
	private Long loopFlag;
	private Date loopStartDate;
	private Date loopEndDate;
	private Long loopDelay;
	private String filterKeyword;

	// Constructors

	/** default constructor */
	public MissionParameterDefaults() {
	}

	/** full constructor */
	public MissionParameterDefaults(String missionTypeName,
			Long missionType, Long viewLevel, Long groupId,
			Long nodeListId, Long systemId, String targetPath,
			String checkValue, Date startTime, Date endTime, Long maxReturn,
			String startFlag, String endFlag, Long loopFlag,
			Date loopStartDate, Date loopEndDate, Long loopDelay,
			String filterKeyword) {
		this.missionTypeName = missionTypeName;
		this.missionType = missionType;
		this.viewLevel = viewLevel;
		this.groupId = groupId;
		this.nodeListId = nodeListId;
		this.systemId = systemId;
		this.targetPath = targetPath;
		this.checkValue = checkValue;
		this.startTime = startTime;
		this.endTime = endTime;
		this.maxReturn = maxReturn;
		this.startFlag = startFlag;
		this.endFlag = endFlag;
		this.loopFlag = loopFlag;
		this.loopStartDate = loopStartDate;
		this.loopEndDate = loopEndDate;
		this.loopDelay = loopDelay;
		this.filterKeyword = filterKeyword;
	}

	// Property accessors

	public Long getId() {
		return this.id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getMissionTypeName() {
		return this.missionTypeName;
	}

	public void setMissionTypeName(String missionTypeName) {
		this.missionTypeName = missionTypeName;
	}

	public Long getMissionType() {
		return this.missionType;
	}

	public void setMissionType(Long missionType) {
		this.missionType = missionType;
	}

	public Long getViewLevel() {
		return this.viewLevel;
	}

	public void setViewLevel(Long viewLevel) {
		this.viewLevel = viewLevel;
	}

	public Long getGroupId() {
		return this.groupId;
	}

	public void setGroupId(Long groupId) {
		this.groupId = groupId;
	}

	public Long getNodeListId() {
		return this.nodeListId;
	}

	public void setNodeListId(Long nodeListId) {
		this.nodeListId = nodeListId;
	}

	public Long getSystemId() {
		return this.systemId;
	}

	public void setSystemId(Long systemId) {
		this.systemId = systemId;
	}

	public String getTargetPath() {
		return this.targetPath;
	}

	public void setTargetPath(String targetPath) {
		this.targetPath = targetPath;
	}

	public String getCheckValue() {
		return this.checkValue;
	}

	public void setCheckValue(String checkValue) {
		this.checkValue = checkValue;
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

	public Long getMaxReturn() {
		return this.maxReturn;
	}

	public void setMaxReturn(Long maxReturn) {
		this.maxReturn = maxReturn;
	}

	public String getStartFlag() {
		return this.startFlag;
	}

	public void setStartFlag(String startFlag) {
		this.startFlag = startFlag;
	}

	public String getEndFlag() {
		return this.endFlag;
	}

	public void setEndFlag(String endFlag) {
		this.endFlag = endFlag;
	}

	public Long getLoopFlag() {
		return this.loopFlag;
	}

	public void setLoopFlag(Long loopFlag) {
		this.loopFlag = loopFlag;
	}

	public Date getLoopStartDate() {
		return this.loopStartDate;
	}

	public void setLoopStartDate(Date loopStartDate) {
		this.loopStartDate = loopStartDate;
	}

	public Date getLoopEndDate() {
		return this.loopEndDate;
	}

	public void setLoopEndDate(Date loopEndDate) {
		this.loopEndDate = loopEndDate;
	}

	public Long getLoopDelay() {
		return this.loopDelay;
	}

	public void setLoopDelay(Long loopDelay) {
		this.loopDelay = loopDelay;
	}

	public String getFilterKeyword() {
		return this.filterKeyword;
	}

	public void setFilterKeyword(String filterKeyword) {
		this.filterKeyword = filterKeyword;
	}

}