package nis.nms.domains;

import java.util.Date;

/**
 * DeviceTypeInfo entity.
 * 
 * @author MyEclipse Persistence Tools
 */

public class DeviceTypeInfo implements java.io.Serializable
{
	
	// Fields
	
	/**
	 * 
	 */
	 
	private static final long serialVersionUID = 1L;
	private Long id;
	private String deviceTypeCode;
	private String deviceRandCode;
	private String deviceDesc;
	private Long showIndex;
	private Integer showIndexStart;//批量新增时，编号开始
	private Integer showIndexEnd;//批量新增时，编号结尾
	private String showIndexRule;//端口编号的规则：0全部，1奇数，2偶数
	private String pid;//父设备型号：关系确定，不可变
	private String canConfigPid;//可以配置的父设备：可以配置的父设备
	private String parDevCode;
	private String figureType;
	private Long figureX;
	private Long figureY;
	private Long figureWidth;
	private Long figureHeight;
	private String figureStroke;
	private Long figureStrokeWidth;
	private String figureFill;
	private String nameFormat;
	private Date addTime;
	private Long addUserid;
	private Date lastUpdateTime;
	private Long lastUpdateUserid;
	private String diTableName;
	private String indexFiled;
	private String statusFiled;
	private String statusSymbols;
	private String statusValue;
	private Long showLevel;
	private Long isLink;
	private Long isLeaf;
	private Long maxDeviceNum;
	private Long isPositionDev;
	private Long hasInstance;
	
	// Constructors
	
	/** default constructor */
	public DeviceTypeInfo()
	{
	}
	
	/** minimal constructor */
	public DeviceTypeInfo(String deviceTypeCode, String deviceRandCode, String figureType)
	{
		this.deviceTypeCode = deviceTypeCode;
		this.deviceRandCode = deviceRandCode;
		this.figureType = figureType;
	}
	
