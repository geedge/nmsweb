package nis.nms.web.actions.nodePosition;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.apache.log4j.Logger;
import org.apache.struts2.config.Result;
import org.apache.struts2.config.Results;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.JsonConfig;
import nis.nms.domains.NodegroupPositionAll;
import nis.nms.domains.SystemTable;
import nis.nms.domains.TopoInfo;
import nis.nms.domains.TopoLineInfo;
import nis.nms.domains.TopoNodeInfo;
import nis.nms.service.CommonService;
import nis.nms.util.BaseAction;
import nis.nms.util.Constant;
import nis.nms.util.StringUtil;
@Results({
	@Result(name = "showTopo", value = "/page/show/nodeGroup/newShowTopo.jsp")
	/*@Result(name = "showSingleTopo", value = "/page/show/nodeGroup/newShowSingleTopo.jsp")*/
})
public class NewTopoShowAction extends BaseAction{
	private Logger logger = Logger.getLogger(NewTopoShowAction.class);
	private CommonService commonService;
	private String action;
	private List<TopoNodeInfo> topoNodeInfos =new ArrayList<TopoNodeInfo>();
	private List<TopoLineInfo> topoLineInfos =new ArrayList<TopoLineInfo>();
	private List<TopoInfo> topoInfos = new ArrayList<TopoInfo>();
	private Long topoInfoId;
	private String requestType;
	@Override
	public String executeAction() throws Exception {
		String resultpage = null;
		if ("showTopo".equals(this.action))
		{
			resultpage = showTopo();
		}
		return resultpage;
	}
	/**
	 * 展示拓扑数据页面
	 * @return
	 */
	private String showTopo(){
		/**
		 * 涉及的3个表说明
		 * 
		 * topo_info 对应的实体类  TopoInfo topo图的基本信息存储表
		 * topo_node_info 对应的实体类 TopoNodeInfo topo图当中的节点或节点组等属性
		 * topo_line_info 对应的实体类 TopoLineInfo topo图当中的连线位置以及属性相关
		 * 
		 */
		try{
			//根据当前用户选择的业务系统来查询对应的topo图
			//如果当前用户的业务系统为-1 代表为全权限 看主控系统的业务拓扑图
			Long systemId=this.getSystemID();
			if(this.getSystemID()==-1L){
				//查询主控系统的systemId号
				List<SystemTable> systemTables = this.commonService.find("from SystemTable where 1=1 and isMaster=1 ");
				systemId=systemTables.get(0).getSystemId();
			}
			String topoHql="from TopoInfo where 1=1 and systemId="+systemId;
			topoInfos = commonService.find(topoHql);
//			logger.info("query topoInfo response : "+topoInfos);
			if(StringUtil.objectIsNUll(topoInfos)){
				return null;
			}			
			//如果topoInfoId为空 则代表第一次进入查询拓扑页面展示
			if(topoInfoId==null){
				topoInfoId = topoInfos.get(0).getId();
			}
			//查询node所有节点信息
			String nodeHql="from TopoNodeInfo where 1=1 and topoInfo.id="+topoInfoId;
			topoNodeInfos = commonService.find(nodeHql);
			List singleNodeStatus =null;
			List nodesStatus =null;
			List countNodes=null;
			if(!StringUtil.objectIsNUll(topoNodeInfos)){
				for(TopoNodeInfo topoNodeInfo:topoNodeInfos){
					String statusSql="";
					String countSql="";
					//根据当前节点表中出来的数据判断是节点还是节点组然后查询状态
					if(topoNodeInfo.getType().equals(2L)){
						statusSql="select COUNT( distinct nt.node_id) from detection_info_new diw  "
								+ "left join node_table nt on diw.seq_id=nt.seq_id  left join detection_set_info dsi "
								+ "on diw.DETECTION_SET_INFO_ID=dsi.ID left join check_type_info cti on dsi.CHECK_TYPE_ID=cti.id "
								+ "where diw.DETECTIONED_STATE<>1 AND diw.valid=1 AND diw.police_emergent=0 and "
								+ "dsi.DETECTION_SET_STATE=1  and nt.NODE_STATE = 0 and "
								+ "((nt.node_type=0 and (cti.IS_SNMP!=1 or cti.IS_SNMP is null)) or nt.node_type!=0)"
								+ "and nt.node_id ="+topoNodeInfo.getTypeId();
						singleNodeStatus = commonService.executeSQL(statusSql);
					}else if(topoNodeInfo.getType().equals(1L)){
						//查询节点组下不包含拓扑图展示单个节点的节点总数
						countSql="select count(*) from node_table "
								+ "where node_group_id="+topoNodeInfo.getTypeId()+"  and node_state=0 and "
								+ "node_id not in (select type_id from topo_node_info where type=2)";
						//查询节点组下不包含拓扑图展示单个节点的异常节点个数
						statusSql="select COUNT( distinct nt.node_id) from detection_info_new diw "
						+ "left join node_table nt on diw.seq_id = nt.seq_id where diw.DETECTIONED_STATE<>1  AND diw.valid=1 AND diw.police_emergent=0  "
						+ "and diw.DETECTION_SET_INFO_ID in (select dst.ID from DETECTION_SET_INFO dst where dst.DETECTION_SET_STATE=1) "
						+ "and nt.NODE_STATE = 0 and nt.node_group_id ="+topoNodeInfo.getTypeId()+" and "
						+ "node_id not in (select type_id from topo_node_info where type=2)";
						nodesStatus = commonService.executeSQL(statusSql);
						countNodes=commonService.executeSQL(countSql);
					}else if(topoNodeInfo.getType().equals(3L)){
						//如果当前节点类型为其它 不进行任何操作
						continue;
					}
					// 单个节点状态 显示状态 0：正常 1：异常
					if (topoNodeInfo.getType().equals(2L)&&singleNodeStatus != null && singleNodeStatus.size() > 0)
					{
						Integer count = Integer.valueOf(singleNodeStatus.get(0).toString());
						if (count > 0)
						{
							topoNodeInfo.setAlarm("!");
							topoNodeInfo.setStatus(1);
						}
					}else if(topoNodeInfo.getType().equals(1L)&&nodesStatus!=null && nodesStatus.size()>0 && countNodes!=null && countNodes.size()>0){
						Integer allWarningNodes = Integer.valueOf(nodesStatus.get(0).toString());
						Integer allNodes = Integer.valueOf(countNodes.get(0).toString());
						// 节点组状态判断  超过80% 设置节点状态异常
						double doubleValue =0; 
						if(allNodes!=0){		
							doubleValue=new BigDecimal((double)allWarningNodes*100/allNodes).setScale(2,BigDecimal.ROUND_HALF_UP).doubleValue();
						}
						if (doubleValue >= topoNodeInfo.getThresholdValue())
						{
							topoNodeInfo.setAlarm(doubleValue+"%");
							topoNodeInfo.setStatus(1);
						}
					}else{
						topoNodeInfo.setStatus(0);
					}
				}
			}
			//查询line所有线条信息
			String lineHql="from TopoLineInfo where 1=1 and flag=1 and topoInfo.id="+topoInfoId;
			topoLineInfos=commonService.find(lineHql);
			
			// 5分钟刷新一次 ajax请求给返回数据
			if (!StringUtil.objectIsNUll(requestType) && requestType.equals("ajax"))
			{
				List<NodegroupPositionAll> nodegroupPositionAllList = new ArrayList<NodegroupPositionAll>();
				NodegroupPositionAll nodegroupPositionAll = new NodegroupPositionAll();
				nodegroupPositionAll.setTopoLineInfoList(topoLineInfos);
				nodegroupPositionAll.setTopoNodeInfoList(topoNodeInfos);
				nodegroupPositionAllList.add(nodegroupPositionAll);
				
				JsonConfig jsonConfig=new JsonConfig();
				jsonConfig.setExcludes(new String[]{"handler","hibernateLazyInitializer"});
				JSONArray fromObject = JSONArray.fromObject(nodegroupPositionAllList,jsonConfig);
				outJsonArray(fromObject);
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return "showTopo";
	}

	
	
	//获取当前业务系统ID
	public Long getSystemID(){
		HttpSession session = getRequest().getSession(true);
		Long systemId = (Long)session.getAttribute(Constant.SESSION_SYSTEM_LOGIN);
		return systemId;
	}
	
	
	public String getAction() {
		return action;
	}
	public void setAction(String action) {
		this.action = action;
	}
	public CommonService getCommonService() {
		return commonService;
	}
	public void setCommonService(CommonService commonService) {
		this.commonService = commonService;
	}
	public List<TopoNodeInfo> getTopoNodeInfos() {
		return topoNodeInfos;
	}
	public void setTopoNodeInfos(List<TopoNodeInfo> topoNodeInfos) {
		this.topoNodeInfos = topoNodeInfos;
	}
	public List<TopoLineInfo> getTopoLineInfos() {
		return topoLineInfos;
	}
	public void setTopoLineInfos(List<TopoLineInfo> topoLineInfos) {
		this.topoLineInfos = topoLineInfos;
	}
	public List<TopoInfo> getTopoInfos() {
		return topoInfos;
	}
	public void setTopoInfos(List<TopoInfo> topoInfos) {
		this.topoInfos = topoInfos;
	}
	public Long getTopoInfoId() {
		return topoInfoId;
	}
	public void setTopoInfoId(Long topoInfoId) {
		this.topoInfoId = topoInfoId;
	}
	public String getRequestType() {
		return requestType;
	}
	public void setRequestType(String requestType) {
		this.requestType = requestType;
	}
	
}
