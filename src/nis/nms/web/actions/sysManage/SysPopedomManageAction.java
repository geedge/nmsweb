package nis.nms.web.actions.sysManage;

import java.io.File;
import java.io.FileInputStream;
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import nis.nms.core.Resource;
import nis.nms.domains.NodeTable;
import nis.nms.domains.TableDepartment;
import nis.nms.domains.TableUserDepartment;
import nis.nms.domains.UserInfoVO;
import nis.nms.domains.XtJsJbxx;
import nis.nms.domains.XtJsMkIndex;
import nis.nms.domains.XtMkJbxx;
import nis.nms.domains.XtYhJbxx;
import nis.nms.domains.XtYhJsIndex;
import nis.nms.service.CommonService;
import nis.nms.util.BaseAction;
import nis.nms.util.Constant;
import nis.nms.util.ExportUtils;
import nis.nms.util.MD5;
import nis.nms.util.Page;
import nis.nms.util.pwd.PwdMaker;
import nis.nms.util.pwd.SendMail;
import org.apache.log4j.Logger;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.apache.struts2.config.Result;
import org.apache.struts2.config.Results;
import com.nis.util.StringUtil;

@SuppressWarnings("unchecked")
@Results( {
		@Result(name = "openAddMkInfo", value = "/page/system/addMkInfo.jsp"),
		@Result(name = "queryMkInfo", value = "/page/system/mkInfoList.jsp"),
		@Result(name = "updateMkInfo", value = "/page/system/updateMkInfo.jsp"),
		@Result(name = "openAddUserInfo", value = "/page/system/addUserInfo.jsp"),
		@Result(name = "openAddUserInfoDeptTree", value = "/page/system/addUser.jsp"),
		// @Result(name = "addUserInfo", value =
		// "/page/system/addUserInfo.jsp"),
		@Result(name = "queryUserInfo", value = "/page/system/usersInfoList.jsp"),
		@Result(name = "updateUserInfo", value = "/page/system/updateUserInfo.jsp"),
		@Result(name = "updateUserInfoDeptTree", value = "/page/system/updateUser.jsp"),
		@Result(name = "updateUserPassword", value = "/page/system/updateUserPassword.jsp"),
		@Result(name = "updateSelfInfo", value = "/page/system/updateSelfInfo.jsp"),

		@Result(name = "queryDeptInfo", value = "/page/system/deptInfoList.jsp"),
		@Result(name = "openAddDeptInfo", value = "/page/system/addDeptInfo.jsp"),
		@Result(name = "openUpdateDeptPage", value = "/page/system/updateDeptInfo.jsp"),

		@Result(name = "queryJsInfo", value = "/page/system/jsInfoList.jsp"),
		@Result(name = "openAddJsPage", value = "/page/system/addJsInfo.jsp"),
		@Result(name = "openUpdateJsPage", value = "/page/system/updateJsInfo.jsp"),

		@Result(name = "openConfigJsPage", value = "/page/system/configJsMKGnInfo.jsp"),
		@Result(name = "configJsMkGnTreeXml", value = "/page/system/configJsMkGnTreeXml.jsp"),

		@Result(name = "showError", value = "/page/system/showImportUserError.jsp"),

		@Result(name = "error", value = "/error.jsp") })
public class SysPopedomManageAction extends BaseAction
{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private Logger logger = Logger.getLogger(SysPopedomManageAction.class);
	private MD5 md5 = new MD5();
	private CommonService commonService;
	private int pageNo = 1;
	private int pageSize = this.getDefaultPageSize(); // 每页显示的记录条数
	private Page page;
	private String action;// 系统操作
	private List allMkInfo = new ArrayList();// 保存所有模块信息
	private List updateInfo = new ArrayList();
	private List allMkTitle = new ArrayList();
	private List allMkFunInfo = new ArrayList();
	private List updateFunInfo = new ArrayList();
	private List allUserInfo = new ArrayList();
	// private String mkbh;//模块编号
	private String mkid;// 模块ID
	private Long pid = 0l;// 模块父id
	private String jsbh;// 角色编号
	private String type;
	private String yhzbh;
	private List userInfo;// 保存用户信息
	private String strUser;
	private String mkmc;// 模块名称
	private XtMkJbxx module;// 保存模块信息
	private XtJsJbxx role;// 保存角色信息
	private XtJsMkIndex roleModule;// 保存角色模块信息
	private String jsmc;// 角色名称
	private List allJsInfo = new ArrayList();// 保存角色信息
	private List listJsInfo = new ArrayList();// 保存角色信息
	private List listJsMkInfo = new ArrayList();// 保存角色模块信息
	private XtYhJbxx user;// 保存用户信息
	private String yhbh;// 用户编号
	private String yhmc;// 用户名称
	private String yhid;
	private String deptid;// 部门编码
	private String email;
	private List listDeptInfo = new ArrayList();
	private List deptList = new ArrayList();
	private TableDepartment dept;
	private List listModel = new ArrayList();
	private List cfgMax;
	private String deptname;// 部门名称
	private String mkms;// 模块描述
	private String yhbhpram;
	private String position;
	// 导入节点文件
	private File myFile;
	private String myFileFileName;
	private Long isUpdatePwd;
	
	private String yhbhValue;//用于用户名校验
	
	public String executeAction()
	{
		try
		{
			if (action.equals("openAddMkInfo"))
			{
				queryMkInfo();
				return "openAddMkInfo";
			}
			if (action.equals("addMkInfo"))
			{
				addMkInfo();
				queryMkInfo();
				return "queryMkInfo";
			}
			if (action.equals("queryMkInfo"))
			{// 查询模块信息
				queryMkInfo();
				return "queryMkInfo";
			}
			if (action.equals("updateMkInfo"))
			{// 根据ID查询出要修改的模块信息
				updateMkInfo();
				return "updateMkInfo";
			}
			if (action.equals("doUpdate"))
			{// 修改模块信息
				doUpdate();
				queryMkInfo();
				return "queryMkInfo";
			}
			// 用户管理部分
			if (action.equals("openAddUserInfo"))
			{// 新增用户
				queryAllJsInfo();// 查询出所有角色信息，加载到添加用户时的界面。。。。。。。。。。。。。。。。
// queryAllDeptInfo();// 查询用户部门信息,列表显示部门信息
// return "openAddUserInfo";
				Long deptFlag = this.getDeptFlag();
				if(deptFlag!=null&&deptFlag==0){
					queryDeptInfoAsTree();// 查询用户部门信息,树形显示部门信息
				}
				return "openAddUserInfoDeptTree";
			}
			if (action.equals("doaddUserInfo"))
			{// 添加系统用户信息
				addUserInfo();
				// queryUserInfo();
				return null;
			}
			if (action.equals("queryUserInfo"))
			{// 查询系统用户信息
				queryUserInfo();
				return "queryUserInfo";
			}
			if (action.equals("updateUserInfo"))
			{// 修改用户信息：根据id查询出需修改的信息
				queryJsInfoByYhBh();
				queryUserInfoById();
// queryDeptInfoByYhBh();// 查询用户部门信息，列表显示部门信息
// return "updateUserInfo";
				Long deptFlag = this.getDeptFlag();
				if(deptFlag!=null&&deptFlag==0){
					queryDeptInfoAsTreeByYhBh();// 查询用户部门信息，树形显示部门信息
				}
				return "updateUserInfoDeptTree";
			}
			if (action.equals("doUpdateUserInfo"))
			{// 修改用户信息
				doUpdateUserInfo();
				// queryUserInfo();
				return null;
			}
			
			if (action.equals("importXls"))
			{// 导入
				return this.importXls();
			}
			
			if ("downloadExample".equals(this.action))
			{// 导出模板
				return this.downloadExample();
			}
			
			if (action.equals("updateSelfInfo"))
			{// 根据登陆用户id查询个人信息
				querySelfInfoById();
				return "updateSelfInfo";
			}
			if (action.equals("doUpdateSelfInfo"))
			{// 修改用户信息
				doUpdateSelfInfo();
				querySelfInfoById();
				return "updateSelfInfo";
			}
			if (action.equals("updateUserPassword"))
			{// 根据id查询出需修改的信息
				queryUserInfoById();
				return "updateUserPassword";
			}
			if (action.equals("doUpdatePassword"))
			{// 修改用户密码信息
				doUpdateUserPassword();
				queryUserInfo();
				return "queryUserInfo";
			}
			// 部门管理部分
			if (action.equals("queryDeptInfo"))
			{// 查询部门信息
				queryDeptInfo();
				return "queryDeptInfo";
			}
			if (action.equals("openAddDeptInfo"))
			{
				queryDeptInfo();// 查询出所有部门信息，加载到添加部门时的界面。。。。。。。。。。。。。。。。
				return "openAddDeptInfo";
			}
			if (action.equals("addDeptInfo"))
			{// 添加角色信息
				addDeptInfo();// 添加
				queryDeptInfo();// 查询
				return "queryDeptInfo";// 返回
			}
			if (action.equals("openUpdateDeptPage"))
			{// 打开修改角色界面，加载界面
				queryDeptInfoByid();
				return "openUpdateDeptPage";
			}
			if (action.equals("doUpdateDeptInfo"))
			{// 修改角色模块信息
				doUpdateDeptInfo();
				queryDeptInfo();// 查询
				return "queryDeptInfo";// 返回
			}
			// 角色管理部分
			if (action.equals("queryJsInfo"))
			{// 查询角色信息
				queryJsInfo();
				return "queryJsInfo";
			}
			if (action.equals("openAddJsPage"))
			{// 打开添加角色界面时加载模块信息
				queryMk();
				return "openAddJsPage";
			}
			
			if (action.equals("addJsInfo"))
			{// 添加角色信息
				addJsInfo();
				// queryJsInfo();
				return null;
			}
			if (action.equals("openUpdateJsPage"))
			{// 打开修改角色界面，加载界面
				queryJsInfoByid();
				queryJsMkInfoByJsbh();
				return "openUpdateJsPage";
			}
			if (action.equals("doUpdateJsMkInfo"))
			{// 修改角色模块信息
				doUpdateJsMkInfo();
				// queryJsInfo();
				
				return null;
				
			}
			if (action.equals("openConfigJsPage"))
			{// 打开配置角色界面，加载角色基本信息界面
				queryJsInfoByid();
				return "openConfigJsPage";
			}
			if (action.equals("configJsMkGnTreeXml"))
			{// 打开配置角色界面，加载模块列表界面
				queryJsMkInfoById();
				return "configJsMkGnTreeXml";
			}
			if(action.equals("checkUserName")){
				checkUserName();
				return null;
			}
		} catch (Exception e)
		{
			e.printStackTrace();
			return "error";
		}
		return "";
	}
	
