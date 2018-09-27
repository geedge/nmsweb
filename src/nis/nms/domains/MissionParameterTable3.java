package nis.nms.domains;

/**
 * MissionParameterTable3 entity.
 * 
 * @author MyEclipse Persistence Tools
 */

public class MissionParameterTable3 implements java.io.Serializable {

	// Fields

	private Long missionId;
	private String missionDesc;
	private String filePath;
	private Long timeFormat;
	private Long startTime;
	private Long endTime;
	private Long filterType;
	private String filterKeyword;
	private Long maxReturn;
	private Long nodeListId;

	// Constructors

	/** default constructor */
	public MissionParameterTable3() {
	}

	/** minimal constructor */
	public MissionParameterTable3(String filePath, Long filterType,
			Long maxReturn, Long nodeListId) {
		this.filePath = filePath;
		this.filterType = filterType;
		this.maxReturn = maxReturn;
		this.nodeListId = nodeListId;
	}

	/** full constructor */
	public MissionParameterTable3(String missionDesc, String filePath,
			Long timeFormat, Long startTime, Long endTime, Long filterType,
			String filterKeyword, Long maxReturn, Long nodeListId) {
		this.missionDesc = missionDesc;
		this.filePath = filePath;
		this.timeFormat = timeFormat;
		this.startTime = startTime;
		this.endTime = endTime;
		this.filterType = filterType;
		this.filterKeyword = filterKeyword;
		this.maxReturn = maxReturn;
		this.nodeListId = nodeListId;
	}

	// Property accessors

	public Long getMissionId() {
		return this.missionId;
	}

	public void setMissionId(Long missionId) {
		this.missionId = missionId;
	}

	public String getMissionDesc() {
		return this.missionDesc;
	}

	public void setMissionDesc(String missionDesc) {
		this.missionDesc = missionDesc;
	}

	public String getFilePath() {
		return this.filePath;
	}

	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}

	public Long getTimeFormat() {
		return this.timeFormat;
	}

	public void setTimeFormat(Long timeFormat) {
		this.timeFormat = timeFormat;
	}

	public Long getStartTime() {
		return this.startTime;
	}

	public void setStartTime(Long startTime) {
		this.startTime = startTime;
	}

	public Long getEndTime() {
		return this.endTime;
	}

	public void setEndTime(Long endTime) {
		this.endTime = endTime;
	}

	public Long getFilterType() {
		return this.filterType;
	}

	public void setFilterType(Long filterType) {
		this.filterType = filterType;
	}

	public String getFilterKeyword() {
		return this.filterKeyword;
	}

	public void setFilterKeyword(String filterKeyword) {
		this.filterKeyword = filterKeyword;
	}

	public Long getMaxReturn() {
		return this.maxReturn;
	}

	public void setMaxReturn(Long maxReturn) {
		this.maxReturn = maxReturn;
	}

	public Long getNodeListId() {
		return this.nodeListId;
	}

	public void setNodeListId(Long nodeListId) {
		this.nodeListId = nodeListId;
	}

}