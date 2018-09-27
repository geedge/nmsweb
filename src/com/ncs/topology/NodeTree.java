package com.ncs.topology;

import java.util.ArrayList;
import java.util.List;

public class NodeTree {
	
	String name;
	
	List<Node> nodeList=new ArrayList<Node>();

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public List<Node> getNodeList() {
		return nodeList;
	}

	public void setNodeList(List<Node> nodeList) {
		this.nodeList = nodeList;
	}

}
