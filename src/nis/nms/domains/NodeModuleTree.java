package nis.nms.domains;

import java.util.ArrayList;
import java.util.List;



public class NodeModuleTree {
	
	String name;
	List<NodeTableModule> nodeList=new ArrayList<NodeTableModule>();
	//List<NodePositionModule> nodeList=new ArrayList<NodePositionModule>();
	List<NodePositionModule> sysAndNgList=new ArrayList<NodePositionModule>();
	List<NodeRelationModule> relaList=new ArrayList<NodeRelationModule>();
	//-----------10 13 日添加-------------------------------------
	List<NodeBoxModule> nodeBoxList = new ArrayList<NodeBoxModule>();
	List<NodeInBoxModule> nodeInBoxList = new ArrayList<NodeInBoxModule>();
	
	public List<NodeBoxModule> getNodeBoxList() {
		return nodeBoxList;
	}

	public void setNodeBoxList(List<NodeBoxModule> nodeBoxList) {
		this.nodeBoxList = nodeBoxList;
	}

	//-----------------------------------------------------------
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public List<NodeTableModule> getNodeList() {
		return nodeList;
	}

	public void setNodeList(List<NodeTableModule> nodeList) {
		this.nodeList = nodeList;
	}

	public List<NodeRelationModule> getRelaList() {
		return relaList;
	}

	public void setRelaList(List<NodeRelationModule> relaList) {
		this.relaList = relaList;
	}

	public List<NodeInBoxModule> getNodeInBoxList() {
		return nodeInBoxList;
	}

	public void setNodeInBoxList(List<NodeInBoxModule> nodeInBoxList) {
		this.nodeInBoxList = nodeInBoxList;
	}

	public List<NodePositionModule> getSysAndNgList() {
		return sysAndNgList;
	}

	public void setSysAndNgList(List<NodePositionModule> sysAndNgList) {
		this.sysAndNgList = sysAndNgList;
	}

}
