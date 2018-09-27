package com.nms.objectSnmp.util;

import java.io.Serializable;

public class EntityInfo implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public EntityInfo(){}
	
	private String filedName;
	private String filedType;
	private String oid;
	private int showNum;
	
	public int getShowNum() {
		return showNum;
	}
	public void setShowNum(int showNum) {
		this.showNum = showNum;
	}
	public String getFiledName() {
		return filedName;
	}
	public void setFiledName(String filedName) {
		this.filedName = filedName;
	}
	public String getFiledType() {
		return filedType;
	}
	public void setFiledType(String filedType) {
		this.filedType = filedType;
	}
	public String getOid() {
		return oid;
	}
	public void setOid(String oid) {
		this.oid = oid;
	}
}
