package nis.nms.web.actions.nodePosition;

import java.util.List;
import nis.nms.core.Topology;
import nis.nms.domains.XtYhJbxx;
import nis.nms.service.CommonService;
import nis.nms.util.service.ServiceUtil;
import flex.messaging.io.amf.ASObject;

public class TopoShow {
	private static int 	TOPOTYPE_SYSTEM = 0;
	private static int 	TOPOTYPE_NODEGROUP = 1;
	private static int 	TOPOTYPE_LEAFNODEGROUP = 2;
	private static int 	TOPOTYPE_ROOM = 3;
	private static int 	TOPOTYPE_BOX = 4;
	private static int 	TOPOTYPE_NODE = 5;
	
	private CommonService commonService;
	public static Long sysID;
	public static XtYhJbxx user;
	private Long treeId;
	
	public TopoShow() {
		// 获取service
		commonService = (CommonService) ServiceUtil
				.getServiceObject("commonService");
		System.out.println("----------------"+commonService.toString());
		
		System.out.println("-------sysID---------"+sysID);
		System.out.println("-------userID---------"+user.getYhid());
		System.out.println("-------username---------"+user.getYhbh());
	}
	
	/**
	 * 一级拓扑展示：业务系统下的顶级节点组
	 * @param object
	 * @return
	 */
	public Topology getTopoShow(Object object) {
		treeId = 1l;
		Topology topology = new Topology();
		try {
			//当前系统
			String sysSql =
				"SELECT " +
				" ST.SYSTEM_ID," +
				" ST.SYSTEM_NAME," +
				" ST.SYSTEM_DESC" +
				" FROM SYSTEM_TABLE ST " + 
				" WHERE SYSTEM_STATE = 0 " +
				" AND SYSTEM_ID = " + sysID;
			System.out.println("getTopoShow...sysSql:"+sysSql);
			
			List<Object []> sysList = (List<Object [] >)this.commonService.executeSQL(sysSql);
			if (sysList != null && sysList.size() > 0) {
				Object[] objs = sysList.get(0);
				topology.setType(this.TOPOTYPE_SYSTEM);
				topology.setTreeId(treeId++);
				topology.setId(Long.parseLong(objs[0].toString()));
				topology.setName(objs[1].toString());
				
				//设置节点组
				setChildNodeGroup(topology, 0l);
			}
	
		} catch (Exception e) {
			e.printStackTrace();
		}
		return topology;
	}
	
	/**
	 * 二级拓扑展示：含有子节点组的节点组
	 * @param object
	 * @return
	 */
	public Topology getGroupTopoShow(Object object) {
		treeId = 1l;
		Topology topology = new Topology();
		try {
			ASObject as = (ASObject) object;
			Long groupID = Long.parseLong(as.get("groupID").toString());
			String back = as.get("back").toString();
			String sql =
				"SELECT " +
				" NGT.GROUP_ID," +
				" NGT.GROUP_NAME," +
				" NGT.GROUP_LEVEL," +
				" NGT.GROUP_DESC" +
				" FROM NODEGROUP_TABLE NGT " + 
				" WHERE IS_VALID = 1 ";
			if("0".equals(back)){//返回上一级节点组
				sql += " AND NGT.GROUP_ID in (select NG.PARENT_GROUP_ID from NODEGROUP_TABLE NG where NG.GROUP_ID=" + groupID + ")";
			}else{
				sql += " AND NGT.GROUP_ID = " + groupID;
			}
			
			System.out.println("getGroupTopoShow...sql:" + sql);
			
			List<Object []> list = (List<Object [] >)this.commonService.executeSQL(sql);
			if (list != null && list.size() > 0) {
				Object[] objs = list.get(0);
				topology.setType(this.TOPOTYPE_NODEGROUP);
				topology.setTreeId(treeId++);
				topology.setId(Long.parseLong(objs[0].toString()));
				topology.setName(objs[1].toString());
				topology.setGroupLevel(objs[2].toString());
				System.out.println("---group---glevel---" + topology.getGroupLevel());
				int falseNum = this.getFalseNodeNumInGroup(objs[0].toString());
				topology.setIsOk(falseNum > 0 ? 1 : 0);
				topology.setChildSize(this.getNodeNum(objs[0].toString()).intValue());
				topology.setFalseChildSize(falseNum);
				topology.setOkChildSize(topology.getChildSize()-falseNum);
				System.out.println("--getGroupTopoShow---" + topology.getName() +"---total=" + topology.getChildSize() + "---false=" + topology.getFalseChildSize() + "---ok=" +topology.getOkChildSize());

				//设置节点组
				setChildNodeGroup(topology, Long.parseLong(objs[0].toString()));
			}
	
		} catch (Exception e) {
			e.printStackTrace();
		}
		return topology;
	}
	