	// 添加模块信息
	public void addMkInfo()
	{
		try
		{
			module.setCtime(new Date());
			this.commonService.save(module);
			// 将添加操作写到操作日志中
			this.addDBOperationRpt(commonService, "XT_MK_JBXX", "INSERT", module.getId());
			this.getRequest().setAttribute("MSG", "1");// 操作成功
		} catch (Exception e)
		{
			this.getRequest().setAttribute("MSG", "2");// 操作失败
			e.printStackTrace();
			
		}
		
	}
	
	// 查询模块信息
	public String queryMkInfo()
	{
		try
		{
			String sql = "from XtMkJbxx where 1=1 ";
			String sqlCondition = "where 1=1";// 将查询条件记录到操作日志中
			if (mkmc != null && !"".equals(mkmc))
			{
				sql += " and Upper(mkmc) like '%" + mkmc.toUpperCase() + "%'";
				sqlCondition += " and Upper(mkmc) like '%" + mkmc.toUpperCase() + "%'";
			}
			if (mkms != null && !"".equals(mkms))
			{
				sql += " and Upper(mkms) like '%" + mkms.toUpperCase() + "%'";
				sqlCondition += " and Upper(mkms) like '%" + mkms.toUpperCase() + "%'";
			}
			sql += "order by id";
			page = this.commonService.findByPage(sql, pageNo, pageSize);
			allMkInfo = (List<XtMkJbxx>) page.getResult();
			// 将查询请求记入到操作日志表中
			this.addDBOperationRpt(commonService, sqlCondition, "xt_mk_jbxx");
		} catch (Exception e)
		{
			e.printStackTrace();
			return "error";
		}
		return "queryMkInfo";
	}
	
	// 进入修改模块信息页面
	public void updateMkInfo()
	{
		try
		{
			updateInfo = this.commonService.find("from XtMkJbxx where id=?", Long.parseLong(mkid));
		} catch (Exception e)
		{
			e.printStackTrace();
		}
	}
	
	// 进行修改模块信息操作
	public void doUpdate()
	{
		try
		{
			XtMkJbxx md = (XtMkJbxx) commonService.get(XtMkJbxx.class, module.getId());
			// md.setMkbh(module.getMkbh());
			md.setMkmc(module.getMkmc());
			md.setMkms(module.getMkms());
			md.setMkurl(module.getMkurl());
			md.setZxbz(module.getZxbz());
			this.commonService.update(md);
			// 将更新操作写到操作日志中
			this.addDBOperationRpt(commonService, "XT_MK_JBXX", "UPDATE", module.getId());
			this.getRequest().setAttribute("MSG", "1");
		} catch (Exception e)
		{
			this.getRequest().setAttribute("MSG", "2");
			updateMkInfo();
			e.printStackTrace();
		}
	}
	
	// 查询角色信息
	public String queryJsInfo()
	{
		try
		{
			String sql = "from XtJsJbxx where (type is null or type = 0)";
			String sqlCondition = "where (type is null or type = 0)";// 将查询条件记录到操作日志中
			if (jsmc != null && !"".equals(jsmc))
			{
				sql += " and Upper(jsmc) like '%" + jsmc.toUpperCase() + "%'";
				sqlCondition += " and Upper(jsmc) like '%" + jsmc.toUpperCase() + "%'";
			}
			sql += "order by jsbh";
			page = this.commonService.findByPage(sql, pageNo, pageSize);
			allJsInfo = (List<XtJsJbxx>) page.getResult();
			// 将查询请求记入到操作日志表中
			this.addDBOperationRpt(commonService, sqlCondition, "xt_js_jbxx");
		} catch (Exception e)
		{
			e.printStackTrace();
			return "error";
		}
		return "queryJsInfo";
	}
	
	/**
	 * 
	 * 根据角色名称判断角色是否已经存在
	 * 
	 * @author hyx Mar 28, 2012
	 * @version 1.0
	 * @return
	 */
	public String checkRoleIsExisted()
	{
		try
		{
			String roleName = this.getRequest().getParameter("roleName");
			String hasExisted = "false";
			StringBuffer jsonStr = new StringBuffer();
			if (roleName != null && !"".equals(roleName))
			{
				String sql = "from XtJsJbxx where (type is null or type = 0) and jsmc='"
						+ roleName.trim() + "'";
				List list = this.commonService.find(sql);
				if (list.size() > 0)
				{
					hasExisted = "true";
				}
			}
			jsonStr.append("{\"hasExisted\":\"");
			jsonStr.append(hasExisted);
			jsonStr.append("\"}");
			this.outJsonString(jsonStr.toString());
			
		} catch (Exception e)
		{
			e.printStackTrace();
			return "error";
		}
		return null;
	}
	
	/**
	 * 
	 * 根据部门名称，判断同一个上级的部门中，此名称的部门是否已经存在
	 * 
	 * @author hyx Mar 28, 2012
	 * @version 1.0
	 * @return
	 */
	public String checkDeptIsExisted()
	{
		try
		{
			String deptName = this.getRequest().getParameter("deptName");
			String upper = this.getRequest().getParameter("upper");
			System.out.println("deptName:" + deptName);
			System.out.println("upper:" + upper);
			String hasExisted = "false";
			StringBuffer jsonStr = new StringBuffer();
			if (deptName != null && !"".equals(deptName))
			{
				// String upperLayer = "select upperlayer from TableDepartment
				// where deptname='" + deptName.trim() + "'";
				String sql = "";
				if (upper != null && !"".equals(upper))
				{
					sql = "from TableDepartment where (deptname='" + deptName.trim()
							+ "' and upperlayer =" + upper + ") " + "or (deptname='"
							+ deptName.trim() + "' and deptid =" + upper + ")";
				} else
				{
// sql = "from TableDepartment where (deptname='" + deptName.trim() + "' and
// upperlayer = 0) " +
// "or (deptname='" + deptName.trim() + "' and deptid = 1)";
					sql = "from TableDepartment where deptname='" + deptName.trim()
							+ "' and upperlayer = 1";
				}
				
				System.out.println("==" + sql);
				List list = this.commonService.find(sql);
				if (list.size() > 0)
				{
					hasExisted = "true";
				}
			}
			jsonStr.append("{\"hasExisted\":\"");
			jsonStr.append(hasExisted);
			jsonStr.append("\"}");
			this.outJsonString(jsonStr.toString());
			
		} catch (Exception e)
		{
			e.printStackTrace();
			return "error";
		}
		return null;
	}
	
	// 新增角色信息
	public void addJsInfo()
	{
		try
		{
			role.setZxbz("0");
			this.commonService.save(role);
			// 将添加操作写到操作日志中
			this.addDBOperationRpt(commonService, "XT_JS_JBXX", "INSERT", role.getJsbh());
			String[] sMk = mkid.split(",");
			if (sMk != null)
				for (int i = 0; i < sMk.length; i++)
				{
					roleModule = new XtJsMkIndex();
					roleModule.setJsbh(role.getJsbh());
					roleModule.setMkbh(Long.parseLong(sMk[i].trim()));
					roleModule.setCtime(new Date());
					this.commonService.save(roleModule);
				}
			outHtmlString("<script type=\"text/javascript\">alert('i18n_SysPopedomManageAction.addJsInfo.success_n81i');this.location='sysPopedomManage.do?action=queryJsInfo'</script>");
		} catch (Exception e)
		{
			outHtmlString("<script type=\"text/javascript\">alert('i18n_SysPopedomManageAction.addJsInfo.faild_n81i');this.location='sysPopedomManage.do?action=queryJsInfo'</script>");
			e.printStackTrace();
		}
	}
	
	// 查询模块信息
	public void queryMk()
	{
		try
		{
			allMkInfo = this.commonService.find("from XtMkJbxx where zxbz!=1");
			// allMkTitle=this.commonService.find("select mkbh,mkmc from
			// XtMkJbxx where mkurl is null");
			
			List treeList = new ArrayList();
			String sql = "select pid,id,mkmc,mkms,mkurl,mktb from XtMkJbxx where zxbz=0 order by id"; // 查找有效的模块信息
			List menuList = this.commonService.find(sql);
			for (int i = 0; i < menuList.size(); i++)
			{
				Object[] obj = (Object[]) menuList.get(i);// 0为pid,1为id,2为mkmc,3为mkms,4为mkurl,5为mktb
				Resource resource = new Resource();
				resource.setParRsCode(obj[0].toString());
				resource.setRsCode(obj[1].toString());
				resource.setRsid(obj[1].toString());
				resource.setRsname(obj[2].toString());
				// resource.setRsaddress(obj[4] == null ? "" :
				// obj[4].toString());
				treeList.add(resource);
			}
			this.getRequest().setAttribute("treeList", treeList);
			String sqlCondition = "where zxbz=0";// 将查询条件记录到操作日志中
			// 将查询请求记入到操作日志表中
			this.addDBOperationRpt(commonService, sqlCondition, "xt_mk_jbxx");
		} catch (Exception e)
		{
			e.printStackTrace();
		}
	}
	
