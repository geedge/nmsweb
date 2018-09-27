package nis.nms.bean;

import java.util.Date;

/**
 * DiSysteminfo entity.
 * 
 * @author MyEclipse Persistence Tools
 */

public class DiSystem implements java.io.Serializable {

	// Fields

	private String sysDescr;
	private String sysUpTime;
	private String sysName;
	private String sysLocation;
	
	private String sysCpu;
	private String sysMemory;
	private String sysFan;//风扇
	
	private String sysInSpeedSum;//系统输入速度总和
	private String sysOutSpeedSum;//系统输出速度总和
	
	private String sysInPktsSpeedSum;//系统收包速率总和
	private String sysOutPktsSpeedSum;//系统发包速率总和
	
	private String sysStatus;//系统状态，通过统计所有监测得出，所有监测都正常就正常，有一个异常则异常
	
	public String getSysDescr()
	{
		return sysDescr;
	}
	
	public void setSysDescr(String sysDescr)
	{
		this.sysDescr = sysDescr;
	}
	
	public String getSysUpTime()
	{
		return sysUpTime;
	}
	
	public void setSysUpTime(String sysUpTime)
	{
		this.sysUpTime = sysUpTime;
	}
	
	public String getSysName()
	{
		return sysName;
	}
	
	public void setSysName(String sysName)
	{
		this.sysName = sysName;
	}
	
	public String getSysLocation()
	{
		return sysLocation;
	}
	
	public void setSysLocation(String sysLocation)
	{
		this.sysLocation = sysLocation;
	}

	
	public String getSysCpu()
	{
		return sysCpu;
	}

	
	public void setSysCpu(String sysCpu)
	{
		this.sysCpu = sysCpu;
	}

	
	public String getSysMemory()
	{
		return sysMemory;
	}

	
	public void setSysMemory(String sysMemory)
	{
		this.sysMemory = sysMemory;
	}

	
	public String getSysFan()
	{
		return sysFan;
	}

	
	public void setSysFan(String sysFan)
	{
		this.sysFan = sysFan;
	}

	
	public String getSysInSpeedSum()
	{
		return sysInSpeedSum;
	}

	
	public void setSysInSpeedSum(String sysInSpeedSum)
	{
		this.sysInSpeedSum = sysInSpeedSum;
	}

	
	public String getSysOutSpeedSum()
	{
		return sysOutSpeedSum;
	}

	
	public void setSysOutSpeedSum(String sysOutSpeedSum)
	{
		this.sysOutSpeedSum = sysOutSpeedSum;
	}

	
	public String getSysInPktsSpeedSum()
	{
		return sysInPktsSpeedSum;
	}

	
	public void setSysInPktsSpeedSum(String sysInPktsSpeedSum)
	{
		this.sysInPktsSpeedSum = sysInPktsSpeedSum;
	}

	
	public String getSysOutPktsSpeedSum()
	{
		return sysOutPktsSpeedSum;
	}

	
	public void setSysOutPktsSpeedSum(String sysOutPktsSpeedSum)
	{
		this.sysOutPktsSpeedSum = sysOutPktsSpeedSum;
	}

	
	public String getSysStatus()
	{
		return sysStatus;
	}

	
	public void setSysStatus(String sysStatus)
	{
		this.sysStatus = sysStatus;
	}


}