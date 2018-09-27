package nis.nms.domains;

import java.util.Date;

/**
 * MissionStateTable entity.
 * 
 * @author MyEclipse Persistence Tools
 */

public class MissionStateTable implements java.io.Serializable {

	// Fields

	/**
	 * 
	 */
	private static final long serialVersionUID = -1342600696641355325L;
	private Long missionId;
	private String missionName;
	private Long missionType;
	private String missionTypeName;
	private Long missionState;
	private Long viewLevel;
	private Long userId;
	private String userIdName;
	private Long groupId;
	private String groupIdName;
	private Date createTime;
	private Date startTime;
	private Date endTime;
	private String failDesc;
	private Long systemId;
	private String  systemIdName;
	private Long loopFlag;
	private Long loopDelay;
	private String contactUserIds;
	private String autoDesc;
	private String missionStateDesc;
	private Long failedCount;
	private String isLook;
	private String lookUserIds;
	// Constructors

	/** default constructor */
	public MissionStateTable() {
	}

	/** minimal constructor */
	public MissionStateTable(String missionName, Long missionType,
			Long missionState, Long viewLevel, Long userId,
			Long groupId,Long loopFlag) {
		this.missionName = missionName;
		this.missionType = missionType;
		this.missionState = missionState;
		this.viewLevel = viewLevel;
		this.userId = userId;
		this.groupId = groupId;
		this.loopFlag = loopFlag;
	}

	/** full constructor */
	public MissionStateTable(String missionName, Long missionType,
			Long missionState, Long viewLevel, Long userId,
			Long groupId, Date createTime, Date startTime, Date endTime,
			String failDesc, Long systemId,Long loopFlag) {
		this.missionName = missionName;
		this.missionType = missionType;
		this.missionState = missionState;
		this.viewLevel = viewLevel;
		this.userId = userId;
		this.groupId = groupId;
		this.createTime = createTime;
		this.startTime = startTime;
		this.endTime = endTime;
		this.failDesc = failDesc;
		this.systemId = systemId;
		this.loopFlag = loopFlag;
	}
	
	/** full constructor */
	public MissionStateTable(String missionName, Long missionType,
			Long missionState, Long viewLevel, Long userId,
			Long groupId, Date createTime, Date startTime, Date endTime,
			String failDesc, Long systemId,Long loopFlag,String isLook,String lookUserIds) {
		this.missionName = missionName;
		this.missionType = missionType;
		this.missionState = missionState;
		this.viewLevel = viewLevel;
		this.userId = userId;
		this.groupId = groupId;
		this.createTime = createTime;
		this.startTime = startTime;
		this.endTime = endTime;
		this.failDesc = failDesc;
		this.systemId = systemId;
		this.loopFlag = loopFlag;
		this.isLook = isLook;
		this.lookUserIds = lookUserIds;
	}

	// Property accessors

	public Long getMissionId() {
		return this.missionId;
	}

	public void setMissionId(Long missionId) {
		this.missionId = missionId;
	}

	public String getMissionName() {
		if(this.missionName!=null&&!"".equals(this.missionName)){
			return  this.missionName.trim();
		}else{
			return this.missionName;
		}
	}

	public void setMissionName(String missionName) {
		this.missionName = missionName;
	}

	public Long getMissionType() {
		return this.missionType;
	}

	public void setMissionType(Long missionType) {
		this.missionType = missionType;
	}

	public Long getMissionState() {
		return this.missionState;
	}

	public void setMissionState(Long missionState) {
		this.missionState = missionState;
	}

	public Long getViewLevel() {
		return this.viewLevel;
	}

	public void setViewLevel(Long viewLevel) {
		this.viewLevel = viewLevel;
	}

	public Long getUserId() {
		return this.userId;
	}

	public void setUserId(Long userId) {
		this.userId = userId;
	}

	public Long getGroupId() {
		return this.groupId;
	}

	public void setGroupId(Long groupId) {
		this.groupId = groupId;
	}

	public Date getCreateTime() {
		return this.createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
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
		if(this.failDesc!=null&&!"".equals(this.failDesc)){
			return this.failDesc.trim();
		}else{
			return this.failDesc;
		}
		
	}

	public void setFailDesc(String failDesc) {
		this.failDesc = failDesc;
	}

	public Long getSystemId() {
		return this.systemId;
	}

	public void setSystemId(Long systemId) {
		this.systemId = systemId;
	}

	public String getGroupIdName() {
		if(this.groupIdName!=null&&!"".equals(this.groupIdName)){
			return this.groupIdName.trim();
		}else{
			return this.groupIdName;
		}
	}

	public void setGroupIdName(String groupIdName) {
		this.groupIdName = groupIdName;
	}

	public String getSystemIdName() {
		return systemIdName;
	}

	public void setSystemIdName(String systemIdName) {
		this.systemIdName = systemIdName;
	}

	public String getUserIdName() {
		return userIdName;
	}

	public void setUserIdName(String userIdName) {
		this.userIdName = userIdName;
	}

	public String getMissionTypeName() {
		return missionTypeName;
	}

	public void setMissionTypeName(String missionTypeName) {
		this.missionTypeName = missionTypeName;
	}

	public Long getLoopFlag() {
		return loopFlag;
	}

	public void setLoopFlag(Long loopFlag) {
		this.loopFlag = loopFlag;
	}

	public Long getLoopDelay() {
		return loopDelay;
	}

	public void setLoopDelay(Long loopDelay) {
		this.loopDelay = loopDelay;
	}

	public String getContactUserIds() {
		return contactUserIds;
	}

	public void setContactUserIds(String contactUserIds) {
		this.contactUserIds = contactUserIds;
	}

	public Long getFailedCount() {
		return failedCount;
	}

	public void setFailedCount(Long failedCount) {
		this.failedCount = failedCount;
	}

	public String getAutoDesc() {
		return autoDesc;
	}

	public void setAutoDesc(String autoDesc) {
		this.autoDesc = autoDesc;
	}

	public String getIsLook() {
		return isLook;
	}

	public String getMissionStateDesc()
	{
		return missionStateDesc;
	}

	public void setIsLook(String isLook) {
		this.isLook = isLook;
	}

	public void setMissionStateDesc(String missionStateDesc)
	{
		this.missionStateDesc = missionStateDesc;
	}

	public String getLookUserIds() {
		return lookUserIds;
	}

	public void setLookUserIds(String lookUserIds) {
		this.lookUserIds = lookUserIds;
	}
}