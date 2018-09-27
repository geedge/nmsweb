/**
 * 
 */
package nis.nms.core;

import java.util.List;

/**
 * @author Administrator
 *
 */
public class NewResource {

    private Long rsid;
    private String rsname;
    private Long number;
    private String rsdesc;
    private String rsaddress;
    private String business;
    private Long rsCode;
    private Long parRsCode;
    private List cRsList;
    private String position;
    
    public String getPosition() {
		return position;
	}

	public void setPosition(String position) {
		this.position = position;
	}

	public NewResource() {
    }
    
    /** full constructor */
    
	public List getCRsList() {
		return cRsList;
	}
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
	/**
	 * @param args
	 */
	public static void main(String[] args) {
		// TODO 自动生成方法存根

	}

}
