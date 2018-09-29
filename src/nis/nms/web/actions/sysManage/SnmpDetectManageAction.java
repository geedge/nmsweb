package nis.nms.web.actions.sysManage;

import java.util.ArrayList;
import java.util.List;

import nis.nms.domains.SortInfo;
import nis.nms.service.CommonService;
import nis.nms.util.BaseAction;
import nis.nms.util.Page;

import org.apache.struts2.config.Result;
import org.apache.struts2.config.Results;

@SuppressWarnings("unchecked")
@Results( {
		@Result(name = "snmpDetectTypeList", value = "/page/system/snmpDetectTypeManage/snmpDetectTypeInfoList.jsp"),
		@Result(name = "toAddSnmpDetectType", value = "/page/system/snmpDetectTypeManage/addSnmpDetectTypeInfo.jsp"),
		@Result(name = "toUpdateSnmpDetectType", value = "/page/system/snmpDetectTypeManage/updateSnmpDetectTypeInfo.jsp"),
		@Result(name = "detailSnmpDetectType", value = "/page/system/snmpDetectTypeManage/detailSnmpDetectTypeInfo.jsp"),

		@Result(name = "error", value = "/error.jsp") })
public class SnmpDetectManageAction extends BaseAction {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private CommonService commonService;
	
	private int pageNo = 1;
	private int pageSize = this.getDefaultPageSize(); // 每页显示的记录条数
	private Page page;
	
	private String action;// 系统操作
	
	private List<SortInfo> sortInfoList = new ArrayList();
	private SortInfo sortInfo;//保存snmp监测项信息
	private String sortNameForSearch;// snmp监测类型名称,snmp监测项列表查询的时候输入的条件
	private String ids;//snmp监测项列表，选中的snmp监测项的id
	
	private String position;

	public String executeAction() {
		try {
            // snmp监测项管理
			if (action.equals("querySnmpDetectTypeInfo")) {// 查询snmp监测项列表
				querySnmpDetectTypeInfo();
				return "snmpDetectTypeList";
			}
			if (action.equals("toAddSnmpDetectType")) {//新增snmp监测项页面
				toAddSnmpDetectType();
				return "toAddSnmpDetectType";
			}
			if (action.equals("addSnmpDetectType")) {//新增snmp监测项操作
				addSnmpDetectType();
				return null;
			}
			if (action.equals("toUpdateSnmpDetectType")) {//修改snmp监测项页面
				toUpdateSnmpDetectType();
				return "toUpdateSnmpDetectType";
			}
			if (action.equals("updateSnmpDetectType")) {//修改snmp监测项操作
				updateSnmpDetectType();
				return null;
			}			
			if (action.equals("detailSnmpDetectType")) {//查看snmp监测项详细信息
				detailSnmpDetectType();
				return "detailSnmpDetectType";
			}
			
			if (action.equals("deleteSnmpDetectType")) {//删除snmp监测项
				return deleteSnmpDetectType();
			}
		} catch (Exception e) {
			e.printStackTrace();
			return "error";
		}
		return null;
	}

    /**
     * 
     * 查询snmp监测项信息：查询条件+分页 
     * @author hyx Apr 6, 2012
     * @version 1.0 
     * @return
     */
	public String querySnmpDetectTypeInfo() {
		try {
			String hql = "from SortInfo where 1=1 ";
			String sqlCondition = "where 1=1";// 将查询条件记录到操作日志中
			if (sortNameForSearch != null && !"".equals(sortNameForSearch)) {
				hql += " and Upper(sortName) like '%" + sortNameForSearch.toUpperCase() + "%'";
				sqlCondition += " and Upper(sortName) like '%" + sortNameForSearch.toUpperCase() + "%'";
			}
			hql += "order by id";
			page = this.commonService.findByPage(hql, pageNo,pageSize);
			sortInfoList = (ArrayList<SortInfo>)page.getResult();

			// 将查询请求记入到操作日志表中
			this.addDBOperationRpt(commonService, sqlCondition,
					"SortInfo");
		} catch (Exception e) {
			e.printStackTrace();
			return "error";
		}
		return "snmpDetectTypeList";
	}
	
	//进入新增页面
	public String toAddSnmpDetectType() {
		System.out.println(sortNameForSearch);
		return null;
	}
	
	// 添加snmp监测项操作
	public String addSnmpDetectType() {
		try {
			commonService.beginTransaction();
			if(sortInfo!=null){
				this.commonService.save(sortInfo);
				// 将添加操作写到操作日志中
				this.addDBOperationRpt(commonService, "SortInfo", "INSERT",sortInfo.getId());
				outHtmlString("<script type=\"text/javascript\">alert('i18n_SnmpDetectManageAction.addSnmpDetectType.success_n81i');this.location='snmpDetectManage.do?action=querySnmpDetectTypeInfo'</script>");
			}
			commonService.commit();
		} catch (Exception e) {
			commonService.rollback();
			e.printStackTrace();
			outHtmlString("<script type=\"text/javascript\">alert('i18n_SnmpDetectManageAction.addSnmpDetectType.faild_n81i');this.location='snmpDetectManage.do?action=querySnmpDetectTypeInfo'</script>");
		}
		return null;
	}
	