	// 根据角色编号查询角色模块信息，并且角色以及具有的模块权限选中
	public void queryJsMkInfoByJsbh()
	{
		try
		{
			listJsMkInfo = new ArrayList();
			// 获取该角色下的模块信息
			List roleModuleList = this.commonService.find("from XtJsMkIndex where jsbh=?", Long
					.parseLong(jsbh));
			String sqlCondition = "where jsbh=" + jsbh;// 将查询条件记录到操作日志中
			// 将查询请求记入到操作日志表中
			this.addDBOperationRpt(commonService, sqlCondition, "xt_js_mk_index");
			// List moduleList = this.commonService.find("from XtMkJbxx order by
			// mkbh");
			// for(int j = 0;j<moduleList.size();j++){
			// XtMkJbxx mk = (XtMkJbxx)moduleList.get(j);
			// for(int i =0;i<roleModuleList.size();i++){
			// XtJsMkIndex jbxx = (XtJsMkIndex)roleModuleList.get(i);
			// if(mk.getMkbh().trim().equals(jbxx.getMkbh().trim())){
			// mk.setIsChecked("isChecked");
			// }
			// }
			// listJsMkInfo.add(mk);
			// }
			// 获取所有模块信息
			List treeList = new ArrayList();
			String sql = "select pid,id,mkmc,mkms,mkurl,mktb,mktype from XtMkJbxx where zxbz=0 order by id";
			List menuList = this.commonService.find(sql);
			// 记录操作日志
			sqlCondition = "where  zxbz=0";// 将查询条件记录到操作日志中
			// 将查询请求记入到操作日志表中
			this.addDBOperationRpt(commonService, sqlCondition, "xt_mk_jbxx");
			
			// 处理模块列表，将角色已有的权限置为选中状态
			for (int i = 0; i < menuList.size(); i++)
			{
				Object[] obj = (Object[]) menuList.get(i);// 0为pid,1为id,2为mkmc,3为mkms,4为mkurl,5为mktb
				Resource resource = new Resource();
				resource.setParRsCode(obj[0].toString());
				resource.setRsCode(obj[1].toString());
				resource.setRsid(obj[1].toString());
				resource.setRsname(obj[2].toString());
				resource.setRsaddress(obj[4] == null ? "" : obj[4].toString());
				resource.setMktype(obj[6] == null ? "" : obj[6].toString());
				// 此角色意见有的权限模块处于选中状态
				for (int j = 0; j < roleModuleList.size(); j++)
				{
					XtJsMkIndex jsMkIndex = (XtJsMkIndex) roleModuleList.get(j);
					if (jsMkIndex.getMkbh().equals(Long.parseLong(resource.getRsCode())))
					{
						resource.setChecked("checked");
					}
				}
				treeList.add(resource);
			}
			this.getRequest().setAttribute("treeList", treeList);
			this.getRequest().setAttribute("roleModuleList", roleModuleList);
			
		} catch (Exception e)
		{
			e.printStackTrace();
		}
	}
	
	// 根据角色编号查询角色信息
	public void queryJsInfoByid()
	{
		try
		{
			listJsInfo = this.commonService
					.find("from XtJsJbxx where jsbh=?", Long.parseLong(jsbh));
			String sqlCondition = "where jsbh=" + jsbh;// 将查询条件记录到操作日志中
			// 将查询请求记入到操作日志表中
			this.addDBOperationRpt(commonService, sqlCondition, "xt_js_jbxx");
		} catch (Exception e)
		{
			e.printStackTrace();
		}
	}
	
	// 根据角色编号查询所有角色模块信息
	public void queryJsMkInfoById()
	{
		try
		{
			listJsMkInfo = this.commonService.find("from XtJsMkIndex where jsbh=?", Long
					.parseLong(jsbh));
			String sqlCondition = "where jsbh=" + jsbh;// 将查询条件记录到操作日志中
			// 将查询请求记入到操作日志表中
			this.addDBOperationRpt(commonService, sqlCondition, "xt_js_mk_index");
		} catch (Exception e)
		{
			e.printStackTrace();
		}
	}
	
	// 更新角色模块信息
	public void doUpdateJsMkInfo()
	{
		try
		{
			String[] sMk = mkid.split(",");
			// 删除旧的角色模块信息
			this.commonService.delete("delete XtJsMkIndex where jsbh=" + role.getJsbh());
			// 更新角色信息
			XtJsJbxx ro = (XtJsJbxx) this.commonService.get(XtJsJbxx.class, role.getJsbh());
			ro.setJsmc(role.getJsmc());
			ro.setJsms(role.getJsms());
			ro.setZxbz(role.getZxbz());
			this.commonService.update(ro);
			// //将更新操作写到操作日志中
			this.addDBOperationRpt(commonService, "XT_JS_JBXX", "UPDATE", ro.getJsbh());
			// 插入新的角色模块信息
			if (sMk != null)
				for (int i = 0; i < sMk.length; i++)
				{
					roleModule = new XtJsMkIndex();
					roleModule.setJsbh(role.getJsbh());
					roleModule.setMkbh(Long.parseLong(sMk[i].trim()));
					this.commonService.save(roleModule);
				}
			outHtmlString("<script type=\"text/javascript\">alert('i18n_SysPopedomManageAction.addJsInfo.success_n81i');this.location='sysPopedomManage.do?action=queryJsInfo'</script>");
		} catch (Exception e)
		{
			queryJsInfoByid();
			queryJsMkInfoByJsbh();
			outHtmlString("<script type=\"text/javascript\">alert('i18n_SysPopedomManageAction.addJsInfo.faild_n81i');this.location='sysPopedomManage.do?action=queryJsInfo'</script>");
			e.printStackTrace();
		}
	}
	
	//校验用户名是否存在
	public void checkUserName(){
		try {
			List list = this.commonService.find("from XtYhJbxx where yhbh=?", yhbhValue);
			if (list != null && list.size() > 0){
				this.outString("1");
			}
		} catch (Exception e) {
			e.printStackTrace();
			outHtmlString("<script type=\"text/javascript\">alert('i18n_SysPopedomManageAction.addJsInfo.faild_n81i');this.location='sysPopedomManage.do?action=queryUserInfo'</script>");
		}
	}
	
	
	// 添加用户信息
	public void addUserInfo()
	{
		String pwdString = "";
		try
		{
			/*List list = this.commonService.find("from XtYhJbxx where yhbh=?", user.getYhbh());
			if (list != null && list.size() > 0)
			{
				this.outHtmlString("<script>alert('用户名已存在！');history.back();</script>");
				return;
			} else
			{*/
				
				String[] strsJsBh = jsbh.split(",");// 用户角色信息
				String[] strsDept = deptid.split(",");// 用户部门信息
				// user.setYhbh(user.getYhmc());//用户编号默认与用户名称相同，不能重复，唯一约束
				// user.setYhmm(md5.getMD5Code(user.getYhmm()));// 密码使用md5加密
				// 新创建用户时，生成随机密码，并邮件发送给用户
//				pwdString = PwdMaker.genRandomNum(10);
				//2018-08-30新创建用户时，生成密码yhbh+nms
				String oldYhbh = user.getYhbh();
				pwdString=oldYhbh+"nms";
				System.out.println("密码：" + pwdString);
				// user.setYhmm(md5.getMD5Code(PwdMaker.getProtectPwd(pwdString,
				// user.getYhbh())));// 密码使用md5加密
				user.setYhmm(md5.getMD5Code(pwdString));// 密码使用md5加密
				user.setPwdState("0");// 密码初始化状态不可用，首次登陆必须修改密码才可进入系统
				// 添加邮件发送密码代码
				//2018-08-30当系统启用邮件功能时才发送邮件
				Long emailFlag = (Long) this.getRequest().getSession().getAttribute(Constant.EMAIL_FLAG);
				if(emailFlag==null){
					String sql="select t.type_state from type_table t where t.type_identity = ?";
					List list = this.commonService.executeSQL(sql, "emailflag");
					if(list!=null&&list.size()>0){
						emailFlag = ((BigDecimal) list.get(0)).longValue();
					}else{
						emailFlag=1L;
					}
					System.out.println("是否启用邮件功能："+(emailFlag==0?"启用":"关闭"));
					this.getRequest().getSession().setAttribute(Constant.EMAIL_FLAG, emailFlag);
				}
				if(emailFlag==0){
					SendMail cn = new SendMail();
					logger.debug("邮件 To " + (email));
					// 设置发件人地址、收件人地址和邮件标题
					cn.setAddress(BaseAction.rb.getString("email.address"), email, getI18nText("i18n_SysPopedomManageAction.addJsInfo.nmsInitPwd_n81i"));
					// PwdMaker.getProtectPwd(pwdString, user.getYhbh());
					cn.send(getI18nText("i18n_SysPopedomManageAction.addJsInfo.sendMsg.username_n81i") + user.getYhbh() + getI18nText("i18n_SysPopedomManageAction.addJsInfo.sendMsg.password_n81i") + pwdString
							+ getI18nText("i18n_SysPopedomManageAction.addJsInfo.sendMsg.toChangePwd_n81i"));
					logger.debug("成功发送邮件 To " + (email));
				}
				user.setCtime(new Date());// 用户创建时间
				user.setEmail(email);
				user.setZxbz("0");
				this.commonService.save(user);
				// 将添加操作写到操作日志中
				this.addDBOperationRpt(commonService, "XT_YH_JBXX", "INSERT", user.getYhid());
				// 用户角色信息
				if (strsJsBh != null)
					for (int i = 0; i < strsJsBh.length; i++)
					{
						XtYhJsIndex userRole = new XtYhJsIndex();
						userRole.setCtime(new Date());
						userRole.setJsbh(Long.parseLong(strsJsBh[i].trim()));
						userRole.setYhbh(user.getYhbh());
						this.commonService.save(userRole);
					}
				// 插入用户组用户信息
				if (yhzbh != null && !"".equals(yhzbh))
				{
					String[] strgroupBh = yhzbh.split(",");
					if (strgroupBh != null)
					{
						for (int i = 0; i < strgroupBh.length; i++)
						{
							XtYhJsIndex userRole = new XtYhJsIndex();
							userRole.setCtime(new Date());
							userRole.setJsbh(Long.parseLong(strgroupBh[i].trim()));
							userRole.setYhbh(user.getYhbh());
							userRole.setType(1l);
							userRole.setYhId(user.getYhid());
							this.commonService.save(userRole);
						}
					}
				}
				Long deptFlag =(Long) this.getRequest().getSession().getAttribute(Constant.DEPT_FLAG);
				if(deptFlag==0){
					// 插入用户部门信息
					if (strsDept != null){
						for (int i = 0; i < strsDept.length; i++)
						{
							TableUserDepartment userDept = new TableUserDepartment();
							userDept.setDeptid(Long.parseLong(strsDept[i].trim()));
							userDept.setUserid(user.getYhid());
							this.commonService.save(userDept);
						}
					}
				}
				outHtmlString("<script type=\"text/javascript\">alert('i18n_SysPopedomManageAction.addJsInfo.success_n81i');this.location='sysPopedomManage.do?action=queryUserInfo'</script>");
		//	}
		} catch (Exception e)
		{
			e.printStackTrace();
			outHtmlString("<script type=\"text/javascript\">alert('i18n_SysPopedomManageAction.addJsInfo.faild_n81i');this.location='sysPopedomManage.do?action=queryUserInfo'</script>");
		}
	}
	
