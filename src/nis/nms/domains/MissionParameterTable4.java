package nis.nms.domains;

/**
 * MissionParameterTable4 entity.
 * 
 * @author MyEclipse Persistence Tools
 */

public class MissionParameterTable4 implements java.io.Serializable {

	// Fields

	/**
	 * 
	 */
	private static final long serialVersionUID = -4973199745589122294L;
	private Long missionId;
	private String missionDesc;
	private Long commandType;
	private Long commandId;
	private String commandName;
	private String commandPara;
	private Long filterType;
	private String filterKeyword;
	private Long maxReturn;
	private Long nodeListId;
	private Long version;
	private String nodeListName;
	private String nodeGroupsId;
	private String nodeIpsId;
	private String nodeListName2;
	// Constructors

	private String commandEName;
	
	/** default constructor */
	public MissionParameterTable4() {
	}

	/** minimal constructor */
	public MissionParameterTable4(Long commandType, Long filterType,
			Long maxReturn, Long nodeListId) {
		this.commandType = commandType;
		this.filterType = filterType;
		this.maxReturn = maxReturn;
		this.nodeListId = nodeListId;
	}

	/** full constructor */
	public MissionParameterTable4(String missionDesc, Long commandType,
			Long commandId, String commandPara, Long filterType,
			String filterKeyword, Long maxReturn, Long nodeListId,String nodeGroupsId,String commandEName) {
		this.missionDesc = missionDesc;
		this.commandType = commandType;
		this.commandId = commandId;
		this.commandPara = commandPara;
		this.filterType = filterType;
		this.filterKeyword = filterKeyword;
		this.maxReturn = maxReturn;
		this.nodeListId = nodeListId;
		this.nodeGroupsId = nodeGroupsId;
		this.commandEName = commandEName;
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

	public Long getCommandType() {
		return this.commandType;
	}

	public void setCommandType(Long commandType) {
		this.commandType = commandType;
	}

	public Long getCommandId() {
		return this.commandId;
	}

	public void setCommandId(Long commandId) {
		this.commandId = commandId;
	}

	public String getCommandPara() {
		return this.commandPara;
	}

	public void setCommandPara(String commandPara) {
		this.commandPara = commandPara;
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

	public String getCommandName() {
		return commandName;
	}

	public void setCommandName(String commandName) {
		this.commandName = commandName;
	}

	public Long getVersion() {
		return version;
	}

	public void setVersion(Long version) {
		this.version = version;
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

	public String getCommandEName() {
		return commandEName;
	}

	public void setCommandEName(String commandEName) {
		this.commandEName = commandEName;
	}

}