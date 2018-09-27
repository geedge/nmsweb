package nis.nms.domains;

import java.io.Serializable;
import java.util.Date;

public class TopoConInfo implements Serializable{
	private Long id;
	private TopoInfo topoInfo;
	private Long x;
	private Long y;
	private Long width;
	private Long height;
	private Date createTime;
	private Long createUser;
	private Date updateTime;
	private Long updateUser;
	private String topoConInfoClass;
	private String text;
	private Long flag;
	
	
	public TopoConInfo() {
	}
	public TopoConInfo(Long id, TopoInfo topoInfo, Long x, Long y, Long width, Long height, Date createTime,
			Long createUser, Date updateTime, Long updateUser, String topoConInfoClass, String text, Long flag) {
		super();
		this.id = id;
		this.topoInfo = topoInfo;
		this.x = x;
		this.y = y;
		this.width = width;
		this.height = height;
		this.createTime = createTime;
		this.createUser = createUser;
		this.updateTime = updateTime;
		this.updateUser = updateUser;
		this.topoConInfoClass = topoConInfoClass;
		this.text = text;
		this.flag = flag;
	}
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public TopoInfo getTopoInfo() {
		return topoInfo;
	}
	public void setTopoInfo(TopoInfo topoInfo) {
		this.topoInfo = topoInfo;
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
	public String getTopoConInfoClass() {
		return topoConInfoClass;
	}
	public void setTopoConInfoClass(String topoConInfoClass) {
		this.topoConInfoClass = topoConInfoClass;
	}
	public String getText() {
		return text;
	}
	public void setText(String text) {
		this.text = text;
	}
	public Long getFlag() {
		return flag;
	}
	public void setFlag(Long flag) {
		this.flag = flag;
	}
	
}
