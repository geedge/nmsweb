package nis.nms.domains;

import java.util.Date;

/**
 * DeviceBrandInfo entity.
 * 
 * @author MyEclipse Persistence Tools
 */

public class DeviceBrandInfo implements java.io.Serializable
{
	
	// Fields
	
	/**
	 * 
	 */
	 
	private static final long serialVersionUID = 1L;
	private Long id;
	private String deviceRandCode;
	private String deviceRandName;
	private String deviceBrandDesc;
	private Date addTime;
	private Long addUserid;
	private Date lastUpdateTime;
	private Long lastUpdateUserid;
	
	// Constructors
	
	/** default constructor */
	public DeviceBrandInfo()
	{
	}
	
	/** minimal constructor */
	public DeviceBrandInfo(String deviceRandCode, String deviceRandName)
	{
		this.deviceRandCode = deviceRandCode;
		this.deviceRandName = deviceRandName;
	}
	
	/** full constructor */
	public DeviceBrandInfo(String deviceRandCode, String deviceRandName, String deviceBrandDesc,
			Date addTime, Long addUserid, Date lastUpdateTime, Long lastUpdateUserid)
	{
		this.deviceRandCode = deviceRandCode;
		this.deviceRandName = deviceRandName;
		this.deviceBrandDesc = deviceBrandDesc;
		this.addTime = addTime;
		this.addUserid = addUserid;
		this.lastUpdateTime = lastUpdateTime;
		this.lastUpdateUserid = lastUpdateUserid;
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
	
	public String getDeviceRandCode()
	{
		return this.deviceRandCode;
	}
	
	public void setDeviceRandCode(String deviceRandCode)
	{
		this.deviceRandCode = deviceRandCode;
	}
	
	public String getDeviceRandName()
	{
		return this.deviceRandName;
	}
	
	public void setDeviceRandName(String deviceRandName)
	{
		this.deviceRandName = deviceRandName;
	}
	
	public String getDeviceBrandDesc()
	{
		return this.deviceBrandDesc;
	}
	
	public void setDeviceBrandDesc(String deviceBrandDesc)
	{
		this.deviceBrandDesc = deviceBrandDesc;
	}
	
	public Date getAddTime()
	{
		return this.addTime;
	}
	
	public void setAddTime(Date addTime)
	{
		this.addTime = addTime;
	}
	
	public Long getAddUserid()
	{
		return this.addUserid;
	}
	
	public void setAddUserid(Long addUserid)
	{
		this.addUserid = addUserid;
	}
	
	public Date getLastUpdateTime()
	{
		return this.lastUpdateTime;
	}
	
	public void setLastUpdateTime(Date lastUpdateTime)
	{
		this.lastUpdateTime = lastUpdateTime;
	}
	
	public Long getLastUpdateUserid()
	{
		return this.lastUpdateUserid;
	}
	
	public void setLastUpdateUserid(Long lastUpdateUserid)
	{
		this.lastUpdateUserid = lastUpdateUserid;
	}
	
}