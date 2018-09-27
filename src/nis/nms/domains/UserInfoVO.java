package nis.nms.domains;
import java.util.Date;

public class UserInfoVO implements java.io.Serializable {

	// Fields

	
	private static final long serialVersionUID = 1L;
	private Long yhid;
	private String yhbh;	//用户名
	private String yhmm;	//密码
	private String yhmc;	//名称
	private String email;
	private String zxbz;	//状态
	private Date ctime;//创建时间
	
	private String showError;
	
	/** default constructor */
	public UserInfoVO() {
	}

	/** full constructor */
	public UserInfoVO(Long yhid, String yhbh, String yhmm, String yhmc,String showError,
		String zxbz, Date ctime) {
		this.yhid = yhid;
		this.yhbh = yhbh;
		this.yhmm = yhmm;
		this.yhmc = yhmc;
		this.zxbz = zxbz;
		this.ctime = ctime;
		this.showError =showError;
	}

	// Property accessors

	public Long getYhid() {
		return this.yhid;
	}

	public void setYhid(Long yhid) {
		this.yhid = yhid;
	}

	public String getYhbh() {
		return this.yhbh;
	}

	public void setYhbh(String yhbh) {
		this.yhbh = yhbh;
	}

	public String getYhmm() {
		return this.yhmm;
	}

	public void setYhmm(String yhmm) {
		this.yhmm = yhmm;
	}

	public String getYhmc() {
		return this.yhmc;
	}

	public void setYhmc(String yhmc) {
		this.yhmc = yhmc;
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

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getShowError() {
		return showError;
	}

	public void setShowError(String showError) {
		this.showError = showError;
	}

}