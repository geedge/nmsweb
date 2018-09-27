package nis.nms.bean;

import com.zhtelecom.common.snmp.mib.MibSystem;

public class DeviceInfo extends MibSystem implements Cloneable{
	
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 2180134682630033989L;
	
	private Long id;
	private String parDeviceCode;
	private String deviceCode;
	private Long deviceWidth;
	private Long deviceHeight;
	private String deviceFill;
	private String deviceFillMini;
	
	private String showIndex;
	private String parShowIndex;//父设备在祖父设备上的位置标号
	private Long showLevel;
	private Long figureX;
	private Long figureY;
	private Long isLink;
	
	private Long isLeaf;
	
	private String pid;
	
	private Integer devNum;//多个设备叠加时，设备编号，从0-（maxDevNum-1）
	
	private Integer devPostionNum;//每个设备的位置个数
	
	
	public String getPid()
	{
		return pid;
	}


	
	public void setPid(String pid)
	{
		this.pid = pid;
	}


	public String getShowIndex()
	{
		return showIndex;
	}

	
	public void setShowIndex(String showIndex)
	{
		this.showIndex = showIndex;
	}

	

	public String getParDeviceCode()
	{
		return parDeviceCode;
	}
	
	public void setParDeviceCode(String parDeviceCode)
	{
		this.parDeviceCode = parDeviceCode;
	}
	
	public String getDeviceCode()
	{
		return deviceCode;
	}
	
	public void setDeviceCode(String deviceCode)
	{
		this.deviceCode = deviceCode;
	}
	
	
	public String getDeviceFill()
	{
		return deviceFill;
	}
	
	public void setDeviceFill(String deviceFill)
	{
		this.deviceFill = deviceFill;
	}

	
	public String getDeviceFillMini()
	{
		return deviceFillMini;
	}

	
	public void setDeviceFillMini(String deviceFillMini)
	{
		this.deviceFillMini = deviceFillMini;
	}




	
	public String getParShowIndex()
	{
		return parShowIndex;
	}



	
	public void setParShowIndex(String parShowIndex)
	{
		this.parShowIndex = parShowIndex;
	}



	
	public Long getId()
	{
		return id;
	}



	
	public void setId(Long id)
	{
		this.id = id;
	}



	
	public Long getDeviceWidth()
	{
		return deviceWidth;
	}



	
	public void setDeviceWidth(Long deviceWidth)
	{
		this.deviceWidth = deviceWidth;
	}



	
	public Long getDeviceHeight()
	{
		return deviceHeight;
	}



	
	public void setDeviceHeight(Long deviceHeight)
	{
		this.deviceHeight = deviceHeight;
	}



	
	public Long getShowLevel()
	{
		return showLevel;
	}



	
	public void setShowLevel(Long showLevel)
	{
		this.showLevel = showLevel;
	}



	
	public Long getFigureX()
	{
		return figureX;
	}



	
	public void setFigureX(Long figureX)
	{
		this.figureX = figureX;
	}



	
	public Long getFigureY()
	{
		return figureY;
	}



	
	public void setFigureY(Long figureY)
	{
		this.figureY = figureY;
	}



	
	public Long getIsLink()
	{
		return isLink;
	}



	
	public void setIsLink(Long isLink)
	{
		this.isLink = isLink;
	}



	
	public Long getIsLeaf()
	{
		return isLeaf;
	}



	
	public void setIsLeaf(Long isLeaf)
	{
		this.isLeaf = isLeaf;
	}



	
	public DeviceInfo clone() throws CloneNotSupportedException
	{
		// TODO Auto-generated method stub
		return (DeviceInfo)super.clone();
	}



	
	public Integer getDevNum()
	{
		return devNum;
	}



	
	public void setDevNum(Integer devNum)
	{
		this.devNum = devNum;
	}



	
	public Integer getDevPostionNum()
	{
		return devPostionNum;
	}



	
	public void setDevPostionNum(Integer devPostionNum)
	{
		this.devPostionNum = devPostionNum;
	}


}
