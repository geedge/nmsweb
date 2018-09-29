/**
 * DesktopAction.java
 * 版权所有(C) 2010 北京中科智源育成信息技术有限公司
 * @author ZhengXi
 * @date 2010-11-19
 * @version V1.0
 */
package nis.nms.web.actions.nodePosition;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletResponse;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import nis.nms.domains.NodeBoxModule;
import nis.nms.domains.NodeInBoxModule;
import nis.nms.domains.NodeLatticeTable;
import nis.nms.domains.NodeModuleTree;
import nis.nms.domains.NodePosition;
import nis.nms.domains.NodePositionModule;
import nis.nms.domains.NodeRelationModule;
import nis.nms.domains.NodeTable;
import nis.nms.domains.NodeTableModule;
import nis.nms.domains.NodeWaringModuleTree;
import nis.nms.domains.NodegroupTable;
import nis.nms.service.CommonService;
import nis.nms.util.BaseAction;
import nis.nms.util.Constant;

import org.apache.log4j.Logger;
import org.apache.struts2.config.Result;
import org.apache.struts2.config.Results;




@Results( {
	@Result(name = "gotoDesktop", value = "/page/show/showMap.jsp"),
	@Result(name = "topologyView", value = "/page/show/showTopology.jsp"),
	@Result(name = "editMap", value = "/page/show/editMap.jsp"),
	@Result(name = "showSubGroup", value = "/page/show/showTopologySub.jsp"),
	@Result(name = "error", value = "/error.jsp") })
/**
* 拓扑图左面展示
*/
public class NodePositionAction extends BaseAction {
	private Logger logger = Logger.getLogger(NodePositionAction.class);
	private static final long serialVersionUID = 1L;
	private CommonService commonService;
	private String pid;
	private String action;
	private String secondUrl;
	private String bgColors;
	private NodePositionModule nodeM ;
	private String descinfo;
	private String groupId;
	private String groupNpId;
	private String sysPositionId;
	private String from;
	
	public String executeAction() {
		String resultpage = "error";
		if("getIconModules".equals(this.action)){
			resultpage = getIconModules();
		}else if("showMap".equals(this.action)){
			resultpage = showMap();
		}else if("loadImg".equals(this.action)){
			resultpage = loadImgs();
		}else if("editMap".equals(this.action)){
			resultpage = getNodes();
		}else if("getNodeModules".equals(this.action)){
			resultpage =ajaxDrawDateSource();
		}else if("updateNodes".equals(this.action)){
			resultpage = updateNodes();
		}else if("deleteNodes".equals(this.action)){
			resultpage = deleteNodes();
		}else if("updateLines".equals(this.action)){
			resultpage = updateLines();
		}else if("deleteLatt".equals(this.action)){
			resultpage = deleteLatt();
		}else if("showTopology".equals(this.action)){
			resultpage = showTopology();
		}else if("getLastLineSate".equals(this.action)){
			resultpage = getLastLineSate();
		}else if("initnodeBox".equals(this.action)){
			resultpage = initnodeBox();
		}else if("getWarNodeFromBox".equals(this.action)){
			resultpage = getWarNodeFromBox();
		}else if("getBox".equals(this.action)){
			resultpage = getBoxInfo();
		}else if("getBoxByGroup".equals(this.action)){
			resultpage = getBoxByGroup();
		}else if("saveBoxLine".equals(this.action)){
			resultpage = saveBoxInfo();
		}else if("getChildNg".equals(this.action)){
			resultpage = getChildNg();
		}
		return resultpage;
	}
	
	
	private String showMap(){
		return "gotoDesktop";
	}
	private String showTopology(){
		return "topologyView";
	}
	public String getNodes() {
		groupId = this.getRequest().getParameter("gid");
		groupNpId = this.getRequest().getParameter("npGroupId");
		from = this.getRequest().getParameter("from");
		return "editMap";
	}
	
