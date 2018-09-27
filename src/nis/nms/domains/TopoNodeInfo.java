package nis.nms.domains;

import java.io.Serializable;
import java.util.Date;

public class TopoNodeInfo implements Serializable{
	private Long id;
	private TopoImg topoImg;
	private TopoInfo topoInfo;
	private Long type;
	private Long typeId;
	private Long x;
	private Long y;
	private Long width;
	private Long height;
	private Date createTime;
	private Long createUser;
	private Date updateTime;
	private Long updateUser;
	private String text;
	private TopoConInfo topoConInfo;
	private String topoNodeInfoClass;
	private String alarm;
	private int status;
	private double warningCount;
	private Double thresholdValue;
	public TopoNodeInfo() {
		
	}

	public TopoNodeInfo(Long id, TopoImg topoImg, TopoInfo topoInfo, Long type, Long typeId, Long x, Long y, Long width,
			Long height, Date createTime, Long createUser, Date updateTime, Long updateUser, String text,
			TopoConInfo topoConInfo, String topoNodeInfoClass, String alarm, int status, double warningCount) {
		super();
		this.id = id;
		this.topoImg = topoImg;
		this.topoInfo = topoInfo;
		this.type = type;
		this.typeId = typeId;
		this.x = x;
		this.y = y;
		this.width = width;
		this.height = height;
		this.createTime = createTime;
		this.createUser = createUser;
		this.updateTime = updateTime;
		this.updateUser = updateUser;
		this.text = text;
		this.topoConInfo = topoConInfo;
		this.topoNodeInfoClass = topoNodeInfoClass;
		this.alarm = alarm;
		this.status = status;
		this.warningCount = warningCount;
	}

	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public TopoImg getTopoImg() {
		return topoImg;
	}
	public void setTopoImg(TopoImg topoImg) {
		this.topoImg = topoImg;
	}
	public TopoInfo getTopoInfo() {
		return topoInfo;
	}
	public void setTopoInfo(TopoInfo topoInfo) {
		this.topoInfo = topoInfo;
	}
	public Long getType() {
		return type;
	}
	public void setType(Long type) {
		this.type = type;
	}
	public Long getTypeId() {
		return typeId;
	}
	public void setTypeId(Long typeId) {
		this.typeId = typeId;
	}
	public Long getX() {
		return x;
	}
	public void setX(Long x) {
		this.x = x;
	}
	public Long getY() {
		return y;
	}
	public void setY(Long y) {
		this.y = y;
	}
	public Long getWidth() {
		return width;
	}
	public void setWidth(Long width) {
		this.width = width;
	}
	public Long getHeight() {
		return height;
	}
	public void setHeight(Long height) {
		this.height = height;
	}
	public Date getCreateTime() {
		return createTime;
	}
	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}
	public Long getCreateUser() {
		return createUser;
	}
	public void setCreateUser(Long createUser) {
		this.createUser = createUser;
	}
	public Date getUpdateTime() {
		return updateTime;
	}
	public void setUpdateTime(Date updateTime) {
		this.updateTime = updateTime;
	}
	public Long getUpdateUser() {
		return updateUser;
	}
	public void setUpdateUser(Long updateUser) {
		this.updateUser = updateUser;
	}
	public String getText() {
		return text;
	}
	public void setText(String text) {
		this.text = text;
	}
	public TopoConInfo getTopoConInfo() {
		return topoConInfo;
	}
	public void setTopoConInfo(TopoConInfo topoConInfo) {
		this.topoConInfo = topoConInfo;
	}
	public String getTopoNodeInfoClass() {
		return topoNodeInfoClass;
	}
	public void setTopoNodeInfoClass(String topoNodeInfoClass) {
		this.topoNodeInfoClass = topoNodeInfoClass;
	}

	public String getAlarm() {
		return alarm;
	}

	public void setAlarm(String alarm) {
		this.alarm = alarm;
	}


	public int getStatus() {
		return status;
	}


	public void setStatus(int status) {
		this.status = status;
	}

	public double getWarningCount() {
		return warningCount;
	}

	public void setWarningCount(double warningCount) {
		this.warningCount = warningCount;
	}

	public Double getThresholdValue() {
		return thresholdValue;
	}

	public void setThresholdValue(Double thresholdValue) {
		this.thresholdValue = thresholdValue;
	}
	
}
