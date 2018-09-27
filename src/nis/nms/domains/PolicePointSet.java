package nis.nms.domains;

/**
 * PolicePointSet entity.
 * 
 * @author MyEclipse Persistence Tools
 */

public class PolicePointSet implements java.io.Serializable {

	// Fields

	private Long id;
	private CheckTypeInfo checkTypeInfo;
	private String nodeIp;
	private String policeTable;
	private String policeCol;
	private String checkSymbols;
	private Long criticalPoint;
	private Long policeLevel;

	// Constructors

	/** default constructor */
	public PolicePointSet() {
	}

	/** full constructor */
	public PolicePointSet(CheckTypeInfo checkTypeInfo,String nodeIp,
			String policeTable, String policeCol, String checkSymbols,
			Long criticalPoint, Long policeLevel) {
		this.checkTypeInfo = checkTypeInfo;
		this.nodeIp = nodeIp;
		this.policeTable = policeTable;
		this.policeCol = policeCol;
		this.checkSymbols = checkSymbols;
		this.criticalPoint = criticalPoint;
		this.policeLevel = policeLevel;
	}

	// Property accessors

	public Long getId() {
		return this.id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public CheckTypeInfo getCheckTypeInfo() {
		return this.checkTypeInfo;
	}

	public void setCheckTypeInfo(CheckTypeInfo checkTypeInfo) {
		this.checkTypeInfo = checkTypeInfo;
	}


	public String getNodeIp() {
		return nodeIp;
	}

	public void setNodeIp(String nodeIp) {
		this.nodeIp = nodeIp;
	}

	public String getPoliceTable() {
		return this.policeTable;
	}

	public void setPoliceTable(String policeTable) {
		this.policeTable = policeTable;
	}

	public String getPoliceCol() {
		return this.policeCol;
	}

	public void setPoliceCol(String policeCol) {
		this.policeCol = policeCol;
	}

	public String getCheckSymbols() {
		return this.checkSymbols;
	}

	public void setCheckSymbols(String checkSymbols) {
		this.checkSymbols = checkSymbols;
	}

	public Long getCriticalPoint() {
		return this.criticalPoint;
	}

	public void setCriticalPoint(Long criticalPoint) {
		this.criticalPoint = criticalPoint;
	}

	public Long getPoliceLevel() {
		return this.policeLevel;
	}

	public void setPoliceLevel(Long policeLevel) {
		this.policeLevel = policeLevel;
	}

}