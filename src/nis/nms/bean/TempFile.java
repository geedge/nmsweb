package nis.nms.bean;

import java.io.File;

public class TempFile {
	private String fileName = null;
	private File File = null;
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	public File getFile() {
		return File;
	}
	public void setFile(File file) {
		File = file;
	}
}
