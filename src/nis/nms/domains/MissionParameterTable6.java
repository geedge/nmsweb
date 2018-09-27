package nis.nms.domains;

import java.util.Date;

/**
 * MissionParameterTable6 entity.
 * 
 * @author MyEclipse Persistence Tools
 */

public class MissionParameterTable6 implements java.io.Serializable {

	// Fields

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private long missionId;
	private String missionDesc;
	private long commandType;
	private long commandId;
	private String commandName;
	private String commandPara;
	private long nodeListId;
	private String nodeListName;	//节点组名称
	private String sourcePath;
	private String targetPath;
	private String checkValue;
	private Date startTime;
	private Long version;
	private String nodeGroupsId;
	private String nodeIpsId;
	private String nodeListName2;	//节点名称
	private Long oldTaskId;
	// Constructors
	private String commandEName;
	/** default constructor */
	public MissionParameterTable6() {
	}

	/** full constructor */
	public MissionParameterTable6(String missionDesc, long commandType,
			long commandId, String commandPara, long nodeListId,
			String sourcePath, String targetPath, String checkValue,
			Date startTime, long version,String nodeGroupsId,String commandEName) {
		this.missionDesc = missionDesc;
		this.commandType = commandType;
		this.commandId = commandId;
		this.commandPara = commandPara;
		this.nodeListId = nodeListId;
		this.sourcePath = sourcePath;
		this.targetPath = targetPath;
		this.checkValue = checkValue;
		this.startTime = startTime;
		this.version = version;
		this.nodeGroupsId = nodeGroupsId;
		this.commandEName = commandEName;
	}

	// Property accessors

	public long getMissionId() {
		return this.missionId;
	}

	public void setMissionId(long missionId) {
		this.missionId = missionId;
	}

	public String getMissionDesc() {
		return this.missionDesc;
	}

	public void setMissionDesc(String missionDesc) {
		this.missionDesc = missionDesc;
	}

	public long getCommandType() {
		return this.commandType;
	}

	public void setCommandType(long commandType) {
		this.commandType = commandType;
	}

	public long getCommandId() {
		return this.commandId;
	}

	public void setCommandId(long commandId) {
		this.commandId = commandId;
	}

	public String getCommandPara() {
		return this.commandPara;
	}

	public void setCommandPara(String commandPara) {
		this.commandPara = commandPara;
	}

	public long getNodeListId() {
		return this.nodeListId;
	}

	public void setNodeListId(long nodeListId) {
		this.nodeListId = nodeListId;
	}

	public String getSourcePath() {
		return this.sourcePath;
	}

	public void setSourcePath(String sourcePath) {
		this.sourcePath = sourcePath;
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

	public Long getVersion() {
		return this.version;
	}

	public void setVersion(Long version) {
		this.version = version;
	}

	public String getCommandName() {
		return commandName;
	}

	public void setCommandName(String commandName) {
		this.commandName = commandName;
	}

	public String getNodeListName() {
		return nodeListName;
	}

	public void setNodeListName(String nodeListName) {
		this.nodeListName = nodeListName;
	}

	
	public String getNodeGroupsId()
	{
		return nodeGroupsId;
	}

	
	public void setNodeGroupsId(String nodeGroupsId)
	{
		this.nodeGroupsId = nodeGroupsId;
	}

	public String getNodeIpsId() {
		return nodeIpsId;
	}

	public void setNodeIpsId(String nodeIpsId) {
		this.nodeIpsId = nodeIpsId;
	}

	public String getNodeListName2() {
		return nodeListName2;
	}

	public void setNodeListName2(String nodeListName2) {
		this.nodeListName2 = nodeListName2;
	}

	public Long getOldTaskId() {
		return oldTaskId;
	}

	public void setOldTaskId(Long oldTaskId) {
		this.oldTaskId = oldTaskId;
	}

	public String getCommandEName() {
		return commandEName;
	}

	public void setCommandEName(String commandEName) {
		this.commandEName = commandEName;
	}
}