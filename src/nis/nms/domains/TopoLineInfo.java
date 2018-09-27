package nis.nms.domains;

import java.io.Serializable;
import java.util.Date;

public class TopoLineInfo implements Serializable{
	private Long id;
	private TopoNodeInfo topoNodeInfo1;
	private TopoNodeInfo topoNodeInfo2;
	private String topoLineInfoClass;
	private String text;
	private Date createTime;
	private Long createUser;
	private Date updateTime;
	private Long updateUser;
	private TopoInfo topoInfo;
	private Long flag;
	
	
	public TopoLineInfo() {
		
	}
	
	public TopoLineInfo(Long id, TopoNodeInfo topoNodeInfo1, TopoNodeInfo topoNodeInfo2, String topoLineInfoClass,
			String text, Date createTime, Long createUser, Date updateTime, Long updateUser, TopoInfo topoInfo,
			Long flag) {
		super();
		this.id = id;
		this.topoNodeInfo1 = topoNodeInfo1;
		this.topoNodeInfo2 = topoNodeInfo2;
		this.topoLineInfoClass = topoLineInfoClass;
		this.text = text;
		this.createTime = createTime;
		this.createUser = createUser;
		this.updateTime = updateTime;
		this.updateUser = updateUser;
		this.topoInfo = topoInfo;
		this.flag = flag;
	}

	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public TopoNodeInfo getTopoNodeInfo1() {
		return topoNodeInfo1;
	}
	public void setTopoNodeInfo1(TopoNodeInfo topoNodeInfo1) {
		this.topoNodeInfo1 = topoNodeInfo1;
	}
	public TopoNodeInfo getTopoNodeInfo2() {
		return topoNodeInfo2;
	}
	public void setTopoNodeInfo2(TopoNodeInfo topoNodeInfo2) {
		this.topoNodeInfo2 = topoNodeInfo2;
	}
	public String getTopoLineInfoClass() {
		return topoLineInfoClass;
	}
	public void setTopoLineInfoClass(String topoLineInfoClass) {
		this.topoLineInfoClass = topoLineInfoClass;
	}
	public String getText() {
		return text;
	}
	public void setText(String text) {
		this.text = text;
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
	public TopoInfo getTopoInfo() {
		return topoInfo;
	}
	public void setTopoInfo(TopoInfo topoInfo) {
		this.topoInfo = topoInfo;
	}
	public Long getFlag() {
		return flag;
	}
	public void setFlag(Long flag) {
		this.flag = flag;
	}
	
}
