package nis.nms.domains;

/**
 * DeviceBoardsoltBoard entity.
 * 
 * @author MyEclipse Persistence Tools
 */

public class DeviceBoardsoltBoard implements java.io.Serializable {

	// Fields

	private Long id;
	private String deviceBrandCode;
	private String deviceBoardSoltCode;
	private String deviceBoardCode;
	private String deviceTypeCode;

	// Constructors

	/** default constructor */
	public DeviceBoardsoltBoard() {
	}

	/** full constructor */
	public DeviceBoardsoltBoard(String deviceBrandCode,
			String deviceBoardSoltCode, String deviceBoardCode,
			String deviceTypeCode) {
		this.deviceBrandCode = deviceBrandCode;
		this.deviceBoardSoltCode = deviceBoardSoltCode;
		this.deviceBoardCode = deviceBoardCode;
		this.deviceTypeCode = deviceTypeCode;
	}

	// Property accessors

	public Long getId() {
		return this.id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getDeviceBrandCode() {
		return this.deviceBrandCode;
	}

	public void setDeviceBrandCode(String deviceBrandCode) {
		this.deviceBrandCode = deviceBrandCode;
	}

	public String getDeviceBoardSoltCode() {
		return this.deviceBoardSoltCode;
	}

	public void setDeviceBoardSoltCode(String deviceBoardSoltCode) {
		this.deviceBoardSoltCode = deviceBoardSoltCode;
	}

	public String getDeviceBoardCode() {
		return this.deviceBoardCode;
	}

	public void setDeviceBoardCode(String deviceBoardCode) {
		this.deviceBoardCode = deviceBoardCode;
	}

	public String getDeviceTypeCode() {
		return this.deviceTypeCode;
	}

	public void setDeviceTypeCode(String deviceTypeCode) {
		this.deviceTypeCode = deviceTypeCode;
	}

}