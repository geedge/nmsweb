package nis.nms.domains;

import java.util.Date;

/**
 * XtMkGnJbxx entity.
 * 
 * @author MyEclipse Persistence Tools
 */

public class XtMkGnJbxx implements java.io.Serializable {

	// Fields

	private Long gnbh;
	private String mkbh;
	private String gnmc;
	private String gnms;
	private String gnurl;
	private String zxbz;
	private Date ctime;

	// Constructors

	/** default constructor */
	public XtMkGnJbxx() {
	}

	/** minimal constructor */
	public XtMkGnJbxx(Long gnbh) {
		this.gnbh = gnbh;
	}

	/** full constructor */
	public XtMkGnJbxx(Long gnbh, String mkbh, String gnmc, String gnms,
			String gnurl, String zxbz, Date ctime) {
		this.gnbh = gnbh;
		this.mkbh = mkbh;
		this.gnmc = gnmc;
		this.gnms = gnms;
		this.gnurl = gnurl;
		this.zxbz = zxbz;
		this.ctime = ctime;
	}

	// Property accessors

	public Long getGnbh() {
		return this.gnbh;
	}

	public void setGnbh(Long gnbh) {
		this.gnbh = gnbh;
	}

	public String getMkbh() {
		return this.mkbh;
	}

	public void setMkbh(String mkbh) {
		this.mkbh = mkbh;
	}

	public String getGnmc() {
		return this.gnmc;
	}

	public void setGnmc(String gnmc) {
		this.gnmc = gnmc;
	}

	public String getGnms() {
		return this.gnms;
	}

	public void setGnms(String gnms) {
		this.gnms = gnms;
	}

	public String getGnurl() {
		return this.gnurl;
	}

	public void setGnurl(String gnurl) {
		this.gnurl = gnurl;
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

}