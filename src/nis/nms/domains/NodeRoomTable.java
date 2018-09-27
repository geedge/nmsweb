package nis.nms.domains;

import java.util.Date;
import java.util.Map;

/**
 * NodeRoomTable entity.
 * 
 * @author MyEclipse Persistence Tools
 */

public class NodeRoomTable implements java.io.Serializable
{
	
	// Fields
	
	private Long roomId;
	private String roomIspn;
	private String roomDesc;
	private Long roomRows;
	private Long roomCols;
	private Long createUserId;
	private Date createDatetime;
	private Long updateUserId;
	private Date updateDatetime;
	
	//3d机房
	private NodegroupTable nodegroupTable;
	//3d机房展示给个位置上的机柜
	private Map<String, NodeBoxTable> nodeBoxMap;
	private String nodeBoxInfo;
	
	// Constructors
	
	/** default constructor */
	public NodeRoomTable()
	{
	}
	
	/** minimal constructor */
	public NodeRoomTable(Long roomId, String roomIspn)
	{
		this.roomId = roomId;
		this.roomIspn = roomIspn;
	}
	
	/** full constructor */
	public NodeRoomTable(Long roomId, String roomIspn, String roomDesc, Long roomRows,
			Long roomCols, Long createUserId, Date createDatetime, Long updateUserId,
			Date updateDatetime)
	{
		this.roomId = roomId;
		this.roomIspn = roomIspn;
		this.roomDesc = roomDesc;
		this.roomRows = roomRows;
		this.roomCols = roomCols;
		this.createUserId = createUserId;
		this.createDatetime = createDatetime;
		this.updateUserId = updateUserId;
		this.updateDatetime = updateDatetime;
	}
	
	// Property accessors
	
	public Long getRoomId()
	{
		return this.roomId;
	}
	
	public void setRoomId(Long roomId)
	{
		this.roomId = roomId;
	}
	
	public String getRoomIspn()
	{
		return this.roomIspn;
	}
	
	public void setRoomIspn(String roomIspn)
	{
		this.roomIspn = roomIspn;
	}
	
	public String getRoomDesc()
	{
		return this.roomDesc;
	}
	
	public void setRoomDesc(String roomDesc)
	{
		this.roomDesc = roomDesc;
	}
	
	public Long getRoomRows()
	{
		return this.roomRows;
	}
	
	public void setRoomRows(Long roomRows)
	{
		this.roomRows = roomRows;
	}
	
	public Long getRoomCols()
	{
		return this.roomCols;
	}
	
	public void setRoomCols(Long roomCols)
	{
		this.roomCols = roomCols;
	}
	
	public Long getCreateUserId()
	{
		return this.createUserId;
	}
	
	public void setCreateUserId(Long createUserId)
	{
		this.createUserId = createUserId;
	}
	
	public Date getCreateDatetime()
	{
		return this.createDatetime;
	}
	
	public void setCreateDatetime(Date createDatetime)
	{
		this.createDatetime = createDatetime;
	}
	
	public Long getUpdateUserId()
	{
		return this.updateUserId;
	}
	
	public void setUpdateUserId(Long updateUserId)
	{
		this.updateUserId = updateUserId;
	}
	
	public Date getUpdateDatetime()
	{
		return this.updateDatetime;
	}
	
	public void setUpdateDatetime(Date updateDatetime)
	{
		this.updateDatetime = updateDatetime;
	}
	
	public NodegroupTable getNodegroupTable()
	{
		return nodegroupTable;
	}
	
	public void setNodegroupTable(NodegroupTable nodegroupTable)
	{
		this.nodegroupTable = nodegroupTable;
	}

	
	public Map<String, NodeBoxTable> getNodeBoxMap()
	{
		return nodeBoxMap;
	}

	
	public void setNodeBoxMap(Map<String, NodeBoxTable> nodeBoxMap)
	{
		this.nodeBoxMap = nodeBoxMap;
	}

	
	public String getNodeBoxInfo()
	{
		return nodeBoxInfo;
	}

	
	public void setNodeBoxInfo(String nodeBoxInfo)
	{
		this.nodeBoxInfo = nodeBoxInfo;
	}
	
}