	/** full constructor */
	public DeviceTypeInfo(String deviceTypeCode, String deviceRandCode, String deviceDesc,
			Long showIndex, String pid, String figureType, Long figureX, Long figureY,
			Long figureWidth, Long figureHeight, String figureStroke, Long figureStrokeWidth,
			String figureFill, String nameFormat, Date addTime, Long addUserid,
			Date lastUpdateTime, Long lastUpdateUserid, String diTableName, String indexFiled,
			String statusFiled, String statusSymbols, String statusValue, Long showLevel,
			Long isLink, Long isLeaf,Long maxDeviceNum)
	{
		this.deviceTypeCode = deviceTypeCode;
		this.deviceRandCode = deviceRandCode;
		this.deviceDesc = deviceDesc;
		this.showIndex = showIndex;
		this.pid = pid;
		this.figureType = figureType;
		this.figureX = figureX;
		this.figureY = figureY;
		this.figureWidth = figureWidth;
		this.figureHeight = figureHeight;
		this.figureStroke = figureStroke;
		this.figureStrokeWidth = figureStrokeWidth;
		this.figureFill = figureFill;
		this.nameFormat = nameFormat;
		this.addTime = addTime;
		this.addUserid = addUserid;
		this.lastUpdateTime = lastUpdateTime;
		this.lastUpdateUserid = lastUpdateUserid;
		this.diTableName = diTableName;
		this.indexFiled = indexFiled;
		this.statusFiled = statusFiled;
		this.statusSymbols = statusSymbols;
		this.statusValue = statusValue;
		this.showLevel = showLevel;
		this.isLink = isLink;
		this.isLeaf = isLeaf;
		this.maxDeviceNum = maxDeviceNum;
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
	
	public String getDeviceTypeCode()
	{
		return this.deviceTypeCode;
	}
	
	public void setDeviceTypeCode(String deviceTypeCode)
	{
		this.deviceTypeCode = deviceTypeCode;
	}
	
	public String getDeviceRandCode()
	{
		return this.deviceRandCode;
	}
	
	public void setDeviceRandCode(String deviceRandCode)
	{
		this.deviceRandCode = deviceRandCode;
	}
	
	public String getDeviceDesc()
	{
		return this.deviceDesc;
	}
	
	public void setDeviceDesc(String deviceDesc)
	{
		this.deviceDesc = deviceDesc;
	}
	
	public Long getShowIndex()
	{
		return this.showIndex;
	}
	
	public void setShowIndex(Long showIndex)
	{
		this.showIndex = showIndex;
	}
	
	public String getPid()
	{
		return this.pid;
	}
	
	public void setPid(String pid)
	{
		this.pid = pid;
	}
	
	public String getFigureType()
	{
		return this.figureType;
	}
	
	public void setFigureType(String figureType)
	{
		this.figureType = figureType;
	}
	
	public Long getFigureX()
	{
		return this.figureX;
	}
	
	public void setFigureX(Long figureX)
	{
		this.figureX = figureX;
	}
	
	public Long getFigureY()
	{
		return this.figureY;
	}
	
	public void setFigureY(Long figureY)
	{
		this.figureY = figureY;
	}
	
	public Long getFigureWidth()
	{
		return this.figureWidth;
	}
	
	public void setFigureWidth(Long figureWidth)
	{
		this.figureWidth = figureWidth;
	}
	
	public Long getFigureHeight()
	{
		return this.figureHeight;
	}
	
	public void setFigureHeight(Long figureHeight)
	{
		this.figureHeight = figureHeight;
	}
	
	public String getFigureStroke()
	{
		return this.figureStroke;
	}
	
	public void setFigureStroke(String figureStroke)
	{
		this.figureStroke = figureStroke;
	}
	
	public Long getFigureStrokeWidth()
	{
		return this.figureStrokeWidth;
	}
	
	public void setFigureStrokeWidth(Long figureStrokeWidth)
	{
		this.figureStrokeWidth = figureStrokeWidth;
	}
	
	public String getFigureFill()
	{
		return this.figureFill;
	}
	
	public void setFigureFill(String figureFill)
	{
		this.figureFill = figureFill;
	}
	
	public String getNameFormat()
	{
		return this.nameFormat;
	}
	
	public void setNameFormat(String nameFormat)
	{
		this.nameFormat = nameFormat;
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
	
	public String getDiTableName()
	{
		return this.diTableName;
	}
	
	public void setDiTableName(String diTableName)
	{
		this.diTableName = diTableName;
	}
	
	public String getIndexFiled()
	{
		return this.indexFiled;
	}
	
	public void setIndexFiled(String indexFiled)
	{
		this.indexFiled = indexFiled;
	}
	
	public String getStatusFiled()
	{
		return this.statusFiled;
	}
	
	public void setStatusFiled(String statusFiled)
	{
		this.statusFiled = statusFiled;
	}
	
	public String getStatusSymbols()
	{
		return this.statusSymbols;
	}
	
	public void setStatusSymbols(String statusSymbols)
	{
		this.statusSymbols = statusSymbols;
	}
	
	public String getStatusValue()
	{
		return this.statusValue;
	}
	
	public void setStatusValue(String statusValue)
	{
		this.statusValue = statusValue;
	}
	
	public Long getShowLevel()
	{
		return this.showLevel;
	}
	
	public void setShowLevel(Long showLevel)
	{
		this.showLevel = showLevel;
	}
	
	public Long getIsLink()
	{
		return this.isLink;
	}
	
	public void setIsLink(Long isLink)
	{
		this.isLink = isLink;
	}
	
	public Long getIsLeaf()
	{
		return this.isLeaf;
	}
	
	public void setIsLeaf(Long isLeaf)
	{
		this.isLeaf = isLeaf;
	}

	
	public String getParDevCode()
	{
		return parDevCode;
	}

	
	public void setParDevCode(String parDevCode)
	{
		this.parDevCode = parDevCode;
	}

	
	public Long getMaxDeviceNum()
	{
		return maxDeviceNum;
	}

	
	public void setMaxDeviceNum(Long maxDeviceNum)
	{
		this.maxDeviceNum = maxDeviceNum;
	}

	
	public Integer getShowIndexStart()
	{
		return showIndexStart;
	}

	
	public void setShowIndexStart(Integer showIndexStart)
	{
		this.showIndexStart = showIndexStart;
	}

	
	public Integer getShowIndexEnd()
	{
		return showIndexEnd;
	}

	
	public void setShowIndexEnd(Integer showIndexEnd)
	{
		this.showIndexEnd = showIndexEnd;
	}

	
	public Long getIsPositionDev()
	{
		return isPositionDev;
	}

	
	public void setIsPositionDev(Long isPositionDev)
	{
		this.isPositionDev = isPositionDev;
	}

	public String getCanConfigPid()
	{
		return canConfigPid;
	}

	
	public void setCanConfigPid(String canConfigPid)
	{
		this.canConfigPid = canConfigPid;
	}

	
	public Long getHasInstance()
	{
		return hasInstance;
	}

	
	public void setHasInstance(Long hasInstance)
	{
		this.hasInstance = hasInstance;
	}

	
	public String getShowIndexRule()
	{
		return showIndexRule;
	}

	
	public void setShowIndexRule(String showIndexRule)
	{
		this.showIndexRule = showIndexRule;
	}


 	
}