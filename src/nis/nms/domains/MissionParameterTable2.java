package nis.nms.domains;

import java.util.Date;

/**
 * MissionParameterTable2 entity.
 * 
 * @author MyEclipse Persistence Tools
 */

public class MissionParameterTable2 implements java.io.Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 4061216570938158715L;
	// Fields

	private Long missionId;//任务id
	private String missionDesc;//任务描述
	private String filePath;//检测文件路径
	private String startFlag;//起始标志为空表示从文件头开始，支持换行符
	private String endFlag;//结束标志为空表示到文件末尾，支持换行符
	private String filterKeyword;//过滤关键词支持与或表达式
	private Long maxReturn;//返回结果最大长度不能为空，缺省1024，返回结果的最大长度
	private Long nodeListId;//节点组id不能为空外键
	private Long loopFlag;//是否定时任务1是0不是
	private Date loopStartDate;//任务起始时间Loop_flag为1时不能为空
	private Date loopEndDate;//任务结束时间Loop_flag为1时不能为空
	private Long loopDelay;//任务循环周期，单位为分钟Loop_flag为1时不能为空

	// Constructors

	/** default constructor */
	public MissionParameterTable2() {
	}

	/** minimal constructor */
	public MissionParameterTable2(String filePath, Long nodeListId) {
		this.filePath = filePath;
		this.nodeListId = nodeListId;
	}

	/** full constructor */
	public MissionParameterTable2(String missionDesc, String filePath,
			String startFlag, String endFlag, String filterKeyword,
			Long maxReturn, Long nodeListId, Long loopFlag,
			Date loopStartDate, Date loopEndDate, Long loopDelay) {
		this.missionDesc = missionDesc;
		this.filePath = filePath;
		this.startFlag = startFlag;
		this.endFlag = endFlag;
		this.filterKeyword = filterKeyword;
		this.maxReturn = maxReturn;
		this.nodeListId = nodeListId;
		this.loopFlag = loopFlag;
		this.loopStartDate = loopStartDate;
		this.loopEndDate = loopEndDate;
		this.loopDelay = loopDelay;
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

	public Long getLoopFlag() {
		return loopFlag;
	}

	public void setLoopFlag(Long loopFlag) {
		this.loopFlag = loopFlag;
	}

}