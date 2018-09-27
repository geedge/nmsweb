package nis.nms.domains;

import java.util.Date;

/**
 * XtYhJsIndex entity.
 * 
 * @author MyEclipse Persistence Tools
 */

public class XtYhJsIndex implements java.io.Serializable {

	// Fields

	/**
	 * 
	 */
	private static final long serialVersionUID = -8535241672692702338L;
	private Long id;
	private String yhbh;
	private Long jsbh;
	private Date ctime;
	private Long type;
	private Long yhId;

	// Constructors

	/** default constructor */
	public XtYhJsIndex() {
	}

	/** minimal constructor */
	public XtYhJsIndex(Long id) {
		this.id = id;
	}

	/** full constructor */
	public XtYhJsIndex(Long id, String yhbh, Long jsbh, Date ctime) {
		this.id = id;
		this.yhbh = yhbh;
		this.jsbh = jsbh;
		this.ctime = ctime;
	}

	// Property accessors

	public Long getId() {
		return this.id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getYhbh() {
		return this.yhbh;
	}

	public void setYhbh(String yhbh) {
		this.yhbh = yhbh;
	}

	public Long getJsbh() {
		return this.jsbh;
	}

	public void setJsbh(Long jsbh) {
		this.jsbh = jsbh;
	}

	public Date getCtime() {
		return this.ctime;
	}

	public void setCtime(Date ctime) {
		this.ctime = ctime;
	}

	public Long getYhId() {
		return yhId;
	}

	public void setYhId(Long yhId) {
		this.yhId = yhId;
	}

	public Long getType() {
		return type;
	}

	public void setType(Long type) {
		this.type = type;
	}

}