package com.ncs.topology;

public class Node {
	
	 //编号 
	
	String id;
	
	//父结点编号
	
	String fatherId;
	
	//显示名称
	
	String name;
	
	//运行状态(0=正常;1=故障)
	
	int state;
	
	//显示图片
	
	String url;

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getFatherId() {
		return fatherId;
	}

	public void setFatherId(String fatherId) {
		this.fatherId = fatherId;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public int getState() {
		return state;
	}

	public void setState(int state) {
		this.state = state;
	}

}
