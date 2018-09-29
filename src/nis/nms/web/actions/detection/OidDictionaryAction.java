package nis.nms.web.actions.detection;                        
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;

import nis.nms.domains.NodeBoxTable;
import nis.nms.domains.NodeLatticeTable;
import nis.nms.domains.OidDictionary;
import nis.nms.domains.SystemTable;
import nis.nms.domains.TroubleState;
import nis.nms.domains.TypeTable;
import nis.nms.domains.XtYhJbxx;
import nis.nms.service.CommonService;
import nis.nms.util.BaseAction;
import nis.nms.util.Page;

import org.apache.log4j.Logger;
import org.apache.struts2.config.Result;
import org.apache.struts2.config.Results;


@SuppressWarnings("unchecked")
@Results( { 
	@Result(name="queryOidDictionaryInfo", value = "/page/detection/oidDictionary/oidDictionaryList.jsp"),
	@Result(name="addOidDictionary", value = "/page/detection/oidDictionary/addOidDictionary.jsp"),
	@Result(name="updateOidDictionary", value = "/page/detection/oidDictionary/updateOidDictionary.jsp"),
	@Result(name="detailOidDictionary", value = "/page/detection/oidDictionary/detailOidDictionary.jsp")
})

/**
 * 监测设置相关操作
 */
public class OidDictionaryAction extends BaseAction {
	private Logger logger = Logger.getLogger(OidDictionaryAction.class);
	private static final long serialVersionUID = 1L;
	private CommonService commonService;
	private int pageNo = 1;
	private int pageSize =this.getDefaultPageSize();		//每页显示的记录条数
	private Page page;
	private String action;
	private List<OidDictionary> oidDictionaryList;
	private OidDictionary od;
	private String odid;

	@Override
	public String executeAction() throws Exception {
		String resultpage = "";
		if("query".equals(this.action)){
			resultpage = this.queryDictionary();
		}else if("openAdd".equals(this.action)){
			resultpage = "addOidDictionary";
		}else if("doAdd".equals(this.action)){
			addOidDictionary();
			return null;
		}else if("openUpdate".equals(this.action)){
			resultpage = this.openUpdOidDictionary();
		}else if("doUpdate".equals(this.action)){
			doUpdOidDictionary();
			return null;
		}else{
			resultpage = this.queryDictionary();
		}
		return resultpage;
	}
	
	public String queryDictionary(){
		try {
			//查询oid字典
			String oidhql = "from OidDictionary order by id";
			page = this.commonService.findByPage(oidhql, pageNo, pageSize);
			oidDictionaryList = (List<OidDictionary>)page.getResult();
		} catch (Exception e) {
			logger.error(e.getStackTrace());
			this.outHtmlString("<script>alert('i18n_OidDictionaryAction.queryDictionary.queryDictFaild_n81i');history.back();</script>");
			return null;
		}
		return "queryOidDictionaryInfo";
	}
	
	public void addOidDictionary(){
		try {
			commonService.beginTransaction();
			if(checkOid(od.getOid())){
				this.commonService.save(od);
				// 将添加操作写到操作日志中
				this.addDBOperationRpt(commonService, "oid_dictionary", "INSERT",
						od.getId());
				outHtmlString("<script type=\"text/javascript\">alert('i18n_OidDictionaryAction.queryDictionary.faild_n81i');this.location='oidDictionary.do?action=query&pageNo="+pageNo+"&pageSize="+pageSize+"'</script>");
			}else{
				this.outHtmlString("<script>alert('i18n_OidDictionaryAction.queryDictionary.oidExists_n81i');history.back();</script>");
				return;
			}
			commonService.commit();
		} catch (Exception e) {
			commonService.rollback();
			logger.error(e.getStackTrace());
			this.outHtmlString("<script>alert('i18n_OidDictionaryAction.queryDictionary.addBoxFaild_n81i');history.back();</script>");
			return;
		}
	}
	
	public String openUpdOidDictionary(){
		try {
			if(odid!=null && !"".equals(odid)){
				List list = this.commonService.find(
						"from OidDictionary where id=?", Long.parseLong(odid));
				if(list!=null && list.size()>0){
					od = (OidDictionary)list.get(0);
				}
			}
		} catch (Exception e) {
			logger.error(e.getStackTrace());
			this.outHtmlString("<script>alert('i18n_OidDictionaryAction.queryDictionary.openUpdateViewFaild_n81i');history.back();</script>");
			return null;
		}
		
		return "updateOidDictionary";
		
	}
	
	public void doUpdOidDictionary(){
		try {
			commonService.beginTransaction();
			List list = this.commonService.find("from OidDictionary where oid=? and id<>?",
					od.getOid().trim(),od.getId());
			if (list != null && list.size() > 0){
				this.outHtmlString("<script>alert('i18n_OidDictionaryAction.queryDictionary.recordExists_n81i');history.back();</script>");
				return;
			}
			OidDictionary md = (OidDictionary) commonService.get(OidDictionary.class, od
					.getId());
			md.setOid(od.getOid());
			md.setOidDesc(od.getOidDesc());
			this.commonService.update(md);
			// 将更新操作写到操作日志中
			this.addDBOperationRpt(commonService, "oid_dictionary", "UPDATE",
					md.getId());
			commonService.commit();
			outHtmlString("<script type=\"text/javascript\">alert('i18n_OidDictionaryAction.queryDictionary.success_n81i');this.location='oidDictionary.do?action=query&pageNo="+pageNo+"&pageSize="+pageSize+"'</script>");
		} catch (Exception e) {
			commonService.rollback();
			logger.error(e.getStackTrace());
			this.outHtmlString("<script>alert('i18n_OidDictionaryAction.queryDictionary.updateFaild_n81i');history.back();</script>");
			return;
		}
	}
	
	public boolean checkOid(String oid){
		boolean checkResu = true;
		try {
			String sql = "select count(*) from oid_dictionary t where oid ='"+oid+"'";
			List list = this.commonService.executeSQL(sql);
			if(list!=null && list.get(0)!=null){
				int num = Integer.parseInt(list.get(0).toString());
				if(num>0){
					checkResu = false;
				}
			}
		} catch (NumberFormatException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return checkResu;
	}
	
	public CommonService getCommonService() {
		return commonService;
	}

	public void setCommonService(CommonService commonService) {
		this.commonService = commonService;
	}

	public int getPageNo() {
		return pageNo;
	}

	public void setPageNo(int pageNo) {
		this.pageNo = pageNo;
	}

	public int getPageSize() {
		return pageSize;
	}

	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}

	public Page getPage() {
		return page;
	}

	public void setPage(Page page) {
		this.page = page;
	}

	public String getAction() {
		return action;
	}

	public void setAction(String action) {
		this.action = action;
	}

	public String getOdid() {
		return odid;
	}

	public void setOdid(String odid) {
		this.odid = odid;
	}

	public List<OidDictionary> getOidDictionaryList() {
		return oidDictionaryList;
	}

	public void setOidDictionaryList(List<OidDictionary> oidDictionaryList) {
		this.oidDictionaryList = oidDictionaryList;
	}

	public OidDictionary getOd() {
		return od;
	}

	public void setOd(OidDictionary od) {
		this.od = od;
	}

}
