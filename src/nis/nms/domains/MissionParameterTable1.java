package nis.nms.domains;

/**
 * MissionParameterTable1 entity.
 * 
 * @author MyEclipse Persistence Tools
 */

public class MissionParameterTable1 implements java.io.Serializable {

	// Fields

	/**
	 * 
	 */
	private static final long serialVersionUID = -2236847794053337210L;
	private Long missionId;//任务id
	private String missionDesc;//任务描述
	private String sourcePath;//源文件路径
	private String targetPath;//目标路径
	private String checkValue;//文件校验值不能为空，初步可以设定文件长度（单位字节）
	private Long nodeListId;//节点组的id
	private Long osLimits;
	private String isCreateCover;
	private String nodeListName;
	private String commandPara;
	private String nodeGroupsId;
	private String nodeIpsId;
	private String nodeListName2;
	// Constructors

	public String getNodeListName2() {
		return nodeListName2;
	}

	public void setNodeListName2(String nodeListName2) {
		this.nodeListName2 = nodeListName2;
	}

	public String getNodeIpsId() {
		return nodeIpsId;
	}

	public void setNodeIpsId(String nodeIpsId) {
		this.nodeIpsId = nodeIpsId;
	}

	public String getCommandPara() {
		return commandPara;
	}

	public void setCommandPara(String commandPara) {
		this.commandPara = commandPara;
	}

	/** default constructor */
	public MissionParameterTable1() {
	}

	/** minimal constructor */
	public MissionParameterTable1(String sourcePath, String targetPath,
			String checkValue) {
		this.sourcePath = sourcePath;
		this.targetPath = targetPath;
		this.checkValue = checkValue;
	}

	/** full constructor */
	public MissionParameterTable1(String missionDesc, String sourcePath,
			String targetPath, String checkValue, Long nodeListId,String nodeGroupsId) {
		this.missionDesc = missionDesc;
		this.sourcePath = sourcePath;
		this.targetPath = targetPath;
		this.checkValue = checkValue;
		this.nodeListId = nodeListId;
		this.nodeGroupsId = nodeGroupsId;
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

	public Long getNodeListId() {
		return this.nodeListId;
	}

	public void setNodeListId(Long nodeListId) {
		this.nodeListId = nodeListId;
	}

	public Long getOsLimits() {
		return osLimits;
	}

	public void setOsLimits(Long osLimits) {
		this.osLimits = osLimits;
	}

	public String getIsCreateCover() {
		return isCreateCover;
	}

	public void setIsCreateCover(String isCreateCover) {
		this.isCreateCover = isCreateCover;
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

}