	//进入修改页面
	public String toUpdateSnmpDetectType() {
		try {
			if(ids!=null&&!"".equals(ids) ){
				List list = this.commonService.find("from SortInfo where id=?", Long.valueOf(ids));
				if(list!=null && list.size()>0){
					sortInfo = (SortInfo)list.get(0);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			outHtmlString("<script type=\"text/javascript\">alert('i18n_SnmpDetectManageAction.addSnmpDetectType.faild_n81i');this.location='snmpDetectManage!execute.do?action=querySnmpDetectTypeInfo'</script>");
		}
		return null;
	}
	
	// 进行修改snmp监测项操作
	public String updateSnmpDetectType() {
		try {
			commonService.beginTransaction();
			SortInfo sortForUpdate = (SortInfo) commonService.get(SortInfo.class, sortInfo.getId());
			sortForUpdate.setSortName(sortInfo.getSortName());
			sortForUpdate.setSortDesc(sortInfo.getSortDesc());
			this.commonService.update(sortForUpdate);
			// 将更新操作写到操作日志中
			this.addDBOperationRpt(commonService, "SortInfo", "UPDATE",sortForUpdate.getId());
			outHtmlString("<script type=\"text/javascript\">alert('i18n_SnmpDetectManageAction.addSnmpDetectType.success_n81i');this.location='snmpDetectManage.do?action=querySnmpDetectTypeInfo&pageNo="+pageNo+"&pageSize="+pageSize+"'</script>");
			commonService.commit();
			return null;
		} catch (Exception e) {
			commonService.rollback();
			e.printStackTrace();
			outHtmlString("<script type=\"text/javascript\">alert('i18n_SnmpDetectManageAction.addSnmpDetectType.faild_n81i');this.location='snmpDetectManage.do?action=querySnmpDetectTypeInfo&pageNo="+pageNo+"&pageSize="+pageSize+"'</script>");
			return null;
		}
	}
	
	// 进行修改snmp监测项操作
	public String detailSnmpDetectType() {
		try {
			String sortId = this.getRequest().getParameter("sortId");
			sortInfo = (SortInfo) commonService.get(SortInfo.class, Long.valueOf(sortId));
			// 将更新操作写到操作日志中
			this.addDBOperationRpt(commonService, "SortInfo", "SELECT",sortInfo.getId());
		} catch (Exception e) {
			e.printStackTrace();
			outHtmlString("<script type=\"text/javascript\">alert('i18n_SnmpDetectManageAction.addSnmpDetectType.faild_n81i');this.location='snmpDetectManage.do?action=querySnmpDetectTypeInfo'</script>");
		}
		return null;
	}
	
	//删除snmp监测项
	public String deleteSnmpDetectType()throws Exception{
		try {
			commonService.beginTransaction();
			if(ids!=null&&!"".equals(ids)) {
				String hql = "DELETE FROM SortInfo WHERE ID IN ("+ ids + ")";
				this.commonService.delete(hql);
			}
			commonService.commit();
			
//			this.getRequest().setAttribute("MSG", 1);
//			outHtmlString("<script type=\"text/javascript\">this.location='brandManage.do?action=queryBrandInfo'</script>");
		} catch (Exception e) {
			commonService.rollback();
			e.printStackTrace();
			//outHtmlString("<script type=\"text/javascript\">alert('操作失败');this.location='checkTypeSet.do?action=query'</script>");
		}
		return this.querySnmpDetectTypeInfo();
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
	
	public String getPosition() {
		return position;
	}

	public void setPosition(String position) {
		this.position = position;
	}
	
	
	public String getIds()
	{
		return ids;
	}
	
	public void setIds(String ids)
	{
		this.ids = ids;
	}

	
	public List<SortInfo> getSortInfoList()
	{
		return sortInfoList;
	}

	
	public void setSortInfoList(List<SortInfo> sortInfoList)
	{
		this.sortInfoList = sortInfoList;
	}

	
	public SortInfo getSortInfo()
	{
		return sortInfo;
	}

	
	public void setSortInfo(SortInfo sortInfo)
	{
		this.sortInfo = sortInfo;
	}

	
	public String getSortNameForSearch()
	{
		return sortNameForSearch;
	}

	
	public void setSortNameForSearch(String sortNameForSearch)
	{
		this.sortNameForSearch = sortNameForSearch;
	}
	
}