	public String getChildNg() {
		groupId = this.getRequest().getParameter("gid");
		groupNpId = this.getRequest().getParameter("npGroupId");
		from = this.getRequest().getParameter("from");
		return "showSubGroup";
	}
	
	
	private String loadImgs(){
		try {
			String sqlString = "select url from img_url";
			List imgList = this.commonService.executeSQL(sqlString);
			
			HttpServletResponse response = getResponse();
			response.reset();	   
			response.setCharacterEncoding("UTF-8");
			
			response.setContentType("application/json");
			response.getWriter().print(JSONArray.fromObject(imgList).toString());
		}catch (Exception e) {
			logger.error("LoadImgs method failed to load 'modify' image"+e.getMessage());
		}
		return null;
	}
	public String ajaxDrawDateSource(){
		String splits = "@$@";
		Long sysID = this.getSystemID();
		Long groupId = Long.parseLong(this.getRequest().getParameter("gid"));
		Long npGroupId = Long.parseLong(this.getRequest().getParameter("npGroupId"));
		String path	= this.getRequest().getContextPath();
		System.out.println(groupId);
		System.out.println(npGroupId);
		System.out.println(path);
		String ngtSql="";
		try {
			//判断是否存在子节点组
			String checkSql="select count(*) from NODEGROUP_TABLE t where t.PARENT_GROUP_ID ="+groupId.toString()+" and t.is_valid =1";
			List list = this.commonService.executeSQL(checkSql);
			int num = Integer.parseInt(list.get(0).toString());
			if(num>0){
				this.getChildGroup(groupId.toString(), npGroupId.toString(),num);
			}else{
				NodeModuleTree tree = new NodeModuleTree();
				//节点
				String ntSql = 
					 "SELECT " +
					 "NT.NODE_ID, " +
					 "NT.NODE_IP, " +
					 "NT.NODE_NAME, " +
					 "NT.NODE_TYPE, " +
					 "NT.NODE_STATE, " +
					 "NT.SEQ_ID, " +
					 "NT.SYSTEM_ID, " +
					 "NT.NODE_GROUP_ID, " +
					 "NT.NODE_LATTICE_ID, " +
					 "NT.NODE_U_TYPE " +
					 "FROM NODE_TABLE NT  " +
					 "WHERE NT.NODE_STATE = 0  " +
					 "AND NT.NODE_LATTICE_ID IS NULL " +
					 "AND (NT.NODE_GROUP_ID = "+groupId+
					 "OR NT.NODE_GROUP_ID IS NULL) " +
					 "AND NT.SYSTEM_ID="+sysID;
			
				System.out.println("-----ntSql------:"+ntSql);
				
				
				//--节点组
				if(this.getAdminMark()){//如果是admin登陆则无限制
					ngtSql =
						"SELECT  " +
						"NP.ID, " +
						"NGT.GROUP_ID, " +
						"NGT.GROUP_NAME, " +
						"NGT.GROUP_DESC, " +
						"NP.POSITION_X, " +
						"NP.POSITION_Y, " +
						"NP.IMAGE_URL,  " +
						//"TRUNC((NVL(NP.VIEW_TIME_MARK,TO_DATE('2011-01-01','YYYY-MM-DD')) - SYSDATE) / 30, -1) TIME_MARK,  " +
						getTruncSql()+ " TIME_MARK, "+
						"NVL(NP.VIEW_TYPE,0),  " +
						"NP.PARENT_ID   " +
						"FROM NODEGROUP_TABLE NGT  " +
						"LEFT JOIN NODE_POSITION NP ON NP.TABLE_NAME='nodegroup_table' AND NP.NODE_ID=NGT.GROUP_ID  " +
						"WHERE IS_VALID = 1  " +
						"AND NP.ID="+npGroupId;
				}else{
					ngtSql =
						"SELECT  " +
						"NP.ID, " +
						"NGT.GROUP_ID, " +
						"NGT.GROUP_NAME, " +
						"NGT.GROUP_DESC, " +
						"NP.POSITION_X, " +
						"NP.POSITION_Y, " +
						"NP.IMAGE_URL,  " +
						//"TRUNC((NVL(NP.VIEW_TIME_MARK,TO_DATE('2011-01-01','YYYY-MM-DD')) - SYSDATE) / 30, -1) TIME_MARK,  " +
						getTruncSql()+ " TIME_MARK, "+
						"NVL(NP.VIEW_TYPE,0),  " +
						"NP.PARENT_ID   " +
						"FROM NODEGROUP_TABLE NGT  " +
						"LEFT JOIN NODE_POSITION NP ON NP.TABLE_NAME='nodegroup_table' AND NP.NODE_ID=NGT.GROUP_ID  " +
						"WHERE IS_VALID = 1  " +
						" AND (( NGT.VIEW_LEVEL=1 AND NGT.CREATE_USER_ID="+this.getUserID()+")" +
						" OR ( NGT.VIEW_LEVEL=2 AND NGT.CREATE_USERGROUP_ID " +
						" IN (SELECT X.JSBH FROM Xt_Yh_Js_Index  X  WHERE X.YHBH='"+this.getUser().getYhbh()+"' AND X.TYPE = 1))" + 
						" OR (NGT.VIEW_LEVEL=3 AND NGT.SYSTEM_ID = "+sysID+") OR (NGT.VIEW_LEVEL=4 ))"+
						" AND NP.ID="+npGroupId;
					
				}
				
				System.out.println("----====---ngtSql:"+ngtSql);
				
				//可拖拽机柜列表
				String boxSQl = 
					"SELECT " +
					"NP.ID, " +
					"NBT.BOX_ID, " +
					"NBT.DESCINFO, " +
					"NP.POSITION_X, " +
					"NP.POSITION_Y, " +
					"NP.IMAGE_URL, " +
					//"TRUNC((NVL(NP.VIEW_TIME_MARK,TO_DATE('2011-01-01','YYYY-MM-DD')) - SYSDATE) / 30, -1) TIME_MARK, " +
					getTruncSql()+ " TIME_MARK, "+
					"NVL(NP.VIEW_TYPE,0), " +
					"NBT.ISPN, " +
					"NP.PARENT_ID " +
					"FROM NODE_BOX_TABLE NBT LEFT JOIN NODE_POSITION NP ON NP.TABLE_NAME='node_box_table'  " +
					"AND NP.NODE_ID=NBT.BOX_ID  " +
					"WHERE NP.NODE_TYPE ='nodeBox'"+
					"AND NP.PARENT_ID = "+npGroupId;
				
				System.out.println("--=-=-=boxSQl=--===-:"+boxSQl.toUpperCase());
				
				List<Object []> ntList = (List<Object []>)this.commonService.executeSQL(ntSql);
				List<Object []> groupList = (List<Object []>)this.commonService.executeSQL(ngtSql);
				
				//关联机柜
				List<Object []> boxList = (List<Object []>)this.commonService.executeSQL(boxSQl);
				
				
				//遍历节点(pc)
				if(ntList!=null && ntList.size()>0){
					for (Object[] objs : ntList) {
						tree.getNodeList().add(new NodeTableModule(
								Long.parseLong(objs[0]==null?"0":objs[0].toString()), 
								"node_table",
								"node",
								objs[1].toString(), 
								objs[2].toString(), 
								Long.parseLong(objs[3]==null?"0":objs[3].toString()), 
								Long.parseLong(objs[4]==null?"0":objs[4].toString()), 
								Long.parseLong(objs[5]==null?"0":objs[5].toString()), 
								Long.parseLong(objs[6]==null?"0":objs[6].toString()), 
								Long.parseLong(objs[7]==null?"0":objs[7].toString()), 
								Long.parseLong(objs[8]==null?"0":objs[8].toString()), 
								Long.parseLong(objs[9]==null?"1":objs[9].toString()),
								path+"/images/show/node_pc.png"
								));
						
					}
					
				}
				
				//遍历节点组
				if(groupList!=null && groupList.size()>0){
					for (Object[] objs : groupList) {
						tree.getSysAndNgList().add(new NodePositionModule(
								Long.parseLong(objs[0]==null?"0":objs[0].toString()),//node position Id
								Long.parseLong(objs[1]==null?"0":objs[1].toString()),		//sys Id
								objs[2]==null ? "" :objs[2].toString(),		//	sys name
								objs[3]==null ? "" :objs[3].toString(), //sys desc
								"nodegroup_table",
								"nodeGroup",	//type
								Long.parseLong(objs[4]==null?"0":objs[4].toString()),
								Long.parseLong(objs[5]==null?"0":objs[5].toString()),
								objs[6]==null?path+"/images/show/topic.png":objs[6].toString(),
								"nodegroup_table"+splits+"0"+splits+"0",
								Long.valueOf(objs[7].toString()),
								Long.valueOf(objs[8].toString()) ,
								Long.parseLong(objs[9]==null?"0":objs[9].toString())
								)
						);
					}
				}
				
				String getBoxIDByGroup = "select t1.node_id from node_position t1 where t1.parent_id ="+ npGroupId +" and t1.node_type = 'nodeBox'"; 
				
				List nbt = this.commonService.executeSQL(getBoxIDByGroup);
				
				
				//--节点组和机柜关系
				if(nbt!=null && nbt.size()>0){
					for (int i=0;i<nbt.size();i++) {
						String state = (Math.random()+"");
						Object boxId = nbt.get(i);
						tree.getRelaList().add(new NodeRelationModule(
								"nodegroup_table_nodeGroup_"+groupId,
								"node_box_table_nodeBox_"+boxId,
								"#"+(state.substring(state.indexOf(".")+1,state.indexOf(".")+7))
								)
						);
					}
				}
				
				//遍历列表机柜
				if(boxList!=null && boxList.size()>0){
					for (Object[] objs : boxList) {
						tree.getNodeBoxList().add(
								new NodeBoxModule(
								Long.parseLong(objs[0]==null?"0":objs[0].toString()),//id,
								Long.parseLong(objs[1]==null?"0":objs[1].toString()), //nodeId
								"node_box_table",//tableName
								"nodeBox",//nodeType
								objs[8]==null?"":objs[8].toString(),//ispn
								objs[2].toString(), //nodeDesc
								Long.parseLong(objs[3]==null?"0":objs[3].toString()),//positionX
								Long.parseLong(objs[4]==null?"0":objs[4].toString()),//positionY
								objs[5]==null?path+"/images/show/nm.png":objs[5].toString(),//imageUrl
								Long.valueOf(objs[6].toString()),//monthMark
								Long.valueOf("2"),//viewType
								"nodegroup_table"+splits+"0"+splits+"0",//linkSplit
								Long.valueOf(objs[9].toString())//parentId
								)
						);
					}
				}
							
				HttpServletResponse response = getResponse();
			    response.reset();	   
			    response.setCharacterEncoding("UTF-8");
		        
			    response.setContentType("application/json");
		        System.out.println(JSONObject.fromObject(tree).toString());
			    response.getWriter().print(JSONObject.fromObject(tree).toString());
			}
			
		}catch (Exception e) {
			logger.error("The ajaxDrawDateSource method, get data error"+e.getMessage());
		}
		return null;
	} 	
	
