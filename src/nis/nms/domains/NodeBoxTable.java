package nis.nms.domains;

import java.util.List;

/**
 * NodeBoxTable entity.
 * 
 * @author MyEclipse Persistence Tools
 */

public class NodeBoxTable implements java.io.Serializable {

	// Fields
	private static final long serialVersionUID = 1984053252904108229L;
	private Long nodeBoxId;
	private String descinfo;
	private String ispn;
	private Long boxUType;
	private String roomIspn;
	private Long roomRowPosition;
	private Long roomColPosition;
	//机柜设置机柜位置集合
	private List<NodeLatticeTable> nodeLatticeList;
	
	//机柜状态，机柜中的节点是否正常
	private boolean alarm;
	
	//机柜状态，节点组下的节点在本机柜中
	private boolean hasNode;

	// Constructors

	/** default constructor */
	public NodeBoxTable() {
	}

	/** minimal constructor */
	public NodeBoxTable(Long nodeBoxId) {
		this.nodeBoxId = nodeBoxId;
	}

	/** full constructor */
	public NodeBoxTable(Long nodeBoxId, String descinfo, String ispn,
			Long boxUType, String roomIspn, Long roomRowPosition,
			Long roomColPosition) {
		this.nodeBoxId = nodeBoxId;
		this.descinfo = descinfo;
		this.ispn = ispn;
		this.boxUType = boxUType;
		this.roomIspn = roomIspn;
		this.roomRowPosition = roomRowPosition;
		this.roomColPosition = roomColPosition;
	}

	// Property accessors

	public Long getNodeBoxId() {
		return this.nodeBoxId;
	}

	public void setNodeBoxId(Long nodeBoxId) {
		this.nodeBoxId = nodeBoxId;
	}

	public String getDescinfo() {
		return this.descinfo;
	}

	public void setDescinfo(String descinfo) {
		this.descinfo = descinfo;
	}

	public String getIspn() {
		return this.ispn;
	}

	public void setIspn(String ispn) {
		this.ispn = ispn;
	}

	public Long getBoxUType() {
		return this.boxUType;
	}

	public void setBoxUType(Long boxUType) {
		this.boxUType = boxUType;
	}

	public String getRoomIspn() {
		return this.roomIspn;
	}

	public void setRoomIspn(String roomIspn) {
		this.roomIspn = roomIspn;
	}

	public Long getRoomRowPosition() {
		return this.roomRowPosition;
	}

	public void setRoomRowPosition(Long roomRowPosition) {
		this.roomRowPosition = roomRowPosition;
	}

	public Long getRoomColPosition() {
		return this.roomColPosition;
	}

	public void setRoomColPosition(Long roomColPosition) {
		this.roomColPosition = roomColPosition;
	}

	
	public List<NodeLatticeTable> getNodeLatticeList()
	{
		return nodeLatticeList;
	}

	
	public void setNodeLatticeList(List<NodeLatticeTable> nodeLatticeList)
	{
		this.nodeLatticeList = nodeLatticeList;
	}

	
	public boolean isAlarm()
	{
		return alarm;
	}

	
	public void setAlarm(boolean alarm)
	{
		this.alarm = alarm;
	}

	
	public boolean isHasNode()
	{
		return hasNode;
	}

	
	public void setHasNode(boolean hasNode)
	{
		this.hasNode = hasNode;
	}

}