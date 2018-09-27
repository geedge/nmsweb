package nis.nms.core;

import java.util.ArrayList;
import java.util.List;

public class Topology implements Comparable<Topology> {

	/**
	 * 对象类型0：业务系统 1：父节点组 2：叶子节点组 3：机房 4：机柜 5：节点机
	 */
	private int type;

	/**
	 * 对象ID
	 */
	private Long id;

	/**
	 * 展现图片时用的ID
	 */
	private Long treeId;

	/**
	 * 名称type=0时业务系统名称 type=1、2时节点组名称 type=3时机房编号 type=4时机柜描述 type=5对应节点名称
	 */
	private String name;
	/**
	 * 运行状态 type=1 type=2 type=3 type=4是否存在异常节点机 type=5节点机是否异常 0：正常 1：异常
	 */
	private int isOk;
	/**
	 * 子节点集合 type=0 是一级节点组的集合 type=1 是子节点组的集合 type=2 是机房的集合 type=3 是机柜的集合 type=4 是节点机的集合
	 */
	private List<Topology> child = new ArrayList<Topology>();

	/**
	 * 节点组下的节点数量
	 */
	private int childSize;
	/**
	 * 节点组下的正常节点数量
	 */
	private int okChildSize;
	/**
	 * 节点组下的不正常节点数量
	 */
	private int falseChildSize;
	/**
	 * 节点组下不正常节点的SEQID，以逗号隔开
	 */
	private String falseSeqIds;
	/**
	 * 节点组级别，用于返回
	 */
	private String groupLevel;
	// 下面的用于机柜展示
	/**
	 * 机柜编号
	 */
	private String ispn;
	/**
	 * 机柜U位
	 */
	private Long boxUType;
	/**
	 * 节点机IP信息
	 */
	private String nodeIp;
	/**
	 * 节点机名称
	 */
	private String nodeName;
	/**
	 * 节点机U位
	 */
	private Long nodeUType;
	/**
	 * 节点的起始U位
	 */
	private Long nodeBeginUType;
	/**
	 * 一、机柜下的节点是否是在当前打开机柜的组，即是否可编辑，0：是 1：否, -1 则是无效节点
	 * 二、机房下的机柜是否在当前节点组下有有效的节点，-1 无有效节点
	 */
	private int isEdit;
	
	
	public int getType() {
		return type;
	}

	public void setType(int type) {
		this.type = type;
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

	public int getIsOk() {
		return isOk;
	}

	public void setIsOk(int isOk) {
		this.isOk = isOk;
	}

	public List<Topology> getChild() {
		return child;
	}

	public void setChild(List<Topology> child) {
		this.child = child;
	}

	public Long getTreeId() {
		return treeId;
	}

	public void setTreeId(Long treeId) {
		this.treeId = treeId;
	}

	public String getNodeIp() {
		return nodeIp;
	}

	public void setNodeIp(String nodeIp) {
		this.nodeIp = nodeIp;
	}

	public String getNodeName() {
		return nodeName;
	}

	public void setNodeName(String nodeName) {
		this.nodeName = nodeName;
	}

	public Long getNodeUType() {
		return nodeUType;
	}

	public void setNodeUType(Long nodeUType) {
		this.nodeUType = nodeUType;
	}

	@Override
	public int compareTo(Topology topo) {
		if (this.isOk > topo.getIsOk()) {
			return 1;
		} else if (this.isOk < topo.getIsOk()) {
			return -1;
		} else {
			return 0;
		}
	}

	public int getChildSize() {
		return childSize;
	}

	public void setChildSize(int childSize) {
		this.childSize = childSize;
	}

	public String getIspn() {
		return ispn;
	}

	public void setIspn(String ispn) {
		this.ispn = ispn;
	}

	public String getGroupLevel() {
		return groupLevel;
	}

	public void setGroupLevel(String groupLevel) {
		this.groupLevel = groupLevel;
	}

	public int getOkChildSize() {
		return okChildSize;
	}

	public void setOkChildSize(int okChildSize) {
		this.okChildSize = okChildSize;
	}

	public int getFalseChildSize() {
		return falseChildSize;
	}

	public void setFalseChildSize(int falseChildSize) {
		this.falseChildSize = falseChildSize;
	}

	public int getIsEdit() {
		return isEdit;
	}

	public void setIsEdit(int isEdit) {
		this.isEdit = isEdit;
	}

	public String getFalseSeqIds() {
		return falseSeqIds;
	}

	public void setFalseSeqIds(String falseSeqIds) {
		this.falseSeqIds = falseSeqIds;
	}

	public Long getBoxUType() {
		return boxUType;
	}

	public void setBoxUType(Long boxUType) {
		this.boxUType = boxUType;
	}

	public Long getNodeBeginUType() {
		return nodeBeginUType;
	}

	public void setNodeBeginUType(Long nodeBeginUType) {
		this.nodeBeginUType = nodeBeginUType;
	}

}