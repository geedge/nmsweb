package nis.nms.web.actions.deptManage;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.struts2.config.Result;
import org.apache.struts2.config.Results;

import nis.nms.domains.TableDepartment;
import nis.nms.persistence.HibernateGeneralDaoImpl;
import nis.nms.service.CommonService;
import nis.nms.util.BaseAction;
import nis.nms.util.Page;


@SuppressWarnings("unchecked")
@Results( {
		@Result(name = "queryDeptInfo", value = "/page/system/deptManage/deptInfoList.jsp"),
		@Result(name = "add", value = "/deptManage/deptManage!execute.do?action=queryDeptInfo"),
		@Result(name = "openUpdateDeptPage", value = "/page/system/updateDeptInfo.jsp")})
public class DeptManageAction extends BaseAction {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private CommonService commonService;
	
	private int pageNo = 1;
	private int pageSize = this.getDefaultPageSize(); // 每页显示的记录条数
	private Page page;
	
	private String action;// 系统操作
	
	private TableDepartment dept;//保存部门信息
	private List listDeptInfo = new ArrayList();
	private List deptList = new ArrayList();
	private String deptname;// 部门名称
	
	public String executeAction() {
		String resultpage = "";
		// 部门管理部分
		if (action.equals("queryDeptInfo")) {// 查询部门信息
			resultpage = queryDeptInfo();
		}
		if (action.equals("add")) {//添加部门
			add();
			return null;
		}
		if (action.equals("update")) {//修改部门
			update();
			return null;	
		}
		return resultpage;
	}

	/**
	 * 
	 * 查询部门信息 
	 * @author hyx Mar 29, 2012
	 * @version 1.0 
	 * @return
	 */
	public String queryDeptInfo() {
		try {
			String sql = "from TableDepartment where 1=1 ";
			String sqlCondition = "where 1=1";// 将查询条件记录到操作日志中
			if (deptname != null && !"".equals(deptname)) {
				sql += " and Upper(deptname) like '%" + deptname.toUpperCase() + "%'";
				sqlCondition += " and deptname like '%" + deptname + "%'";
			}
			sql += "order by deptid";
			listDeptInfo = (List<TableDepartment>)this.commonService.find(sql);

			// 将查询请求记入到操作日志表中
			this.addDBOperationRpt(commonService, sqlCondition,
					"TableDepartment");

		} catch (Exception e) {
			e.printStackTrace();
		}
		return "queryDeptInfo";
	}

	// 进行修改模块信息操作
	public void update() {
		try {
			commonService.beginTransaction();
			if(dept.getDeptid()!=null && !dept.getDeptid().toString().equals("1")){
				if(dept.getDeptstate()!=null){
					if(dept.getDeptstate().equals("1")){//置为无效，则其下部门全部职位无效
						
						//@2018-3-9 fang 修改 首先查询符合条件的id，在拼接sql，适配mysql
						String swcbSql = "select deptid from tabledepartment where 1=1  ";
						List<Map<String,Object>> list = this.commonService.startWithConnectBy(swcbSql, "deptid="+dept.getDeptid(), "deptid", "upperlayer");
						StringBuilder sb = new StringBuilder();
						for(Map<String,Object> map : list){
							if(map != null){
								Object o = HibernateGeneralDaoImpl.getIgnoreCase(map, "deptid");
								if(o != null){
									sb.append(",");
									sb.append(o.toString());
								}
							}
						}
						if(sb.length() > 0){
							sb.deleteCharAt(0);
						}
						
						String getAllDept = "select * from tabledepartment t where t.deptid in ("+sb.toString()+")";
/*						String getAllDept = "select * from tabledepartment t start with t.deptid="+dept.getDeptid()+" connect by prior t.deptid = t.upperlayer";
*/						List deptUpdateLsit = this.commonService.executeSQL(getAllDept,TableDepartment.class);
						
						for(int i=0;i<deptUpdateLsit.size();i++){
							TableDepartment td = (TableDepartment)deptUpdateLsit.get(i);
							td.setDeptstate("1");
							this.commonService.update(td);
							// 将更新操作写到操作日志中
							this.addDBOperationRpt(commonService, "TABLEDEPARTMENT", "UPDATE",td.getDeptid());
						}
					}else{
						TableDepartment deptForUpdate = (TableDepartment) commonService.get(TableDepartment.class, dept.getDeptid());
						deptForUpdate.setDeptname(dept.getDeptname());
						deptForUpdate.setUpperlayer(dept.getUpperlayer());
						deptForUpdate.setDeptstate(dept.getDeptstate());
						this.commonService.update(deptForUpdate);
						// 将更新操作写到操作日志中
						this.addDBOperationRpt(commonService, "TABLEDEPARTMENT", "UPDATE",deptForUpdate.getDeptid());
					}
				}
			}
			commonService.commit();
			outHtmlString("<script type=\"text/javascript\">alert('i18n_DeptManageAction.update.success_n81i');this.location='deptManage!execute.do?action=queryDeptInfo'</script>");
			
		} catch (Exception e) {
			e.printStackTrace();
			commonService.rollback();
			outHtmlString("<script type=\"text/javascript\">alert('i18n_DeptManageAction.update.faild_n81i');this.location='deptManage!execute.do?action=queryDeptInfo'</script>");
		}
	}
	
