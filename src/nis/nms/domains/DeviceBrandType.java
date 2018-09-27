package nis.nms.domains;

/**
 * DeviceBrandType entity.
 * 
 * @author MyEclipse Persistence Tools
 */

public class DeviceBrandType implements java.io.Serializable
{
	
	// Fields
	
	/**
	 * 
	 */
	 
	private static final long serialVersionUID = 1L;
	private Long id;
	private String deviceBrandCode;
	private String parDeviceTypeCode;
	private String subDeviceTypeCode;
	
	// Constructors
	
	/** default constructor */
	public DeviceBrandType()
	{
	}
	
	/** full constructor */
	public DeviceBrandType(String deviceBrandCode, String parDeviceTypeCode,
			String subDeviceTypeCode)
	{
		this.deviceBrandCode = deviceBrandCode;
		this.parDeviceTypeCode = parDeviceTypeCode;
		this.subDeviceTypeCode = subDeviceTypeCode;
	}
	
	// Property accessors
	
	public Long getId()
	{
		return this.id;
	}
	
	public void setId(Long id)
	{
		this.id = id;
	}
	
	public String getDeviceBrandCode()
	{
		return this.deviceBrandCode;
	}
	
	public void setDeviceBrandCode(String deviceBrandCode)
	{
		this.deviceBrandCode = deviceBrandCode;
	}
	
	public String getParDeviceTypeCode()
	{
		return this.parDeviceTypeCode;
	}
	
	public void setParDeviceTypeCode(String parDeviceTypeCode)
	{
		this.parDeviceTypeCode = parDeviceTypeCode;
	}
	
	public String getSubDeviceTypeCode()
	{
		return this.subDeviceTypeCode;
	}
	
	public void setSubDeviceTypeCode(String subDeviceTypeCode)
	{
		this.subDeviceTypeCode = subDeviceTypeCode;
	}
	
}