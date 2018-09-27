package nis.nms.bean;

import java.util.List;

public class ParamForM6 {
	//-Upgrade 参数
	
	/**
	 * 指定更新需要的文件，如果是相对路径，则相对推送目的地
	 */
	private String fileName;
	/**
	 * 指定文件覆盖目录
	 */
	private String cover;
	/**
	 * 是否创建覆盖目录
	 */
	private String isCreateCover;
	/**
	 * 如果更新源文件是个压缩包：Y 按绝对路径解压即在根目录下解压，N 按进入备份目录解压（这个属性只针对Linux有效，Windows下只按进入备份目录解压）
	 */
	private String isAbs;
	/**
	 * 备份目录，如果是相对路径，则相对覆盖目录
	 */
	private List<Backup> backups;
	/**
	 * 恢复目录
	 */
	private List<CoverUpdate> recoverys;
	/**
	 * 需要删除的目录，如果是相对路径，则相对覆盖目录
	 */
	private String []  delete;
	/**
	 * 进程PID文件全路径
	 */
	private String pidFile;
	/**
	 * 进程启动文件全路径
	 */
	private String startupFile;
	/**
	 * 执行文件的参数序列
	 */
	private String[] execParams;
	/**
	 * 该命令是否强制执行：Y是，N否
	 */
	private String forceExec;
	/**
	 * 最终结果获取最大等待时间（单位：分钟）
	 */
	private String maxWaitTime;
	/**
	 * 文件的属主或运行的用户（只针对Linux有效）
	 */
	private String username;
	/**
	 * 用记密码
	 */
	private String param1;
	/**
	 * 文件的属组（只针对Linux有效）
	 */
	private String groupName;
	/**
	 * 权限设置
	 */
	private String permisson;
	/**
	 * 配合页面修改用的属性
	 */
	private String  deleteTmpStr;
	private String execParamsTmpStr;
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	public String getCover() {
		return cover;
	}
	public void setCover(String cover) {
		this.cover = cover;
	}
	public String getPidFile() {
		return pidFile;
	}
	public void setPidFile(String pidFile) {
		this.pidFile = pidFile;
	}
	public String getStartupFile() {
		return startupFile;
	}
	public void setStartupFile(String startupFile) {
		this.startupFile = startupFile;
	}
	public String[] getDelete() {
		return delete;
	}
	public void setDelete(String[] delete) {
		this.delete = delete;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public List<Backup> getBackups() {
		return backups;
	}
	public void setBackups(List<Backup> backups) {
		this.backups = backups;
	}
	public String getPermisson() {
		return permisson;
	}
	public void setPermisson(String permisson) {
		this.permisson = permisson;
	}
	public String getIsCreateCover() {
		return isCreateCover;
	}
	public void setIsCreateCover(String isCreateCover) {
		this.isCreateCover = isCreateCover;
	}
	public String[] getExecParams() {
		return execParams;
	}
	public void setExecParams(String[] execParams) {
		this.execParams = execParams;
	}
	public String getIsAbs() {
		return isAbs;
	}
	public void setIsAbs(String isAbs) {
		this.isAbs = isAbs;
	}
	public String getForceExec() {
		return forceExec;
	}
	public void setForceExec(String forceExec) {
		this.forceExec = forceExec;
	}
	public String getMaxWaitTime() {
		return maxWaitTime;
	}
	public void setMaxWaitTime(String maxWaitTime) {
		this.maxWaitTime = maxWaitTime;
	}
	public String getGroupName() {
		return groupName;
	}
	public void setGroupName(String groupName) {
		this.groupName = groupName;
	}
	public String getDeleteTmpStr() {
		return deleteTmpStr;
	}
	public void setDeleteTmpStr(String deleteTmpStr) {
		this.deleteTmpStr = deleteTmpStr;
	}
	public String getExecParamsTmpStr() {
		return execParamsTmpStr;
	}
	public void setExecParamsTmpStr(String execParamsTmpStr) {
		this.execParamsTmpStr = execParamsTmpStr;
	}
	
	public List<CoverUpdate> getRecoverys()
	{
		return recoverys;
	}
	
	public void setRecoverys(List<CoverUpdate> recoverys)
	{
		this.recoverys = recoverys;
	}
	public String getParam1() {
		return param1;
	}
	public void setParam1(String param1) {
		this.param1 = param1;
	}
	
}
