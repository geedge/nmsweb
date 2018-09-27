package nis.nms.bean;

public class Permisson {
	private String[] dirpath= new String[]{"要指定权限的文件或目录1","要指定权限的文件或目录2"};
	private String permission = "指定权限数字";
	public String[] getDirpath() {
		return dirpath;
	}
	public void setDirpath(String[] dirpath) {
		this.dirpath = dirpath;
	}
	public String getPermission() {
		return permission;
	}
	public void setPermission(String permission) {
		this.permission = permission;
	}
}
