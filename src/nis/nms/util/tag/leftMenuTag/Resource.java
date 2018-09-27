/**
 * 
 */
package nis.nms.util.tag.leftMenuTag;

import java.util.List;

/**
 * @author Administrator
 *
 */
public class Resource {

    private Long rsid;  
    /**显示的菜单名*/
    private String rsname;
    private Long number;
    private String rsdesc;
    /**当前菜单的链接*/
    private String rsaddress;
    private String business;
    /**当前菜单的id*/
    private Long rsCode;
    /**当前菜单父菜单的id*/
    private Long parRsCode;
    @SuppressWarnings("unchecked")
	private List cRsList;
    /**菜单样式*/
    private String menucss;
    
	public String getMenucss() {
		return menucss;
	}

	public void setMenucss(String menucss) {
		this.menucss = menucss;
	}

	public Resource() {
    }
    
    /** full constructor */
    
	@SuppressWarnings("unchecked")
	public List getCRsList() {
		return cRsList;
	}
	@SuppressWarnings("unchecked")
	public void setCRsList(List rsList) {
		cRsList = rsList;
	}
	public Long getParRsCode() {
		return parRsCode;
	}

	public void setParRsCode(Long parRsCode) {
		this.parRsCode = parRsCode;
	}

	public String getBusiness() {
		return business;
	}
	public void setBusiness(String business) {
		this.business = business;
	}
	public Long getNumber() {
		return number;
	}
	public void setNumber(Long number) {
		this.number = number;
	}
	public String getRsaddress() {
		return rsaddress;
	}
	public void setRsaddress(String rsaddress) {
		this.rsaddress = rsaddress;
	}
	public Long getRsCode() {
		return rsCode;
	}
	public void setRsCode(Long rsCode) {
		this.rsCode = rsCode;
	}
	public String getRsdesc() {
		return rsdesc;
	}
	public void setRsdesc(String rsdesc) {
		this.rsdesc = rsdesc;
	}
	public Long getRsid() {
		return rsid;
	}
	public void setRsid(Long rsid) {
		this.rsid = rsid;
	}
	public String getRsname() {
		return rsname;
	}
	public void setRsname(String rsname) {
		this.rsname = rsname;
	}

}