	/**
	 * 三级拓扑展示：叶子节点组下的机房
	 * @param object
	 * @return
	 */
	public Topology getRoomTopoShow(Object object) {
		treeId = 1l;
		Topology topology = new Topology();
		try {
			ASObject as = (ASObject) object;
			Long groupID = Long.parseLong(as.get("groupID").toString());
			String sql =
				"SELECT " +
				" NGT.GROUP_ID," +
				" NGT.GROUP_NAME," +
				" NGT.GROUP_LEVEL," +
				" NGT.GROUP_DESC" +
				" FROM NODEGROUP_TABLE NGT " + 
				" WHERE IS_VALID = 1 " +
				" AND NGT.GROUP_ID = " + groupID;
			
			System.out.println("getBoxTopoShow...sql:" + sql);
			
			List<Object []> list = (List<Object [] >)this.commonService.executeSQL(sql);
			if (list != null && list.size() > 0) {
				Object[] objs = list.get(0);
				topology.setType(this.TOPOTYPE_LEAFNODEGROUP);
				topology.setTreeId(treeId++);
				topology.setId(Long.parseLong(objs[0].toString()));
				topology.setName(objs[1].toString());
				topology.setGroupLevel(objs[2].toString());
				System.out.println("---box---glevel---" + topology.getGroupLevel());
				// 设置不正常的节点
				Object[] falseObjs = this.getFalseNodeInGroup(objs[0].toString());
				int falseNum = (Integer)falseObjs[0];
				topology.setFalseSeqIds(falseObjs[1].toString());
				topology.setIsOk(falseNum > 0 ? 1 : 0);
				topology.setChildSize(this.getNodeNum(objs[0].toString()).intValue());
				topology.setFalseChildSize(falseNum);
				topology.setOkChildSize(topology.getChildSize()-falseNum);
				System.out.println("--getRoomTopoShow---" + topology.getName() +"---total=" + topology.getChildSize() + "---false=" + topology.getFalseChildSize() + "---ok=" +topology.getOkChildSize());

				setChildRoom(topology, objs[0].toString());//设置机房
				//setChildBox(topology, objs[0].toString());//设置机柜
			}
	
		} catch (Exception e) {
			e.printStackTrace();
		}
		return topology;
	}

