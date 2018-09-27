package nis.nms.domains;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * NodegroupTable entity.
 * 
 * @author MyEclipse Persistence Tools
 */

public class NodegroupTable implements java.io.Serializable
{
	
	// Fields
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private Long groupId;
	private String groupName;
	private Long viewLevel;
	private Long createUserId;// 查看权限为组时，所选组的id
	private Long createUsergroupId;
	private Long groupType;
	private String groupDesc;
	private Long systemId;
	private Long isValid;// 0是失效，1是生效
	private Date groupCreatetime;
	private String systemIdName;
	private String userGroupIdName;// 查看权限为组时，所选组的name？
	private Long parentGroupId;// 父节点ID
	private Long leafGroup;// 是否为叶子节点组
	private Long groupLevel;// 组级别
	private Long showIndex;// 显示序号
	
	// 3D机房展示节点组状态 0正常 1异常
	private int status;
	// 3D机房展示 节点组告警信息
	private String alramInfo;
	
	// Constructors
	
	public Long getParentGroupId()
	{
		return parentGroupId;
	}
	
	public void setParentGroupId(Long parentGroupId)
	{
		this.parentGroupId = parentGroupId;
	}
	
	public Long getLeafGroup()
	{
		return leafGroup;
	}
	
	public void setLeafGroup(Long leafGroup)
	{
		this.leafGroup = leafGroup;
	}
	
	public Long getGroupLevel()
	{
		return groupLevel;
	}
	
	public void setGroupLevel(Long groupLevel)
	{
		this.groupLevel = groupLevel;
	}
	
	public Long getShowIndex()
	{
		return showIndex;
	}
	
	public void setShowIndex(Long showIndex)
	{
		this.showIndex = showIndex;
	}
	
	/** default constructor */
	public NodegroupTable()
	{
	}
	
	/** minimal constructor */
	public NodegroupTable(String groupName, Long viewLevel, Long createUserId,
			Long createUsergroupId, Long groupType, Long systemId, Long isValid)
	{
		this.groupName = groupName;
		this.viewLevel = viewLevel;
		this.createUserId = createUserId;
		this.createUsergroupId = createUsergroupId;
		this.groupType = groupType;
		this.systemId = systemId;
		this.isValid = isValid;
	}
	
	/** full constructor */
	public NodegroupTable(String groupName, Long viewLevel, Long createUserId,
			Long createUsergroupId, Long groupType, String groupDesc, Long systemId, Long isValid,
			Date groupCreatetime)
	{
		this.groupName = groupName;
		this.viewLevel = viewLevel;
		this.createUserId = createUserId;
		this.createUsergroupId = createUsergroupId;
		this.groupType = groupType;
		this.groupDesc = groupDesc;
		this.systemId = systemId;
		this.isValid = isValid;
		this.groupCreatetime = groupCreatetime;
	}
	
	// Property accessors
	
	public Long getGroupId()
	{
		return this.groupId;
	}
	
	public void setGroupId(Long groupId)
	{
		this.groupId = groupId;
	}
	
	public String getGroupName()
	{
		return this.groupName;
	}
	
	public void setGroupName(String groupName)
	{
		this.groupName = groupName;
	}
	
	public Long getViewLevel()
	{
		return this.viewLevel;
	}
	
	public void setViewLevel(Long viewLevel)
	{
		this.viewLevel = viewLevel;
	}
	
	public Long getCreateUserId()
	{
		return this.createUserId;
	}
	
	public void setCreateUserId(Long createUserId)
	{
		this.createUserId = createUserId;
	}
	
	public Long getGroupType()
	{
		return this.groupType;
	}
	
	public void setGroupType(Long groupType)
	{
		this.groupType = groupType;
	}
	
	public String getGroupDesc()
	{
		return this.groupDesc;
	}
	
	public void setGroupDesc(String groupDesc)
	{
		this.groupDesc = groupDesc;
	}
	
	public Long getSystemId()
	{
		return this.systemId;
	}
	
	public void setSystemId(Long systemId)
	{
		this.systemId = systemId;
	}
	
	public Long getIsValid()
	{
		return this.isValid;
	}
	
	public void setIsValid(Long isValid)
	{
		this.isValid = isValid;
	}
	
	public Date getGroupCreatetime()
	{
		return groupCreatetime;
	}
	
	public void setGroupCreatetime(Date groupCreatetime)
	{
		this.groupCreatetime = groupCreatetime;
	}
	
	public String getSystemIdName()
	{
		return systemIdName;
	}
	
	public void setSystemIdName(String systemIdName)
	{
		this.systemIdName = systemIdName;
	}
	
	public Long getCreateUsergroupId()
	{
		return createUsergroupId;
	}
	
	public void setCreateUsergroupId(Long createUsergroupId)
	{
		this.createUsergroupId = createUsergroupId;
	}
	
	public String getUserGroupIdName()
	{
		return userGroupIdName;
	}
	
	public void setUserGroupIdName(String userGroupIdName)
	{
		this.userGroupIdName = userGroupIdName;
	}
	
	
	public int getStatus()
	{
		return status;
	}
	
	public void setStatus(int status)
	{
		this.status = status;
	}

	
	public String getAlramInfo()
	{
		return alramInfo;
	}

	
	public void setAlramInfo(String alramInfo)
	{
		this.alramInfo = alramInfo;
	}
	
}