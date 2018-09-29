package nis.nms.web.actions.logs;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import nis.nms.domains.TableDBOperationRpt;
import nis.nms.domains.TableLoginRpt;
import nis.nms.service.CommonService;
import nis.nms.util.BaseAction;
import nis.nms.util.Page;

import org.apache.struts2.config.Result;
import org.apache.struts2.config.Results;


@SuppressWarnings("unchecked")
@Results( { 
	@Result(name="login", value = "/page/logs/loginlogs.jsp"),
	@Result(name="operate", value = "/page/logs/operatelogs.jsp"),
	@Result(name="error", value ="/error.jsp")
})

public class LogsAction extends BaseAction {
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private CommonService commonService=null;
	private int pageNo = 1;//当前页
	private int pageSize = getDefaultPageSize();		//每页显示的记录条数
	private Page page;
    private List<TableLoginRpt> loginList = null;
    private List<TableDBOperationRpt> actionList = null;

	private String username;
    private Date startTime;
    private Date endTime;
    private String logsaction;
 
	private String position;	
	private String module;
	
	@Override
	public String executeAction() throws Exception {
		// TODO Auto-generated method stub
		return this.login();
	}
	
    public String login () {
    	try {
			SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			String date = "";
			String sql = "from TableLoginRpt ";
			boolean haswhere = false;
			if (username != null && !"".equals(username))
				if(haswhere)
					sql+= " and username='" + username+"'";
				else{
				    sql += "where username='"+ username+"'";
				    haswhere = true;
				}
			
			if(logsaction!=null&&!"".equals(logsaction)){
				if(haswhere)
				   sql +=" and action='"+ logsaction+"'";
				else{
					sql += "where action='"+ logsaction+"'";
					haswhere = true;
				}
			}
			if (startTime != null && !"".equals(startTime)) {
				date = format.format(startTime);
				if(haswhere)
				sql += " and time>=to_date('" + date
						+ "','yyyy-MM-dd hh24-mi-ss')";
				else{
					sql+= "where time>=to_date('" + date
							+ "','yyyy-MM-dd hh24-mi-ss')";
					haswhere = true;
				}
			}
			if (endTime != null && !"".equals(endTime)) {
				date = format.format(endTime);
				if(haswhere)
				sql += " and time<=to_date('" + date
						+ "','yyyy-MM-dd hh24-mi-ss')";
				else{
					sql+= "where time>=to_date('" + date
					+ "','yyyy-MM-dd hh24-mi-ss')";
			        haswhere = true;
				}
			}
			sql +=" order by id desc";
			page = this.commonService.findByPage(sql, pageNo, pageSize);		
			loginList = (List<TableLoginRpt>) page.getResult();
		} catch (Exception e) {
			e.printStackTrace();
			return "error";
		}

       return "login";
    }
    
    public  String operate() {
		try {
			SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			String date = "";
			String sql = "from TableDBOperationRpt ";
			boolean haswhere = false;
			if (username != null && !"".equals(username))
				if(haswhere)
					sql+= " and username='" + username+"'";
				else{
				    sql += "where username='"+ username+"'";
				    haswhere = true;
				}
			
			if(logsaction!=null&&!"".equals(logsaction)){
				if(haswhere)
				   sql +=" and action='"+ logsaction+"'";
				else{
					sql += "where action='"+ logsaction+"'";
					haswhere = true;
				}
			}
			if (startTime != null && !"".equals(startTime)) {
				date = format.format(startTime);
				if(haswhere)
				sql += " and time>=to_date('" + date
						+ "','yyyy-MM-dd hh24-mi-ss')";
				else{
					sql+= "where time>=to_date('" + date
							+ "','yyyy-MM-dd hh24-mi-ss')";
					haswhere = true;
				}
			}
			if (endTime != null && !"".equals(endTime)) {
				date = format.format(endTime);
				if(haswhere)
				sql += " and time<=to_date('" + date
						+ "','yyyy-MM-dd hh24-mi-ss')";
				else{
					sql+= "where time>=to_date('" + date
					+ "','yyyy-MM-dd hh24-mi-ss')";
			        haswhere = true;
				}
			}
			sql +=" order by id desc";
			page = this.commonService.findByPage(sql, pageNo, pageSize);		
			actionList = (List<TableDBOperationRpt>) page.getResult();
		} catch (Exception e) {
			e.printStackTrace();
			return "error";
		}		

    	return "operate";
    }
    
	public void setCommonService(CommonService commonService) {
		this.commonService = commonService;
	}

    public void setUsername(String _username){
    	username = _username;
    }
    public String getUsername(){
    	return username;
    }
    public void setStartTime(Date _starttime){
    	startTime = _starttime;
    }
    public Date getStartTime(){
    	return startTime;
    }
    public void setEndTime(Date _endtime){
    	endTime = _endtime;
    }
    
    public Date getEndTime(){
    	return endTime;
    }
    public void setLogsaction(String _action){
    	logsaction = _action;
    }
    public String getLogsaction(){
    	return logsaction;
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
	public String getPosition() {
		return position;
	}

	public void setPosition(String position) {
		this.position = position;
	}
	public String getModule() {
		return module;
	}

	public void setModule(String module) {
		this.module = module;
	}
	public void setLoginList(List<TableLoginRpt> loginList){
		this.loginList = loginList;
	}
	public List<TableLoginRpt> getLoginList(){
		return loginList;
	}
	public void setActionList(List<TableDBOperationRpt> actionList){
		this.actionList = actionList;
	}
	public List<TableDBOperationRpt> getActionList(){
		return actionList;
	}
}