	public String getChildGroup(String gid,String npgid,int num){
		String splits = "@$@";
		Long sysID = this.getSystemID();
		String path	= this.getRequest().getContextPath();
		System.out.println(gid);
		System.out.println(npgid);
	
		try {
			
			NodeModuleTree tree = new NodeModuleTree();
			
			//--父节点组
			String ngtSql =
				"SELECT  " +
				"NP.ID, " +
				"NGT.GROUP_ID, " +
				"NGT.GROUP_NAME, " +
				"NGT.GROUP_DESC, " +
				"NP.POSITION_X, " +
				"NP.POSITION_Y, " +
				"NP.IMAGE_URL,  " +
//				"TRUNC((NVL(NP.VIEW_TIME_MARK,TO_DATE('2011-01-01','YYYY-MM-DD')) - SYSDATE) / 30, -1) TIME_MARK,  " +
				getTruncSql()+ " TIME_MARK, "+
				"NVL(NP.VIEW_TYPE,0),  " +
				"NP.PARENT_ID   " +
				"FROM NODEGROUP_TABLE NGT  " +
				"LEFT JOIN NODE_POSITION NP ON NP.TABLE_NAME='nodegroup_table' AND NP.NODE_ID=NGT.GROUP_ID  " +
				"WHERE IS_VALID = 1  " +
				" AND (( NGT.VIEW_LEVEL=1 AND NGT.CREATE_USER_ID="+this.getUserID()+")" +
				" OR ( NGT.VIEW_LEVEL=2 AND NGT.CREATE_USERGROUP_ID " +
				" IN (SELECT X.JSBH FROM Xt_Yh_Js_Index  X  WHERE X.YHBH='"+this.getUser().getYhbh()+"' AND X.TYPE = 1))" + 
				" OR (NGT.VIEW_LEVEL=3 AND NGT.SYSTEM_ID = "+sysID+") OR (NGT.VIEW_LEVEL=4 ))"+
				"AND NP.ID="+npgid;
				
			System.out.println("----====---ngtSql:"+ngtSql);
			
			//--子节点组
			String cngtSql =
				"SELECT  " +
				"NP.ID, " +
				"NGT.GROUP_ID, " +
				"NGT.GROUP_NAME, " +
				"NGT.GROUP_DESC, " +
				"NP.POSITION_X, " +
				"NP.POSITION_Y, " +
				"NP.IMAGE_URL,  " +
				//"TRUNC((NVL(NP.VIEW_TIME_MARK,TO_DATE('2011-01-01','YYYY-MM-DD')) - SYSDATE) / 30, -1) TIME_MARK,  " +
				getTruncSql()+ " TIME_MARK, "+
				"NVL(NP.VIEW_TYPE,0),  " +
				"NP.PARENT_ID   " +
				"FROM NODEGROUP_TABLE NGT  " +
				"LEFT JOIN NODE_POSITION NP ON NP.TABLE_NAME='nodegroup_table' AND NP.NODE_ID=NGT.GROUP_ID  " +
				"WHERE IS_VALID = 1  " +
				" AND (( NGT.VIEW_LEVEL=1 AND NGT.CREATE_USER_ID="+this.getUserID()+")" +
				" OR ( NGT.VIEW_LEVEL=2 AND NGT.CREATE_USERGROUP_ID " +
				" IN (SELECT X.JSBH FROM Xt_Yh_Js_Index  X  WHERE X.YHBH='"+this.getUser().getYhbh()+"' AND X.TYPE = 1))" + 
				" OR (NGT.VIEW_LEVEL=3 AND NGT.SYSTEM_ID = "+sysID+") OR (NGT.VIEW_LEVEL=4 ))"+
				" AND NGT.PARENT_GROUP_ID ="+gid+
			    " AND NP.PARENT_ID = "+npgid;
				
			System.out.println("----====---cngtSql:"+cngtSql);
			
			List<Object []> groupList = (List<Object []>)this.commonService.executeSQL(ngtSql);
			
			List<Object []> childGroupList = (List<Object []>)this.commonService.executeSQL(cngtSql);
			
			//遍历父节点组
			if(groupList!=null && groupList.size()>0){
				for (Object[] objs : groupList) {
					tree.getSysAndNgList().add(new NodePositionModule(
							Long.parseLong(objs[0]==null?"0":objs[0].toString()),//node position Id
							Long.parseLong(objs[1]==null?"0":objs[1].toString()),		//gourp Id
							objs[2]==null ? "" :objs[2].toString(),		//	gourp name
							objs[3]==null ? "" :objs[3].toString(), //gourp desc
							"nodegroup_table",
							"nodeGroup",	//type
							Long.parseLong(objs[4]==null?"0":objs[4].toString()),
							Long.parseLong(objs[5]==null?"0":objs[5].toString()),
							objs[6]==null?path+"/images/show/topic.png":objs[6].toString(),
							"nodegroup_table"+splits+"0"+splits+"0",
							Long.valueOf(objs[7].toString()),
							Long.valueOf(objs[8].toString()) ,
							Long.parseLong(objs[9]==null?"0":objs[9].toString()),
							new Long((long)num),
							this.getNodeNum(objs[1].toString())
							)
					);
				}
			}
			
			//遍历子节点组
			if(childGroupList!=null && childGroupList.size()>0){
				for (Object[] objs : childGroupList) {
					//初始化之前先去查询子节点组个数
					Long numLong = Long.parseLong("0");
					if(objs[1]!=null){
						String isHaveChildSQl = "select count(*) from NODEGROUP_TABLE t where t.PARENT_GROUP_ID =" +objs[1].toString()+" and t.is_valid =1";
						numLong = Long.parseLong(this.commonService.executeSQL(isHaveChildSQl).get(0).toString());
					}
					if(Integer.parseInt(numLong.toString())==0){
						NodeWaringModuleTree nwmt =new NodeWaringModuleTree();
						tree.getSysAndNgList().add(new NodePositionModule(
								Long.parseLong(objs[0]==null?"0":objs[0].toString()),//node position Id
								Long.parseLong(objs[1]==null?"0":objs[1].toString()),		//node Id
								objs[2]==null ? "" :objs[2].toString(),		//	node name
								objs[3]==null ? "" :objs[3].toString(), //node desc
								"nodegroup_table",
								"nodeGroup",	//type
								Long.parseLong(objs[4]==null?"0":objs[4].toString()),
								Long.parseLong(objs[5]==null?"0":objs[5].toString()),
								objs[6]==null?path+"/images/show/topic.png":objs[6].toString(),
								"nodegroup_table"+splits+"0"+splits+"0",
								Long.valueOf(objs[7].toString()),
								Long.valueOf(objs[8].toString()) ,
								Long.parseLong(objs[9]==null?"0":objs[9].toString()),
								numLong,
								nwmt= getWarningInfo(objs[1].toString())//NodeWaringModuleTree
								)
						);
					}else{
						tree.getSysAndNgList().add(new NodePositionModule(
								Long.parseLong(objs[0]==null?"0":objs[0].toString()),//node position Id
								Long.parseLong(objs[1]==null?"0":objs[1].toString()),		//gourp Id
								objs[2]==null ? "" :objs[2].toString(),		//	gourp name
								objs[3]==null ? "" :objs[3].toString(), //gourp desc
								"nodegroup_table",
								"nodeGroup",	//type
								Long.parseLong(objs[4]==null?"0":objs[4].toString()),
								Long.parseLong(objs[5]==null?"0":objs[5].toString()),
								objs[6]==null?path+"/images/show/topic.png":objs[6].toString(),
								"nodegroup_table"+splits+"0"+splits+"0",
								Long.valueOf(objs[7].toString()),
								Long.valueOf(objs[8].toString()) ,
								Long.parseLong(objs[9]==null?"0":objs[9].toString()),
								numLong,
								this.getNodeNum(objs[1].toString())
								)
						);
					}
				}
			}
			
			String getChildGroupId = "select t1.node_id from node_position t1 where t1.parent_id ="+ npgid +" and t1.node_type = 'nodeGroup'"; 
			
			List cngtList = this.commonService.executeSQL(getChildGroupId);
			
			//--父节点组和子节点组关系
			if(cngtList!=null && cngtList.size()>0){
				for (int i=0;i<cngtList.size();i++) {
					Object ngId = cngtList.get(i);
					String warnSql = this.doSQl(ngId);
					List<Object []> warnList = this.commonService.executeSQL(warnSql);
					//存在不正常节点，线为红色
					if(warnList!=null && warnList.size()>0){
						tree.getRelaList().add(new NodeRelationModule(
								"nodegroup_table_nodeGroup_"+gid,
								"nodegroup_table_nodeGroup_"+ngId.toString(),
								"#FF0000")
						);
					}else{
						tree.getRelaList().add(new NodeRelationModule(
								"nodegroup_table_nodeGroup_"+gid,
								"nodegroup_table_nodeGroup_"+ngId.toString(),
								"#00FF00"
								)
						);
					}
					
				}
			}
						
			HttpServletResponse response = getResponse();
		    response.reset();	   
		    response.setCharacterEncoding("UTF-8");
	        
		    response.setContentType("application/json");
	        System.out.println(JSONObject.fromObject(tree).toString());
		    response.getWriter().print(JSONObject.fromObject(tree).toString());
			
		}catch (Exception e) {
			logger.error("The getChildGroup method, get child node group error"+e.getMessage());
		}
		return null;
	} 	

	
	private String initnodeBox(){
		String boxid = this.getRequest().getParameter("boxId");
		String gId = this.getRequest().getParameter("gId");
		System.out.println("boxid:"+boxid);
		System.out.println("gId:"+gId);
		NodeModuleTree tree = new NodeModuleTree();
		String path	= this.getRequest().getContextPath();
		System.out.println(path);
		//节点
		String nibSql =
			" select" +
			" nt.node_id," +
			" nt.node_name," +
			" nt.node_desc," +
			" nlt.lattice_position," +
			" nbt.box_id," +
			" nbt.descinfo," +
			" nt.system_id," +
			" nt.node_ip," +
			" nbt.ispn," +
			" nt.node_type,"+
		    " nt.node_u_type,"+
		    " nt.seq_id,"+
		    " nt.node_group_id,"+
		    " ''"+
			" from node_table nt" +
			" left join node_lattice_table nlt on nt.node_lattice_id = nlt.id" +
			" left join node_box_table nbt on nlt.node_box_id = nbt.box_id" +
			" where nt.node_state = 0" +
			" and nt.node_lattice_id is not null" +
			" and nbt.box_id = " +boxid;
			
		System.out.println("init box---sql:"+nibSql);
		
		try {
			List<Object []> nibList = (List<Object []>)this.commonService.executeSQL(nibSql);
			Map<Object,Object[]> map = new HashMap<Object,Object[]>();
			if(nibList!=null && nibList.size()>0){
				for(Object[] objs : nibList){
					//判断本次循环对象是不是本组节点objs[12]=是否可拖拽标识：0是，1否
					if(objs[12] != null && gId.equals(objs[12].toString())){
						objs[13]="0";
						//把本节点放入，本格子可编辑拖动标识
						map.put(objs[3], objs);
					}else{
						objs[13]="1";
						//判断本次循环对象不是本组节点
						//再判断键值能不能取出值，即判断本位置是否已有逻辑节点
						//objs[3] = nlt.lattice_position
						Object [] objstemp = (Object [])map.get(objs[3]);
						//如果是
						if(objstemp==null){
							//如果不能取出值则把本对象放入，并且添加本格子不可编辑拖动的标识
							map.put(objs[3], objs);
						}
					}				
				}
			}
	
			Object[] objs = map.values().toArray();
			NodeInBoxModule nbm = null;
			for(int i=0;i<objs.length;i++){
				Object[] ob = (Object[])objs[i];
				nbm =  new NodeInBoxModule(
						Long.parseLong(ob[0]==null?"0":ob[0].toString()), //node_id
						"node_table",											
						"node",
						ob[1]==null ? "" : ob[1].toString(), 				//node_name
						ob[2]==null ? "" : ob[2].toString(), 				//node_desc
						path+"/images/show/node_pc.png",
						ob[3]==null ? "" : ob[3].toString(), 				//lattice_position
						Long.parseLong(ob[4]==null?"0":ob[4].toString()),	//box_id
						ob[5]==null ? "" : ob[5].toString(),				//box descinfo
						ob[7]==null ? "" : ob[7].toString(),				//node_ip
						ob[8]==null ? "" : ob[8].toString(),				//box ispn
						ob[13].toString(),//"0"为相同系统下，可以拖拽
						Long.parseLong(ob[9]==null?"0":ob[9].toString()),	//nodeType
						Long.parseLong(ob[10]==null?"1":ob[10].toString()),	// u位
						Long.parseLong(ob[11]==null?"0":ob[11].toString())	//seqId
						);
				tree.getNodeInBoxList().add(nbm);
			}
				
			HttpServletResponse response = getResponse();
		    response.reset();	   
		    response.setCharacterEncoding("UTF-8");
		    response.setContentType("application/json");
		    response.getWriter().print(JSONObject.fromObject(tree).toString());
		    System.out.println(JSONObject.fromObject(tree).toString());
		} catch (Exception e) {
			logger.error("The initnodeBox method, error initializing cabinet information"+e.getMessage());
		}
		return null;
	}
	