	// 查询所有用户信息
	public String queryUserInfo()
	{
		try
		{
			XtYhJbxx crruser = (XtYhJbxx) this.getRequest().getSession().getAttribute(Constant.SESSION_CZY_NAME);
			String sql="";
			if("admin".equals(crruser.getYhbh())){
				sql = "from XtYhJbxx where 1=1";
			}else{
				sql="from XtYhJbxx where 1=1 and Upper(yhbh) != 'admin'";
			}
			String sqlCondition = "where 1=1";// 将查询条件记录到操作日志中
			if (yhbh != null && !"".equals(yhbh))
			{
				sql += " and Upper(yhbh) like '%" + yhbh.toUpperCase() + "%'";
				sqlCondition += " and Upper(yhbh) like '%" + yhbh.toUpperCase() + "%'";
			}
			if (yhmc != null && !"".equals(yhmc))
			{
				sql += " and Upper(yhmc) like '%" + yhmc.toUpperCase() + "%'";
				sqlCondition += " and Upper(yhmc) like '%" + yhmc.toUpperCase() + "%'";
			}
			sql += "order by ctime desc";
			page = this.commonService.findByPage(sql, pageNo, pageSize);
			List list = (List<XtYhJbxx>) page.getResult();
			
			// 将查询请求记入到操作日志表中
			this.addDBOperationRpt(commonService, sqlCondition, "xt_yh_jbxx");
			
			// 获取用户角色信息
			for (int i = 0; i < list.size(); i++)
			{
				XtYhJbxx user = (XtYhJbxx) list.get(i);
				String userRole = "";
				String userDept = "";
				List userRoleList = this.commonService.find("from XtYhJsIndex where yhbh=?", user
						.getYhbh());
				List roleList = this.commonService
						.find("from XtJsJbxx where zxbz = 0 and type is null order by jsbh ");
				for (int j = 0; j < roleList.size(); j++)
				{
					XtJsJbxx role = (XtJsJbxx) roleList.get(j);
					for (int k = 0; k < userRoleList.size(); k++)
					{
						XtYhJsIndex jbxx = (XtYhJsIndex) userRoleList.get(k);
						if (role.getJsbh().equals(jbxx.getJsbh()))
						{
							if ("".equals(userRole))
							{
								userRole = role.getJsmc();
							} else
							{
								userRole += "，" + role.getJsmc();
							}
						}
					}
				}
				user.setUserRole(userRole);
				// 获取用户部门信息
				Long deptFlag = this.getDeptFlag();
				if(deptFlag!=null&&deptFlag==0){
					List userDeptList = this.commonService
							.find("from TableUserDepartment where userid=?", user.getYhid());
					List deptList = this.commonService.find("from TableDepartment order by deptid");
					for (int j = 0; j < deptList.size(); j++)
					{
						TableDepartment dept = (TableDepartment) deptList.get(j);
						for (int k = 0; k < userDeptList.size(); k++)
						{
							TableUserDepartment userDepartment = (TableUserDepartment) userDeptList
									.get(k);
							if (dept.getDeptid().equals(userDepartment.getDeptid()))
							{
								if ("".equals(userDept))
								{
									userDept = dept.getDeptname();
								} else
								{
									userDept += "," + dept.getDeptname();
								}
							}
						}
					}
					user.setUserDept(userDept);
				}
				allUserInfo.add(user);
				
			}
		} catch (Exception e)
		{
			e.printStackTrace();
			return "error";
		}
		return "queryUserInfo";
	}
	
	// 根据用户编号查询用户信息
	public void queryUserInfoById()
	{
		try
		{
			userInfo = this.commonService.find("from XtYhJbxx where yhid=?", Long.parseLong(yhid
					.trim()));
			
			String sqlCondition = "where yhid=" + yhid;// 将查询条件记录到操作日志中
			// 将查询请求记入到操作日志表中
			this.addDBOperationRpt(commonService, sqlCondition, "xt_yh_jbxx");
			
		} catch (Exception e)
		{
			e.printStackTrace();
		}
	}
	
	// 查询登陆用户自己的信息
	public void querySelfInfoById()
	{
		try
		{
			userInfo = new ArrayList();
			List userList = this.commonService.find("from XtYhJbxx where yhid=?", this.getUserID());
			String sqlCondition = "where yhid=" + this.getUserID();// 将查询条件记录到操作日志中
			// 将查询请求记入到操作日志表中
			this.addDBOperationRpt(commonService, sqlCondition, "xt_yh_jbxx");
			
			// 获取用户角色信息
			for (int i = 0; i < userList.size(); i++)
			{
				XtYhJbxx user = (XtYhJbxx) userList.get(i);
				String userRole = "";
				String userDept = "";
				List userRoleList = this.commonService.find("from XtYhJsIndex where yhbh=?", user
						.getYhbh());
				List roleList = this.commonService.find("from XtJsJbxx order by jsbh");
				for (int j = 0; j < roleList.size(); j++)
				{
					XtJsJbxx role = (XtJsJbxx) roleList.get(j);
					for (int k = 0; k < userRoleList.size(); k++)
					{
						XtYhJsIndex jbxx = (XtYhJsIndex) userRoleList.get(k);
						if (role.getJsbh().equals(jbxx.getJsbh()))
						{
							if ("".equals(userRole))
							{
								userRole = role.getJsmc();
							} else
							{
								userRole += "，" + role.getJsmc();
							}
						}
					}
				}
				user.setUserRole(userRole);
				// 获取用户部门信息
				List userDeptList = this.commonService
						.find("from TableUserDepartment where userid=?", user.getYhid());
				List deptList = this.commonService.find("from TableDepartment order by deptid");
				for (int j = 0; j < deptList.size(); j++)
				{
					TableDepartment dept = (TableDepartment) deptList.get(j);
					for (int k = 0; k < userDeptList.size(); k++)
					{
						TableUserDepartment userDepartment = (TableUserDepartment) userDeptList
								.get(k);
						if (dept.getDeptid().equals(userDepartment.getDeptid()))
						{
							if ("".equals(userDept))
							{
								userDept = dept.getDeptname();
							} else
							{
								userDept += "," + dept.getDeptname();
							}
						}
					}
				}
				user.setUserDept(userDept);
				userInfo.add(user);
			}
			
		} catch (Exception e)
		{
			e.printStackTrace();
		}
	}
	
	// 修改登录用户自己的个人信息
	public void doUpdateSelfInfo()
	{
		try
		{
			XtYhJbxx userNew = (XtYhJbxx) this.commonService.get(XtYhJbxx.class, this.getUserID());
			if (isUpdatePwd == 0l)
			{// 修改密码
				userNew.setYhmm(md5.getMD5Code(user.getYhmm()));
			}
			userNew.setYhmc(user.getYhmc());
			
			userNew.setEmail(user.getEmail());
			userNew.setIsReceiveEmail(user.getIsReceiveEmail());
			userNew.setLanguage(user.getLanguage());
			this.commonService.update(userNew);
			// 将删除操作写到操作日志中
			this.addDBOperationRpt(commonService, "XT_YH_JBXX", "UPDATE", this.getUserID());
			this.getRequest().setAttribute("MSG", 1);
		} catch (Exception e)
		{
			this.getRequest().setAttribute("MSG", 2);
			queryUserInfoById();
			e.printStackTrace();
		}
	}
	
