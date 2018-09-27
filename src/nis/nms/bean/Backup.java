package nis.nms.bean;
public class Backup{
	private String  backup;
	private String  backupTo;
	private String[] except;
	private String exceptTmpStr;
	private String isAbs;

    public Backup() { 
    	
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
	public String getIsAbs() {
		return isAbs;
	}
	public void setIsAbs(String isAbs) {
		this.isAbs = isAbs;
	}
	public String getExceptTmpStr() {
		return exceptTmpStr;
	}
	public void setExceptTmpStr(String exceptTmpStr) {
		this.exceptTmpStr = exceptTmpStr;
	}
	
}