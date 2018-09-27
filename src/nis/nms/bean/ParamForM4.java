package nis.nms.bean;

public class ParamForM4 {
	//--可执行命令 参数
	/**
	 * 执行文件或命令
	 */	
	private String execCmd;
	/**
	 * 执行文件或命令的参数序列
	 */
	private String [] execParams;
	private String execParamsTmpStr;
	/**
	 * 该命令是否强制执行：Y是，N否
	 */
	private String forceExec;
	/**
	 * 常驻内存标识: Y是，N否
	 */
	private String residentFlag;
	/**
	 * 存放执行结果标识的文件:1、常驻内存的，写入PID，2、非常驻的，写执行结果：结果标识（0 成功 1 失败）|结果描述
	 */
	private String execResult;
	/**
	 * 回传标识: Y是，N否
	 */
	private String returnFlag;
	/**
	 * 回传文件或目录路径
	 */
	private String returnPath;
	/**
	 * 最终结果获取最大等待时间（单位：分钟）
	 */
	private String maxWaitTime;
	/**
	 * 执行文件或命令的用户名
	 */
	private String username;
	/**
	 * 用户密码
	 */
	private String param1;
	
	//--批量备份
	private String  backup;
	private String  backupTo;
	private String[] except;
	private String exceptTmpStr;
	private String isAbs;
	
	//--批量更新
	private String source;
	private String cover;
	private String isCreateCover;
	private String[] delete;
	private String deleteTmpStr;
	
	//--批量停用
	private String pidFile;
	public String getExecCmd() {
		return execCmd;
	}
	public void setExecCmd(String execCmd) {
		this.execCmd = execCmd;
	}

	public String[] getExecParams() {
		return execParams;
	}
	public void setExecParams(String[] execParams) {
		this.execParams = execParams;
	}
	public String getForceExec() {
		return forceExec;
	}
	public void setForceExec(String forceExec) {
		this.forceExec = forceExec;
	}
	public String getResidentFlag() {
		return residentFlag;
	}
	public void setResidentFlag(String residentFlag) {
		this.residentFlag = residentFlag;
	}
	public String getExecResult() {
		return execResult;
	}
	public void setExecResult(String execResult) {
		this.execResult = execResult;
	}
	public String getReturnFlag() {
		return returnFlag;
	}
	public void setReturnFlag(String returnFlag) {
		this.returnFlag = returnFlag;
	}
	public String getReturnPath() {
		return returnPath;
	}
	public void setReturnPath(String returnPath) {
		this.returnPath = returnPath;
	}
	public String getMaxWaitTime() {
		return maxWaitTime;
	}
	public void setMaxWaitTime(String maxWaitTime) {
		this.maxWaitTime = maxWaitTime;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getBackup() {
		return backup;
	}
	public void setBackup(String backup) {
		this.backup = backup;
	}
	public String getBackupTo() {
		return backupTo;
	}
	public void setBackupTo(String backupTo) {
		this.backupTo = backupTo;
	}
	public String[] getExcept() {
		return except;
	}
	public void setExcept(String[] except) {
		this.except = except;
	}
	public String[] getDelete() {
		return delete;
	}
	public void setDelete(String[] delete) {
		this.delete = delete;
	}
	public String getIsAbs() {
		return isAbs;
	}
	public void setIsAbs(String isAbs) {
		this.isAbs = isAbs;
	}
	public String getSource() {
		return source;
	}
	public void setSource(String source) {
		this.source = source;
	}
	public String getCover() {
		return cover;
	}
	public void setCover(String cover) {
		this.cover = cover;
	}
	public String getIsCreateCover() {
		return isCreateCover;
	}
	public void setIsCreateCover(String isCreateCover) {
		this.isCreateCover = isCreateCover;
	}
	public String getPidFile() {
		return pidFile;
	}
	public void setPidFile(String pidFile) {
		this.pidFile = pidFile;
	}
	public String getExecParamsTmpStr() {
		return execParamsTmpStr;
	}
	public void setExecParamsTmpStr(String execParamsTmpStr) {
		this.execParamsTmpStr = execParamsTmpStr;
	}
	public String getExceptTmpStr() {
		return exceptTmpStr;
	}
	public void setExceptTmpStr(String exceptTmpStr) {
		this.exceptTmpStr = exceptTmpStr;
	}
	public String getDeleteTmpStr() {
		return deleteTmpStr;
	}
	public void setDeleteTmpStr(String deleteTmpStr) {
		this.deleteTmpStr = deleteTmpStr;
	}
	public String getParam1() {
		return param1;
	}
	public void setParam1(String param1) {
		this.param1 = param1;
	}

}