	/**
	 * 设置当前系统下某节点组下的节点组, 父节点组ID为0，则显示当前系统下的一级节点组
	 * 
	 * @param parentTopo
	 * @param sysID
	 * @param parGroupId
	 */
	private void setChildNodeGroup(Topology parentTopo, Long parGroupId){
		try{
			String ngtSql ="";
			//--节点组
			if("admin".equals(user.getYhbh())){//如果是admin登陆则无限制
				ngtSql =
					"SELECT " +
					" NGT.GROUP_ID," +
					" NGT.GROUP_NAME," +
					" NGT.GROUP_LEVEL," +
					" NGT.GROUP_DESC" +
					" FROM NODEGROUP_TABLE NGT " + 
					" WHERE IS_VALID = 1 " +
					" AND NGT.PARENT_GROUP_ID = " + parGroupId  + 
					" AND NGT.SYSTEM_ID = " + sysID;
			}else{
				ngtSql =
					"SELECT " +
					" NGT.GROUP_ID," +
					" NGT.GROUP_NAME," +
					" NGT.GROUP_LEVEL," +
					" NGT.GROUP_DESC" +
					" FROM NODEGROUP_TABLE NGT " + 
					" WHERE IS_VALID = 1 " +
					" AND NGT.PARENT_GROUP_ID = " + parGroupId  + 
					" AND (( NGT.VIEW_LEVEL=1 AND NGT.CREATE_USER_ID="+user.getYhid()+")" +
					" OR ( NGT.VIEW_LEVEL=2 AND NGT.CREATE_USERGROUP_ID " +
					" IN (SELECT X.JSBH FROM Xt_Yh_Js_Index  X  WHERE X.YHBH='"+user.getYhbh()+"' AND X.TYPE = 1))" + 
					" OR (NGT.VIEW_LEVEL=3 AND NGT.SYSTEM_ID = "+sysID+") OR (NGT.VIEW_LEVEL=4 ))"+
					" AND NGT.SYSTEM_ID ="+sysID;
			}
			
			System.out.println("setChildNodeGroup...nodegroupSql:"+ngtSql);
			
			List<Object []> groupList = (List<Object []>)this.commonService.executeSQL(ngtSql);
			if(groupList!=null && groupList.size()>0){
				for (Object[] objs : groupList) {
					//初始化之前先去查询子节点组个数
					Long numLong = Long.parseLong("0");
					if(objs[1]!=null){
						Topology topo = new Topology();
						topo.setTreeId(treeId++);
						topo.setId(Long.parseLong(objs[0].toString()));
						topo.setName(objs[1].toString());
						topo.setGroupLevel(objs[2].toString());
						// 设置不正常的节点
						Object[] falseObjs = this.getFalseNodeInGroup(objs[0].toString());
						int falseNum = (Integer)falseObjs[0];
						topo.setFalseSeqIds(falseObjs[1].toString());
						topo.setIsOk(falseNum > 0 ? 1 : 0);
						topo.setChildSize(this.getNodeNum(objs[0].toString()).intValue());
						topo.setFalseChildSize(falseNum);
						topo.setOkChildSize(topo.getChildSize()-falseNum);
						System.out.println("------11---" + topo.getName() +"---total=" + topo.getChildSize() + "---false=" + topo.getFalseChildSize() + "---ok=" +topo.getOkChildSize());
						
						// 设置节点类型：节点组，叶子节点组
						String isHaveChildSQl = "select count(*) from NODEGROUP_TABLE t where t.PARENT_GROUP_ID =" +objs[0].toString()+" and t.is_valid =1";
						numLong = Long.parseLong(this.commonService.executeSQL(isHaveChildSQl).get(0).toString());
						if(Integer.parseInt(numLong.toString())==0){
							topo.setType(this.TOPOTYPE_LEAFNODEGROUP);
							// 设置机柜
							//setChildBox(topo, objs[0].toString());
						}else{
							topo.setType(this.TOPOTYPE_NODEGROUP);
							// 设置子节点组
							//setChildNodeGroup(topo, Long.parseLong(objs[0].toString()));
						}
						parentTopo.getChild().add(topo);
					}
					
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
	
	/**
	 * 设置节点组下的机房
	 * @return
	 */
	private void setChildRoom(Topology parentTopo, String groupID){
		 String getRoomByGroup = 
			 "select" +
				" nht.room_id," +
				" nht.room_ispn," +
				" nht.room_rows," +
				" nht.room_cols," +
				" nht.room_desc" +
				" from node_room_table nht where nht.room_id in" +
				" (select distinct nbt.room_id from node_room_lattice_table nbt where nbt.node_box_id in" +
				" (select distinct nlt.node_box_id from node_lattice_table nlt where nlt.node_seq in" +
					" (select distinct nt.seq_id from node_table nt where nt.node_state = 0 and nt.node_group_id = " + groupID + " )" +
				" )" + 
				" )";
		
		System.out.println("setChildRoom----:"+getRoomByGroup);
		
		try {
			List<Object []> roomList = (List<Object []>)this.commonService.executeSQL(getRoomByGroup);
			
			//遍历机房
			if(roomList!=null && roomList.size()>0){
				for (Object[] objs : roomList) {
					int isOk = this.isOkInRoom(objs[0].toString(), groupID);
					Topology topo = new Topology();
					topo.setType(this.TOPOTYPE_ROOM);
					topo.setTreeId(treeId++);
					topo.setId(Long.parseLong(objs[0].toString()));
					topo.setName(objs[1].toString());
					topo.setIsOk(isOk);
					topo.setIspn(objs[1].toString());
					//topo.setRoomRows(Long.parseLong(objs[2]==null?"0":objs[2].toString()));
					//topo.setRoomCols(Long.parseLong(objs[3]==null?"0":objs[3].toString()));
					System.out.println("------setChildRoom---" + topo.getName());
					parentTopo.getChild().add(topo);
				}
			}
		    
		}catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * 设置节点组下的机柜
	 * @return
	 */
	private void setChildBox(Topology parentTopo, String groupID){
		 String getBoxByGroup = 
				"select" +
				" nbt.box_id," +
				" nbt.descinfo," +
				" nbt.ispn," +
				" nbt.box_u_type" +
				" from node_box_table nbt where nbt.box_id in" +
				" (select nlt.node_box_id from node_lattice_table nlt where nlt.node_seq in" +
					" (select distinct nt.seq_id from node_table nt where nt.node_state = 0 and nt.node_group_id = " + groupID + " )" +
				" )";
		
		System.out.println("setChildBox----:"+getBoxByGroup);
		
		try {
			List<Object []> boxList = (List<Object []>)this.commonService.executeSQL(getBoxByGroup);
			
			//遍历机柜
			if(boxList!=null && boxList.size()>0){
				for (Object[] objs : boxList) {
					int isOk = this.isOkInBox(objs[0].toString(), groupID);
					Topology topo = new Topology();
					topo.setType(this.TOPOTYPE_BOX);
					topo.setTreeId(treeId++);
					topo.setId(Long.parseLong(objs[0].toString()));
					topo.setName(objs[1].toString());
					topo.setIsOk(isOk);
					topo.setIspn(objs[2].toString());
					topo.setBoxUType(Long.parseLong(objs[3]==null?"0":objs[3].toString()));
					System.out.println("------11---" + topo.getName());
					parentTopo.getChild().add(topo);
				}
			}
		    
		}catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * 得到节点组及其子节点组下所有不正常的节点总数
	 * @param groupId
	 * @return
	 * @throws Exception
	 */
	private int getFalseNodeNumInGroup(String groupId) throws Exception{
		int falseNum = 0;
		//状态不正常的节点 (过滤有效节点和有效监测设置)
		//@2018-3-9 fang 修改 首先查询符合条件的id，在拼接sql，适配mysql
		String gsql = "select group_id from nodegroup_table t where 1=1 ";
		String gids = this.commonService.getGroupIdStartWith(gsql, "t.group_id = " +groupId);
		/*String falseNodeSql="select count(distinct diw.seq_id) from detection_info_new diw " +
							"left join node_table nt "+
							"on diw.seq_id = nt.seq_id " +
							"where diw.DETECTIONED_STATE<>1 AND diw.police_emergent=0 " +
							"and diw.DETECTION_SET_INFO_ID in (select dst.ID from DETECTION_SET_INFO dst where dst.DETECTION_SET_STATE=1) " +
							"and nt.NODE_STATE = 0 "+
							"and nt.node_group_id in " +
							"(select t.group_id from nodegroup_table t "+
							"start with t.group_id ="+groupId +
							" connect by prior t.group_id = t.parent_group_id)";*/
		String falseNodeSql="select count(distinct diw.seq_id) from detection_info_new diw " +
				"left join node_table nt "+
				"on diw.seq_id = nt.seq_id " +
				"where diw.DETECTIONED_STATE<>1 AND diw.police_emergent=0 " +
				"and diw.DETECTION_SET_INFO_ID in (select dst.ID from DETECTION_SET_INFO dst where dst.DETECTION_SET_STATE=1) " +
				"and nt.NODE_STATE = 0 "+
				"and nt.node_group_id in " +
				"("+gids+")";
		System.out.println("getFalseNodeNumInGroup---sql:"+falseNodeSql);
		try {
			List<Object> falseList = this.commonService.executeSQL(falseNodeSql);
			falseNum = Integer.parseInt(falseList.get(0).toString());
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return falseNum;
	}
	
	/**
	 * 得到节点组及其子节点组下所有不正常的节点的相关信息
	 * @param groupId
	 * @return
	 * @throws Exception
	 */
	private Object[] getFalseNodeInGroup(String groupId) throws Exception{
		Object[] objs = new Object[2];
		//状态不正常的节点   police_emergent=0 只显示紧急告警
		//@2018-3-9 fang 修改 首先查询符合条件的id，在拼接sql，适配mysql
		String gsql = "select group_id from nodegroup_table t where 1=1 ";
		String gids = this.commonService.getGroupIdStartWith(gsql, "t.group_id = " +groupId);
		/*String falseNodeSql="select distinct nt.node_id,nt.node_ip,nt.seq_id,"+
							"nt.node_name from detection_info_new diw " +
							"left join node_table nt "+
							"on diw.seq_id = nt.seq_id " +
							"where diw.DETECTIONED_STATE<>1 AND diw.police_emergent=0 " +
							"and diw.DETECTION_SET_INFO_ID in (select dst.ID from DETECTION_SET_INFO dst where dst.DETECTION_SET_STATE=1) " +
							"and nt.NODE_STATE = 0 "+
							"and nt.node_group_id in " +
							"(select t.group_id from nodegroup_table t "+
							"start with t.group_id ="+groupId +
							" connect by prior t.group_id = t.parent_group_id)";*/
		String falseNodeSql="select distinct nt.node_id,nt.node_ip,nt.seq_id,"+
							"nt.node_name from detection_info_new diw " +
							"left join node_table nt "+
							"on diw.seq_id = nt.seq_id " +
							"where diw.DETECTIONED_STATE<>1 AND diw.police_emergent=0 " +
							"and diw.DETECTION_SET_INFO_ID in (select dst.ID from DETECTION_SET_INFO dst where dst.DETECTION_SET_STATE=1) " +
							"and nt.NODE_STATE = 0 "+
							"and nt.node_group_id in " +
							"("+gids+")";
		System.out.println("getFalseNodeNumInGroup---sql:"+falseNodeSql);
		List<Object []> falseList = this.commonService.executeSQL(falseNodeSql);
		if(falseList!=null && falseList.size()>0){
			StringBuffer sb = new StringBuffer();
			for(Object[] falseObj : falseList){
				sb.append(falseObj[2] + ",");
			}
			sb.deleteCharAt(sb.length()-1);
			objs[0] = falseList.size();
			objs[1] = sb.toString();
		}else{
			objs[0] = 0;
			objs[1] = "";
		}
		
		return objs;
	}
	
	/**
	 * 检查机房下是否所有节点都正常
	 * @param roomId
	 * @param groupId
	 * @return 0 正常，1 不正常
	 */
	private int isOkInRoom(String roomId, String groupId){
		int isOk = 0;
		
		String nibSql =
			" select count(distinct diw.seq_id)" +
			" from detection_info_new diw" +
			" left join node_table nt on nt.seq_id = diw.seq_id "+ 
			" where diw.DETECTIONED_STATE<>1 AND diw.police_emergent=0 " +
			" and diw.DETECTION_SET_INFO_ID in (select dst.ID from DETECTION_SET_INFO dst where dst.DETECTION_SET_STATE=1)" +
			" and nt.node_state = 0" +
			" and nt.system_id="+sysID+
			" and nt.node_group_id ="+groupId +
			" and nt.seq_id in" +
			" (select distinct nlt.node_seq from node_lattice_table nlt left join node_room_lattice_table nrlt on nlt.node_box_id=nrlt.node_box_id" +
			" where nlt.node_seq is not null and nrlt.node_box_id is not null and nrlt.room_id="+roomId + ")";
		System.out.println("isOkInRoom---sql:"+nibSql);
		
		try {
			List<Object> falseList = this.commonService.executeSQL(nibSql);
			if(Long.parseLong(falseList.get(0).toString())>0){
				isOk = 1;
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return isOk;
	}
	
	/**
	 * 检查机柜下是否所有节点都正常
	 * @param boxId
	 * @param groupId
	 * @return 0 正常，1 不正常
	 */
	private int isOkInBox(String boxId, String groupId){
		int isOk = 0;
		
		String nibSql =
			" select count(distinct diw.seq_id)" +
			" from detection_info_new diw" +
			" left join node_table nt on nt.seq_id = diw.seq_id "+ 
			" where diw.DETECTIONED_STATE<>1 AND diw.police_emergent=0 " +
			" and diw.DETECTION_SET_INFO_ID in (select dst.ID from DETECTION_SET_INFO dst where dst.DETECTION_SET_STATE=1)" +
			" and nt.node_state = 0" +
			" and nt.system_id="+sysID+
			" and nt.node_group_id ="+groupId +
			" and nt.seq_id in (select distinct nlt.node_seq from node_lattice_table nlt where nlt.node_seq is not null and nlt.node_box_id = "+boxId + ")";
		System.out.println("isOkInBox---sql:"+nibSql);
		
		try {
			List<Object> falseList = this.commonService.executeSQL(nibSql);
			if(Long.parseLong(falseList.get(0).toString())>0){
				isOk = 1;
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return isOk;
	}
	
	/**
	 * 检查节点是否正常
	 * @param boxId
	 * @param groupId
	 * @return 0 正常，1 不正常
	 */
	private int isOkNode(String seqId){
		int isOk = 0;
		if(seqId!=null && !"".equals(seqId)){
			String sql = "select count(diw.seq_Id) from detection_info_new diw where diw.DETECTIONED_STATE<>1 AND diw.police_emergent=0  and diw.seq_id = " + seqId +
			" and diw.DETECTION_SET_INFO_ID in (select dst.ID from DETECTION_SET_INFO dst where dst.DETECTION_SET_STATE=1)";
			System.out.println("isOkNode---sql:"+sql);
			try {
				List<Object> falseList = this.commonService.executeSQL(sql);
				if(Long.parseLong(falseList.get(0).toString())>0){
					isOk = 1;
				}
				
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return isOk;
	}
	
	/**
	 * 得到节点组及其子节点组下所有节点总数
	 * @param groupId
	 * @return
	 * @throws Exception
	 */
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
		nodeNum = Long.parseLong(gIdList.get(0).toString());
		
		return nodeNum;
	}
	
	/**
	 * 机柜展示
	 * @param object
	 * @return
	 */
	public Topology getNodeByBox(Object object){
		Topology topology = new Topology();
		topology.setType(TOPOTYPE_BOX);
		try {
			ASObject as = (ASObject) object;
			Long boxID = Long.parseLong(as.get("boxId").toString());
			String groupID = as.get("groupId").toString();
			System.out.println("getNodeByBox---groupID=" + groupID);
			topology.setId(boxID);
			//初始化机柜位置
			String boxLatSql = "select nlt.id," +
					" nlt.lattice_position," +
					" nlt.node_box_id," +
					" nlt.node_seq" +
					" from node_lattice_table nlt" +
					" where nlt.node_box_id = " + boxID + 
					" order by nlt.lattice_position desc";
				
			System.out.println("getNodeByBox---sql:"+boxLatSql);
			List<Object []> boxLatList = (List<Object []>)this.commonService.executeSQL(boxLatSql);
			if(boxLatList!=null && boxLatList.size()>0){
				int i=0;
				while(i<boxLatList.size()){
					Object[] boxLatObj = (Object[])boxLatList.get(i);
					Topology topo= new Topology();
					topo.setId(Long.parseLong(boxLatObj[0]==null?"0":boxLatObj[0].toString()));
					topo.setType(this.TOPOTYPE_NODE);
					if(boxLatObj[3]!=null && !"".equals(boxLatObj[3])){//若放置了节点机
						String seqID = boxLatObj[3].toString();
						//节点是否正常
						topo.setIsOk(isOkNode(seqID));
						topo.setFalseSeqIds(seqID);
						//设置节点信息
						String nodeSql =
							" select" +
							" nt.node_id," +
							" nt.node_ip," +
							" nt.node_name," +
						    " nt.node_u_type,"+
						    " nt.node_group_id,"+
						    " nt.system_id," +
						    " nt.node_state," +
						    " nt.NODE_BEGIN_UTYPE" +
							" from node_table nt" +
							" where nt.seq_id=" + seqID; //+" and nt.node_state = 0"
						List<Object []> nodeList = (List<Object []>)this.commonService.executeSQL(nodeSql);
						if(nodeList!=null && nodeList.size()>0){
							Object[] nodeObj = nodeList.get(0);
							topo.setNodeIp(nodeObj[1]==null ? "" : nodeObj[1].toString());//节点IP
							topo.setNodeName(nodeObj[2]==null ? "" : nodeObj[2].toString());
							topo.setNodeUType(Long.parseLong(nodeObj[3]==null?"0":nodeObj[3].toString()));
							topo.setNodeBeginUType(Long.parseLong(nodeObj[7]==null?"0":nodeObj[7].toString()));
							// 设置节点是否属于本节点组
							topo.setIsEdit(1);
							for (Object[] nodeObj2 : nodeList) {
								String gid = nodeObj2[4] == null ? "" : nodeObj2[4].toString();
								if (gid.equals(groupID)) {// 如果节点是属于本节点组的
									// 设置节点名为当前组中的节点名称
									topo.setNodeName(nodeObj2[2]==null ? "" : nodeObj2[2].toString());
									// 判断节点在当前组中是否有效
									if (Long.parseLong(nodeObj2[6] == null ? "0"
													: nodeObj2[6].toString()) == 0) {// 有效
										topo.setIsEdit(0);
									} else {// 节点无效
										topo.setIsEdit(-1);
									}
									break;
								}
							}
						}
					}
					
					topology.getChild().add(topo);
					
					if(topo.getNodeUType()!=null && topo.getNodeUType()>0){
						i += topo.getNodeUType();
					}else{
						i += 1;
					}
					//System.out.println("==========utype=" + (topo.getNodeUType()!=null ? topo.getNodeUType():"0") +"----i=" + i);
				}//while end
			}
			
			System.out.println("===============child cnt = " + topology.getChild().size());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return topology;
	}
	
	/**
	 * 机房展示
	 * @param object
	 * @return
	 */
	public Topology getBoxByRoom(Object object){
		Topology topology = new Topology();
		topology.setType(TOPOTYPE_BOX);
		try {
			ASObject as = (ASObject) object;
			Long roomID = Long.parseLong(as.get("roomId").toString());
			String groupID = as.get("groupId").toString();
			System.out.println("getNodeByBox---groupID=" + groupID);
			topology.setId(roomID);
			//初始化机房位置--先查出机房的行
			String roomLatSql = "select nht.room_rows from node_room_table nht where nht.room_id = " + roomID;
			System.out.println("getBoxByRoom---roomLatSql:"+roomLatSql);
			List<Object> roomRowList = (List<Object>)this.commonService.executeSQL(roomLatSql);
			if(roomRowList!=null && roomRowList.size()>0){
				long rows = Long.parseLong(roomRowList.get(0).toString());
				for(int i=1; i <= rows; i++){
					Topology row= new Topology();
					// 初始化机房位置--按行查列
					roomLatSql = "select nlt.id," +
							" nlt.lattice_row_position," +
							" nlt.lattice_col_position," +
							" nlt.room_id," +
							" nlt.node_box_id" +
							" from node_room_lattice_table nlt" +
							" where nlt.room_id = " + roomID + 
							" and nlt.lattice_row_position=" + i +
							" order by nlt.lattice_row_position asc,nlt.lattice_col_position asc";
					System.out.println("getBoxByRoom---roomLatSql:"+roomLatSql);
					List<Object[]> roomColList = (List<Object[]>)this.commonService.executeSQL(roomLatSql);
					for(int j=0; j<roomColList.size(); j++){
						Object[] roomLatObj = (Object[])roomColList.get(j);
						
						Topology colTopo= new Topology();
						colTopo.setType(this.TOPOTYPE_BOX);
						
						if(roomLatObj[4]!=null){// 存放了机柜，设置机柜信息，机柜是否正常
							String boxSql =
								" select" +
								" nt.box_id," +
								" nt.ispn,nt.box_u_type" +
								" from node_box_table nt" +
								" where nt.box_id = " + roomLatObj[4];
							List<Object []> boxList = (List<Object []>)this.commonService.executeSQL(boxSql);
							if(boxList!=null && boxList.size()>0){
								Object[] boxObj = boxList.get(0);
								colTopo.setId(Long.parseLong(boxObj[0]==null?"0":boxObj[0].toString()));
								colTopo.setIspn(boxObj[1].toString());
								colTopo.setBoxUType(Long.parseLong(boxObj[2]==null?"0":boxObj[2].toString()));
								colTopo.setIsOk(isOkInBox(boxObj[0].toString(),groupID));
							}
							colTopo.setIsEdit(this.isEditBoxInRoom(roomLatObj[4].toString(), groupID));
						}
						// 列添加到行
						row.getChild().add(colTopo);
						
					}

					topology.getChild().add(row);
				}
			}
			
			System.out.println("===============child cnt = " + topology.getChild().size());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return topology;
	}
	
	/**
	 * 机房下的机柜是否在当前节点组下有有效的节点，0 有，-1 无有效节点
	 * @param boxID
	 * @param groupID
	 * @return
	 */
	private int isEditBoxInRoom(String boxID, String groupID) throws Exception{
		// 机柜下的节点
		String sql1 = "select distinct nlt.node_seq" +
				" from node_lattice_table nlt" +
				" where nlt.node_box_id = " + boxID;
		// 当前节点组下在该机柜是否有有效的节点
		String cntSql =" select count(nt.node_id) from node_table nt" +
			" where nt.node_state=0 and nt.node_group_id=" + groupID+ 
			" and nt.seq_id in(" + sql1 + ")";
		
		List list= this.commonService.executeSQL(cntSql);
		Long nodeNum = Long.parseLong(list.get(0).toString());
		
		if(nodeNum>0){
			return 0;
		}else{
			return -1;
		}
	}
}