	private String getWarNodeFromBox(){
		String boxid = this.getRequest().getParameter("boxId");
		String ngId = this.getRequest().getParameter("ngId");
		NodeModuleTree tree = new NodeModuleTree();
		String path	= this.getRequest().getContextPath();
		Long sysId = this.getSystemID();
		System.out.println("boxid:"+boxid);
		System.out.println("ngId:"+ngId);
		
		String nibSql =
			" select distinct" +
			" nt.node_id," +
			" nt.node_name," +
			" nt.node_desc," +
			" nlt.lattice_position," +
			" nbt.box_id," +
			" nbt.descinfo," +
			" diw.seq_id," +
			" nt.node_ip," +
			" nt.node_u_type" +
			" from node_table nt" +
			" left join node_lattice_table nlt on nt.node_lattice_id = nlt.id" +
			" left join node_box_table nbt on nlt.node_box_id = nbt.box_id" +
			" left join detection_info_warning diw on nt.seq_id = diw.seq_id "+ 
			" where nt.node_state = 0" +
			" and nt.node_lattice_id is not null" +
			" and nbt.box_id = " +boxid+
			" and nt.node_group_id ="+ngId+
			" and nt.system_id="+sysId;
		
		System.out.println("getWarNodeFromBox---sql:"+nibSql);
		
		try {
			List<Object []> nibList = (List<Object []>)this.commonService.executeSQL(nibSql);
			if(nibList!=null && nibList.size()>0){
				for (Object[] objs : nibList) {
					tree.getNodeInBoxList().add(new NodeInBoxModule(
							Long.parseLong(objs[0]==null?"0":objs[0].toString()), 
							"node_table",
							"node",
							objs[1]==null ? "" : objs[1].toString(), 
							objs[2]==null ? "" : objs[2].toString(), 
							path+"/images/show/node_pc.png",
							objs[3]==null ? "" : objs[3].toString(), 
							Long.parseLong(objs[4]==null?"0":objs[4].toString()),
							objs[5]==null ? "" : objs[5].toString(),
							Long.parseLong(objs[6]==null?"0":objs[6].toString()),
							objs[7]==null ? "" : objs[7].toString(),
							Long.parseLong(objs[8]==null?"1":objs[8].toString()))
					);
				}
			}
			
			HttpServletResponse response = getResponse();
		    response.reset();	   
		    response.setCharacterEncoding("UTF-8");
		    response.setContentType("application/json");
		    response.getWriter().print(JSONObject.fromObject(tree).toString());
		    System.out.println(JSONObject.fromObject(tree).toString());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	private NodeWaringModuleTree getWarningInfo(String groupId){
		NodeWaringModuleTree tree = new NodeWaringModuleTree();
		try {
			//节点组下的所有节点
			String nodeNumSql="select nt.node_id,nt.node_ip,nt.node_name,"+
					"nt.seq_id from node_table nt " +
					"where nt.node_group_id="+groupId+" and nt.node_state = 0";
			
			System.out.println("---nodeNumSql---:"+nodeNumSql);
			List<Object []> nList = this.commonService.executeSQL(nodeNumSql);
			if(nList!=null && nList.size()>0){
				for (Object[] objs : nList) {
					tree.getNodeTableList().add(new NodeTableModule(
							Long.parseLong(objs[0]==null?"0":objs[0].toString()),
							objs[1]==null ? "" : objs[1].toString(), 
							objs[2]==null ? "" : objs[2].toString(), 
							Long.parseLong(objs[3]==null?"0":objs[3].toString())
							)
					);
				}
				
				//状态不正常的节点
				String falseNodeSql="select distinct nt.node_id,nt.node_ip,nt.node_name,"+
									"nt.seq_id from detection_info_warning diw " +
									"left join node_table nt "+
									"on diw.seq_id = nt.seq_id " +
									"where nt.node_group_id="+groupId+" and nt.NODE_STATE = 0";
				System.out.println("---falseNodeSql---:"+falseNodeSql);
				List<Object []> falseList = this.commonService.executeSQL(falseNodeSql);
				if(falseList!=null && falseList.size()>0){
					for (Object[] objs : falseList) {
						tree.getFalseNodeList().add(new NodeTableModule(
								Long.parseLong(objs[0]==null?"0":objs[0].toString()),
								objs[1]==null ? "" : objs[1].toString(), 
								objs[2]==null ? "" : objs[2].toString(), 
								Long.parseLong(objs[3]==null?"0":objs[3].toString())
								)
						);
					}
				}
				//状态正常的节点
				String trueNodeSql="select distinct nt.node_id,nt.node_ip,nt.node_name,"+
									" nt.seq_id from node_table nt " +
									" where nt.node_group_id="+groupId+
									" and nt.node_state = 0"+
									" and nt.seq_id not in"+
									" (select distinct seq_id from detection_info_warning diw " +
									" where diw.seq_id is not null)";
				System.out.println("---trueNodeSql----:"+trueNodeSql);
				List<Object []> trueList = this.commonService.executeSQL(trueNodeSql);
				if(trueList!=null && trueList.size()>0){
					for (Object[] objs : trueList) {
						tree.getTrueNodeList().add(new NodeTableModule(
								Long.parseLong(objs[0]==null?"0":objs[0].toString()),
								objs[1]==null ? "" : objs[1].toString(), 
								objs[2]==null ? "" : objs[2].toString(), 
								Long.parseLong(objs[3]==null?"0":objs[3].toString())
								)
						);
					}
				}
			}
			
		} catch (Exception e) {
			logger.error("The getWarningInfo method, get alarm data error"+e.getMessage());
		}
		
		return tree;
	}
	
	private Long getNodeNum(String groupId) throws Exception{
		Long nodeNum = new Long(0l);
		//@2018-3-9 fang 修改 首先查询符合条件的id，在拼接sql，适配mysql
		String gsql = "select group_id from nodegroup_table t where 1=1 ";
		String gids = this.commonService.getGroupIdStartWith(gsql, "t.group_id = " +groupId);
		/*String sql="select count(*) from node_table t where t.node_group_id in " +
					"(select t.group_id from nodegroup_table t start with t.group_id = "+groupId+
					" connect by prior t.group_id = t.parent_group_id) and t.node_state = 0";*/
		String sql="select count(*) from node_table t where t.node_group_id in " +
				"("+gids+") and t.node_state = 0";
		List gIdList= this.commonService.executeSQL(sql);
		if(gIdList!=null && gIdList.size()>0){
			nodeNum = Long.parseLong(gIdList.get(0).toString());
		}
		return nodeNum;
	}
	
	//初始化桌面菜单的节点
	private String getIconModules() {
		//得到系统ID
		Long sysID =this.getSystemID();
		String path	= this.getRequest().getContextPath();
		System.out.println("path:"+path);
		System.out.println("系统ID:"+sysID);
		String splits = "@$@";
		try {
			NodeModuleTree tree = new NodeModuleTree();
			String ngtSql ="";
			//系统节点
			String sysSql =
				"SELECT " +
				" NP.ID," +
				" ST.SYSTEM_ID," +
				" ST.SYSTEM_NAME," +
				" ST.SYSTEM_DESC," +
				" NP.POSITION_X," +
				" NP.POSITION_Y," +
				" NP.IMAGE_URL, " +
//				" TRUNC((NVL(NP.VIEW_TIME_MARK,to_date('2011-01-01','yyyy-mm-dd')) - sysdate) / 30, -1) TIME_MARK, " +
				getTruncSql()+ " TIME_MARK, "+
				" NVL(NP.VIEW_TYPE,0), " +
				" NP.PARENT_ID " +
				" FROM SYSTEM_TABLE ST "	+ 
				" LEFT JOIN NODE_POSITION NP ON NP.TABLE_NAME ='system_table' AND NP.NODE_ID =ST.SYSTEM_ID " + 
				" WHERE SYSTEM_STATE = 0 " +
				" AND SYSTEM_ID = " +sysID;
			
			System.out.println("getI...sysSql:"+sysSql);
			
			//--节点组
			if(this.getAdminMark()){//如果是admin登陆则无限制
				ngtSql =
					"SELECT " +
					" NP.ID," +
					" NGT.GROUP_ID," +
					" NGT.GROUP_NAME," +
					" NGT.GROUP_DESC," +
					" NP.POSITION_X," +
					" NP.POSITION_Y," +
					" NP.IMAGE_URL, " +
//					" TRUNC((NVL(NP.VIEW_TIME_MARK,to_date('2011-01-01','yyyy-mm-dd')) - sysdate) / 30, -1) TIME_MARK, " +
					getTruncSql()+ " TIME_MARK, "+
					" NVL(NP.VIEW_TYPE,0), " +
					" NP.PARENT_ID " +
					" FROM NODEGROUP_TABLE NGT " + 
					" LEFT JOIN NODE_POSITION NP ON NP.TABLE_NAME='nodegroup_table' AND NP.NODE_ID = NGT.GROUP_ID " + 
					" WHERE IS_VALID = 1 " +
					" AND NGT.PARENT_GROUP_ID = 0" +
					" AND NGT.SYSTEM_ID ="+sysID;
			}else{
				ngtSql =
					"SELECT " +
					" NP.ID," +
					" NGT.GROUP_ID," +
					" NGT.GROUP_NAME," +
					" NGT.GROUP_DESC," +
					" NP.POSITION_X," +
					" NP.POSITION_Y," +
					" NP.IMAGE_URL, " +
//					" TRUNC((NVL(NP.VIEW_TIME_MARK,to_date('2011-01-01','yyyy-mm-dd')) - sysdate) / 30, -1) TIME_MARK, " +
					getTruncSql()+ " TIME_MARK, "+
					" NVL(NP.VIEW_TYPE,0), " +
					" NP.PARENT_ID " +
					" FROM NODEGROUP_TABLE NGT " + 
					" LEFT JOIN NODE_POSITION NP ON NP.TABLE_NAME='nodegroup_table' AND NP.NODE_ID = NGT.GROUP_ID " + 
					" WHERE IS_VALID = 1 " +
					" AND NGT.PARENT_GROUP_ID = 0" +
					" AND (( NGT.VIEW_LEVEL=1 AND NGT.CREATE_USER_ID="+this.getUserID()+")" +
					" OR ( NGT.VIEW_LEVEL=2 AND NGT.CREATE_USERGROUP_ID " +
					" IN (SELECT X.JSBH FROM Xt_Yh_Js_Index  X  WHERE X.YHBH='"+this.getUser().getYhbh()+"' AND X.TYPE = 1))" + 
					" OR (NGT.VIEW_LEVEL=3 AND NGT.SYSTEM_ID = "+sysID+") OR (NGT.VIEW_LEVEL=4 ))"+
					" AND NGT.SYSTEM_ID ="+sysID;
			}
			
			System.out.println("getI...ngtSql:"+ngtSql);
			
			//系统
			List<Object []> sysList = (List<Object [] >)this.commonService.executeSQL(sysSql);
			//节点组
			List<Object []> groupList = (List<Object []>)this.commonService.executeSQL(ngtSql);
			
			//遍历系统		
			if(sysList!=null && sysList.size()>0){
				for (Object [] objs : sysList) {
					tree.getSysAndNgList().add(new NodePositionModule(
							Long.parseLong(objs[0]==null?"0":objs[0].toString()),//node position Id, 
							Long.parseLong(objs[1]==null?"0":objs[1].toString()),		//sys Id,
							objs[2]==null ? "" :objs[2].toString(),		//	sys name
							objs[3]==null ? "" :objs[3].toString(), //sys desc, 
							"system_table", //table name 
							"system",		//type,
							Long.parseLong(objs[4]==null?"0":objs[4].toString()),//positionX
							Long.parseLong(objs[5]==null?"0":objs[5].toString()),//positionY,
							objs[6]==null?path+"/images/show/sensor.png":objs[6].toString(),//imageUrl,
							"nodegroup_table"+splits+"0"+splits+"0",//linkSplit,
							Long.valueOf(objs[7].toString()),	//monthMark, 
							Long.valueOf(objs[8].toString()),//viewType, 
							Long.parseLong(objs[9]==null?"0":objs[9].toString())//parent_id
							)
					);
				}
			}
			
			
			
			//遍历节点组
			if(groupList!=null && groupList.size()>0){
				for (Object[] objs : groupList) {
					//初始化之前先去查询子节点组个数
					Long numLong = Long.parseLong("0");
					if(objs[1]!=null){
						String isHaveChildSQl = "select count(*) from NODEGROUP_TABLE t where t.PARENT_GROUP_ID =" +objs[1].toString()+" and t.is_valid =1";
						numLong = Long.parseLong(this.commonService.executeSQL(isHaveChildSQl).get(0).toString());
						if(Integer.parseInt(numLong.toString())==0){
							NodeWaringModuleTree nwmt =new NodeWaringModuleTree();
							tree.getSysAndNgList().add(new NodePositionModule(
									Long.parseLong(objs[0]==null?"0":objs[0].toString()),//node position Id
									Long.parseLong(objs[1]==null?"0":objs[1].toString()),		//node Id
									objs[2]==null ? "" :objs[2].toString(),		//	node name
									objs[3]==null ? "" :objs[3].toString(), //node desc
									"nodegroup_table",
									"nodeGroup",	//type
									Long.parseLong(objs[4]==null?"0":objs[4].toString()),
									Long.parseLong(objs[5]==null?"0":objs[5].toString()),
									objs[6]==null?path+"/images/show/topic.png":objs[6].toString(),
									"nodegroup_table"+splits+"0"+splits+"0",
									Long.valueOf(objs[7].toString()),
									Long.valueOf(objs[8].toString()) ,
									Long.parseLong(objs[9]==null?"0":objs[9].toString()),
									numLong,
									nwmt= getWarningInfo(objs[1].toString())//NodeWaringModuleTree
									)
							);
						}else{
							tree.getSysAndNgList().add(new NodePositionModule(
									Long.parseLong(objs[0]==null?"0":objs[0].toString()),//node position Id
									Long.parseLong(objs[1]==null?"0":objs[1].toString()),		//node Id
									objs[2]==null ? "" :objs[2].toString(),		//	node name
									objs[3]==null ? "" :objs[3].toString(), //node desc
									"nodegroup_table",
									"nodeGroup",	//type
									Long.parseLong(objs[4]==null?"0":objs[4].toString()),
									Long.parseLong(objs[5]==null?"0":objs[5].toString()),
									objs[6]==null?path+"/images/show/topic.png":objs[6].toString(),
									"nodegroup_table"+splits+"0"+splits+"0",
									Long.valueOf(objs[7].toString()),
									Long.valueOf(objs[8].toString()) ,
									Long.parseLong(objs[9]==null?"0":objs[9].toString()),
									numLong,
									this.getNodeNum(objs[1].toString())
									)
							);
						}
					}
					
				}
			}
			
			String getNgIdBySys = "select t1.node_id from node_position t1 where t1.parent_id =("+
								  "select id  from node_position t "+
								  "where node_id = "+sysID+" and node_type = 'system')";
			System.out.println("------getNgIdBySys--------:"+getNgIdBySys);
			List ng = this.commonService.executeSQL(getNgIdBySys);//所有系统下的父级节点组id
			
			
			//系统和节点组关系
			if(ng!=null && ng.size()>0){
				for (int i=0;i<ng.size();i++) {
					Object ngId = ng.get(i);
					String warnSql = this.doSQl(ngId);
					List<Object []> warnList = this.commonService.executeSQL(warnSql);
					//存在不正常节点，线为红色
					if(warnList!=null && warnList.size()>0){
						tree.getRelaList().add(new NodeRelationModule(
								"nodegroup_table_nodeGroup_"+ngId.toString(),
								"system_table_system_"+sysID,
								"#FF0000")
						);
					}else{
						tree.getRelaList().add(new NodeRelationModule(
								"nodegroup_table_nodeGroup_"+ngId.toString(),
								"system_table_system_"+sysID,
								"#00FF00"
								)
						);
					}
				}
			}
	
			HttpServletResponse response = getResponse();
		    response.reset();	   
		    response.setCharacterEncoding("UTF-8");
	        
		    response.setContentType("application/json");
	        System.out.println(JSONObject.fromObject(tree).toString());
		    response.getWriter().print(JSONObject.fromObject(tree).toString());
		} catch (Exception e) {
			logger.error("The getIconModules method, error initializing desktop element"+e.getMessage());
		}
		return null;
	}
	
	
	public String doSQl(Object gId) throws Exception{
		//@2018-3-9 fang 修改 首先查询符合条件的id，在拼接sql，适配mysql
		String gsql = "select group_id from nodegroup_table t where 1=1 ";
		String gids = this.commonService.getGroupIdStartWith(gsql, "t.group_id = " +gId);
		/*String sql="select distinct nt.node_id,nt.node_ip,nt.node_name,"+
							"nt.seq_id from detection_info_warning diw " +
							"left join node_table nt "+
							"on diw.seq_id = nt.seq_id " +
							"where nt.node_state = 0 " +
							"and nt.node_group_id in " +
							"(select t.group_id from nodegroup_table t "+
							"start with t.group_id ="+gId +
							" connect by prior t.group_id = t.parent_group_id)";*/
		String sql="select distinct nt.node_id,nt.node_ip,nt.node_name,"+
				"nt.seq_id from detection_info_warning diw " +
				"left join node_table nt "+
				"on diw.seq_id = nt.seq_id " +
				"where nt.node_state = 0 " +
				"and nt.node_group_id in " +
				"("+gids+")";
		return sql;
	}
	
	private String getBoxByGroup(){
		NodeModuleTree tree = new NodeModuleTree();
		String path	= this.getRequest().getContextPath();
		String npid = this.getRequest().getParameter("npGId");
		String gid = this.getRequest().getParameter("groupId");
		String splits = "@$@";
		String getBoxByGroup = 
			"select" +
			" np.id," +
			" nbt.box_id," +
			" nbt.descinfo," +
			" np.position_x," +
			" np.position_y," +
			" np.image_url," +
//			" trunc((nvl(np.view_time_mark,to_date('2011-01-01','yyyy-mm-dd')) - sysdate) / 30, -1) time_mark," +
			getTruncSql()+ " TIME_MARK, "+
			" nvl(np.view_type,0)," +
			" nbt.ispn," +
			" np.parent_id"+
			" from node_box_table nbt left join node_position np on np.table_name='node_box_table' " +
			" and np.node_id=nbt.box_id" +
			" where np.parent_id  ="+npid;
		
		System.out.println("getBoxSQl----:"+getBoxByGroup);
		
		try {
			List<Object []> boxList = (List<Object []>)this.commonService.executeSQL(getBoxByGroup);
			
			//遍历机柜
			if(boxList!=null && boxList.size()>0){
				for (Object[] objs : boxList) {
					boolean isResu = this.isHaveWriningNodeInBox(objs[1].toString(), gid);
					tree.getNodeBoxList().add(
							new NodeBoxModule(
									Long.parseLong(objs[0]==null?"0":objs[0].toString()),//id,
									Long.parseLong(objs[1]==null?"0":objs[1].toString()), //nodeId
									"node_box_table",//tableName
									"nodeBox",//nodeType
									objs[8]==null?"":objs[8].toString(),//ispn
									objs[2].toString(), //nodeDesc
									Long.parseLong(objs[3]==null?"0":objs[3].toString()),//positionX
									Long.parseLong(objs[4]==null?"0":objs[4].toString()),//positionY
									objs[5]==null?path+"/images/show/nm.png":objs[5].toString(),//imageUrl
									Long.valueOf(objs[6].toString()),//monthMark
									Long.valueOf("2"),//viewType
									"nodegroup_table"+splits+"0"+splits+"0",//linkSplit
									Long.valueOf(objs[9].toString()),//parentId
									isResu==true?"1":"0"
									)
					);
				}
			}
			HttpServletResponse response = getResponse();
		    response.reset();	   
		    response.setCharacterEncoding("UTF-8");
	        
		    response.setContentType("application/json");
	        System.out.println(JSONObject.fromObject(tree).toString());
		    response.getWriter().print(JSONObject.fromObject(tree).toString());
		    
		}catch (Exception e) {
			logger.error("The getBoxByGroup method, topology showing error getting cabinet"+e.getMessage());
		}
		return null;
	}
	
	private Boolean isHaveWriningNodeInBox(String boxId,String gid){
		Long sysId = this.getSystemID();
		System.out.println("boxid:"+boxId);
		System.out.println("ngId:"+gid);
		boolean resu = true;
		
		String nibSql =
			" select distinct" +
			" nt.node_id," +
			" nt.node_name," +
			" nt.node_desc," +
			" nlt.lattice_position," +
			" nbt.box_id," +
			" nbt.descinfo," +
			" diw.seq_id," +
			" nt.node_ip," +
			" nt.node_u_type" +
			" from node_table nt" +
			" left join node_lattice_table nlt on nt.node_lattice_id = nlt.id" +
			" left join node_box_table nbt on nlt.node_box_id = nbt.box_id" +
			" left join detection_info_warning diw on nt.seq_id = diw.seq_id "+ 
			" where nt.node_state = 0" +
			" and nt.system_id="+sysId+
			" and nt.node_lattice_id is not null" +
			" and nt.node_group_id ="+gid +
			" and nbt.box_id = "+boxId;
		
		System.out.println("getWarNodeFromBox---sql:"+nibSql);
		
		try {
			List<Object []> nibList = (List<Object []>)this.commonService.executeSQL(nibSql);
			if(nibList!=null && nibList.size()>0){
				resu = true;
			}else{
				resu = false;
			}
			
		} catch (Exception e) {
			logger.error("The isHaveWriningNodeInBox method to determine if an alarm node exists"+e.getMessage());
		}
		return resu;
	}
	
	private String getBoxInfo(){
		String boxIspn = this.getRequest().getParameter("boxIspn");
		String gid = this.getRequest().getParameter("gid");
		System.out.println("groupId:"+gid);
		NodeModuleTree tree = new NodeModuleTree();
		String path	= this.getRequest().getContextPath();
		String splits = "@$@";
	
		String getBoxSQl = 
			"select" +
			" nbt.box_id," +
			" nbt.descinfo," +
//			" trunc((nvl(sysdate,to_date('2011-01-01','yyyy-mm-dd')) - sysdate) / 30, -1) time_mark," +
			" 0 time_mark " +
			" nbt.ispn" +
			" from node_box_table nbt " +
			" where nbt.box_id not in" +
			" (select npo.node_id from node_position npo" +
			" where npo.parent_id ="+gid+" and npo.node_type ='nodeBox')";
		
		if(!"".equals(boxIspn)){
			getBoxSQl +=" and nbt.ispn like '%"+boxIspn+"%'"; 
		}
		
		System.out.println("getBoxSQl----:"+getBoxSQl);
		
		try {
			List<Object []> boxList = (List<Object []>)this.commonService.executeSQL(getBoxSQl);
			
			//遍历机柜
			if(boxList!=null && boxList.size()>0){
				for (Object[] objs : boxList) {
					tree.getNodeBoxList().add(
							new NodeBoxModule(
									Long.parseLong(objs[0]==null?"0":objs[0].toString()), //nodeId
									"node_box_table",//tableName
									"nodeBox",//nodeType
									objs[3]==null?"":objs[3].toString(),//ispn
									objs[1].toString(), //nodeDesc
									Long.valueOf("0"),//positionX
									Long.valueOf("0"),//positionY
									path+"/images/show/nm.png",//imageUrl
									Long.valueOf(objs[2].toString()),//monthMark
									Long.valueOf("2"),//viewType
									"nodegroup_table"+splits+"0"+splits+"0"//linkSplit
							)
					);
				}
			}
			
			HttpServletResponse response = getResponse();
		    response.reset();	   
		    response.setCharacterEncoding("UTF-8");
	        
		    response.setContentType("application/json");
	        System.out.println(JSONObject.fromObject(tree).toString());
		    response.getWriter().print(JSONObject.fromObject(tree).toString());
		    
		}catch (Exception e) {
			logger.error("The getBoxInfo method, get error on all cabinets"+e.getMessage());
		}
		return null;
	}
	
	public String getLastLineSate(){
		//	--节点组和节点关系表
		String ngMemSql = "select t.node_group_id,t.node_id from node_table t order by t.node_group_id";
		//	--节点组和系统关系表
		String nsMemSql = "select group_id,system_id from nodegroup_table order by group_id";
		NodeModuleTree tree = new NodeModuleTree();
		List<Object[]> memList;
		try {
			memList = (List<Object []>)this.commonService.executeSQL(ngMemSql);
			List<Object []> nsMemList = (List<Object []>)this.commonService.executeSQL(nsMemSql);
			if(memList!=null && memList.size()>0){
				for (Object[] objs : memList) {
					String state = (Math.random()+"");
					tree.getRelaList().add(new NodeRelationModule(
							"nodegroup_table_nodeGroup_"+objs[0].toString(),
							"node_table_node_"+objs[1].toString(),
							"#"+(state.substring(state.indexOf(".")+1,state.indexOf(".")+7))
					)
					);
				}
			}
			if(nsMemList!=null && nsMemList.size()>0){
				for (Object[] objs : nsMemList) {
					String state = (Math.random()+"");
					tree.getRelaList().add(new NodeRelationModule(
							"nodegroup_table_nodeGroup_"+objs[0].toString(),
							"system_table_system_"+objs[1].toString(),
							"#"+(state.substring(state.indexOf(".")+1,state.indexOf(".")+7))
					)
					);
				}
			}
			System.out.println("--"+tree.getRelaList().size());
			
			HttpServletResponse response = getResponse();
		    response.reset();	   
		    response.setCharacterEncoding("UTF-8");
	        
		    response.setContentType("application/json");
			response.getWriter().print(JSONObject.fromObject(tree).toString());
		}catch(Exception e) {
			logger.error("The getLastLineSate method, refresh connection error"+e.getMessage());
		}
		return null;
	}
	
	
	private String saveBoxInfo(){
		try {
			commonService.beginTransaction();
			//保存格子和节点表格子ID
			String nodeGroupId = this.getRequest().getParameter("nodeGroupId");
			String boxId = this.getRequest().getParameter("boxId");
			String nIdSeqLatts = this.getRequest().getParameter("nIdSeqLatts");
			String seqList = this.getRequest().getParameter("seqList");
			String path	= this.getRequest().getContextPath();
			
			System.out.println("--nodeGroupId: "+nodeGroupId);
			System.out.println("--boxId: "+boxId);
			System.out.println("--nIdSeqLatts: "+nIdSeqLatts);
			System.out.println("--seqList: "+seqList);
			
			if(nIdSeqLatts!=null && !"".equals(nIdSeqLatts)){
				String[] nIdSeqLattArr = nIdSeqLatts.split(":");
				if(nIdSeqLattArr.length>0){
					//查询机柜下所有节点位置信息
					for(int g=0;g<nIdSeqLattArr.length;g++){
						//节点ID@seq_Latt
						String[] nIdSeqLatt = nIdSeqLattArr[g].split("_");
						String[] nIdSeqArr = nIdSeqLatt[0].split("@");
						List nltList = this.commonService.find("from NodeLatticeTable t where nodeBoxId="+boxId+" and nodeSeqId="+nIdSeqArr[1]);
						//如果存在做更新(更新机柜ID和位置)
						if(nltList!=null && nltList.size()>0){
							NodeLatticeTable nlt = (NodeLatticeTable)nltList.get(0);
							nlt.setNodeposition(Long.parseLong(nIdSeqLatt[1]));
							nlt.setNodeBoxId(Long.parseLong(boxId));
							this.commonService.update(nlt);
						}else{//保存节点位置(格子)
							NodeLatticeTable nlt = new NodeLatticeTable();
							nlt.setNodeBoxId(Long.parseLong(boxId));
							nlt.setNodeSeqId(Long.parseLong(nIdSeqArr[1]));
							nlt.setNodeposition(Long.parseLong(nIdSeqLatt[1]));
							this.commonService.save(nlt);
	
							//更新节点的格子id
							List sameSeqNodeList = this.commonService.find("from NodeTable where seqId=?",Long.parseLong(nIdSeqArr[1]));
							if(sameSeqNodeList!=null && sameSeqNodeList.size()>0){
								for(int b=0;b<sameSeqNodeList.size();b++){
									NodeTable setSeqNt = (NodeTable)sameSeqNodeList.get(b);
									setSeqNt.setNodeLatticeId(nlt.getId());
									this.commonService.update(setSeqNt);
								}
							}
							
						}
						//保存新建的发信息过来节点关联关系（不是通过nms创建的）
						List list = this.commonService.find("from NodeTable t where seqId="+Long.parseLong(nIdSeqArr[1])+" and nodeId="+Long.parseLong(nIdSeqArr[0]));
						//如果存在做更新
						NodeTable nt= null;
						if(list!=null && list.size()>0){
							nt = (NodeTable)list.get(0);
							nt.setGroupId(Long.parseLong(nodeGroupId));
							this.commonService.update(nt);
						}
					}
					//for end
					
					//保存其他逻辑节点的 机柜和节点组 关联关系 for nodepositiontable
					//系统模板对象
					NodePosition templateSysNP = (NodePosition) this.commonService.find("from NodePosition where nodeType = 'system'").get(0);
					//节点组模板对象
					NodePosition templateGroupNP = (NodePosition) this.commonService.find("from NodePosition where nodeId = ? and nodeType = 'nodeGroup'",nodeGroupId).get(0);
					//机柜模板对象
					NodePosition templateBoxNP = null;
					List tempBoxNpList = this.commonService.find("from NodePosition where nodeId = ? and nodeType = 'nodeBox'",boxId);
					if(tempBoxNpList.size()!=0){
						templateBoxNP= (NodePosition)tempBoxNpList.get(0);
					}else{
						templateBoxNP = new NodePosition("node_box_table", "nodeBox",Long.valueOf("100"), Long.valueOf("100"), path+"/images/show/nm.png", Long.valueOf("2"));
					}
					
					if(seqList!=null && !"".equals(seqList)){
						if(seqList.endsWith(",")){
							seqList = seqList.substring(0,seqList.length()-1);
						}
					
						String sqlString = "select distinct" +
											" t.node_group_id," +
											" t.system_id" +
											" from node_table t" +
											" where t.seq_id in ("+seqList+") " +
											" and t.node_group_id is not null" +
											" and t.node_group_id <> "+nodeGroupId +
											" and t.system_id is not null";
						System.out.println("---sqlString---:"+sqlString);
						List<Object[]> group_sysIdList = (List<Object[]>)this.commonService.executeSQL(sqlString);
						
						if(group_sysIdList!=null && group_sysIdList.size()>0){
							for (int j=0;j<group_sysIdList.size();j++) {
								Object[] ob = group_sysIdList.get(j);
								//systemNp
								List sysNPList = this.commonService.find("from NodePosition where nodeType = 'system' and nodeId ='"+ob[1].toString()+"'");
								
								//groupNp
								List gNPList = this.commonService.find("from NodePosition where nodeType = 'nodeGroup' and nodeId ='"+ob[0].toString()+"'");
								
								NodePosition npsys = null;
								NodePosition npGroup = null;
								NodePosition npBox = null;
								if(sysNPList.size()==0){//判断系统是否已经存在
									//没有system 则保存system
									npsys = new NodePosition();
									npsys.setTableName(templateSysNP.getTableName());
									npsys.setNodeType(templateSysNP.getNodeType());
									npsys.setNodeId(ob[1].toString());//ob[1] 系统
									npsys.setPositionX(templateSysNP.getPositionX());
									npsys.setPositionY(templateSysNP.getPositionY());
									npsys.setParent_id(templateSysNP.getParent_id());
									npsys.setViewType(templateSysNP.getViewType());
									npsys.setViewTimeMark(new Date());
								
									if(templateSysNP.getImageUrl().indexOf(this.getRequest().getContextPath())>0){
										npsys.setImageUrl(templateSysNP.getImageUrl().substring(templateSysNP.getImageUrl().indexOf(this.getRequest().getContextPath())));
									}else {
										npsys.setImageUrl(templateSysNP.getImageUrl());
									}
									this.commonService.save(npsys);
								}
								if(gNPList.size()==0){//判断节点组是否已经存在
									//没有group 则保存group
									npGroup = new NodePosition();
									npGroup.setTableName(templateGroupNP.getTableName());
									npGroup.setNodeType(templateGroupNP.getNodeType());
									npGroup.setNodeId(ob[0].toString());//ob[0] 节点组
									npGroup.setPositionX(templateGroupNP.getPositionX());
									npGroup.setPositionY(templateGroupNP.getPositionY());
									npGroup.setParent_id(npsys.getId());
									npGroup.setViewType(templateGroupNP.getViewType());
									npGroup.setViewTimeMark(new Date());
								
									if(templateGroupNP.getImageUrl().indexOf(this.getRequest().getContextPath())>0){
										npGroup.setImageUrl(templateGroupNP.getImageUrl().substring(templateGroupNP.getImageUrl().indexOf(this.getRequest().getContextPath())));
									}else {
										npGroup.setImageUrl(templateGroupNP.getImageUrl());
									}
									this.commonService.save(npGroup);
									//节点组不存在那么此节点组对应的机柜也不存在，则同时保存机柜
									//保存机柜
									npBox = new NodePosition();
									npBox.setTableName(templateBoxNP.getTableName());
									npBox.setNodeType(templateBoxNP.getNodeType());
									npBox.setNodeId(boxId);
									npBox.setPositionX(templateBoxNP.getPositionX());
									npBox.setPositionY(templateBoxNP.getPositionY());
									npBox.setParent_id(npGroup.getId());
									npBox.setViewType(templateBoxNP.getViewType());
									npBox.setViewTimeMark(new Date());
								
									if(templateBoxNP.getImageUrl().indexOf(this.getRequest().getContextPath())>0){
										npBox.setImageUrl(templateBoxNP.getImageUrl().substring(templateBoxNP.getImageUrl().indexOf(this.getRequest().getContextPath())));
									}else {
										npBox.setImageUrl(templateBoxNP.getImageUrl());
									}
									this.commonService.save(npBox);
								}else{//节点组存在，判断对应机柜是否存在
									//boxNp
									List boxNPList = this.commonService.find("from NodePosition where nodeType = 'nodeBox' and nodeId ='"+boxId+"' and parent_id ="+((NodePosition)gNPList.get(0)).getId());
									if(boxNPList.size()==0){
										//保存机柜
										npBox = new NodePosition();
										npBox.setTableName(templateBoxNP.getTableName());
										npBox.setNodeType(templateBoxNP.getNodeType());
										npBox.setNodeId(boxId);
										npBox.setPositionX(templateBoxNP.getPositionX());
										npBox.setPositionY(templateBoxNP.getPositionY());
										npBox.setParent_id(((NodePosition)gNPList.get(0)).getId());
										npBox.setViewType(templateBoxNP.getViewType());
										npBox.setViewTimeMark(new Date());
									
										if(templateBoxNP.getImageUrl().indexOf(this.getRequest().getContextPath())>0){
											npBox.setImageUrl(templateBoxNP.getImageUrl().substring(templateBoxNP.getImageUrl().indexOf(this.getRequest().getContextPath())));
										}else {
											npBox.setImageUrl(templateBoxNP.getImageUrl());
										}
										this.commonService.save(npBox);
									}
								}	
							}
						}
					}
				}
				outHtmlString("1");	
			}else{
				outHtmlString("2");
			}
			commonService.commit();
		} catch (Exception e) {
			commonService.rollback();
			logger.error("The saveBoxInfo method, error saving cabinet information"+e.getMessage());
			e.printStackTrace();
		}
		return null;
	}
	
	//保存父级节点
	private String updateNodes(){
		
		try {
			commonService.beginTransaction();
				if(nodeM!=null){
					if (nodeM.getId() != null
							&& !"0".equals(nodeM.getId().toString())
							&& !"".equals(nodeM.getId())) {
						NodePosition np = (NodePosition) this.commonService.get(
								NodePosition.class, nodeM.getId());
						np.setPositionX(nodeM.getPositionX());
						np.setPositionY(nodeM.getPositionY());
						np.setViewType(nodeM.getViewType());
						np.setParent_id(nodeM.getParent_id());
						if (nodeM.getImageUrl().indexOf(
								this.getRequest().getContextPath()) > 0) {
							np.setImageUrl(nodeM.getImageUrl().substring(
									nodeM.getImageUrl().indexOf(
											this.getRequest().getContextPath())));
						} else {
							np.setImageUrl(nodeM.getImageUrl());
						}
						this.commonService.update(np);
						if (nodeM.getNodeType().equals("system")) {// 如果是系统则取出该系统npid
							
							sysPositionId = nodeM.getId().toString();
							outHtmlString(sysPositionId);
						}else{
							outHtmlString("save1");
						}
					} else { // id为空的情况下做保存
						NodePosition np = new NodePosition();
						np.setTableName(nodeM.getTableName());
						np.setNodeType(nodeM.getNodeType());
						np.setNodeId(nodeM.getNodeId().toString());
						np.setPositionX(nodeM.getPositionX());
						np.setPositionY(nodeM.getPositionY());
						np.setParent_id(nodeM.getParent_id());
						np.setViewType(nodeM.getViewType());
						np.setViewTimeMark(new Date());
	
						if (nodeM.getImageUrl().indexOf(
								this.getRequest().getContextPath()) > 0) {
							np.setImageUrl(nodeM.getImageUrl().substring(
									nodeM.getImageUrl().indexOf(
											this.getRequest().getContextPath())));
						} else {
							np.setImageUrl(nodeM.getImageUrl());
						}
						this.commonService.save(np);
						if (nodeM.getNodeType().equals("system")) {// 如果是系统则取出该系统npid
							NodePosition sysNP = (NodePosition) this.commonService
									.find(
											"from NodePosition where nodeId = ? and nodeType = 'system'",
											this.getSystemID().toString()).get(0);
							sysPositionId = sysNP.getId().toString();
							outHtmlString(sysPositionId);
						}else{
							outHtmlString("save1");
						}
					}
				}
				commonService.commit();
		}catch (Exception e) {
			commonService.rollback();
			logger.error("The updateNodes method, error saving location information"+e.getMessage());
			outHtmlString("2");
		}
		return null;
	}
	private String deleteNodes(){
		List ngtList = null;
		String sql ="";
		try {
			commonService.beginTransaction();
			//nodeposition ids
			String ids = this.getRequest().getParameter("npids");
			//nodegroup ids
			String nodeIds =this.getRequest().getParameter("nodeids");
			if(ids!=null && ids.length()>1){
	//			if(ids.indexOf(",")!=-1){//删除多个节点组
	//				String[] idsArr = ids.split(",");
	//				for(String id : idsArr){
	//					
	//				}
	//			}
				//@2018-3-9 fang 修改 首先查询符合条件的id，在拼接sql，适配mysql
				String gsql = "select group_id from nodegroup_table t where 1=1 ";
				String gids = this.commonService.getGroupIdStartWith(gsql, "t.group_id in ("+nodeIds+")");
				/*sql = "select * from nodegroup_table t"+
				 	  " start with t.group_id in ("+nodeIds+")"+ 
				 	  " connect by prior t.group_id = t.parent_group_id";*/
				sql = "select * from nodegroup_table t where t.group_id in ("+gids+")";
				ngtList = this.commonService.executeSQL(sql,NodegroupTable.class);
				for(int i =0;i<ngtList.size();i++){
					NodegroupTable group = (NodegroupTable) ngtList.get(i);
					group.setIsValid(0l);
					this.commonService.update(group);
				}
				
				//this.commonService.delete("delete from NodePosition np where np.id in ("+ids+")");
			}
			outHtmlString("1");
			commonService.commit();
		} catch (Exception e) {
			commonService.rollback();
			logger.error("The deleteNodes method, error deleting node"+e.getMessage());
			outHtmlString("2");
		}
		return null;
	}
	
	
	private String updateLines(){
		try {
			commonService.beginTransaction();
			String tableName1 = this.getRequest().getParameter("tableName1");
			String nodeId1 = this.getRequest().getParameter("nodeId1");
			String tableName2 = this.getRequest().getParameter("tableName2");
			String nodeId2 = this.getRequest().getParameter("nodeId2");
			System.out.println("--tableName1 "+tableName1);
			System.out.println("--nodeId1 "+nodeId1);
			System.out.println("--tableName2 "+tableName2);
			System.out.println("--nodeId2 "+nodeId2);
			System.out.println("--------------------");
	
			if("system_table".equals(tableName1.toLowerCase()) || "system_table".equals(tableName2.toLowerCase())){
				if("system_table".equals(tableName1.toLowerCase())){
					NodegroupTable nodegroupTable = (NodegroupTable) this.commonService.get(NodegroupTable.class, Long.parseLong(nodeId2));
					nodegroupTable.setSystemId(Long.parseLong(nodeId1));
					this.commonService.update(nodegroupTable);
				}else {
					NodegroupTable nodegroupTable = (NodegroupTable) this.commonService.get(NodegroupTable.class, Long.parseLong(nodeId1));
					nodegroupTable.setSystemId(Long.parseLong(nodeId2));
					this.commonService.update(nodegroupTable);
				}
			}
			outHtmlString("1");
			commonService.commit();
		} catch (Exception e) {
			commonService.rollback();
			logger.error("The updateLines method, update connection error"+e.getMessage());
			outHtmlString("2");
		}
		return null;
	}
	
	//删除机柜内节点
	private String deleteLatt(){
		try {
			commonService.beginTransaction();
			String seqId= this.getRequest().getParameter("seqId");
			System.out.println(seqId);
			if(seqId!=null && !"".equals(seqId)){
				this.commonService.delete("delete from NodeLatticeTable t where t.nodeSeqId="+Long.parseLong(seqId));
				List sameSeqNodeList = this.commonService.find("from NodeTable where seqId="+seqId);
				if(sameSeqNodeList!=null && sameSeqNodeList.size()>0){//清楚相同物理ID节点的格子ID
					for(int b=0;b<sameSeqNodeList.size();b++){
						NodeTable setSeqNt = (NodeTable)sameSeqNodeList.get(b);
						setSeqNt.setNodeLatticeId(null);
						this.commonService.update(setSeqNt);
					}
				}
				
			}
			commonService.commit();
		} catch (Exception e) {
			commonService.rollback();
			logger.error("The deleteLatt method, delete the node in the cabinet"+e.getMessage());
		}
		return null;
	}
	
	/**
	 * 2018年4月18日13:52:00 特殊处理此语句，函数嵌套较多使用正则匹配较复杂
	 * @return
	 */
	private static String getTruncSql(){
		String sql = null;
		if(Constant.IS_MYSQL){
			sql = " truncate(datediff(ifnull(NP.VIEW_TIME_MARK,str_to_date('2011-01-01','%Y-%m-%d')),now())/30,-1) ";
		}else{
			sql = " TRUNC((NVL(NP.VIEW_TIME_MARK,TO_DATE('2011-01-01','YYYY-MM-DD')) - SYSDATE) / 30, -1) ";
		}
		return sql;
	}
	
	
	public String getPid() {
		return pid;
	}
	public void setPid(String pid) {
		this.pid = pid;
	}
	public String getAction() {
		return action;
	}
	public void setAction(String action) {
		this.action = action;
	}
	public String getSecondUrl() {
		return secondUrl;
	}
	public void setSecondUrl(String secondUrl) {
		this.secondUrl = secondUrl;
	}
	public String getBgColors() {
		return bgColors;
	}
	public void setBgColors(String bgColors) {
		this.bgColors = bgColors;
	}
	public NodePositionModule getNodeM() {
		return nodeM;
	}
	public void setNodeM(NodePositionModule nodeM) {
		this.nodeM = nodeM;
	}
	public CommonService getCommonService() {
		return commonService;
	}
	public void setCommonService(CommonService commonService) {
		this.commonService = commonService;
	}
	public String getDescinfo() {
		return descinfo;
	}
	public void setDescinfo(String descinfo) {
		this.descinfo = descinfo;
	}
	public String getGroupId() {
		return groupId;
	}
	public void setGroupId(String groupId) {
		this.groupId = groupId;
	}
	public String getGroupNpId() {
		return groupNpId;
	}
	public void setGroupNpId(String groupNpId) {
		this.groupNpId = groupNpId;
	}
	public String getSysPositionId() {
		return sysPositionId;
	}
	public void setSysPositionId(String sysPositionId) {
		this.sysPositionId = sysPositionId;
	}
	public String getFrom() {
		return from;
	}
	public void setFrom(String from) {
		this.from = from;
	}
}
