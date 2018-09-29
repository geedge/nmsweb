package nis.nms.web.actions.sysManage;

import java.util.ArrayList;
import java.util.List;
import nis.nms.core.Resource;
import nis.nms.domains.TableGuide;
import nis.nms.service.CommonService;
import nis.nms.util.BaseAction;
import nis.nms.util.Page;
import org.apache.struts2.config.Result;
import org.apache.struts2.config.Results;

@SuppressWarnings("unchecked")
@Results( { @Result(name = "guideIndex", value = "/page/systemManage/guide/guideIndex.jsp"),
		@Result(name = "taskConfig", value = "/page/systemManage/guide/taskConfig.jsp"),
		@Result(name = "monitorConfig", value = "/page/systemManage/guide/monitorConfig.jsp")})
public class GuideManageAction extends BaseAction
{
	
	private static final long serialVersionUID = 1L;
	private CommonService commonService;
	private Page page;
	private String isywxt = "no";
	private String isyhz = "no";
	private String isjf = "no";
	private String isjg = "no";
	private String isjdz = "no";
	private String isrw = "no";
	private String isjclb = "no";
	private String isjcsz = "no";
	private String action;// 系统操作
	// 是否完成
	private String ywxtCom;
	private String yhzCom;
	private String jfCom;
	private String jgCom;
	private String jdzCom;
	private String jdCom;
	private String rwCom;
	private String jclbCom;
	private String jclbSourceCom;
	private String jcszCom;
	
	private Long packNum;
	private String packName;
	private Long userid;
	
	public String executeAction()
	{
		String resultPage = "";
		try
		{
			if (action == null)
			{
				return "";
			}
			if (action.equals("index"))
			{// 向导首页
				resultPage = getUserMk();
			} else if ("task".equals(action))
			{
				resultPage = "taskConfig";
			} else if ("monitor".equals(action))
			{
				resultPage = "monitorConfig";
			}
			//
		} catch (Exception e)
		{
			e.printStackTrace();
			return "error";
		}
		return resultPage;
	}
	
