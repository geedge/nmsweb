package nis.nms.domains;

/**
 * NodeTable entity.
 * 
 * @author MyEclipse Persistence Tools
 */

public class NodeLatticeTable implements java.io.Serializable {

	// Fields
	private static final long serialVersionUID = 1984053252904108229L;
	private Long id;
	private Long nodeposition;
	private Long nodeBoxId;
	private Long nodeSeqId;
	//每个位上都放在节点机
	private NodeTable nodeTable;
	private boolean groupNode;
	private Long nodepositionTemp;
	
	public NodeLatticeTable() {
	}

	public NodeLatticeTable(Long id,Long nodeBoxId, Long nodeposition,Long nodeSeqId) {
		this.id = id;
		this.nodeBoxId = nodeBoxId;
		this.nodeposition = nodeposition;
		this.nodeSeqId = nodeSeqId;
	}

	public Long getNodeBoxId() {
		return nodeBoxId;
	}

	public void setNodeBoxId(Long nodeBoxId) {
		this.nodeBoxId = nodeBoxId;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public Long getNodeSeqId() {
		return nodeSeqId;
	}

	public void setNodeSeqId(Long nodeSeqId) {
		this.nodeSeqId = nodeSeqId;
	}

	public Long getNodeposition() {
		return nodeposition;
	}

	public void setNodeposition(Long nodeposition) {
		this.nodeposition = nodeposition;
	}

	
	public NodeTable getNodeTable()
	{
		return nodeTable;
	}

	
	public void setNodeTable(NodeTable nodeTable)
	{
		this.nodeTable = nodeTable;
	}

	
	public boolean isGroupNode()
	{
		return groupNode;
	}

	
	public void setGroupNode(boolean groupNode)
	{
		this.groupNode = groupNode;
	}

	public Long getNodepositionTemp() {
		return nodepositionTemp;
	}

	public void setNodepositionTemp(Long nodepositionTemp) {
		this.nodepositionTemp = nodepositionTemp;
	}

}