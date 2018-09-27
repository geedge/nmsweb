package nis.nms.domains;

import java.util.Date;

public class NodeGroupPosition implements java.io.Serializable
{
	
	private Long id;
	private Long systemId;
	private NodegroupTable nodeGroup;
	private Long pgroupId;
	private Long showLevel;
	private Long showIndex;
	private String figureType;
	private Long figureX;
	private Long figureY;
	private Long figureWidth;
	private Long figureHeight;
	private String figureStroke;
	private Long figureStrokeWidth;
	private String figureFill;
	private Long showStatus;
	private Date addTime;
	private Long addUserid;
	private Date lastUpdateTime;
	private Long lastUpdateUserid;
	
	public NodeGroupPosition()
	{
	}
	
	
	public Long getId()
	{
		return id;
	}
	
	public void setId(Long id)
	{
		this.id = id;
	}
	
	public Long getSystemId()
	{
		return systemId;
	}
	
	public void setSystemId(Long systemId)
	{
		this.systemId = systemId;
	}
	
	public Long getPgroupId()
	{
		return pgroupId;
	}
	
	public void setPgroupId(Long pgroupId)
	{
		this.pgroupId = pgroupId;
	}
	
	public Long getShowLevel()
	{
		return showLevel;
	}
	
	public void setShowLevel(Long showLevel)
	{
		this.showLevel = showLevel;
	}
	
	public Long getShowIndex()
	{
		return showIndex;
	}
	
	public void setShowIndex(Long showIndex)
	{
		this.showIndex = showIndex;
	}
	
	public String getFigureType()
	{
		return figureType;
	}
	
	public void setFigureType(String figureType)
	{
		this.figureType = figureType;
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
	
	public Long getFigureWidth()
	{
		return figureWidth;
	}
	
	public void setFigureWidth(Long figureWidth)
	{
		this.figureWidth = figureWidth;
	}
	
	public Long getFigureHeight()
	{
		return figureHeight;
	}
	
	public void setFigureHeight(Long figureHeight)
	{
		this.figureHeight = figureHeight;
	}
	
	public String getFigureStroke()
	{
		return figureStroke;
	}
	
	public void setFigureStroke(String figureStroke)
	{
		this.figureStroke = figureStroke;
	}
	
	public Long getFigureStrokeWidth()
	{
		return figureStrokeWidth;
	}
	
	public void setFigureStrokeWidth(Long figureStrokeWidth)
	{
		this.figureStrokeWidth = figureStrokeWidth;
	}
	
	public String getFigureFill()
	{
		return figureFill;
	}
	
	public void setFigureFill(String figureFill)
	{
		this.figureFill = figureFill;
	}
	
	public Long getShowStatus()
	{
		return showStatus;
	}
	
	public void setShowStatus(Long showStatus)
	{
		this.showStatus = showStatus;
	}
	
	public Date getAddTime()
	{
		return addTime;
	}
	
	public void setAddTime(Date addTime)
	{
		this.addTime = addTime;
	}
	
	public Long getAddUserid()
	{
		return addUserid;
	}
	
	public void setAddUserid(Long addUserid)
	{
		this.addUserid = addUserid;
	}
	
	public Date getLastUpdateTime()
	{
		return lastUpdateTime;
	}
	
	public void setLastUpdateTime(Date lastUpdateTime)
	{
		this.lastUpdateTime = lastUpdateTime;
	}
	
	public Long getLastUpdateUserid()
	{
		return lastUpdateUserid;
	}
	
	public void setLastUpdateUserid(Long lastUpdateUserid)
	{
		this.lastUpdateUserid = lastUpdateUserid;
	}

	
	public NodegroupTable getNodeGroup()
	{
		return nodeGroup;
	}

	
	public void setNodeGroup(NodegroupTable nodeGroup)
	{
		this.nodeGroup = nodeGroup;
	}
	
}