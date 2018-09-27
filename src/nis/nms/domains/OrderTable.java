package nis.nms.domains;

/**
 * OrderTable entity.
 * 
 * @author MyEclipse Persistence Tools
 */

public class OrderTable implements java.io.Serializable {

	// Fields

	private Long commandId;
	private String commandName;
	private String commandDesc;
	private Long commandType;
	private String commandFlag;
	private String shellPath;
	private String shellCheck;
	private Long isValid;
	private String commandModel;
	private String commandAlias;
	// Constructors

	public String getCommandModel() {
		return commandModel;
	}

	public void setCommandModel(String commandModel) {
		this.commandModel = commandModel;
	}

	/** default constructor */
	public OrderTable() {
	}

	/** minimal constructor */
	public OrderTable(String commandName, Long commandType, String commandFlag,
			Long isValid) {
		this.commandName = commandName;
		this.commandType = commandType;
		this.commandFlag = commandFlag;
		this.isValid = isValid;
	}

	/** full constructor */
	public OrderTable(String commandName, String commandDesc, Long commandType,
			String commandFlag, String shellPath, String shellCheck,
			Long isValid) {
		this.commandName = commandName;
		this.commandDesc = commandDesc;
		this.commandType = commandType;
		this.commandFlag = commandFlag;
		this.shellPath = shellPath;
		this.shellCheck = shellCheck;
		this.isValid = isValid;
	}

	// Property accessors

	public Long getCommandId() {
		return this.commandId;
	}

	public void setCommandId(Long commandId) {
		this.commandId = commandId;
	}

	public String getCommandName() {
		return this.commandName;
	}

	public void setCommandName(String commandName) {
		this.commandName = commandName;
	}

	public String getCommandDesc() {
		return this.commandDesc;
	}

	public void setCommandDesc(String commandDesc) {
		this.commandDesc = commandDesc;
	}

	public Long getCommandType() {
		return this.commandType;
	}

	public void setCommandType(Long commandType) {
		this.commandType = commandType;
	}

	public String getCommandFlag() {
		return this.commandFlag;
	}

	public void setCommandFlag(String commandFlag) {
		this.commandFlag = commandFlag;
	}

	public String getShellPath() {
		return this.shellPath;
	}

	public void setShellPath(String shellPath) {
		this.shellPath = shellPath;
	}

	public String getShellCheck() {
		return this.shellCheck;
	}

	public void setShellCheck(String shellCheck) {
		this.shellCheck = shellCheck;
	}

	public Long getIsValid() {
		return this.isValid;
	}

	public void setIsValid(Long isValid) {
		this.isValid = isValid;
	}

	public String getCommandAlias() {
		return commandAlias;
	}

	public void setCommandAlias(String commandAlias) {
		this.commandAlias = commandAlias;
	}

}