package nis.nms.domains;

/**
 * NodeRoomLatticeTable entity.
 * 
 * @author MyEclipse Persistence Tools
 */

public class NodeRoomLatticeTable implements java.io.Serializable {

	// Fields

	private Long id;
	private Long latticeRowPosition;
	private Long latticeColPosition;
	private Long roomId;
	private Long nodeBoxId;

	// Constructors

	/** default constructor */
	public NodeRoomLatticeTable() {
	}

	/** minimal constructor */
	public NodeRoomLatticeTable(Long id, Long latticeRowPosition,
			Long latticeColPosition, Long roomId) {
		this.id = id;
		this.latticeRowPosition = latticeRowPosition;
		this.latticeColPosition = latticeColPosition;
		this.roomId = roomId;
	}

	/** full constructor */
	public NodeRoomLatticeTable(Long id, Long latticeRowPosition,
			Long latticeColPosition, Long roomId, Long nodeBoxId) {
		this.id = id;
		this.latticeRowPosition = latticeRowPosition;
		this.latticeColPosition = latticeColPosition;
		this.roomId = roomId;
		this.nodeBoxId = nodeBoxId;
	}

	// Property accessors

	public Long getId() {
		return this.id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public Long getLatticeRowPosition() {
		return this.latticeRowPosition;
	}

	public void setLatticeRowPosition(Long latticeRowPosition) {
		this.latticeRowPosition = latticeRowPosition;
	}

	public Long getLatticeColPosition() {
		return this.latticeColPosition;
	}

	public void setLatticeColPosition(Long latticeColPosition) {
		this.latticeColPosition = latticeColPosition;
	}

	public Long getRoomId() {
		return this.roomId;
	}

	public void setRoomId(Long roomId) {
		this.roomId = roomId;
	}

	public Long getNodeBoxId() {
		return this.nodeBoxId;
	}

	public void setNodeBoxId(Long nodeBoxId) {
		this.nodeBoxId = nodeBoxId;
	}

}