package nis.nms.web.actions.sysManage;

import java.util.ArrayList;
import java.util.List;

import nis.nms.domains.Brand;
import nis.nms.service.CommonService;
import nis.nms.util.BaseAction;
import nis.nms.util.Page;

import org.apache.struts2.config.Result;
import org.apache.struts2.config.Results;

@SuppressWarnings("unchecked")
@Results( {
		@Result(name = "brandInfoList", value = "/page/system/brandManage/brandInfoList.jsp"),
		@Result(name = "toAddBrand", value = "/page/system/brandManage/addBrandInfo.jsp"),
		@Result(name = "toUpdateBrand", value = "/page/system/brandManage/updateBrandInfo.jsp"),
		@Result(name = "detailBrand", value = "/page/system/brandManage/detailBrandInfo.jsp"),

		@Result(name = "error", value = "/error.jsp") })
public class BrandManageAction extends BaseAction {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private CommonService commonService;
	
	private int pageNo = 1;
	private int pageSize = this.getDefaultPageSize(); // 每页显示的记录条数
	private Page page;
	
	private String action;// 系统操作
	
	private List<Brand> brandListInfo = new ArrayList();
	private Brand brand;//保存品牌信息
	private String brandNameForSearch;// 品牌名称,品牌列表查询的时候输入的条件
	private String ids;//品牌列表，选中的品牌的id
	
	private String position;

	public String executeAction() {
		try {
            // 品牌管理
			if (action.equals("queryBrandInfo")) {// 查询品牌列表
				queryBrandInfo();
				return "brandInfoList";
			}
			if (action.equals("toAddBrand")) {//新增品牌
				toAddBrand();
				return "toAddBrand";
			}
			if (action.equals("addBrand")) {//新增品牌
				addBrand();
				return null;
			}
			if (action.equals("toUpdateBrand")) {//修改品牌
				toUpdateBrand();
				return "toUpdateBrand";
			}
			if (action.equals("updateBrand")) {//修改品牌
				updateBrand();
				return null;
			}			
			if (action.equals("detailBrand")) {//查看品牌详细信息
				detailBrand();
				return "detailBrand";
			}
			
			if (action.equals("deleteBrand")) {//删除品牌
				return deleteBrand();
			}
		} catch (Exception e) {
			e.printStackTrace();
			return "error";
		}
		return null;
	}

	/**
	 * 
	 * 查询品牌信息：查询条件+分页
	 * @author hyx Mar 29, 2012
	 * @version 1.0 
	 * @return
	 */
	public String queryBrandInfo() {
		try {
			String hql = "from Brand where 1=1 ";
			String sqlCondition = "where 1=1";// 将查询条件记录到操作日志中
			if (brandNameForSearch != null && !"".equals(brandNameForSearch)) {
				hql += " and Upper(brandName) like '%" + brandNameForSearch.toUpperCase() + "%'";
				sqlCondition += " and Upper(brandName) like '%" + brandNameForSearch.toUpperCase() + "%'";
			}
			hql += "order by id";
			page = this.commonService.findByPage(hql, pageNo,pageSize);
			brandListInfo = (ArrayList<Brand>)page.getResult();

			// 将查询请求记入到操作日志表中
			this.addDBOperationRpt(commonService, sqlCondition,
					"Brand");
		} catch (Exception e) {
			e.printStackTrace();
			return "error";
		}
		return "brandInfoList";
	}
	
	//进入新增页面
	public String toAddBrand() {
		System.out.println(brandNameForSearch);
		return null;
	}
	
	//添加品牌信息操作
	public String addBrand() {
		try {
			if(brand!=null){
				this.commonService.save(brand);
				// 将添加操作写到操作日志中
				this.addDBOperationRpt(commonService, "Brand", "INSERT",brand.getId());
				outHtmlString("<script type=\"text/javascript\">alert('i18n_BrandManageAction.addBrand.success_n81i');this.location='brandManage.do?action=queryBrandInfo'</script>");
			}
		} catch (Exception e) {
			e.printStackTrace();
			outHtmlString("<script type=\"text/javascript\">alert('i18n_BrandManageAction.addBrand.faild_n81i');this.location='brandManage.do?action=queryBrandInfo'</script>");
		}
		return null;
	}
	
