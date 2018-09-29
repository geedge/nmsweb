/**
 * DesktopAction.java
 * 版权所有(C) 2010 北京中科智源育成信息技术有限公司
 * @author ZhengXi
 * @date 2010-11-19
 * @version V1.0
 */
package nis.nms.web.actions.desktop;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import nis.nms.core.MakeTree;
import nis.nms.core.Resource;
import nis.nms.domains.Module;
import nis.nms.domains.XtYhJbxx;
import nis.nms.service.CommonService;
import nis.nms.util.BaseAction;
import nis.nms.util.CNToPinyUtils;

import org.apache.struts2.config.Result;
import org.apache.struts2.config.Results;

@Results( {
		@Result(name = "gotoDesktop", value = "/page/desktop/desktop.jsp"),		
		@Result(name = "thirdItem", value = "/page/desktop/thirdItem.jsp"),
		@Result(name = "error", value = "/error.jsp") })
/**
 * 桌面系统控制
 */
public class DesktopAction extends BaseAction {
	private static final long serialVersionUID = 1L;
	private CommonService commonService;
	private String pid;
	private String secondUrl;
	private String bgColors;
	private List<Resource> thirdResource=new ArrayList();
	private String nodeTitle;

	public String getNodeTitle() {
		return nodeTitle;
	}


	public void setNodeTitle(String nodeTitle) {
		this.nodeTitle = nodeTitle;
	}


	public String getPid() {
		return pid;
	}


	public void setPid(String pid) {
		this.pid = pid;
	}

	//初始化桌面菜单的节点
	public String getIconModules() {
		try {			
			List<Resource> list = (List<Resource>) getRequest().getSession()
					.getAttribute("treeList");
			List<Resource> menus = MakeTree.getRootResourceList(list);
			
			int id=Integer.parseInt(this.getRequest().getSession().getAttribute("loginYhid").toString());
			String sql="from XtYhJbxx where yhid="+id+"";			
			List<XtYhJbxx> userInfoList=this.commonService.find(sql);
			XtYhJbxx userInfo = (XtYhJbxx)userInfoList.get(0);
			List draggRight=new ArrayList();
			if(userInfo.getRightMenuItems()!=null&&!"".equals(userInfo.getRightMenuItems())){
				String[] all=userInfo.getRightMenuItems().split(",");
				if(all!=null&&all.length!=0){
					for(int k=0;k<all.length;k++){
						draggRight.add(all[k]);			
					}
				}
			}
			List<Module> mods = new ArrayList<Module>();
			for (Resource res : menus) {			
					Module module = new Module();
					module.setId(Integer.valueOf(res.getRsid()));
					module.setTitle(res.getRsname());
					module.setUrl(res.getRsaddress());
					module.setIcon(res.getIconshow());
					module.setKey(CNToPinyUtils.cn2FirstSpell(res.getRsname()));
					module.setPinyin(CNToPinyUtils.cn2Spell(res.getRsname()));
					if(draggRight.contains(module.getTitle())){
						
					}
					else{
						mods.add(module);						
					}
					
			}
			outJsonArray(mods);		
		} catch (Exception e) {
			e.printStackTrace();
		}
//		getRequest().getSession().setAttribute("modules",
//				JSONArray.fromObject(mods).toString());
		//System.out.println(JSONArray.fromObject(mods).toString());
		return null;
	}
	
