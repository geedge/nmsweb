package nis.nms.domains;

import java.util.Date;

/**
 * NodegroupArrowPosition entity.
 * 
 * @author MyEclipse Persistence Tools
 */

public class NodegroupArrowPosition implements java.io.Serializable
{
	
	// Fields
	
	private Long id;
	private Long systemId;
	private NodegroupTable srcNodeGroup;
	private NodegroupTable descNodeGroup;
	private Long figureX;
	private Long figureY;
	private Long figureWidth;
	private Long figureHeight;
	private String figureFill;
	private Date createTime;
	private Long createUserid;
	private Date lastUpdateTime;
	private Long lastUpdateUserid;
	
	// Constructors
	
	/** default constructor */
	public NodegroupArrowPosition()
	{
	}
	
	/** minimal constructor */
	public NodegroupArrowPosition(Long figureX, Long figureY, Long figureWidth, Long figureHeight,
			String figureFill)
	{
		this.figureX = figureX;
		this.figureY = figureY;
		this.figureWidth = figureWidth;
		this.figureHeight = figureHeight;
		this.figureFill = figureFill;
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
	
	public String getFigureFill()
	{
		return this.figureFill;
	}
	
	public void setFigureFill(String figureFill)
	{
		this.figureFill = figureFill;
	}
	
	public Date getCreateTime()
	{
		return this.createTime;
	}
	
	public void setCreateTime(Date createTime)
	{
		this.createTime = createTime;
	}
	
	public Long getCreateUserid()
	{
		return this.createUserid;
	}
	
	public void setCreateUserid(Long createUserid)
	{
		this.createUserid = createUserid;
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
	
	public NodegroupTable getSrcNodeGroup()
	{
		return srcNodeGroup;
	}
	
	public void setSrcNodeGroup(NodegroupTable srcNodeGroup)
	{
		this.srcNodeGroup = srcNodeGroup;
	}
	
	public NodegroupTable getDescNodeGroup()
	{
		return descNodeGroup;
	}
	
	public void setDescNodeGroup(NodegroupTable descNodeGroup)
	{
		this.descNodeGroup = descNodeGroup;
	}

	
	public Long getSystemId()
	{
		return systemId;
	}

	
	public void setSystemId(Long systemId)
	{
		this.systemId = systemId;
	}
	
}