	//进入修改页面
	public String toUpdateBrand() {
		try {
			if(ids!=null&&!"".equals(ids) ){
				List list = this.commonService.find("from Brand where id=?", Long.valueOf(ids));
				if(list!=null && list.size()>0){
					brand = (Brand)list.get(0);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			outHtmlString("<script type=\"text/javascript\">alert('i18n_BrandManageAction.addBrand.faild_n81i');this.location='brandManage!execute.do?action=queryBrandInfo'</script>");
		}
		return null;
	}
	
	// 进行修改品牌信息操作
	public String updateBrand() {
		try {
			Brand brandForUpdate = (Brand) commonService.get(Brand.class, brand.getId());
			brandForUpdate.setBrandDesc(brand.getBrandDesc());
			brandForUpdate.setBrandName(brand.getBrandName());
			brandForUpdate.setBrandOid(brand.getBrandOid());
			this.commonService.update(brandForUpdate);
			// 将更新操作写到操作日志中
			this.addDBOperationRpt(commonService, "Brand", "UPDATE",brandForUpdate.getId());
			outHtmlString("<script type=\"text/javascript\">alert('i18n_BrandManageAction.addBrand.success_n81i');this.location='brandManage.do?action=queryBrandInfo&pageNo="+pageNo+"&pageSize="+pageSize+"'</script>");
			return null;
		} catch (Exception e) {
			e.printStackTrace();
			outHtmlString("<script type=\"text/javascript\">alert('i18n_BrandManageAction.addBrand.faild_n81i');this.location='brandManage.do?action=queryBrandInfo&pageNo="+pageNo+"&pageSize="+pageSize+"'</script>");
			return null;
		}
	}
	
	// 进行修改品牌信息操作
	public String detailBrand() {
		try {
			String brandId = this.getRequest().getParameter("brandId");
			brand = (Brand) commonService.get(Brand.class, Long.valueOf(brandId));
			// 将更新操作写到操作日志中
			this.addDBOperationRpt(commonService, "Brand", "SELECT",brand.getId());
		} catch (Exception e) {
			e.printStackTrace();
			outHtmlString("<script type=\"text/javascript\">alert('i18n_BrandManageAction.addBrand.faild_n81i');this.location='brandManage.do?action=queryBrandInfo'</script>");
		}
		return null;
	}
	
	//删除品牌信息
	public String deleteBrand()throws Exception{
		try {
			if(ids!=null&&!"".equals(ids)) {
				String hql = "DELETE FROM Brand WHERE ID IN ("+ ids + ")";
				this.commonService.delete(hql);
			}
//			this.getRequest().setAttribute("MSG", 1);
//			outHtmlString("<script type=\"text/javascript\">this.location='brandManage.do?action=queryBrandInfo'</script>");
		} catch (Exception e) {
			e.printStackTrace();
			//outHtmlString("<script type=\"text/javascript\">alert('操作失败');this.location='checkTypeSet.do?action=query'</script>");
		}
		return this.queryBrandInfo();
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
	
	public List getBrandListInfo()
	{
		return brandListInfo;
	}
	
	public void setBrandListInfo(List brandListInfo)
	{
		this.brandListInfo = brandListInfo;
	}
	
	public Brand getBrand()
	{
		return brand;
	}
	
	public void setBrand(Brand brand)
	{
		this.brand = brand;
	}
	
	public String getIds()
	{
		return ids;
	}
	
	public void setIds(String ids)
	{
		this.ids = ids;
	}
	
	public String getBrandNameForSearch()
	{
		return brandNameForSearch;
	}

	public void setBrandNameForSearch(String brandNameForSearch)
	{
		this.brandNameForSearch = brandNameForSearch;
	}
}
