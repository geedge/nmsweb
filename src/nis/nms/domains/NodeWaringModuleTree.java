package nis.nms.domains;

import java.util.ArrayList;
import java.util.List;



public class NodeWaringModuleTree {
	
	String name;
	List<NodeTableModule> nodeTableList = new ArrayList<NodeTableModule>();
	List<NodeTableModule> trueNodeList = new ArrayList<NodeTableModule>();
	List<NodeTableModule> falseNodeList = new ArrayList<NodeTableModule>();
	
	//-----------------------------------------------------------
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public List<NodeTableModule> getNodeTableList() {
		return nodeTableList;
	}

	public void setNodeTableList(List<NodeTableModule> nodeTableList) {
		this.nodeTableList = nodeTableList;
	}

	public List<NodeTableModule> getTrueNodeList() {
		return trueNodeList;
	}

	public void setTrueNodeList(List<NodeTableModule> trueNodeList) {
		this.trueNodeList = trueNodeList;
	}

	public List<NodeTableModule> getFalseNodeList() {
		return falseNodeList;
	}

	public void setFalseNodeList(List<NodeTableModule> falseNodeList) {
		this.falseNodeList = falseNodeList;
	}
}