	// 获取用户权限
	public String getUserMk()
	{
		try
		{
			
			// List treeList = this.getYhJsMk(this.getUser().getYhbh());
			
			String sql = " select distinct t.mkmc" + " from xt_mk_jbxx t"
					+ " left join  xt_js_mk_index xj on t.id = xj.mkbh"
					+ " left join xt_yh_js_index xy on xj.jsbh = xy.jsbh"
					+ " left join xt_yh_jbxx xyj on xyj.yhbh = xy.yhbh" + " where xy.yhbh = '"
					+ this.getUser().getYhbh()
					+ "' and (t.mktype <> 1 or t.mktype is null ) and t.zxbz = 0";
			
			List mkNames = this.commonService.executeSQL(sql);
			// String[] iss
			// ={"业务系统管理","用户组管理","机房管理","机柜管理","节点组管理","任务管理","监测类别设置","监测设置"};
			String n = "";
			for (int i = 0; i < mkNames.size(); i++)
			{
				n = mkNames.get(i).toString();
				if (n.equals(getI18nText("i18n_GuideManageAction.getUserMk.systemManage_n81i")))
				{
					isywxt = "yes";
				} else if (n.equals(getI18nText("i18n_GuideManageAction.getUserMk.usergroupManage_n81i")))
				{
					isyhz = "yes";
				} else if (n.equals(getI18nText("i18n_GuideManageAction.getUserMk.roomManage_n81i")))
				{
					isjf = "yes";
				} else if (n.equals(getI18nText("i18n_GuideManageAction.getUserMk.boxManage_n81i")))
				{
					isjg = "yes";
				} else if (n.equals(getI18nText("i18n_GuideManageAction.getUserMk.nodegroupManage_n81i")))
				{
					isjdz = "yes";
				} else if (n.equals(getI18nText("i18n_GuideManageAction.getUserMk.missionManage_n81i")))
				{
					isrw = "yes";
				} else if (n.equals(getI18nText("i18n_GuideManageAction.getUserMk.detecateTypeManage_n81i")))
				{
					isjclb = "yes";
				} else if (n.equals(getI18nText("i18n_GuideManageAction.getUserMk.detecateSetsManage_n81i")))
				{
					isjcsz = "yes";
				} else
				{
					continue;
				}
			}
			
			String sqlCom = " from TableGuide where userId = " + this.getUserID()
					+ " and systemId=" + this.getSystemID();
			List completeMenu = this.commonService.find(sqlCom);
			for (int j = 0; j < completeMenu.size(); j++)
			{
				TableGuide tg = (TableGuide) completeMenu.get(j);
				if (tg.getGuideName().equals("ywxt"))
				{
					ywxtCom = "y";
				} else if (tg.getGuideName().equals("yhz"))
				{
					yhzCom = "y";
				} else if (tg.getGuideName().equals("jf"))
				{
					jfCom = "y";
				} else if (tg.getGuideName().equals("jg"))
				{
					jgCom = "y";
				} else if (tg.getGuideName().equals("jdz"))
				{
					jdzCom = "y";
				} else if (tg.getGuideName().equals("jd"))
				{
					jdCom = "y";
				} else if (tg.getGuideName().equals("rw"))
				{
					rwCom = "y";
				} else if (tg.getGuideName().equals("jclb"))
				{
					jclbCom = "y";
				} else if (tg.getGuideName().equals("jclbysj"))
				{
					jclbSourceCom = "y";
				} else if (tg.getGuideName().equals("jcsz"))
				{
					jcszCom = "y";
				} else
				{
					continue;
				}
			}
			
// HttpSession ss = this.getRequest().getSession();
//			
// //业务系统管理完成
// if(ywxtCom!=null && ywxtCom.equals("y")){
// ywxtCom = "y";
// ss.setAttribute("ywxtCom","y");
// }
// //用户组管理
// if(yhzCom!=null && yhzCom.equals("y")){
// yhzCom = "y";
// }
//			
// //机房管理
// if(jfCom!=null && jfCom.equals("y")){
// jfCom = "y";
// }
//			
// //机柜管理
// if(jgCom!=null && jgCom.equals("y")){
// jgCom = "y";
// }
//			
// //节点组管理
// if(jdzCom!=null && jdzCom.equals("y")){
// jdzCom = "y";
// }
//			
// //任务管理
// if(rwCom!=null && rwCom.equals("y")){
// rwCom = "y";
// }
// //监测类别管理
// if(jclbCom!=null && jclbCom.equals("y")){
// jclbCom = "y";
// }
// //监测设置
// if(jcszCom!=null && jcszCom.equals("y")){
// jcszCom = "y";
// }
			
		} catch (Exception e)
		{
			e.printStackTrace();
		}
		return "guideIndex";
	}
	
	public String setComplete()
	{
		String jsonStr = null;
		
		try
		{
			TableGuide tg = null;
			
			List nplist = this.commonService
					.find("from TableGuide where userId=? and guideName = ? and systemId=?", this
							.getUserID(), packName, this.getSystemID());
			if (nplist == null || nplist.size() == 0)
			{
				tg = new TableGuide();
				tg.setUserId(this.getUserID());
				tg.setGuideId(packNum);
				tg.setGuideName(packName);
				tg.setSystemId(this.getSystemID());
				this.commonService.save(tg);
				this.addDBOperationRpt(commonService, "TableGuide", "INSERT", tg.getId());
			} else
			{
				tg = (TableGuide) nplist.get(0);
				tg.setUserId(this.getUserID());
				tg.setGuideId(packNum);
				tg.setGuideName(packName);
				tg.setSystemId(this.getSystemID());
				this.commonService.update(tg);
				this.addDBOperationRpt(commonService, "TableGuide", "update", tg.getId());
			}
			jsonStr = "{\"resu\":\"over\"}";
			this.outJson(jsonStr);
		} catch (Exception e)
		{
			e.printStackTrace();
		}
		return null;
	}
	
	public GuideManageAction()
	{
		// TODO Auto-generated constructor stub
	}
	