	//初始化右边菜单的节点
	public String getRightMenuModules() {
		try {
		
			List<Resource> list = (List<Resource>) getRequest().getSession()
					.getAttribute("treeList");
			List<Resource> menus = MakeTree.getRootResourceList(list);
			
			int id=Integer.parseInt(this.getRequest().getSession().getAttribute("loginYhid").toString());
			String sql="from XtYhJbxx where yhid="+id+"";			
			List<XtYhJbxx> userInfoList=this.commonService.find(sql);
			XtYhJbxx userInfo = (XtYhJbxx)userInfoList.get(0);
			List draggRight=new ArrayList();
			if(userInfo.getRightMenuItems()!=null&&!"".equals(userInfo.getRightMenuItems())){
				String[] all=userInfo.getRightMenuItems().split(",");
				if(all!=null&&all.length!=0){
					for(int k=0;k<all.length;k++){
						draggRight.add(all[k]);			
					}
				}
			}
			List<Module> mods = new ArrayList<Module>();
			for (Resource res : menus) {			
					Module module = new Module();
					module.setId(Integer.valueOf(res.getRsid()));
					module.setTitle(res.getRsname());
					module.setUrl(res.getRsaddress());
					module.setIcon(res.getIconshow());
					module.setKey(CNToPinyUtils.cn2FirstSpell(res.getRsname()));
					module.setPinyin(CNToPinyUtils.cn2Spell(res.getRsname()));
					if(draggRight.contains(module.getTitle())){
						mods.add(module);
					}
					
			}
			outJsonArray(mods);		
		} catch (Exception e) {
			e.printStackTrace();
		}
//		getRequest().getSession().setAttribute("modules",
//				JSONArray.fromObject(mods).toString());
		//System.out.println(JSONArray.fromObject(mods).toString());
		return null;
	}
	
	
	public String showthirdItem(){
		List<Resource> list = (List<Resource>) getRequest().getSession().getAttribute("treeList");
		thirdResource=MakeTree.getotherResourceList(list, pid);
		return "thirdItem";
	}
	
	//把节点从桌面移向右边菜单
	public String addRightMenu(){
		HttpSession session = getRequest().getSession(true); 
		int id=Integer.parseInt(session.getAttribute("loginYhid").toString());
		String sql="from XtYhJbxx where yhid="+id+"";
		try {
			List<XtYhJbxx> userInfoList=this.commonService.find(sql);
			XtYhJbxx userInfo = (XtYhJbxx)userInfoList.get(0);
			String rigthMenu;
			if(userInfo.getRightMenuItems()!=null&&!"".equals(userInfo.getRightMenuItems())){
				rigthMenu=userInfo.getRightMenuItems()+nodeTitle+",";
			}
			else{
				rigthMenu=nodeTitle+",";	
			}
			userInfo.setRightMenuItems(rigthMenu);
			this.commonService.save(userInfo);			
		} catch (Exception e) {
			e.printStackTrace();
		}		
		return null;
	}
	
	//把节点从右边菜单移向桌面
	public String removeRightMenu(){
		HttpSession session = getRequest().getSession(true); 
		int id=Integer.parseInt(session.getAttribute("loginYhid").toString());
		String sql="from XtYhJbxx where yhid="+id+"";
		try {
			List<XtYhJbxx> userInfoList=this.commonService.find(sql);
			XtYhJbxx userInfo = (XtYhJbxx)userInfoList.get(0);
			String rigthMenu;
			if(userInfo.getRightMenuItems()!=null&&!"".equals(userInfo.getRightMenuItems())){
				rigthMenu=userInfo.getRightMenuItems().replace(nodeTitle+",", "");
			}
			else{
				rigthMenu=userInfo.getRightMenuItems();
			}
			userInfo.setRightMenuItems(rigthMenu);
			this.commonService.save(userInfo);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return null;
	}
	
	//更换皮肤
	public String changebgColor(){
		HttpSession session = getRequest().getSession(true); 
		int id=Integer.parseInt(session.getAttribute("loginYhid").toString());
		String sql="from XtYhJbxx where yhid="+id+"";
		try {
			List<XtYhJbxx> userInfoList=this.commonService.find(sql);
			XtYhJbxx userInfo = (XtYhJbxx)userInfoList.get(0);
			if(bgColors!=null&&!"".equals(bgColors)){
				userInfo.setBgColor(bgColors);
			}
			else{				
				userInfo.setBgColor("");
			}		
			this.commonService.save(userInfo);
			session.setAttribute("userBgColor", userInfo.getBgColor());
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "gotoDesktop";
	}
	



	public String executeAction() throws Exception {
		// TODO Auto-generated method stub
		return null;
	}


	public List<Resource> getThirdResource() {
		return thirdResource;
	}


	public void setThirdResource(List<Resource> thirdResource) {
		this.thirdResource = thirdResource;
	}


	public String getSecondUrl() {
		return secondUrl;
	}


	public void setSecondUrl(String secondUrl) {
		this.secondUrl = secondUrl;
	}


	public CommonService getCommonService() {
		return commonService;
	}


	public void setCommonService(CommonService commonService) {
		this.commonService = commonService;
	}


	public String getBgColors() {
		return bgColors;
	}


	public void setBgColors(String bgColors) {
		this.bgColors = bgColors;
	}

}
