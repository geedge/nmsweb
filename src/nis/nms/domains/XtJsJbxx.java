package nis.nms.domains;

import java.util.Date;

/**
 * XtJsJbxx entity.
 * 
 * @author MyEclipse Persistence Tools
 */

public class XtJsJbxx implements java.io.Serializable {

	// Fields

	/**
	 * 
	 */
	private static final long serialVersionUID = 5171001063604851539L;
	private Long jsbh;
	private String jsmc;
	private String jsms;
	private String zxbz;
	private Date ctime;
	private String isChecked;
	//1为用户组，空或者0表示为角色
	private Long type;
	// Constructors

	public String getIsChecked() {
		return isChecked;
	}

	public void setIsChecked(String isChecked) {
		this.isChecked = isChecked;
	}

	/** default constructor */
	public XtJsJbxx() {
	}

	/** minimal constructor */
	public XtJsJbxx(Long jsbh) {
		this.jsbh = jsbh;
	}

	/** full constructor */
	public XtJsJbxx(Long jsbh, String jsmc, String jsms, String zxbz,
			Date ctime) {
		this.jsbh = jsbh;
		this.jsmc = jsmc;
		this.jsms = jsms;
		this.zxbz = zxbz;
		this.ctime = ctime;
	}

	// Property accessors

	public Long getJsbh() {
		return this.jsbh;
	}

	public void setJsbh(Long jsbh) {
		this.jsbh = jsbh;
	}

	public String getJsmc() {
		return this.jsmc;
	}

	public void setJsmc(String jsmc) {
		this.jsmc = jsmc;
	}

	public String getJsms() {
		return this.jsms;
	}

	public void setJsms(String jsms) {
		this.jsms = jsms;
	}

	public String getZxbz() {
		return this.zxbz;
	}

	public void setZxbz(String zxbz) {
		this.zxbz = zxbz;
	}

	public Date getCtime() {
		return this.ctime;
	}

	public void setCtime(Date ctime) {
		this.ctime = ctime;
	}

	public Long getType() {
		return type;
	}

	public void setType(Long type) {
		this.type = type;
	}

}