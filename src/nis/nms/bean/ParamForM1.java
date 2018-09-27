package nis.nms.bean;

public class ParamForM1 {
	//-Upgrade 参数
	/**
	 * 推送文件名
	 */
	private String fileName;
	/**
	 * 推送目的地
	 */
	private String destPath;
	/**
	 * 推送文件的MD5值
	 */
	private String md5Value;
	/**
	 * 是否覆盖：Y是，N否
	 */
	private String isCover;
	/**
	 * 推送文件的属主（只针对Linux有效）
	 */
	private String username;
	/**
	 * 属主密码
	 */
	private String param1;
	/**
	 * 推送文件的属群（只针对Linux有效）
	 */
	private String groupName;
	/**
	 * 推送文件拥有的权限（只针对Linux有效）
	 */
	private String permisson;
	
	public ParamForM1() {
		super();
	}
	
	public ParamForM1(String fileName, String destPath, String md5Value,
			String isCover, String username, String groupName, String permisson) {
		super();
		this.fileName = fileName;
		this.destPath = destPath;
		this.md5Value = md5Value;
		this.isCover = isCover;
		this.username = username;
		this.groupName = groupName;
		this.permisson = permisson;
	}
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	public String getDestPath() {
		return destPath;
	}
	public void setDestPath(String destPath) {
		this.destPath = destPath;
	}
	public String getMd5Value() {
		return md5Value;
	}
	public void setMd5Value(String md5Value) {
		this.md5Value = md5Value;
	}
	public String getIsCover() {
		return isCover;
	}
	public void setIsCover(String isCover) {
		this.isCover = isCover;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getPermisson() {
		return permisson;
	}
	public void setPermisson(String permisson) {
		this.permisson = permisson;
	}
	public String getGroupName() {
		return groupName;
	}
	public void setGroupName(String groupName) {
		this.groupName = groupName;
	}

	public String getParam1() {
		return param1;
	}

	public void setParam1(String param1) {
		this.param1 = param1;
	}
	
}
