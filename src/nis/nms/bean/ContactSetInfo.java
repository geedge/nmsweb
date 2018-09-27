package nis.nms.bean;

import java.util.Date;


/**
 * 客户端用到的监测设置信息实体
 * 
 */
public class ContactSetInfo {

	/**
	 * 监测设置信息ID
	 */
	private Long missionId; 
	private String missionName; 
	private String nodeGroupName; 
	private String nodeGroupsId; 
	private String nodeIpsId; 
	private String nodeIpsName; 
	private Long missionType; 
	private Long missionState; 
	private Long isLoop; 
	private Date startTime; 
	private Date endTime; 
	private Long viewLevel; 
	private Long createUserId; 
	private Long createUserGroupId; 
	private Long systemId; 
	private String contactUserIds;
	public Long getViewLevel() {
		return viewLevel;
	}
	public void setViewLevel(Long viewLevel) {
		this.viewLevel = viewLevel;
	}
	public Long getCreateUserId() {
		return createUserId;
	}
	public void setCreateUserId(Long createUserId) {
		this.createUserId = createUserId;
	}
	public Long getCreateUserGroupId() {
		return createUserGroupId;
	}
	public void setCreateUserGroupId(Long createUserGroupId) {
		this.createUserGroupId = createUserGroupId;
	}
	public Long getSystemId() {
		return systemId;
	}
	public void setSystemId(Long systemId) {
		this.systemId = systemId;
	}
	public String getContactUserIds() {
		return contactUserIds;
	}
	public void setContactUserIds(String contactUserIds) {
		this.contactUserIds = contactUserIds;
	}
	public Long getMissionId() {
		return missionId;
	}
	public void setMissionId(Long missionId) {
		this.missionId = missionId;
	}
	public String getMissionName() {
		return missionName;
	}
	public void setMissionName(String missionName) {
		this.missionName = missionName;
	}
	public String getNodeGroupName() {
		return nodeGroupName;
	}
	public void setNodeGroupName(String nodeGroupName) {
		this.nodeGroupName = nodeGroupName;
	}
	public Long getMissionType() {
		return missionType;
	}
	public void setMissionType(Long missionType) {
		this.missionType = missionType;
	}
	public Long getMissionState() {
		return missionState;
	}
	public void setMissionState(Long missionState) {
		this.missionState = missionState;
	}
	public Long getIsLoop() {
		return isLoop;
	}
	public void setIsLoop(Long isLoop) {
		this.isLoop = isLoop;
	}
	public Date getStartTime() {
		return startTime;
	}
	public void setStartTime(Date startTime) {
		this.startTime = startTime;
	}
	public Date getEndTime() {
		return endTime;
	}
	public void setEndTime(Date endTime) {
		this.endTime = endTime;
	}
	public String getNodeGroupsId() {
		return nodeGroupsId;
	}
	public void setNodeGroupsId(String nodeGroupsId) {
		this.nodeGroupsId = nodeGroupsId;
	}
	public String getNodeIpsId() {
		return nodeIpsId;
	}
	public void setNodeIpsId(String nodeIpsId) {
		this.nodeIpsId = nodeIpsId;
	}
	public String getNodeIpsName() {
		return nodeIpsName;
	}
	public void setNodeIpsName(String nodeIpsName) {
		this.nodeIpsName = nodeIpsName;
	} 
}
