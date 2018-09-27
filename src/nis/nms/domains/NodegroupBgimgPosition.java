package nis.nms.domains;

import java.util.Date;

/**
 * NodegroupBgimgPosition entity.
 * 
 * @author MyEclipse Persistence Tools
 */

public class NodegroupBgimgPosition implements java.io.Serializable
{
	
	// Fields
	
	private Long id;
	private Long systemId;
	private Long groupId;
	private Long figureX;
	private Long figureY;
	private Long figureWidth;
	private Long figureHeight;
	private String figureFill;
	private Date createTime;
	private Long createUserid;
	private Date lastUpdateTime;
	private Long lastUpdateUserid;
	private String nodeInfo;
	
	// Constructors
	
	/** default constructor */
	public NodegroupBgimgPosition()
	{
	}
	
	/** minimal constructor */
	public NodegroupBgimgPosition(Long systemId, Long groupId, Long figureX, Long figureY,
			Long figureWidth, Long figureHeight, String figureFill)
	{
		this.systemId = systemId;
		this.groupId = groupId;
		this.figureX = figureX;
		this.figureY = figureY;
		this.figureWidth = figureWidth;
		this.figureHeight = figureHeight;
		this.figureFill = figureFill;
	}
	
	/** full constructor */
	public NodegroupBgimgPosition(Long systemId, Long groupId, Long figureX, Long figureY,
			Long figureWidth, Long figureHeight, String figureFill, Date createTime,
			Long createUserid, Date lastUpdateTime, Long lastUpdateUserid)
	{
		this.systemId = systemId;
		this.groupId = groupId;
		this.figureX = figureX;
		this.figureY = figureY;
		this.figureWidth = figureWidth;
		this.figureHeight = figureHeight;
		this.figureFill = figureFill;
		this.createTime = createTime;
		this.createUserid = createUserid;
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
	
	public Long getSystemId()
	{
		return this.systemId;
	}
	
	public void setSystemId(Long systemId)
	{
		this.systemId = systemId;
	}
	
	public Long getGroupId()
	{
		return this.groupId;
	}
	
	public void setGroupId(Long groupId)
	{
		this.groupId = groupId;
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
	
	public String getNodeInfo()
	{
		return nodeInfo;
	}
	
	public void setNodeInfo(String nodeInfo)
	{
		this.nodeInfo = nodeInfo;
	}
	
}