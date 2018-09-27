package nis.nms.domains;

import java.io.Serializable;
import java.util.Date;

public class TopoInfo implements Serializable{
	private Long id;
	private String name;
	private Long systemId;
	private Long width;
	private Long height;
	private String topoInfoClass;
	private Date createTime;
	private Long createUser;
	private Date updateTime;
	private Long updateUser;
	private String remarks;
	private Long threshold;
	private Long flag;
	
	
	
	public TopoInfo() {
		
	}
	
	public TopoInfo(Long id, String name, Long systemId, Long width, Long height, String topoInfoClass, Date createTime,
			Long createUser, Date updateTime, Long updateUser, String remarks, Long threshold, Long flag) {
		super();
		this.id = id;
		this.name = name;
		this.systemId = systemId;
		this.width = width;
		this.height = height;
		this.topoInfoClass = topoInfoClass;
		this.createTime = createTime;
		this.createUser = createUser;
		this.updateTime = updateTime;
		this.updateUser = updateUser;
		this.remarks = remarks;
		this.threshold = threshold;
		this.flag = flag;
	}

	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public Long getSystemId() {
		return systemId;
	}
	public void setSystemId(Long systemId) {
		this.systemId = systemId;
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
	public String getTopoInfoClass() {
		return topoInfoClass;
	}
	public void setTopoInfoClass(String topoInfoClass) {
		this.topoInfoClass = topoInfoClass;
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
	public String getRemarks() {
		return remarks;
	}
	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}
	public Long getThreshold() {
		return threshold;
	}
	public void setThreshold(Long threshold) {
		this.threshold = threshold;
	}
	public Long getFlag() {
		return flag;
	}
	public void setFlag(Long flag) {
		this.flag = flag;
	}
	
}