	public List getYhJsMk(String yhbh)
	{
		List treeList = new ArrayList();
		try
		{
			String sql = "select id,mkmc,mkurl from XtMkJbxx where id in "
					+ "(select mkbh from XtJsMkIndex where jsbh in"
					+ "(select a.jsbh from XtJsJbxx a where  a.jsbh in("
					+ "select jsbh from XtYhJsIndex where yhbh = '"
					+ yhbh
					+ "') and a.zxbz='0')) and zxbz='0' and (mktype <> 1 or mktype is null ) order by showlevel,showorder";
			List menuList = this.commonService.find(sql);
			for (int i = 0; i < menuList.size(); i++)
			{
				Object[] obj = (Object[]) menuList.get(i);// 0为id,1为mkmc,2为mkurl
				Resource resource = new Resource();
				resource.setRsCode(obj[0].toString());
				resource.setRsid(obj[1].toString());
				resource.setRsname(obj[2].toString());
				treeList.add(resource);
			}
		} catch (Exception e)
		{
			e.printStackTrace();
		}
		return treeList;
	}
	
	public CommonService getCommonService()
	{
		return commonService;
	}
	
	public void setCommonService(CommonService commonService)
	{
		this.commonService = commonService;
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
	
	public String getIsywxt()
	{
		return isywxt;
	}
	
	public void setIsywxt(String isywxt)
	{
		this.isywxt = isywxt;
	}
	
	public String getIsyhz()
	{
		return isyhz;
	}
	
	public void setIsyhz(String isyhz)
	{
		this.isyhz = isyhz;
	}
	
	public String getIsjf()
	{
		return isjf;
	}
	
	public void setIsjf(String isjf)
	{
		this.isjf = isjf;
	}
	
	public String getIsjg()
	{
		return isjg;
	}
	
	public void setIsjg(String isjg)
	{
		this.isjg = isjg;
	}
	
	public String getIsjdz()
	{
		return isjdz;
	}
	
	public void setIsjdz(String isjdz)
	{
		this.isjdz = isjdz;
	}
	
	public String getIsrw()
	{
		return isrw;
	}
	
	public void setIsrw(String isrw)
	{
		this.isrw = isrw;
	}
	
	public String getIsjclb()
	{
		return isjclb;
	}
	
	public void setIsjclb(String isjclb)
	{
		this.isjclb = isjclb;
	}
	
	public String getIsjcsz()
	{
		return isjcsz;
	}
	
	public void setIsjcsz(String isjcsz)
	{
		this.isjcsz = isjcsz;
	}
	
	public String getYwxtCom()
	{
		return ywxtCom;
	}
	
	public void setYwxtCom(String ywxtCom)
	{
		this.ywxtCom = ywxtCom;
	}
	
	public String getYhzCom()
	{
		return yhzCom;
	}
	
	public void setYhzCom(String yhzCom)
	{
		this.yhzCom = yhzCom;
	}
	
	public String getJfCom()
	{
		return jfCom;
	}
	
	public void setJfCom(String jfCom)
	{
		this.jfCom = jfCom;
	}
	
	public String getJgCom()
	{
		return jgCom;
	}
	
	public void setJgCom(String jgCom)
	{
		this.jgCom = jgCom;
	}
	
	public String getJdzCom()
	{
		return jdzCom;
	}
	
	public void setJdzCom(String jdzCom)
	{
		this.jdzCom = jdzCom;
	}
	
	public String getRwCom()
	{
		return rwCom;
	}
	
	public void setRwCom(String rwCom)
	{
		this.rwCom = rwCom;
	}
	
	public String getJclbCom()
	{
		return jclbCom;
	}
	
	public void setJclbCom(String jclbCom)
	{
		this.jclbCom = jclbCom;
	}
	
	public String getJcszCom()
	{
		return jcszCom;
	}
	
	public void setJcszCom(String jcszCom)
	{
		this.jcszCom = jcszCom;
	}
	
	public Long getPackNum()
	{
		return packNum;
	}
	
	public void setPackNum(Long packNum)
	{
		this.packNum = packNum;
	}
	
	public String getPackName()
	{
		return packName;
	}
	
	public void setPackName(String packName)
	{
		this.packName = packName;
	}
	
	public Long getUserid()
	{
		return userid;
	}
	
	public void setUserid(Long userid)
	{
		this.userid = userid;
	}
	
	public String getJdCom()
	{
		return jdCom;
	}
	
	public void setJdCom(String jdCom)
	{
		this.jdCom = jdCom;
	}
	
	public String getJclbSourceCom()
	{
		return jclbSourceCom;
	}
	
	public void setJclbSourceCom(String jclbSourceCom)
	{
		this.jclbSourceCom = jclbSourceCom;
	}
	
}