	// 更新用户和用户角色信息
	public void doUpdateUserInfo()
	{
		try
		{
			// 删除旧的用户角色信息
			this.commonService.delete("delete XtYhJsIndex where type is null and  yhbh='"
					+ new String(yhbh.getBytes("ISO-8859-1"), "UTF-8") + "'");
			// 删除旧的用户部门信息
			this.commonService.delete("delete TableUserDepartment where userid="
					+ Long.parseLong(yhid.trim()));
			XtYhJbxx userNew = (XtYhJbxx) this.commonService.get(XtYhJbxx.class, Long
					.parseLong(yhid.trim()));
			userNew.setZxbz(user.getZxbz());
			userNew.setYhmc(user.getYhmc());
			userNew.setEmail(user.getEmail());
			userNew.setIsReceiveEmail(user.getIsReceiveEmail());
			userNew.setLanguage(user.getLanguage());
			this.commonService.update(userNew);
			
			// 将更新操作写到操作日志中
			this.addDBOperationRpt(commonService, "XT_YH_JBXX", "UPDATE", userNew.getYhid());
			
			String[] strsJsBh = jsbh.split(",");
			// 插入新的用户角色信息
			if (strsJsBh != null)
				for (int i = 0; i < strsJsBh.length; i++)
				{
					XtYhJsIndex userRole = new XtYhJsIndex();
					userRole.setCtime(new Date());
					userRole.setJsbh(Long.parseLong(strsJsBh[i].trim()));
					userRole.setYhbh(userNew.getYhbh());
					this.commonService.save(userRole);
				}
			// 删除原来用户和用户组关系
			List<XtYhJsIndex> allyhzs = this.commonService
					.find(" from XtYhJsIndex where type=1 and yhId=" + Long.valueOf(yhid));
			for (XtYhJsIndex index: allyhzs)
			{
				this.commonService.delete(XtYhJsIndex.class, "id", index.getId());
			}
			// 插入用户组用户信息
			if (yhzbh != null)
			{
				String[] strgroupBh = yhzbh.split(",");
				if (strgroupBh != null)
				{
					for (int i = 0; i < strgroupBh.length; i++)
					{
						XtYhJsIndex userRole = new XtYhJsIndex();
						userRole.setCtime(new Date());
						userRole.setJsbh(Long.parseLong(strgroupBh[i].trim()));
						userRole.setYhbh(user.getYhbh());
						userRole.setType(1l);
						userRole.setYhId(Long.valueOf(userNew.getYhid()));
						this.commonService.save(userRole);
					}
				}
			}
			Long deptFlag =this.getDeptFlag();
			if(deptFlag==0){
				String[] strsDept = deptid.split(",");
				// 插入新的用户部门信息
				if (strsDept != null){
					for (int i = 0; i < strsDept.length; i++){
						TableUserDepartment userDept = new TableUserDepartment();
						userDept.setDeptid(Long.parseLong(strsDept[i].trim()));
						userDept.setUserid(userNew.getYhid());
						this.commonService.save(userDept);
					}
				}
			}
			
			outHtmlString("<script type=\"text/javascript\">alert('i18n_SysPopedomManageAction.addJsInfo.success_n81i');this.location='sysPopedomManage.do?action=queryUserInfo'</script>");
		} catch (Exception e)
		{
			queryUserInfoById();
			e.printStackTrace();
			outHtmlString("<script type=\"text/javascript\">alert('i18n_SysPopedomManageAction.addJsInfo.faild_n81i');this.location='sysPopedomManage.do?action=queryUserInfo'</script>");
		}
	}
	
	// 更新用户密码信息
	public void doUpdateUserPassword()
	{
		try
		{
			XtYhJbxx userNew = (XtYhJbxx) this.commonService.get(XtYhJbxx.class, Long
					.parseLong(yhid.trim()));
			userNew.setYhmc(user.getYhmc());
			userNew.setYhmm(md5.getMD5Code(user.getYhmm().trim()));
			// 让管理员重置密码之后，修改密码状态未必须修改状态0
			userNew.setPwdState("0");
			
			/*
			 * //添加邮件发送密码代码 SendMail cn = new SendMail(); logger.debug("邮件 To
			 * "+(email)); // 设置发件人地址、收件人地址和邮件标题
			 * cn.setAddress(BaseAction.rb.getString("email.host"), email,
			 * "NMS系统找回密码"); cn.send(user.getYhmm()); logger.debug("成功发送邮件 To
			 * "+(email));
			 */

			this.commonService.update(userNew);
			// //将删除操作写到操作日志中
			this.addDBOperationRpt(commonService, "XT_YH_JBXX", "UPDATE", userNew.getYhid());
			outHtmlString("<script type=\"text/javascript\">alert('i18n_SysPopedomManageAction.addJsInfo.success_n81i');this.location='sysPopedomManage.do?action=queryUserInfo'</script>");
		} catch (Exception e)
		{
			queryUserInfoById();
			e.printStackTrace();
			outHtmlString("<script type=\"text/javascript\">alert('i18n_SysPopedomManageAction.addJsInfo.faild_n81i');this.location='sysPopedomManage.do?action=queryUserInfo'</script>");
		}
	}
	
	// 查询所有角色信息
	public void queryAllJsInfo()
	{
		try
		{
			allJsInfo = this.commonService.find("from XtJsJbxx where zxbz=0 and type is null");
			List<XtJsJbxx> yhzList = this.commonService
					.find("from XtJsJbxx where zxbz=0 and type=1");
			this.getRequest().setAttribute("yhzList", yhzList);
			String sqlCondition = "where zxbz=0";// 将查询条件记录到操作日志中
			// 将查询请求记入到操作日志表中
			this.addDBOperationRpt(commonService, sqlCondition, "xt_js_jbxx");
		} catch (Exception e)
		{
			e.printStackTrace();
		}
	}
	
	// 查询所有部门信息
	public void queryAllDeptInfo()
	{
		try
		{
			listDeptInfo = this.commonService.find("from TableDepartment order by deptid desc");
			String sqlCondition = "where 1=1";// 将查询条件记录到操作日志中
			// 将查询请求记入到操作日志表中
			this.addDBOperationRpt(commonService, sqlCondition, "TableDepartment");
		} catch (Exception e)
		{
			e.printStackTrace();
		}
	}
	
	// 查询所有部门信息,并转换为树形部门信息
	public void queryDeptInfoAsTree()
	{
		try
		{
			listDeptInfo = this.commonService.find("from TableDepartment order by deptid desc");
			
			List treeList = new ArrayList();
			String sql = "select upperlayer,deptid,deptname from TableDepartment where deptstate = 0 order by deptid";
			List menuList = this.commonService.find(sql);
			
			for (int i = 0; i < menuList.size(); i++)
			{
				Object[] obj = (Object[]) menuList.get(i);// 0为pid,1为id,2为deptname
				Resource resource = new Resource();
				resource.setParRsCode(obj[0].toString());
				resource.setRsCode(obj[1].toString());
				resource.setRsid(obj[1].toString());
				resource.setRsname(obj[2].toString());
				treeList.add(resource);
			}
			
			this.getRequest().setAttribute("treeList", treeList);
			String sqlCondition = "where 1=1";// 将查询条件记录到操作日志中
			// 将查询请求记入到操作日志表中
			this.addDBOperationRpt(commonService, sqlCondition, "TableDepartment");
		} catch (Exception e)
		{
			e.printStackTrace();
		}
	}
	
	// 根据用户编号查询用户角色信息，并且已经具有的角色处于选中状态
	public void queryJsInfoByYhBh()
	{
		try
		{
			listJsInfo = new ArrayList();
			List userRoleList = this.commonService.find("from XtYhJsIndex where yhbh=?",
					new String(yhbhpram.getBytes("ISO-8859-1"), "UTF-8"));
			
			String sqlCondition = "where yhbh="
					+ new String(yhbhpram.getBytes("ISO-8859-1"), "UTF-8");// 将查询条件记录到操作日志中
			// 将查询请求记入到操作日志表中
			this.addDBOperationRpt(commonService, sqlCondition, "xt_yh_js_index");
			
			List roleList = this.commonService
					.find("from XtJsJbxx where  type is null and zxbz=0 order by jsbh");// 查询有效的角色信息
			for (int j = 0; j < roleList.size(); j++)
			{
				XtJsJbxx role = (XtJsJbxx) roleList.get(j);
				for (int i = 0; i < userRoleList.size(); i++)
				{
					XtYhJsIndex jbxx = (XtYhJsIndex) userRoleList.get(i);
					if (role.getJsbh().equals(jbxx.getJsbh()))
					{
						role.setIsChecked("isChecked");
					}
				}
				listJsInfo.add(role);
			}
			// 查询用户组
			List userRoles = this.commonService.find("from XtYhJsIndex where type=1 and yhId="
					+ Long.valueOf(yhid));
			// 用户组信息
			List<XtJsJbxx> yhzList = new ArrayList<XtJsJbxx>();
			List<XtJsJbxx> roles = this.commonService.find("from XtJsJbxx where zxbz=0 and type=1");
			for (int j = 0; j < roles.size(); j++)
			{
				XtJsJbxx role = (XtJsJbxx) roles.get(j);
				for (int i = 0; i < userRoles.size(); i++)
				{
					if (userRoles != null && userRoles.get(i) != null)
					{
						XtYhJsIndex jbxx = (XtYhJsIndex) userRoles.get(i);
						if (role.getJsbh().equals(jbxx.getJsbh()))
						{
							role.setIsChecked("isChecked");
						}
					}
				}
				yhzList.add(role);
			}
			this.getRequest().setAttribute("yhzList", yhzList);
		} catch (Exception e)
		{
			e.printStackTrace();
		}
	}
	
	// 根据用户编号查询用户部门信息，并且所在部门处于选中状态
	public void queryDeptInfoByYhBh()
	{
		try
		{
			listDeptInfo = new ArrayList();
			List userDeptList = this.commonService.find("from TableUserDepartment where userid=?",
					Long.parseLong(yhid.trim()));
			String sqlCondition = "where userid=" + yhid;// 将查询条件记录到操作日志中
			// 将查询请求记入到操作日志表中
			this.addDBOperationRpt(commonService, sqlCondition, "TableUserDepartment");
			
			deptList = this.commonService.find("from TableDepartment order by deptid desc");
			for (int j = 0; j < deptList.size(); j++)
			{
				TableDepartment dept = (TableDepartment) deptList.get(j);
				for (int i = 0; i < userDeptList.size(); i++)
				{
					TableUserDepartment userDepartment = (TableUserDepartment) userDeptList.get(i);
					if (dept.getDeptid().equals(userDepartment.getDeptid()))
					{
						dept.setIsChecked("isChecked");
					}
				}
				listDeptInfo.add(dept);
			}
		} catch (Exception e)
		{
			e.printStackTrace();
		}
	}
	
