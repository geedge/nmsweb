package nis.nms.domains;

/**
 * MissionParameterTable5 entity.
 * 
 * @author MyEclipse Persistence Tools
 */

public class MissionParameterTable5 implements java.io.Serializable {

	// Fields

	private Long missionId;
	private String missionDesc;
	private Long nodeListId;
	private Long commandId;
	private String commandEName;

	// Constructors

	/** default constructor */
	public MissionParameterTable5() {
	}

	/** minimal constructor */
	public MissionParameterTable5(Long nodeListId, Long commandId) {
		this.nodeListId = nodeListId;
		this.commandId = commandId;
	}

	/** full constructor */
	public MissionParameterTable5(String missionDesc, Long nodeListId,
			Long commandId,String commandEName) {
		this.missionDesc = missionDesc;
		this.nodeListId = nodeListId;
		this.commandId = commandId;
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

	public Long getNodeListId() {
		return this.nodeListId;
	}

	public void setNodeListId(Long nodeListId) {
		this.nodeListId = nodeListId;
	}

	public Long getCommandId() {
		return this.commandId;
	}

	public void setCommandId(Long commandId) {
		this.commandId = commandId;
	}

	public String getCommandEName() {
		return commandEName;
	}

	public void setCommandEName(String commandEName) {
		this.commandEName = commandEName;
	}

}