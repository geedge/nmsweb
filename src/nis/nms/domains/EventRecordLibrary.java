package nis.nms.domains;

import java.util.Date;

/**
 * EventRecordLibrary entity.
 * 
 * @author MyEclipse Persistence Tools
 */

public class EventRecordLibrary implements java.io.Serializable {

	// Fields

	private Long id;
	private String recordType;
	private String recordContent;
//	private String seqIds;
	private Long state;
	private String recordCommand;
	private Long nmsserverId;
	private Date createTime;		//  创建时间
//	private Long pid;		//父ID
//	private String tableName;		//	操作表
//	private Long tableId;		//表主键
	
	// Constructors

	/** default constructor */
	public EventRecordLibrary() {
	}

	/** full constructor */
	public EventRecordLibrary(String recordType, String recordContent,
			Long state, String recordCommand) {
		this.recordType = recordType;
		this.recordContent = recordContent;
//		this.seqIds = seqIds;
		this.state = state;
		this.recordCommand = recordCommand;
	}

	// Property accessors

	public Long getId() {
		return this.id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getRecordType() {
		return this.recordType;
	}

	public void setRecordType(String recordType) {
		this.recordType = recordType;
	}

	public String getRecordContent() {
		return this.recordContent;
	}

	public void setRecordContent(String recordContent) {
		this.recordContent = recordContent;
	}

//	public String getSeqIds() {
//		return this.seqIds;
//	}
//
//	public void setSeqIds(String seqIds) {
//		this.seqIds = seqIds;
//	}

	public Long getState() {
		return this.state;
	}

	public void setState(Long state) {
		this.state = state;
	}

	public String getRecordCommand() {
		return this.recordCommand;
	}

	public void setRecordCommand(String recordCommand) {
		this.recordCommand = recordCommand;
	}

//	public Long getPid() {
//		return pid;
//	}
//
//	public void setPid(Long pid) {
//		this.pid = pid;
//	}

	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	public Long getNmsserverId() {
		return nmsserverId;
	}

	public void setNmsserverId(Long nmsserverId) {
		this.nmsserverId = nmsserverId;
	}

//	public String getTableName() {
//		return tableName;
//	}
//
//	public void setTableName(String tableName) {
//		this.tableName = tableName;
//	}
//
//	public Long getTableId() {
//		return tableId;
//	}
//
//	public void setTableId(Long tableId) {
//		this.tableId = tableId;
//	}

}