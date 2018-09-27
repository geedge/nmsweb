package nis.nms.domains;

public class NodeBoxTableVo implements java.io.Serializable{
	
	private static final long serialVersionUID = 1L;
	private String descinfo;
	private String ispn;
	private Long boxUType;
	private String roomIspn;
	private Long roomRowPosition;
	private Long roomColPosition;
	
	//导入结点时，数据错误提示信息
	private String showError;
	
	public NodeBoxTableVo() {
	}


	/** full constructor */
	public NodeBoxTableVo(String descinfo, String ispn,
			Long boxUType, String roomIspn, Long roomRowPosition,
			Long roomColPosition,String showError) {
		super();
		this.descinfo = descinfo;
		this.ispn = ispn;
		this.boxUType = boxUType;
		this.roomIspn = roomIspn;
		this.roomRowPosition = roomRowPosition;
		this.roomColPosition = roomColPosition;
		this.showError = showError;
	}


	public String getDescinfo() {
		return descinfo;
	}


	public void setDescinfo(String descinfo) {
		this.descinfo = descinfo;
	}


	public String getIspn() {
		return ispn;
	}


	public void setIspn(String ispn) {
		this.ispn = ispn;
	}


	public Long getBoxUType() {
		return boxUType;
	}


	public void setBoxUType(Long boxUType) {
		this.boxUType = boxUType;
	}


	public String getRoomIspn() {
		return roomIspn;
	}


	public void setRoomIspn(String roomIspn) {
		this.roomIspn = roomIspn;
	}


	public Long getRoomRowPosition() {
		return roomRowPosition;
	}


	public void setRoomRowPosition(Long roomRowPosition) {
		this.roomRowPosition = roomRowPosition;
	}


	public Long getRoomColPosition() {
		return roomColPosition;
	}


	public void setRoomColPosition(Long roomColPosition) {
		this.roomColPosition = roomColPosition;
	}


	public String getShowError() {
		return showError;
	}


	public void setShowError(String showError) {
		this.showError = showError;
	}
}
