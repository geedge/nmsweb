package nis.nms.domains;

import java.util.Date;

/**
 * NodeFigureInfo entity.
 * 
 * @author MyEclipse Persistence Tools
 */

public class NodeFigureInfo implements java.io.Serializable
{
	
	// Fields
	
	/**
	 * 
	 */
	 
	private static final long serialVersionUID = -3308992413062033624L;
	private Long id;
	private Long pid;
	private String deviceTypeCode;
	private Long seqid;
	private Long showLevel;
	private Long showIndex;
	private String nameFlag;
	private Long portOperStatus;
	private Long portStatus;
	private String figureType;
	private Long figureX;
	private Long figureY;
	private Long figureWidth;
	private Long figureHeight;
	private String figureStroke;
	private Long figureStrokeWidth;
	private String figureFill;
	private Long dataCheckTimeDigital;
	private Date addTime;
	private Long addUserid;
	private Date lastUpdateTime;
	private Long lastUpdateUserid;
	private String figureFillModel;
	private Long isLeaf;
	private Long portsetState;
	
	private String diTableName;
	
	// Constructors
	
	
	public Long getIsLeaf()
	{
		return isLeaf;
	}

	
	public void setIsLeaf(Long isLeaf)
	{
		this.isLeaf = isLeaf;
	}

	/** default constructor */
	public NodeFigureInfo()
	{
	}
	
	/** minimal constructor */
	public NodeFigureInfo(Long id, Long pid, String deviceTypeCode, Long seqid, Long showLevel,
			String nameFlag, Long portOperStatus, Long portStatus, String figureType)
	{
		this.id = id;
		this.pid = pid;
		this.deviceTypeCode = deviceTypeCode;
		this.seqid = seqid;
		this.showLevel = showLevel;
		this.nameFlag = nameFlag;
		this.portOperStatus = portOperStatus;
		this.portStatus = portStatus;
		this.figureType = figureType;
	}
	
	/** full constructor */
	public NodeFigureInfo(Long id, Long pid, String deviceTypeCode, Long seqid, Long showLevel,
			Long showIndex, String nameFlag, Long portOperStatus, Long portStatus,
			String figureType, Long figureX, Long figureY, Long figureWidth, Long figureHeight,
			String figureStroke, Long figureStrokeWidth, String figureFill,
			Long dataCheckTimeDigital, Date addTime, Long addUserid, Date lastUpdateTime,
			Long lastUpdateUserid)
	{
		this.id = id;
		this.pid = pid;
		this.deviceTypeCode = deviceTypeCode;
		this.seqid = seqid;
		this.showLevel = showLevel;
		this.showIndex = showIndex;
		this.nameFlag = nameFlag;
		this.portOperStatus = portOperStatus;
		this.portStatus = portStatus;
		this.figureType = figureType;
		this.figureX = figureX;
		this.figureY = figureY;
		this.figureWidth = figureWidth;
		this.figureHeight = figureHeight;
		this.figureStroke = figureStroke;
		this.figureStrokeWidth = figureStrokeWidth;
		this.figureFill = figureFill;
		this.dataCheckTimeDigital = dataCheckTimeDigital;
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
	
	public Long getPid()
	{
		return this.pid;
	}
	
	public void setPid(Long pid)
	{
		this.pid = pid;
	}
	
	public String getDeviceTypeCode()
	{
		return this.deviceTypeCode;
	}
	
	public void setDeviceTypeCode(String deviceTypeCode)
	{
		this.deviceTypeCode = deviceTypeCode;
	}
	
	public Long getSeqid()
	{
		return this.seqid;
	}
	
	public void setSeqid(Long seqid)
	{
		this.seqid = seqid;
	}
	
	public Long getShowLevel()
	{
		return this.showLevel;
	}
	
	public void setShowLevel(Long showLevel)
	{
		this.showLevel = showLevel;
	}
	
	public Long getShowIndex()
	{
		return this.showIndex;
	}
	
	public void setShowIndex(Long showIndex)
	{
		this.showIndex = showIndex;
	}
	
	public String getNameFlag()
	{
		return this.nameFlag;
	}
	
	public void setNameFlag(String nameFlag)
	{
		this.nameFlag = nameFlag;
	}
	
	public Long getPortOperStatus()
	{
		return this.portOperStatus;
	}
	
	public void setPortOperStatus(Long portOperStatus)
	{
		this.portOperStatus = portOperStatus;
	}
	
	public Long getPortStatus()
	{
		return this.portStatus;
	}
	
	public void setPortStatus(Long portStatus)
	{
		this.portStatus = portStatus;
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
	
	public Long getDataCheckTimeDigital()
	{
		return this.dataCheckTimeDigital;
	}
	
	public void setDataCheckTimeDigital(Long dataCheckTimeDigital)
	{
		this.dataCheckTimeDigital = dataCheckTimeDigital;
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

	
	public String getFigureFillModel()
	{
		return figureFillModel;
	}

	
	public void setFigureFillModel(String figureFillModel)
	{
		this.figureFillModel = figureFillModel;
	}


	
	public Long getPortsetState()
	{
		return portsetState;
	}


	
	public void setPortsetState(Long portsetState)
	{
		this.portsetState = portsetState;
	}


	
	public String getDiTableName()
	{
		return diTableName;
	}


	
	public void setDiTableName(String diTableName)
	{
		this.diTableName = diTableName;
	}


	
}