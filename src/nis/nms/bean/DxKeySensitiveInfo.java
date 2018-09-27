package nis.nms.bean;

import java.util.Date;

public class DxKeySensitiveInfo {
	 private Long id;
	private String url;
	private String title;
	private String summary;
	private String boardName;
	private String interval;
	private Date publicTime;
	private String ip;
	private String shapShotPath;
	private Long shapShotOffset;
	private Long shspShotLen;
	
	public DxKeySensitiveInfo(Long id,String url, String title, String boardName,
			Date publicTime, String ip, String shapShotPath,
			Long shapShotOffset, Long shspShotLen) {
		this.id = id;
		this.url = url;
		this.title = title;
		this.boardName = boardName;
		this.publicTime = publicTime;
		this.ip = ip;
		this.shapShotPath = shapShotPath;
		this.shapShotOffset = shapShotOffset;
		this.shspShotLen = shspShotLen;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getSummary() {
		return summary;
	}
	public void setSummary(String summary) {
		this.summary = summary;
	}
	public String getInterval() {
		return interval;
	}
	public void setInterval(String interval) {
		this.interval = interval;
	}
	public Date getPublicTime() {
		return publicTime;
	}
	public void setPublicTime(Date publicTime) {
		this.publicTime = publicTime;
	}
	public String getIp() {
		return ip;
	}
	public void setIp(String ip) {
		this.ip = ip;
	}
	public String getShapShotPath() {
		return shapShotPath;
	}
	public void setShapShotPath(String shapShotPath) {
		this.shapShotPath = shapShotPath;
	}
	public Long getShapShotOffset() {
		return shapShotOffset;
	}
	public void setShapShotOffset(Long shapShotOffset) {
		this.shapShotOffset = shapShotOffset;
	}
	public Long getShspShotLen() {
		return shspShotLen;
	}
	public void setShspShotLen(Long shspShotLen) {
		this.shspShotLen = shspShotLen;
	}
	public String getBoardName() {
		return boardName;
	}
	public void setBoardName(String boardName) {
		this.boardName = boardName;
	}
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	
}