	// 添加模块信息操作
	public void add() {
		try {
			commonService.beginTransaction();
			TableDepartment dptDepartment = new TableDepartment();
			dptDepartment.setDeptname(dept.getDeptname());
			dptDepartment.setDeptstate(dept.getDeptstate());
			if(dept.getUpperlayer()==null){
				//dept.setUpperlayer(1l);
				dptDepartment.setUpperlayer(1l);
			}else{
				dptDepartment.setUpperlayer(dept.getDeptid());
			}
			this.commonService.save(dptDepartment);
			// 将添加操作写到操作日志中
			this.addDBOperationRpt(commonService, "TABLEDEPARTMENT", "INSERT",dptDepartment.getDeptid());
			commonService.commit();
			outHtmlString("<script type=\"text/javascript\">alert('i18n_DeptManageAction.update.success_n81i');this.location='deptManage!execute.do?action=queryDeptInfo'</script>");
			
		} catch (Exception e) {
			e.printStackTrace();
			commonService.rollback();
			outHtmlString("<script type=\"text/javascript\">alert('i18n_DeptManageAction.update.faild_n81i');this.location='deptManage!execute.do?action=queryDeptInfo'</script>");
		}
	}
	
	
	
//	// 查询所有部门信息
//	public void queryAllDeptInfo() {
//		try {
//			listDeptInfo = this.commonService
//					.find("from TableDepartment order by deptid desc");
//			String sqlCondition = "where 1=1";// 将查询条件记录到操作日志中
//			// 将查询请求记入到操作日志表中
//			this.addDBOperationRpt(commonService, sqlCondition,
//					"TableDepartment");
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//	}

	

	// 根据用户编号查询用户部门信息，并且所在部门处于选中状态
//	public void queryDeptInfoByYhBh() {
//		try {
//			listDeptInfo = new ArrayList();
//			List userDeptList = this.commonService.find(
//					"from TableUserDepartment where userid=?", Long
////							.parseLong(yhid.trim()));
////			String sqlCondition = "where userid=" + yhid;// 将查询条件记录到操作日志中
//			// 将查询请求记入到操作日志表中
//			this.addDBOperationRpt(commonService, sqlCondition,
//					"TableUserDepartment");
//
//			deptList = this.commonService
//					.find("from TableDepartment order by deptid desc");
//			for (int j = 0; j < deptList.size(); j++) {
//				TableDepartment dept = (TableDepartment) deptList.get(j);
//				for (int i = 0; i < userDeptList.size(); i++) {
//					TableUserDepartment userDepartment = (TableUserDepartment) userDeptList
//							.get(i);
//					if (dept.getDeptid().equals(userDepartment.getDeptid())) {
//						dept.setIsChecked("isChecked");
//					}
//				}
//				listDeptInfo.add(dept);
//			}
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//	}

	/**
	 * 部门管理部分
	 * 
	 * @return
	 */
//	// 添加部门信息
//	public void addDeptInfo() {
//		try {
//			if (dept.getUpperlayer() == null) {
//				dept.setUpperlayer(-1l);
//			}
//			this.commonService.save(dept);
//
//			// 将添加操作写到操作日志中
//			this.addDBOperationRpt(commonService, "TABLEDEPARTMENT", "INSERT",
//					dept.getDeptid());
//
//			this.getRequest().setAttribute("MSG", "1");// 操作成功
//		} catch (Exception e) {
//			this.getRequest().setAttribute("MSG", "2");// 操作失败
//			e.printStackTrace();
//		}
//	}

	// 根据部门编号查询部门信息
//	public void queryDeptInfoByid() {
//		try {
//			deptList = this.commonService.find(
//					"from TableDepartment where deptid=?", Long
//							.parseLong(deptid.trim()));
//
//			String sqlCondition = "where deptid=" + deptid.trim();// 将查询条件记录到操作日志中
//			// 将查询请求记入到操作日志表中
//			this.addDBOperationRpt(commonService, sqlCondition,
//					"TableDepartment");
//
//			listDeptInfo = this.commonService
//					.find("from TableDepartment order by deptid desc");
//
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//	}

	// 进行部门修改信息
//	public void doUpdateDeptInfo() {
//		try {
//			TableDepartment deptNew = (TableDepartment) commonService.get(
//					TableDepartment.class, Long.parseLong(deptid.trim()));
//			if (dept.getUpperlayer() == null) {
//				dept.setUpperlayer(-1l);
//			}
//			deptNew.setDeptlayer(dept.getDeptlayer());
//			deptNew.setDeptname(dept.getDeptname());
//			deptNew.setUpperlayer(dept.getUpperlayer());
//			this.commonService.update(deptNew);
//
//			// 将更新操作写到操作日志中
//			this.addDBOperationRpt(commonService, "TABLEDEPARTMENT", "UPDATE",
//					dept.getDeptid());
//
//			this.getRequest().setAttribute("MSG", "1");
//		} catch (Exception e) {
//			this.getRequest().setAttribute("MSG", "2");
//			e.printStackTrace();
//		}
//	}

	


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
	

	public List getListDeptInfo() {
		return listDeptInfo;
	}

	public void setListDeptInfo(List listDeptInfo) {
		this.listDeptInfo = listDeptInfo;
	}

	public TableDepartment getDept() {
		return dept;
	}

	public void setDept(TableDepartment dept) {
		this.dept = dept;
	}

	public List getDeptList() {
		return deptList;
	}

	public void setDeptList(List deptList) {
		this.deptList = deptList;
	}

	public String getDeptname() {
		return deptname;
	}

	public void setDeptname(String deptname) {
		this.deptname = deptname;
	}
}