	/**
	 * 
	 * 前台树形显示部门信息，根据用户编号查询用户部门信息，并且所在部门处于选中状态
	 * 
	 * @author Administrator Mar 30, 2012
	 * @version 1.0
	 */
	public void queryDeptInfoAsTreeByYhBh()
	{
		try
		{
			List treeList = new ArrayList();
			// 获取该用户下的部门信息
			List userDeptList = this.commonService.find("from TableUserDepartment where userid=?",
					Long.parseLong(yhid.trim()));
			String sqlCondition = "where userid=" + yhid;// 将查询条件记录到操作日志中
			this.addDBOperationRpt(commonService, sqlCondition,// 将查询请求记入到操作日志表中
					"TableUserDepartment");
			
			// 获取所有部门信息
			deptList = this.commonService
					.find("select upperlayer,deptid,deptname from TableDepartment where deptstate = 0 order by deptid desc");
			
			// 处理部门列表，转换为树形，且将用户已有的部门置为选中状态
			for (int j = 0; j < deptList.size(); j++)
			{
				Object[] obj = (Object[]) deptList.get(j);// 0为pid,1为id,2为deptname,3为级别
				Resource resource = new Resource();
				resource.setParRsCode(obj[0].toString());
				resource.setRsCode(obj[1].toString());
				resource.setRsid(obj[1].toString());
				resource.setRsname(obj[2].toString());
				// 此角色意见有的权限模块处于选中状态
				for (int i = 0; i < userDeptList.size(); i++)
				{
					TableUserDepartment userDepartment = (TableUserDepartment) userDeptList.get(i);
					if (resource.getRsCode().equals(String.valueOf(userDepartment.getDeptid())))
					{
						resource.setChecked("isChecked");
					}
				}
				treeList.add(resource);
			}
			this.getRequest().setAttribute("treeList", treeList);
			this.getRequest().setAttribute("userDeptList", userDeptList);
			
		} catch (Exception e)
		{
			e.printStackTrace();
		}
	}
	
	/**
	 * 部门管理部分
	 * 
	 * @return
	 */
	// 添加部门信息
	public void addDeptInfo()
	{
		try
		{
			if (dept.getUpperlayer() == null)
			{
				dept.setUpperlayer(-1l);
			}
			this.commonService.save(dept);
			
			// 将添加操作写到操作日志中
			this.addDBOperationRpt(commonService, "TABLEDEPARTMENT", "INSERT", dept.getDeptid());
			
			this.getRequest().setAttribute("MSG", "1");// 操作成功
		} catch (Exception e)
		{
			this.getRequest().setAttribute("MSG", "2");// 操作失败
			e.printStackTrace();
		}
	}
	
	// 根据部门编号查询部门信息
	public void queryDeptInfoByid()
	{
		try
		{
			deptList = this.commonService.find("from TableDepartment where deptid=?", Long
					.parseLong(deptid.trim()));
			
			String sqlCondition = "where deptid=" + deptid.trim();// 将查询条件记录到操作日志中
			// 将查询请求记入到操作日志表中
			this.addDBOperationRpt(commonService, sqlCondition, "TableDepartment");
			
			listDeptInfo = this.commonService.find("from TableDepartment order by deptid desc");
			
		} catch (Exception e)
		{
			e.printStackTrace();
		}
	}
	
	// 进行部门修改信息
	public void doUpdateDeptInfo()
	{
		try
		{
			TableDepartment deptNew = (TableDepartment) commonService.get(TableDepartment.class,
					Long.parseLong(deptid.trim()));
			if (dept.getUpperlayer() == null)
			{
				dept.setUpperlayer(-1l);
			}
			deptNew.setDeptstate(dept.getDeptstate());
			deptNew.setDeptname(dept.getDeptname());
			deptNew.setUpperlayer(dept.getUpperlayer());
			this.commonService.update(deptNew);
			
			// 将更新操作写到操作日志中
			this.addDBOperationRpt(commonService, "TABLEDEPARTMENT", "UPDATE", dept.getDeptid());
			
			this.getRequest().setAttribute("MSG", "1");
		} catch (Exception e)
		{
			this.getRequest().setAttribute("MSG", "2");
			updateMkInfo();
			e.printStackTrace();
		}
	}
	
	// 查询部门信息
	public String queryDeptInfo()
	{
		try
		{
			
			String sql = "from TableDepartment where 1=1";
			if (deptname != null && !"".equals(deptname))
			{
				sql += " and Upper(deptname) like '%" + deptname.toUpperCase() + "%'";
			}
			sql += "order by deptid";
			page = this.commonService.findByPage(sql, pageNo, pageSize);
			listDeptInfo = (List<TableDepartment>) page.getResult();
			
			String sqlCondition = "where 1=1";// 将查询条件记录到操作日志中
			// 将查询请求记入到操作日志表中
			this.addDBOperationRpt(commonService, sqlCondition, "TableDepartment");
			
		} catch (Exception e)
		{
			e.printStackTrace();
			return "error";
		}
		return "queryDeptInfo";
	}
	
	// 查询模块名称、描述
	public String queryInfoForAjax()
	{
		String ajaxProperties = this.getRequest().getParameter("ajaxProperties").trim();
		String ajaxTableName = this.getRequest().getParameter("ajaxTableName").trim();
		String ajaxType = null;
		
		if (this.getRequest().getParameter("ajaxType") != null)
		{
			ajaxType = this.getRequest().getParameter("ajaxType").trim();
		}
		String ajaxValue = null;
		if (this.getRequest().getParameter("ajaxValue") != null)
		{
			ajaxValue = this.getRequest().getParameter("ajaxValue").trim();
		}
		String nodeType = null;
		if (this.getRequest().getParameter("nodeType") != null)
		{
			nodeType = this.getRequest().getParameter("nodeType").trim();
		}
		
		String isTableconfig = "";
		String sq1 = "lower(";
		String sq2 = ")";
		if (null != ajaxProperties && !("").equals(ajaxProperties) && null != ajaxTableName
				&& !("").equals(ajaxTableName) && null != ajaxType && !("").equals(ajaxType))
		{
			if (("TableConfig").equals(ajaxTableName))
				isTableconfig = " and x.activeflag not in(9,11)";
			if (("Tableconfig").equals(ajaxTableName) && ("subject").equals(ajaxProperties))
			{
				sq1 = "";
				sq2 = "";
			}
			try
			{
				StringBuffer stringBuffer = new StringBuffer();
				// stringBuffer.append("<response>");
				//				
				// if(ajaxProperties.contains(",")&&ajaxTableName.contains(",")&&ajaxType.contains(","))
				// {
				// String[] ajaxPList =null;
				// String[] ajaxTabList =null;
				// String[] ajaxTypeList =null;
				//					
				// ajaxPList = ajaxProperties.split(",");
				// ajaxTabList = ajaxTableName.split(",");
				// ajaxTypeList = ajaxType.split(",");
				//					
				// for(int i=0;i<ajaxPList.length;i++) {
				// stringBuffer.append(getLXCXList(ajaxPList[i],ajaxTabList[i],ajaxTypeList[i]).toString());
				// }
				// } else {
				// stringBuffer.append(getLXCXList(ajaxProperties,ajaxTableName,ajaxType).toString());
				// }
				//				
				// stringBuffer.append("</response>");
				
				if (("Long").equals(ajaxType))
				{
					String sql = "select distinct x." + ajaxProperties + " from " + ajaxTableName
							+ " x where 1=1" + " and " + sq1 + "x." + ajaxProperties + "" + sq2
							+ " like ('" + ajaxValue + "%') " + isTableconfig + " order by x."
							+ ajaxProperties + "";
					// String sql ="select distinct x."+ajaxProperties+" from
					// "+ajaxTableName+" x where 1=1" +
					// " order by x."+ajaxProperties+"";
					List<Long> list = this.commonService.find(sql);
					
					for (Long s: list)
					{
						// stringBuffer.append("<filed>");
						// stringBuffer.append("<"+ajaxProperties+">"+s+"</"+ajaxProperties+">");
						// stringBuffer.append("</filed>");
						stringBuffer.append("" + s + ",");
					}
				}
				
				if (("Integer").equals(ajaxType))
				{
					String sql = "select distinct x." + ajaxProperties + " from " + ajaxTableName
							+ " x where 1=1" + " and " + sq1 + "x." + ajaxProperties + "" + sq2
							+ " like ('" + ajaxValue + "%') " + isTableconfig + " order by x."
							+ ajaxProperties + "";
					// String sql ="select distinct x."+ajaxProperties+" from
					// "+ajaxTableName+" x where 1=1" +
					// " order by x."+ajaxProperties+"";
					List<Integer> list = this.commonService.find(sql);
					
					for (Integer s: list)
					{
						// stringBuffer.append("<filed>");
						// stringBuffer.append("<"+ajaxProperties+">"+s+"</"+ajaxProperties+">");
						// stringBuffer.append("</filed>");
						stringBuffer.append("" + s + ",");
					}
				}
				
				if (("String").equals(ajaxType))
				{
					String sql = "select distinct trim(x." + ajaxProperties + ") from "
							+ ajaxTableName + " x where 1=1 and x." + ajaxProperties + "!='null' "
							+ " and " + sq1 + "x." + ajaxProperties + "" + sq2 + " like ('%"
							+ ajaxValue.toLowerCase() + "%') " + isTableconfig;
					Object systemIdObj = this.getRequest().getSession()
							.getAttribute(Constant.SESSION_SYSTEM_LOGIN);
					if (!StringUtil.isEmpty(systemIdObj) && ajaxProperties.equals("nodeIp")
							&& ajaxTableName.equals("NodeTable"))
					{
						// 有效节点 节点状态：0，有效；1，无效
						sql += " and x.nodeState = 0 ";
						Long systemId = new Long(systemIdObj.toString());
						// admin 的systemId为-1 管理员可以查看所有系统
						if (!this.getAdminMark())
						{
							sql += " and x.systemId = " + systemId;
						}
						if (!StringUtil.isEmpty(nodeType))
						{
							
							sql += " and x.nodeType = " + nodeType;
						}
						
					}
					// 检测类别联想
					if (ajaxProperties.equals("checkTypeName1"))
					{
						if (this.getAdminMark())
						{
							sql += " and x.isSchedule<>2";
						} else
						{
							sql += " and x.isSchedule<>2  and (( x.viewLevel=1 and x.userId="
									+ this.getUserID()
									+ "  and x.systemId ="
									+ this.getSystemID()
									+ ")  or ( x.viewLevel=2 and x.groupId in (select  x1.jsbh from  XtYhJsIndex  x1  where x1.yhbh=' "
									+ super.getUser().getYhbh()
									+ "' and x1.type = 1) and x.systemId = " + this.getSystemID()
									+ ") or (x.viewLevel=3 and x.systemId = " + this.getSystemID()
									+ ") or (x.viewLevel=4 ))";
						}
					}
					sql += " order by trim(x." + ajaxProperties + ")";
					System.out.println("lianxiang sql：" + sql);
					List<String> list = this.commonService.find(sql);
					
					for (String s: list)
					{
						// stringBuffer.append("<filed>");
						// stringBuffer.append("<"+ajaxProperties+">"+s+"</"+ajaxProperties+">");
						// stringBuffer.append("</filed>");
						stringBuffer.append("" + s + ",");
					}
				}
				
				if (stringBuffer.length() > 0)
					stringBuffer.replace(stringBuffer.length() - 1, stringBuffer.length(), "");
				System.out.println(stringBuffer.toString());
				// this.getResponse().setContentType("application/xml");
				this.getResponse().setCharacterEncoding("utf-8");
				// this.getResponse().setHeader("Cache-Control", "no-cache");
				PrintWriter printWriter = this.getResponse().getWriter();
				printWriter.write(stringBuffer.toString());
				printWriter.close();
				printWriter = null;
				
			} catch (Exception e)
			{
				e.printStackTrace();
				return "error";
			}
			
		}
		return null;
	}
	
