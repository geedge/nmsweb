package nis.nms.domains;

import java.util.Date;

/**
 * MissionFileInformation entity.
 * 
 * @author MyEclipse Persistence Tools
 */

public class MissionFileInformation implements java.io.Serializable {

	// Fields

	/**
	 * 
	 */
	private static final long serialVersionUID = 3494926911304406210L;
	private long id;
	private long missionId;
	private String fileName;
	private String md5Value;
	private Date createTime;

	// Constructors

	/** default constructor */
	public MissionFileInformation() {
	}

	/** full constructor */
	public MissionFileInformation(long missionId, String fileName,
			String md5Value, Date createTime) {
		this.missionId = missionId;
		this.fileName = fileName;
		this.md5Value = md5Value;
		this.createTime = createTime;
	}

	// Property accessors

	public long getId() {
		return this.id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public long getMissionId() {
		return this.missionId;
	}

	public void setMissionId(long missionId) {
		this.missionId = missionId;
	}

	public String getFileName() {
		return this.fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public String getMd5Value() {
		return this.md5Value;
	}

	public void setMd5Value(String md5Value) {
		this.md5Value = md5Value;
	}
	public Date getCreateTime() {
		return this.createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

}