	private String getLXCXList(String ajaxPList, String ajaxTList, String type)
	{
		// TODO Auto-generated method stub
		StringBuffer stringBuffer = new StringBuffer();
		try
		{
			if (("Integer").equals(type))
			{
				String sql = "select distinct x." + ajaxPList + " from " + ajaxTList
						+ " x where 1=1 order by x." + ajaxPList + "";
				List<Integer> list = this.commonService.find(sql);
				
				for (Integer s: list)
				{
					stringBuffer.append("<filed>");
					stringBuffer.append("<" + ajaxPList + ">" + s + "</" + ajaxPList + ">");
					stringBuffer.append("</filed>");
				}
			}
			
			if (("String").equals(type))
			{
				String sql = "select distinct trim(x." + ajaxPList + ") from " + ajaxTList
						+ " x where 1=1 and x." + ajaxPList + "!='null' order by trim(x."
						+ ajaxPList + ")";
				List<String> list = this.commonService.find(sql);
				
				for (String s: list)
				{
					stringBuffer.append("<filed>");
					stringBuffer.append("<" + ajaxPList + ">" + s + "</" + ajaxPList + ">");
					stringBuffer.append("</filed>");
				}
			}
			
		} catch (Exception e)
		{
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return stringBuffer.toString();
	}
	
	// 导入
	public String importXls()
	{
		String errorInfo = "";
		try
		{
			List<UserInfoVO> list = new ArrayList<UserInfoVO>();
			
			Workbook workbook = null;
			if (myFileFileName.endsWith(".xlsx"))
			{
				workbook = new XSSFWorkbook(new FileInputStream(myFile));
			} else
			{
				// 创建对Excel工作簿文件的引用
				/*
				 * POIFSFileSystem fs = new POIFSFileSystem( new
				 * FileInputStream(myFile));
				 */
				workbook = new HSSFWorkbook(new FileInputStream(myFile));
			}
			
			// 创建对工作表的引用，得到表的第一页
			Sheet sheet = workbook.getSheetAt(0);
			// 读取左上端单元
			
			// 记录存储数据条数
			int count = 0;
			// 记录读入excel数据条数
			int sum = (sheet.getLastRowNum());
			// 验证非中文
			String sxString = "^\\w+$";
			Pattern patt = Pattern.compile(sxString);
			
			for (short i = 1; i <= sheet.getLastRowNum(); i++)
			{
				UserInfoVO user = new UserInfoVO();
				Row row = sheet.getRow(i);
				// 登录名、用户名、用户密码、e-mail。"
				Cell cell_1 = row.getCell((short) 0);
				Cell cell_2 = row.getCell((short) 1);
				Cell cell_3 = row.getCell((short) 2);
				
				if ((null == cell_1 || 3 == cell_1.getCellType())
						&& (null == cell_2 || 3 == cell_2.getCellType())
						&& (null == cell_3 || 3 == cell_3.getCellType()))
				{
					sum--;
				} else
				{
					// 用户名
					if (null == cell_1)
					{
						errorInfo +=  getI18nText("i18n_SysPopedomManageAction.addJsInfo.errorInfo1_n81i",i+"");
					} else if (cell_1.getCellType() == Cell.CELL_TYPE_NUMERIC)
					{
						errorInfo +=  getI18nText("i18n_SysPopedomManageAction.addJsInfo.errorInfo2_n81i",i+"");
					} else if (cell_1.getCellType() == Cell.CELL_TYPE_STRING)
					{
						String loginName = cell_1.getStringCellValue().trim();
						user.setYhbh(loginName);
						Matcher mat = patt.matcher(loginName);
						if (!mat.matches())
						{
							errorInfo +=  getI18nText("i18n_SysPopedomManageAction.addJsInfo.errorInfo3_n81i",i+"");
						}
					}
					// 真实姓名
					if (null == cell_2)
					{
						errorInfo +=  getI18nText("i18n_SysPopedomManageAction.addJsInfo.errorInfo6_n81i",i+"");
					} else if (cell_2.getCellType() == Cell.CELL_TYPE_STRING)
					{
						String userName = cell_2.getStringCellValue().trim();
						user.setYhmc(userName);
						
						if (userName.equals(""))
						{
							errorInfo +=  getI18nText("i18n_SysPopedomManageAction.addJsInfo.errorInfo4_n81i",i+"");
						}
					}
					// 密码（字符或者数字），密码改为自动生成，由用户首次登录后修改方可使用
					/*
					 * if(null == cell_3){ errorInfo += i + "行3列不能为空;"; }else if
					 * (cell_3.getCellType() == Cell.CELL_TYPE_STRING ){ String
					 * pwd = cell_3.getStringCellValue().trim();
					 * user.setYhmm(pwd); Matcher mat = patt.matcher(pwd); if
					 * (!mat.matches()) { errorInfo += i + "行3列的密码为中文;"; } }else
					 * if(cell_3.getCellType() == Cell.CELL_TYPE_NUMERIC){
					 * String pwd =
					 * String.valueOf((int)cell_3.getNumericCellValue());
					 * user.setYhmm(pwd); }
					 */
					// e-mail
					//2018-09-11新增如果邮件功能启用，则进行非空判断
					Long emailFlag = (Long)this.getRequest().getSession().getAttribute(Constant.EMAIL_FLAG);
					if (null == cell_3)
					{
						if(emailFlag==0)
							errorInfo +=  getI18nText("i18n_SysPopedomManageAction.addJsInfo.errorInfo7_n81i",i+"");
					} else
					{
						if (cell_3.getCellType() == Cell.CELL_TYPE_STRING)
						{// ^[0-9]*$
							String email = cell_3.getStringCellValue().trim();
							user.setEmail(email);
							
							Pattern pattEmail = Pattern
									.compile("^([a-zA-Z0-9_\\-\\.]+)@((\\[[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}\\.)|(([a-zA-Z0-9\\-]+\\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\\]?)$");
							Matcher matE = pattEmail.matcher(email);
							if (!matE.matches())
							{
								errorInfo +=  getI18nText("i18n_SysPopedomManageAction.addJsInfo.errorInfo5_n81i",i+"");
							}
						}
					}
					if ("".equals(errorInfo))
					{
						errorInfo = this.saveUserInfo(user);
					}
					if ("".equals(errorInfo))
					{
						count++;
					} else
					{
						user.setShowError(errorInfo);
						errorInfo = "";
						list.add(user);
						
					}
				}
			}
			
			this.getRequest().setAttribute("errorList", list);
			if (count == sum && sum > 0)
			{
// this.getRequest().setAttribute("MSG", 1);
// return this.queryUserInfo();
				outHtmlString("<script type=\"text/javascript\">alert('i18n_SysPopedomManageAction.addJsInfo.success_n81i');this.location='sysPopedomManage!execute.do?action=queryUserInfo'</script>");
				return null;
			} else if (sum == 0)
			{
				this.outHtmlString("<script>alert('i18n_SysPopedomManageAction.addJsInfo.selectFileIsNull_n81i');history.back();</script>");
				return null;
			}
			
		} catch (Exception e)
		{
			e.printStackTrace();
			logger.error(e.getStackTrace());
		}
		
		return "showError";
	}
	
	// 模板下载
	public String downloadExample()
	{
		try
		{
			Page p = this.commonService.findByPage("from XtYhJbxx", 1, 3);
			List<NodeTable> st = (List<NodeTable>) p.getResult();
			// String[] title = { "登录名", "用户名","用户密码","e-mail"};
			// String[] colu = { "yhbh", "yhmc","yhmm", "email"};
			// 密码改为自动生成，发送到各自邮箱，由各用户首次登录修改之后可用。
			String[] title = { getI18nText("i18n_SysPopedomManageAction.addJsInfo.title.username_n81i"), 
								getI18nText("i18n_SysPopedomManageAction.addJsInfo.title.realName_n81i"),
								getI18nText("i18n_SysPopedomManageAction.addJsInfo.title.email_n81i") };
			String[] colu = { "yhbh", "yhmc", "email" };
			ExportUtils m = new ExportUtils();
			m.setAutoSizeColumn(true);
			m.exportExcel(getI18nText("i18n_SysPopedomManageAction.addJsInfo.userTable_n81i"), st, title, colu, "downloadExample");
		} catch (Exception e)
		{
			e.printStackTrace();
			logger.error(e.getStackTrace());
		}
		return null;
	}
	
	public String saveUserInfo(UserInfoVO user)
	{
		String resu = "";
		String pwdString = "";
		try
		{
			List list = this.commonService.find("from XtYhJbxx where yhbh=?", user.getYhbh());
			if (list != null && list.size() > 0)
			{
				resu = user.getYhbh() + getI18nText("i18n_SysPopedomManageAction.addJsInfo.exists_n81i");
				return resu;
			} else
			{
				XtYhJbxx userInfo = new XtYhJbxx();
				userInfo.setYhbh(user.getYhbh());// 用户名
				userInfo.setYhmc(user.getYhmc());// 真实姓名
				userInfo.setEmail(user.getEmail());// email
				// userInfo.setYhmm(md5.getMD5Code(user.getYhmm()));// 密码使用md5加密
				pwdString = PwdMaker.genRandomNum(10);
				userInfo.setYhmm(md5.getMD5Code(PwdMaker.getProtectPwd(pwdString, userInfo
						.getYhbh())));// 密码使用md5加密
				userInfo.setPwdState("0");// 密码初始化状态不可用，首次登陆必须修改密码才可进入系统
				// 添加邮件发送密码代码
				SendMail cn = new SendMail();
				logger.debug("邮件 To " + (email));
				// 设置发件人地址、收件人地址和邮件标题
				cn.setAddress(BaseAction.rb.getString("email.address"), email, "NMS系统初始密码");
				// PwdMaker.getProtectPwd(pwdString, user.getYhbh());
				cn.send(getI18nText("i18n_SysPopedomManageAction.addJsInfo.sendMsg.password2_n81i") + pwdString + getI18nText("i18n_SysPopedomManageAction.addJsInfo.sendMsg.toChangePwd_n81i"));
				logger.debug("成功发送邮件 To " + (email));
				userInfo.setCtime(new Date());// 用户创建时间
				userInfo.setZxbz("0");
				this.commonService.save(userInfo);
				// 将添加操作写到操作日志中
				this.addDBOperationRpt(commonService, "XT_YH_JBXX", "INSERT", user.getYhid());
				this.getRequest().setAttribute("MSG", 1);
			}
		} catch (Exception e)
		{
			this.getRequest().setAttribute("MSG", 2);
			e.printStackTrace();
			resu = getI18nText("i18n_SysPopedomManageAction.addJsInfo.userInfoImportErr_n81i");
		}
		return resu;
	}
	
	public List getListModel()
	{
		return listModel;
	}
	
	public void setListModel(List listModel)
	{
		this.listModel = listModel;
	}
	
	public CommonService getCommonService()
	{
		return commonService;
	}
	
	public void setCommonService(CommonService commonService)
	{
		this.commonService = commonService;
	}
	
	public int getPageNo()
	{
		return pageNo;
	}
	
	public void setPageNo(int pageNo)
	{
		this.pageNo = pageNo;
	}
	
	public int getPageSize()
	{
		return pageSize;
	}
	
	public void setPageSize(int pageSize)
	{
		this.pageSize = pageSize;
	}
	
	public Page getPage()
	{
		return page;
	}
	
	public void setPage(Page page)
	{
		this.page = page;
	}
	
	public String getAction()
	{
		return action;
	}
	
	public void setAction(String action)
	{
		this.action = action;
	}
	
	public List getAllMkInfo()
	{
		return allMkInfo;
	}
	
	public void setAllMkInfo(List allMkInfo)
	{
		this.allMkInfo = allMkInfo;
	}
	
	public List getUpdateInfo()
	{
		return updateInfo;
	}
	
	public void setUpdateInfo(List updateInfo)
	{
		this.updateInfo = updateInfo;
	}
	
	public List getAllMkTitle()
	{
		return allMkTitle;
	}
	
	public void setAllMkTitle(List allMkTitle)
	{
		this.allMkTitle = allMkTitle;
	}
	
	public List getAllMkFunInfo()
	{
		return allMkFunInfo;
	}
	
	public void setAllMkFunInfo(List allMkFunInfo)
	{
		this.allMkFunInfo = allMkFunInfo;
	}
	
	public List getUpdateFunInfo()
	{
		return updateFunInfo;
	}
	
	public void setUpdateFunInfo(List updateFunInfo)
	{
		this.updateFunInfo = updateFunInfo;
	}
	
	public List getAllUserInfo()
	{
		return allUserInfo;
	}
	
	public void setAllUserInfo(List allUserInfo)
	{
		this.allUserInfo = allUserInfo;
	}
	
	// public String getMkbh() {
	// return mkbh;
	// }
	//
	// public void setMkbh(String mkbh) {
	// this.mkbh = mkbh;
	// }
	
	public String getJsbh()
	{
		return jsbh;
	}
	
	public void setJsbh(String jsbh)
	{
		this.jsbh = jsbh;
	}
	
	public List getUserInfo()
	{
		return userInfo;
	}
	
	public void setUserInfo(List userInfo)
	{
		this.userInfo = userInfo;
	}
	
	public String getStrUser()
	{
		return strUser;
	}
	
	public void setStrUser(String strUser)
	{
		this.strUser = strUser;
	}
	
	public String getMkmc()
	{
		return mkmc;
	}
	
	public void setMkmc(String mkmc)
	{
		this.mkmc = mkmc;
	}
	
	public XtMkJbxx getModule()
	{
		return module;
	}
	
	public void setModule(XtMkJbxx module)
	{
		this.module = module;
	}
	
	public XtJsJbxx getRole()
	{
		return role;
	}
	
	public void setRole(XtJsJbxx role)
	{
		this.role = role;
	}
	
	public XtJsMkIndex getRoleModule()
	{
		return roleModule;
	}
	
	public void setRoleModule(XtJsMkIndex roleModule)
	{
		this.roleModule = roleModule;
	}
	
	public String getJsmc()
	{
		return jsmc;
	}
	
	public void setJsmc(String jsmc)
	{
		this.jsmc = jsmc;
	}
	
	public List getAllJsInfo()
	{
		return allJsInfo;
	}
	
	public void setAllJsInfo(List allJsInfo)
	{
		this.allJsInfo = allJsInfo;
	}
	
	public List getListJsInfo()
	{
		return listJsInfo;
	}
	
	public void setListJsInfo(List listJsInfo)
	{
		this.listJsInfo = listJsInfo;
	}
	
	public List getListJsMkInfo()
	{
		return listJsMkInfo;
	}
	
	public void setListJsMkInfo(List listJsMkInfo)
	{
		this.listJsMkInfo = listJsMkInfo;
	}
	
	public XtYhJbxx getUser()
	{
		return user;
	}
	
	public void setUser(XtYhJbxx user)
	{
		this.user = user;
	}
	
	public String getYhbh()
	{
		return yhbh;
	}
	
	public void setYhbh(String yhbh)
	{
		this.yhbh = yhbh;
	}
	
	public String getYhmc()
	{
		return yhmc;
	}
	
	public void setYhmc(String yhmc)
	{
		this.yhmc = yhmc;
	}
	
	public String getPosition()
	{
		return position;
	}
	
	public void setPosition(String position)
	{
		this.position = position;
	}
	
	public String getYhid()
	{
		return yhid;
	}
	
	public void setYhid(String yhid)
	{
		this.yhid = yhid;
	}
	
	public String getDeptid()
	{
		return deptid;
	}
	
	public void setDeptid(String deptid)
	{
		this.deptid = deptid;
	}
	
	public List getListDeptInfo()
	{
		return listDeptInfo;
	}
	
	public void setListDeptInfo(List listDeptInfo)
	{
		this.listDeptInfo = listDeptInfo;
	}
	
	public TableDepartment getDept()
	{
		return dept;
	}
	
	public void setDept(TableDepartment dept)
	{
		this.dept = dept;
	}
	
	public List getDeptList()
	{
		return deptList;
	}
	
	public void setDeptList(List deptList)
	{
		this.deptList = deptList;
	}
	
	public String getMkid()
	{
		return mkid;
	}
	
	public void setMkid(String mkid)
	{
		this.mkid = mkid;
	}
	
	public Long getPid()
	{
		return pid;
	}
	
	public void setPid(Long pid)
	{
		this.pid = pid;
	}
	
	public List getCfgMax()
	{
		return cfgMax;
	}
	
	public void setCfgMax(List cfgMax)
	{
		this.cfgMax = cfgMax;
	}
	
	public String getDeptname()
	{
		return deptname;
	}
	
	public void setDeptname(String deptname)
	{
		this.deptname = deptname;
	}
	
	public String getMkms()
	{
		return mkms;
	}
	
	public void setMkms(String mkms)
	{
		this.mkms = mkms;
	}
	
	public String getType()
	{
		return type;
	}
	
	public void setType(String type)
	{
		this.type = type;
	}
	
	public String getYhzbh()
	{
		return yhzbh;
	}
	
	public void setYhzbh(String yhzbh)
	{
		this.yhzbh = yhzbh;
	}
	
	public String getEmail()
	{
		return email;
	}
	
	public void setEmail(String email)
	{
		this.email = email;
	}
	
	public File getMyFile()
	{
		return myFile;
	}
	
	public void setMyFile(File myFile)
	{
		this.myFile = myFile;
	}
	
	public String getMyFileFileName()
	{
		return myFileFileName;
	}
	
	public void setMyFileFileName(String myFileFileName)
	{
		this.myFileFileName = myFileFileName;
	}
	
	public String getYhbhpram()
	{
		return yhbhpram;
	}
	
	public void setYhbhpram(String yhbhpram)
	{
		this.yhbhpram = yhbhpram;
	}
	
	public Long getIsUpdatePwd()
	{
		return isUpdatePwd;
	}
	
	public void setIsUpdatePwd(Long isUpdatePwd)
	{
		this.isUpdatePwd = isUpdatePwd;
	}

	public String getYhbhValue() {
		return yhbhValue;
	}

	public void setYhbhValue(String yhbhValue) {
		this.yhbhValue = yhbhValue;
	}
	
}
