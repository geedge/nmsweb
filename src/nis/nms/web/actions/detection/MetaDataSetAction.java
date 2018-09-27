package nis.nms.web.actions.detection;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.apache.struts2.config.Result;
import org.apache.struts2.config.Results;

import nis.nms.domains.CheckTypeInfo;
import nis.nms.domains.DataPoliceRelation;
import nis.nms.domains.Metadata;
import nis.nms.domains.OidDictionary;
import nis.nms.domains.TypeTable;
import nis.nms.service.CommonService;
import nis.nms.util.BaseAction;
import nis.nms.util.Constant;
import nis.nms.util.Page;


@SuppressWarnings("unchecked")
@Results( { 
	@Result(name="queryCheckTypeSource", value = "/page/detection/checkType/checkTypeSourceList.jsp"),
	@Result(name="addCheckTypeSource", value = "/page/detection/checkType/addCheckTypeSource.jsp"),
	@Result(name="updCheckTypeSource", value = "/page/detection/checkType/updCheckTypeSource.jsp"),
	@Result(name="updCheckTypeSourceList", value = "/page/detection/checkType/updateCheckTypeSourceList.jsp"),
	@Result(name="error", value ="/error.jsp")
})


public class MetaDataSetAction extends BaseAction {
	private Logger logger = Logger.getLogger(MetaDataSetAction.class);
	private static final long serialVersionUID = 1L;
	private CommonService commonService;
	private int pageNo = 1;
	private int pageSize =this.getDefaultPageSize();		//每页显示的记录条数
	private Page page;
	private int pageNoSub = 1;
	private int pageSizeSub =this.getDefaultPageSize();		//每页显示的记录条数
	private Page pageSub;
	private String action;
	private CheckTypeInfo checkTypeInfo;
	private Long[] ids;
	private Long[] typeids;
	private String checkTypeName;
	private Metadata metadata;
	private List<Metadata> metadataList;
	private List<String> metadataIds = new ArrayList<String>();//批量修改时，所修改记录的id
	private String filedTypeLength;
	private String filedType;
	private String isNullString;
	private String isHaveTable;
	private Long maxNum;
	private String ctn;
	private String isSch;
	private String isSnmp;
	private String mState;
	
	private String fromWhere;
	private String isComplete;
	private String isJclbComplete;
	
	
	private List<TypeTable> typeTableList = new ArrayList<TypeTable>();//所有的TypeTable

	@Override
	public String executeAction() throws Exception {
		String resultpage = "";
		this.getRequest().setAttribute("ADMFlag", this.getAdminMark());
		this.getRequest().setAttribute("fromWhere", fromWhere);
		if("query".equals(this.action)){
			//判断数据表是否存在
			this.checkTable();
			isSch();
			
			resultpage = this.queryCheckTypeSource();
		}else if("oppAdd".equals(this.action)){
			isSch();
			this.getRequest().setAttribute("fromWhere", fromWhere);
			this.getCheckTypeAndMetadata();
			resultpage = "addCheckTypeSource";
		}else if("doAdd".equals(this.action)){
			isSch();
			addMetaDataInfo();
			return null;
		}else if("oppUpd".equals(this.action)){//打开修改一条记录页面：原来的
			isSch();
			resultpage = this.openUpdateMetaData();
		}else if("oppUpdList".equals(this.action)){//打开批量修改记录页面
			isSch();//是否预置信息、是否snmp监控
			this.checkTable();
			resultpage = this.openUpdateMetaDataList();
		}else if("doUpd".equals(this.action)){//提交修改一条记录
			isSch();
			doUpdateMetaDataInfo();
			return null;
		}else if("doUpdList".equals(this.action)){//提交批量修改
			isSch();
			doUpdateMetaDataInfoList();
			return null;
		}else if("createTab".equals(this.action)){
			isSch();
			this.checkTable();
			this.createTable();
			return null;
		}else if("stop".equals(this.action)) {
			isSch();
			this.checkTable();
			resultpage = this.stop();//停用
		}else if("start".equals(this.action)) {
			isSch();
			this.checkTable();
			resultpage = this.start();//启用
		}else if("addCheck".equals(this.action)){
			addCheck();
			return null;
		}else if("updateCheck".equals(this.action)){
			updateCheck();
			return null;
		}else {
			this.checkTable();
			isSch();
			resultpage = this.queryCheckTypeSource();
		}
		return resultpage;
	}
	public String queryCheckTypeSource(){
		try {
			this.getRequest().setAttribute("fromWhere", fromWhere);
			checkTypeInfo = (CheckTypeInfo)this.commonService.get(CheckTypeInfo.class,typeids[0]);
			String hql = "from Metadata where 1=1 and checkTypeInfo.id="+typeids[0]+" order by showNum asc";
			page = this.commonService.findByPage(hql, pageNo, pageSize);
			metadataList = (List<Metadata>)page.getResult();
		} catch (Exception e) {
			logger.error(e.getStackTrace());
			e.printStackTrace();
			outHtmlString("<script type=\"text/javascript\">alert('i18n_MetaDataSetAction.queryCheckTypeSource.faild_n81i');this.location='checkTypeSet.do?action=query'</script>");
		}
		return "queryCheckTypeSource";
	}
	
	private String isSch()throws Exception{
		try {
			if(typeids!=null && typeids.length>0){
				CheckTypeInfo ct = (CheckTypeInfo)this.commonService.get(CheckTypeInfo.class,typeids[0]);
				if(ct!=null){
					isSch = ct.getIsSchedule();//是否预置信息
					isSnmp = ct.getIsSnmp()==null?null:String.valueOf(ct.getIsSnmp());//是否snmp监控
					
					if(null!=isSnmp && !isSnmp.equals("")&&Integer.parseInt(isSnmp)<2){//如果为snmp监控  则查询有无分类标识
						String hql = "from Metadata where checkTypeInfo = " + ct.getId()+" and sortSign=0";
						List<Metadata> metadataList = this.commonService.find(hql);
						if(metadataList!=null&&metadataList.size()>0){
							getRequest().setAttribute("hasSortSign", "yes");
						}
					}
				}
			}
			
		} catch (Exception e) {
			logger.error(e.getStackTrace());
			e.printStackTrace();
		}
		return null;
	}

	public String getState() {
		try	{
			String[] ids = this.getRequest().getParameter("ids").split(",");
			System.out.println(ids);
//			Metadata md = (Metadata)this.commonService.get(Metadata.class, Long.valueOf(id));
//			String state = "-1";
//			if(md!=null) {
//				state = md.getState();
//			}
//			jsonStr.append("{\"state\":\"");
//	        jsonStr.append(state);
//	        jsonStr.append("\"}");
//	        this.outJsonString(jsonStr.toString());
			this.outJsonArray(ids);
		} catch (Exception e) {
			logger.error(e.getStackTrace());
			e.printStackTrace();
		}
		
		return null;
	}
	private void getCheckTypeAndMetadata() throws Exception{
		try {
			if(typeids!=null && typeids.length>0){
				checkTypeInfo = (CheckTypeInfo)this.commonService.get(CheckTypeInfo.class, typeids[0]);
				String hql = "from Metadata where 1=1 and checkTypeInfo.id="+typeids[0];
				List<Metadata> list = this.commonService.find(hql);
				if(list!=null && list.size()>0){
					metadata = list.get(0);	
				}
				String ssql ="select max(show_num) from metadata where TABLE_NAME ='"+checkTypeInfo.getTableName()+"' and state=0";
				List numList = this.commonService.executeSQL(ssql);
				if(numList.get(0)!=null){
					maxNum = Long.parseLong(numList.get(0).toString());
				}else{
					maxNum =Long.parseLong("0");
				}
				
			}
			
		} catch (Exception e) {
			logger.error(e.getStackTrace());
			e.printStackTrace();
		}
	}
	
	public void addCheck(){
		int max = 0;
		try{
		String sql = "select count(*) from metadata t where CHECK_TYPE_ID ="+checkTypeInfo.getId()+" and FILED_NAME ='"+metadata.getFiledName()+"'";
		List list = this.commonService.executeSQL(sql);
		int num = Integer.parseInt(list.get(0).toString());
		if(num>0){//判断是否有此列时，只能从metadata表中去判断，不能从数据库中是否真的创建了此列来判断
//		if(hasCreatedTableColumn(tableName, columnName)){
			this.outString(getI18nText("i18n_MetaDataSetAction.queryCheckTypeSource.fieldExists_n81i"));
			return;
		}
		
		//判断showNum是否重复
		String showNumSql = "select t.show_num from metadata t where t.check_type_id="+checkTypeInfo.getId()+" and t.state = 0";
		List showNumList2 = this.commonService.executeSQL(showNumSql);
		if(showNumList2!=null && showNumList2.size()>0){
			for(int i=0;i<showNumList2.size();i++){
				Long snum = Long.parseLong(showNumList2.get(i).toString());
				if(metadata.getShowNum().equals(snum)){
					this.outString(getI18nText("i18n_MetaDataSetAction.queryCheckTypeSource.transIdExists_n81i"));
					return;
				}else{
					continue;
				}
			}
		}
		
		//获取最大“在传输中的序号"
		String getMaxNum = "select max(t.show_num) from metadata t where t.check_type_id="+checkTypeInfo.getId()+
							" and t.table_name='"+metadata.getTableName()+"' and t.state = 0";
		List maxNumList = this.commonService.executeSQL(getMaxNum);
		if(maxNumList!=null && maxNumList.size()>0){
			if(maxNumList.get(0)!=null){
				max = Integer.parseInt(maxNumList.get(0).toString());	
			}else{
				max =0;
			}
		}
		
		//不是连续的
		if(Integer.parseInt(metadata.getShowNum().toString())!=max+1){
			this.outString(getI18nText("i18n_MetaDataSetAction.queryCheckTypeSource.transIdIncoherence_n81i"));
			return;
		}
		}catch (Exception e) {
			e.printStackTrace();
			logger.info("添加监测类别管理校验异常",e);
			this.outString("exception");
		}
		this.outString("success");
	}
	
	//新增
	public void addMetaDataInfo()throws Exception{
		String filedTypeString = null;
		Date dNow = null;
		SimpleDateFormat sdf = null;
		Date createDate = null;
		HttpSession session =null;
		
		try {
			sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			dNow = new Date();
			createDate = sdf.parse(sdf.format(dNow));			
			session = this.getRequest().getSession(true);
			long userid = (Long)session.getAttribute("loginYhid");
			
			CheckTypeInfo typeInfo = (CheckTypeInfo) this.commonService.get(
					CheckTypeInfo.class, checkTypeInfo.getId());
			String tableName = typeInfo.getTableName();//表名
			String columnName = metadata.getFiledName();//新增字段名
			
			//组合metadata对象（一条字段记录）
			if(filedTypeLength!=null && !"".equals(filedTypeLength)){
				filedTypeString = filedType+"("+filedTypeLength+")";
				metadata.setFiledType(filedTypeString);
			}else{
				metadata.setFiledType(filedType);
			}
//			CheckTypeInfo typeInfo = (CheckTypeInfo) this.commonService.get(
//					CheckTypeInfo.class, checkTypeInfo.getId());
			metadata.setCheckTypeInfo(typeInfo);
			metadata.setCreateDate(createDate);//创建日期
			metadata.setCreatePerson(userid);//创建人
			
			//保存字段信息到表METADATA中去
			this.commonService.save(metadata);
			// 将更新操作写到操作日志中
			this.addDBOperationRpt(commonService,"metadata", "INSERT", metadata.getId());
			//与NMSServer通信
			this.sendCheckTypeId(typeInfo.getId()+"",commonService);
			
			//如果表已经生成，则需要修改表的结构
			if(hasCreatedTable(typeInfo.getTableName())){
				//向数据库中添加新的字段
				StringBuffer sqlString = new StringBuffer("alter table ");
				sqlString.append(typeInfo.getTableName().toUpperCase());
				sqlString.append(" add(");
				sqlString.append(metadata.getFiledName()+" "+ toMysqlType(metadata.getFiledType())+")");
				System.out.println(sqlString.toString());
				
				//执行添加字段
				int resu =this.commonService.updateBatchBySql(sqlString.toString());
			}
			
			//记录用户操作用于设置向导
			if(fromWhere!=null && !"".equals(fromWhere)){
				if(fromWhere.equals("formGuide")){
					outHtmlString("<script type=\"text/javascript\">alert('i18n_MetaDataSetAction.queryCheckTypeSource.success_n81i');this.location='metaDataSet.do?action=oppAdd&fromWhere="+fromWhere+"&isComplete=0&typeids="+checkTypeInfo.getId()+"'</script>");
				}
			}else{
				outHtmlString("<script type=\"text/javascript\">alert('i18n_MetaDataSetAction.queryCheckTypeSource.success_n81i');this.location='metaDataSet.do?action=oppAdd&typeids="+checkTypeInfo.getId()+"'</script>");
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(e.getStackTrace());
			outHtmlString("<script type=\"text/javascript\">alert('i18n_MetaDataSetAction.queryCheckTypeSource.faild_n81i');this.location='checkTypeSet.do?action=query'</script>");
		}
		this.checkTable();
		
	}
	
	//判断oracle数据库中是否存在表
	public boolean hasCreatedTable(String tableName) {
		boolean hasCreated = false;
		
		try	{
			/*String sql = "SELECT TABLE_NAME FROM USER_TABLES WHERE TABLE_NAME='"+tableName.toUpperCase()+"'";
			List list = this.commonService.executeSQL(sql);
			if(list!=null&&list.size()>0) {
				hasCreated = true;
			}*/
			//@2018-3-8 11:22:10 mysql适配
			int num = this.commonService.isTableExist(tableName);
			if(num>0) {
				hasCreated = true;
			}
		} catch (Exception e) {
			logger.error(e.getStackTrace());
			e.printStackTrace();
		}
		
		return hasCreated;
	}
	
	//判断oracle数据库表中是否存在字段
	public boolean hasCreatedTableColumn(String tableName,String columnName) {
		boolean hasCreated = false;
		String sql = "SELECT COLUMN_NAME FROM USER_TAB_COLUMNS WHERE TABLE_NAME='" + tableName.toUpperCase() + "' AND COLUMN_NAME='"+columnName.toUpperCase()+"'";
		try	{
			List list = this.commonService.executeSQL(sql);
			if(list!=null&&list.size()>0) {
				hasCreated = true;
			}
		} catch (Exception e) {
			logger.error(e.getStackTrace());
			e.printStackTrace();
		}
		
		return hasCreated;
	}
	
	//修改单条记录
	public String openUpdateMetaData(){
		try {
			
			if(ids!=null && ids.length>0){
				List list = this.commonService.find(
						"from Metadata where id=?", ids[0]);
				if(list!=null && list.size()>0){
					metadata = (Metadata)list.get(0);
				}
				
				//判断是否已经创建数据表，如果存在 判断对应字段时候存在数据
				int num = this.checkTableEntity(metadata.getTableName().trim().toUpperCase());
				if(num==1){
					outHtmlString("<script type=\"text/javascript\">alert('i18n_MetaDataSetAction.queryCheckTypeSource.tableExists_n81i');this.location='checkTypeSet.do?action=query'</script>");
					return null;
				}
				
				//是否启用标识
				mState = metadata.getState();
				
				String filedTypeString = metadata.getFiledType();
				if(filedTypeString.indexOf("(")!=-1){
					filedTypeLength = filedTypeString.substring(filedTypeString.indexOf("(")+1,filedTypeString.indexOf(")"));
					filedType = filedTypeString.substring(0,filedTypeString.indexOf("("));
					isNullString = "block";
				}else{
					filedType = filedTypeString;
					isNullString = "none";
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(e.getStackTrace());
			outHtmlString("<script type=\"text/javascript\">alert('i18n_MetaDataSetAction.queryCheckTypeSource.faild_n81i');this.location='checkTypeSet.do?action=query'</script>");
		}
		
		return "updCheckTypeSource";
		
	}
	
	//批量修改记录
	public String openUpdateMetaDataList(){
		try {
			this.getRequest().setAttribute("isSnmp", isSnmp);
			if(ids!=null && ids.length>0){
				String allId = StringUtils.join(ids, ",");
//				String sql = "select * from METADATA where CHECK_TYPE_ID = " + typeids[0] + "and ID in (" + allId + ")";
				String hql = "from Metadata where checkTypeInfo = " + typeids[0] + "and id in (" + allId + ") order by id desc";
				pageSub = this.commonService.findByPage(hql, pageNoSub, pageSizeSub);
				metadataList = (List<Metadata>)pageSub.getResult(); 
//				metadataList = this.commonService.executeSQL(sql, Metadata.class);
				if(metadataList.size()>0) {
					//判断是否已经创建数据表，如果存在 判断对应字段时候存在数据
					int num = this.checkTableEntity(metadataList.get(0).getTableName().trim().toUpperCase());
					if(num==1){
//						outHtmlString("<script type=\"text/javascript\">alert('数据表已存在');this.location='checkTypeSet.do?action=query'</script>");
//						return null;
					}
				}
				
				//查询Type_option表中的所有内容，共选择
				typeTableList = getAllTypeTable();
				for(Metadata meta:metadataList) {					
//					mState = meta.getState();//是否启用标识????????????????????
					
					String filedTypeString = meta.getFiledType();//字段类型
					if(filedTypeString.indexOf("(")!=-1){//文本类型
						String filedTypeLengthTemp = filedTypeString.substring(filedTypeString.indexOf("(")+1,filedTypeString.indexOf(")"));//字段类型长度
						String filedTypeOnlyTemp = filedTypeString.substring(0,filedTypeString.indexOf("("));//字段类型名（不含长度）
						meta.setFiledTypeLength(filedTypeLengthTemp);
						meta.setFiledTypeOnly(filedTypeOnlyTemp);
						isNullString = "block";
					}else{//时间和数字类型
						meta.setFiledTypeOnly(filedTypeString);
						isNullString = "none";
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(e.getStackTrace());
			outHtmlString("<script type=\"text/javascript\">alert(i18n_MetaDataSetAction.queryCheckTypeSource.faild_n81i);this.location='checkTypeSet.do?action=query'</script>");
		}
		
		return "updCheckTypeSourceList";
		
	}
	
	public List<TypeTable> getAllTypeTable() {
		List<TypeTable> tyTaList = new ArrayList<TypeTable>();
		try {
			String hql = "from TypeTable order by showNum asc";
			String sqlCondition = "where 1=1";
			tyTaList = this.commonService.find(hql);

			// 将查询请求记入到操作日志表中
			this.addDBOperationRpt(commonService, sqlCondition,	"TypeTable");
		} catch (Exception e) {
			logger.error(e.getStackTrace());
			e.printStackTrace();
		}
		return tyTaList;
	}
	
	//提交单条记录修改
	public void doUpdateMetaDataInfo()throws Exception{
		Date dNow = null;
		SimpleDateFormat sdf = null;
		Date updateDate = null;
		HttpSession session =null;
		String fileTypeAll="";
		String pathString = this.getRequest().getContextPath();
		int max =0;
		boolean d = false;
		try {
			sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			dNow = new Date();
			updateDate = sdf.parse(sdf.format(dNow));
			
			session = this.getRequest().getSession(true);
			long userid = (Long)session.getAttribute("loginYhid");
			List list = this.commonService
					.find("from Metadata where tableName=? and checkTypeInfo.id=? and filedName =? and id<>?",
							metadata.getTableName(),checkTypeInfo.getId()
									,metadata.getFiledName(), metadata.getId());
			if (list != null && list.size() > 0) {
				this.outHtmlString("<script>alert('i18n_MetaDataSetAction.queryCheckTypeSource.recordExists_n81i');history.back();</script>");
				return;
			}
				
			//获取最大“在传输中的序号"
			String getMaxNum = "select max(t.show_num) from metadata t where t.check_type_id="+checkTypeInfo.getId()+
								" and t.table_name='"+metadata.getTableName()+"' and t.state = 0";
			List maxNumList = this.commonService.executeSQL(getMaxNum);
			if(maxNumList!=null && maxNumList.size()>0){
				max = Integer.parseInt(maxNumList.get(0).toString());
			}
			
			Metadata md = (Metadata)this.commonService.get(Metadata.class, metadata.getId());
			md.setTableComments(metadata.getTableComments());
			md.setFiledName(metadata.getFiledName());
			md.setFiledComments(metadata.getFiledComments());
			
			if(filedTypeLength!=null && !"".equals(filedTypeLength)){
				fileTypeAll = filedType+"("+filedTypeLength+")";
			}else{
				fileTypeAll = filedType;
			}
			
			//字段类型前后不一致说明进行修改了-------------------------------更新字段类型------------------------
			if(!fileTypeAll.equals(md.getFiledType())){
				//判断是否已经创建数据表，如果存在 判断对应字段时候存在数据
				int num = this.checkTableEntity(metadata.getTableName().trim().toUpperCase());
				//存在表
				if(num ==1){
					String cfs="select count("+metadata.getFiledName().toUpperCase()+") from "+metadata.getTableName().trim().toUpperCase();
					List resu = this.commonService.executeSQL(cfs);
					int sumData = Integer.parseInt(resu.get(0).toString());
					if(sumData>0){
						this.outHtmlString("<script>alert('i18n_MetaDataSetAction.queryCheckTypeSource.editDisable_n81i');history.back();</script>");
						return;
					}else{
						md.setFiledType(fileTypeAll);
					}
				}else{
					md.setFiledType(fileTypeAll);
				}
			}else{
				md.setFiledType(fileTypeAll);
			}
			//------------------------------------------------更新字段类型---------------------------------------------
			
			md.setState(metadata.getState());
			md.setChartState(metadata.getChartState());
			
			//1说明停用了 则保存停用人和停用时间，并且停用告警
			if(metadata.getState().equals("1") && mState.equals("0")){//启用---->停用
				md.setUpdateDate(updateDate);
				md.setUpdatePerson(userid);
				md.setShowNum(null);
				d = true;
				//与NMSServer通信
				this.sendCheckTypeId(typeids[0]+"",commonService);
			}else if(metadata.getState().equals("0") && mState.equals("1")){//停用---->启用
				if(metadata.getShowNum()!=null && !"".equals(metadata.getShowNum())){
					//判断showNum是否重复
					String showNumSql = "select t.show_num from metadata t where t.check_type_id="+checkTypeInfo.getId()+" and id <> "+metadata.getId()+" and t.state = 0 and t.show_num is not null";
					List showNumList2 = this.commonService.executeSQL(showNumSql);
					if(showNumList2!=null && showNumList2.size()>0){
						for(int i=0;i<showNumList2.size();i++){
							Long num = Long.parseLong(showNumList2.get(i).toString());
							if(metadata.getShowNum().equals(num)){
								this.outHtmlString("<script>alert('i18n_MetaDataSetAction.queryCheckTypeSource.transIdExists_n81i');history.back();</script>");
								return;
							}else{
								continue;
							}
						}
					}
					md.setShowNum(metadata.getShowNum());
				}else{
					this.outHtmlString("<script>alert('i18n_MetaDataSetAction.queryCheckTypeSource.inputTransId_n81i');history.back();</script>");
					return;
				}
			}else if(metadata.getState().equals("0") && mState.equals("0")){//启用---->启用
				if(metadata.getShowNum()!=null && !"".equals(metadata.getShowNum())){
					//判断showNum是否重复
					String showNumSql = "select t.show_num from metadata t where t.check_type_id="+checkTypeInfo.getId()+" and id <> "+metadata.getId()+" and t.state = 0 and t.show_num is not null";
					List showNumList2 = this.commonService.executeSQL(showNumSql);
					if(showNumList2!=null && showNumList2.size()>0){
						for(int i=0;i<showNumList2.size();i++){
							Long num = Long.parseLong(showNumList2.get(i).toString());
							if(metadata.getShowNum().equals(num)){
								this.outHtmlString("<script>alert('i18n_MetaDataSetAction.queryCheckTypeSource.transIdExists_n81i');history.back();</script>");
								return;
							}else{
								continue;
							}
						}
					}
					md.setShowNum(metadata.getShowNum());
				}else{
					this.outHtmlString("<script>alert('i18n_MetaDataSetAction.queryCheckTypeSource.inputTransId_n81i');history.back();</script>");
					return;
				}
			}else{
				md.setShowNum(null);
			}
			
			//提交之前再判断是否生成了表
			int n = this.checkTableEntity(metadata.getTableName().trim().toUpperCase());
			if(n==0){
				if(d){
					String policeSql ="select id from data_police_relation where metadata_id="+metadata.getId(); 
					List pList = this.commonService.executeSQL(policeSql);
					if(pList!=null && pList.size()>0){
						DataPoliceRelation dpr = (DataPoliceRelation)this.commonService.get(DataPoliceRelation.class, Long.parseLong(pList.get(0).toString()));
						dpr.setPoliceState("1");
						this.commonService.update(dpr);	
					}
				}
				md.setOid(metadata.getOid());
				this.commonService.update(md);
				// 将更新操作写到操作日志中
				this.addDBOperationRpt(commonService,"metadata", "UPDATE", md.getId());
				outHtmlString("<script type=\"text/javascript\">alert('i18n_MetaDataSetAction.queryCheckTypeSource.success_n81i');this.location='metaDataSet.do?action=query&typeids="+checkTypeInfo.getId()+"'</script>");
			}else{
				this.outHtmlString("<script>alert('i18n_MetaDataSetAction.queryCheckTypeSource.updateTable_n81i');history.back();</script>");
				return;
			}
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(e.getStackTrace());
			outHtmlString("<script type=\"text/javascript\">alert('i18n_MetaDataSetAction.queryCheckTypeSource.faild_n81i');this.location='metaDataSet.do?action=query&typeids="+checkTypeInfo.getId()+"'</script>");
		}
		this.checkTable();
		if( d && metadata.getShowNum()!=null && !mState.equals("1")){
			if(Integer.parseInt(metadata.getShowNum().toString())!= max){
				this.outHtmlString("<script>alert('i18n_MetaDataSetAction.queryCheckTypeSource.addFiled1_n81i"+metadata.getShowNum()+"i18n_MetaDataSetAction.queryCheckTypeSource.addFiled2_n81i');this.location='"+pathString+"/detection/metaDataSet!executeAction.do?action=query&typeids="+typeids[0]+"';</script>");
				return;
			}
		}
		
	}
	
	
	public void updateCheck(){
		//是否存在重复记录：同一个表中字段名相同
		try{
		if(typeids!=null&&typeids.length>0&&metadataIds!=null) {
			String toUpdateIds = StringUtils.join(metadataIds.toArray(),",");//将要修改的记录的id用逗号连接
			String sql = "select FILED_NAME from Metadata where CHECK_TYPE_ID="+typeids[0]+" and id not in("+toUpdateIds+")";
			List noUpdateList =  this.commonService.executeSQL(sql);//获得没有修改的记录的字段名
			for(Metadata md:metadataList) { 
				String name = md.getFiledName();
				if(noUpdateList.contains(name)) {//如果没有修改的记录的字段名中有要修改的记录的字段名就重名了
					this.outString(getI18nText("i18n_MetaDataSetAction.queryCheckTypeSource.repeatRecord_n81i"));
					return;
				}
			}
		}
		}catch (Exception e) {
			e.printStackTrace();
			logger.info("校验是否存在重复记录异常",e);
			this.outString("exception");
		}
		this.outString("success");
	}
	
	//批量修改记录提交
	public void doUpdateMetaDataInfoList()throws Exception{
		if(metadataList!=null){
			try {
				Map<String,String> map = this.getAllDictionary();
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				Date dNow = new Date();
				Date updateDate = sdf.parse(sdf.format(dNow));		
				boolean d = false;
				String fileTypeAll="";
				HttpSession session = this.getRequest().getSession(true);
				long userid = (Long)session.getAttribute("loginYhid");
				//批量修改记录
				for(Metadata metadataTemp:metadataList) {
					Metadata mData = (Metadata)this.commonService.get(Metadata.class, metadataTemp.getId());
					mData.setFiledName(metadataTemp.getFiledName());//字段名
					if(mData.getOid()!=null && !"".equals(mData.getOid())){//oid不为空说明是snmp监测
						if(map!=null && map.size()>0){
							if(map.containsKey(mData.getOid())){//如果map的key和oid相等 那么更新描述为字典的值
								mData.setFiledComments(map.get(mData.getOid()));//字段描述
							}else{
								mData.setFiledComments(metadataTemp.getFiledComments());//字段描述
							}
						}else{
							mData.setFiledComments(metadataTemp.getFiledComments());//字段描述
						}
					}else{
						mData.setFiledComments(metadataTemp.getFiledComments());//字段描述
					}
					//字段类型
					if(metadataTemp.getFiledTypeLength()!=null && !"".equals(metadataTemp.getFiledTypeLength())){
						fileTypeAll = metadataTemp.getFiledTypeOnly()+"("+metadataTemp.getFiledTypeLength()+")";
					}else{
						fileTypeAll = metadataTemp.getFiledTypeOnly();
					}
					//字段类型前后不一致说明进行修改了-------------------------------更新字段类型------------------------
					if(!fileTypeAll.equalsIgnoreCase(mData.getFiledType())){
						//判断是否已经创建数据表，如果存在 判断对应字段时候存在数据
						int num = this.checkTableEntity(mData.getTableName().trim().toUpperCase());
						//存在表
						if(num ==1){
							String cfs="select count("+mData.getFiledName().toUpperCase()+") from "+mData.getTableName().trim().toUpperCase();
							List resu = this.commonService.executeSQL(cfs);
							int sumData = Integer.parseInt(resu.get(0).toString());
							if(sumData>0){
								this.outHtmlString("<script>alert('i18n_MetaDataSetAction.queryCheckTypeSource.editDisable_n81i');history.back();</script>");
								return;
							}else {
								mData.setFiledType(fileTypeAll);
							}
						}else{
							mData.setFiledType(fileTypeAll);
						}
					}
					//------------------------------------------------更新字段类型---------------------------------------------
					
					mData.setState(metadataTemp.getState());//启用标识
					mData.setChartState(metadataTemp.getChartState());//统计标识
					mData.setTypeId(metadataTemp.getTypeId());//翻译字典
					mData.setSortSign(metadataTemp.getSortSign());//分类标识：只能有一个是
					
					//1说明停用了 则保存停用人和停用时间，并且停用告警
					if(metadataTemp.getState().equals("1") && mData.getState().equals("0")){//启用---->停用
						mData.setUpdateDate(updateDate);
						mData.setUpdatePerson(userid);
						mData.setShowNum(null);
						d = true;
						//与NMSServer通信
						this.sendCheckTypeId(typeids[0]+"",commonService);
					}
					//提交之前再判断是否生成了表
//					int n = this.checkTableEntity(mData.getTableName().trim().toUpperCase());
//					if(n==0){//表没生成
						if(d){//启用->停用
							String policeSql ="select id from data_police_relation where metadata_id="+metadataTemp.getId(); 
							List pList = this.commonService.executeSQL(policeSql);
							if(pList!=null && pList.size()>0){
								DataPoliceRelation dpr = (DataPoliceRelation)this.commonService.get(DataPoliceRelation.class, Long.parseLong(pList.get(0).toString()));
								dpr.setPoliceState("1");
								this.commonService.update(dpr);	
							}
						}
						this.commonService.update(mData);
						// 将更新操作写到操作日志中
						this.addDBOperationRpt(commonService,"metadata", "UPDATE", mData.getId());
						outHtmlString("<script type=\"text/javascript\">alert('i18n_MetaDataSetAction.queryCheckTypeSource.success_n81i');this.location='metaDataSet.do?action=query&typeids="+typeids[0]+"'</script>");
//					}else{
//						this.outHtmlString("<script>alert('数据表已生成，禁止修改！');history.back();</script>");
//						return null;
//					}
				}
			} catch (Exception e) {
				e.printStackTrace();
				logger.error(e.getStackTrace());
				outHtmlString("<script type=\"text/javascript\">alert('i18n_MetaDataSetAction.queryCheckTypeSource.faild_n81i');this.location='metaDataSet.do?action=query&typeids="+typeids[0]+"'</script>");
			}
			this.checkTable();
		}
		
	}
	
	//获取OID数据字典
	public Map<String,String> getAllDictionary() throws Exception{
		List<OidDictionary> list = null;
		Map<String,String> map = null;
		try {
			String hql= "from OidDictionary";
			list = this.commonService.find(hql);
			if(list!=null && list.size()>0){
				map = new HashMap<String,String>();
				for(int i=0;i<list.size();i++){
					OidDictionary od = list.get(i);
					map.put(od.getOid(),od.getOidDesc());
				}
			}
		} catch (Exception e) {
			logger.error("Failed to get OID dictionary!",e);
			throw new Exception(getI18nText("i18n_MetaDataSetAction.queryCheckTypeSource.getOidDict_n81i"));
		}
		return map;
	}
	
	public static void main(String[] args) {
		List<String> l = new ArrayList<String>();
		l.add("a");
		l.add("b");
		l.add("a");
		System.out.println(l.size());
		System.out.println(l.contains("a"));
		
	}
	
	//停用表里的字段
	public String stop() {
		try	{
			if(ids!=null&&ids.length>0) {
				for(int i=0;i<ids.length;i++){
					Metadata md = (Metadata)this.commonService.get(Metadata.class, ids[i]);
					md.setState("1");//停用字段：1停用，0启用
					this.commonService.update(md);
				}
			}
		} catch (Exception e) {
			logger.error(e.getStackTrace());
			e.printStackTrace();
		}
		
		return this.queryCheckTypeSource();
	}
	
	//启用表里的字段
	public String start() {
		try	{
			if(ids!=null&&ids.length>0) {
				for(int i=0;i<ids.length;i++){
					Metadata md = (Metadata)this.commonService.get(Metadata.class, ids[i]);
					md.setState("0");//停用字段：1停用，0启用
					this.commonService.update(md);
				}
			}
		} catch (Exception e) {
			logger.error(e.getStackTrace());
			e.printStackTrace();
		}
		
		return this.queryCheckTypeSource();
	}
	
	public int checkTableEntity(String tableName) throws Exception{
		int num = 0;
		try {
			/*String sql = "SELECT COUNT(*) from user_tables where table_name = '"+tableName+"'";
			List isHaveist = null;
			isHaveist = this.commonService.executeSQL(sql);
			num = Integer.parseInt(isHaveist.get(0).toString());*/
			
			//@2018-3-8 11:22:10 mysql适配
			num = this.commonService.isTableExist(tableName);
		} catch (Exception e) {
			logger.error(e.getStackTrace());
			e.printStackTrace();
		}
		return num;
	}
	
	//判断是否生成了数据表
	public void checkTable()throws Exception{
		try {
			if(typeids!=null && typeids.length>0){
				CheckTypeInfo ctInfo = (CheckTypeInfo)this.commonService.get(CheckTypeInfo.class, typeids[0]);
				if(ctInfo.getCreteState().equals("0")){
					isHaveTable = "yes";
				}else if(ctInfo.getCreteState().equals("1")){
					isHaveTable = "no";
				}
			}
			
		} catch (Exception e) {
			logger.error(e.getStackTrace());
			e.printStackTrace();
		}
	}
	
	//向数据表里添加新字段(干掉了,不用了)-------------------------------------------------------------------------
	public String addFiled() throws Exception{
		List<Metadata> metaList= null;
		StringBuffer sqlString = new StringBuffer("alter table ");
		String oneFiledString="";
		StringBuffer fileds = new StringBuffer();
		try {
			if(typeids!=null && typeids.length>0){
				String hql = "from Metadata where 1=1 and checkTypeInfo.id="+typeids[0];
				metaList = this.commonService.find(hql);
				CheckTypeInfo ctInfo = (CheckTypeInfo)this.commonService.get(CheckTypeInfo.class, typeids[0]);
				String sql = "select column_name from user_tab_columns where table_name='"+ctInfo.getTableName().toUpperCase()+"'";
				List list = this.commonService.executeSQL(sql);
				
				if(metaList.size()>list.size()){
					for(int i=0;i<list.size();i++){
						for(int j=0;j<metaList.size();j++){
							if(metaList.get(j).getFiledName().equals(list.get(i).toString())){
								metaList.remove(j);
								break;
							}
						}
					}
					sqlString.append(ctInfo.getTableName().toUpperCase());
					sqlString.append(" add(");
					for(int n=0;n<metaList.size();n++){
						if(n != metaList.size()-1){
							oneFiledString =metaList.get(n).getFiledName()+" "+metaList.get(n).getFiledType()+",";
							sqlString.append(oneFiledString);
						}else{
							oneFiledString =metaList.get(n).getFiledName()+" "+metaList.get(n).getFiledType();
							sqlString.append(oneFiledString);
						}
						//判断是否为统计字段
						if(metaList.get(n).getChartState().equals("0")){
							fileds.append(metaList.get(n).getFiledName()+":");
						}
					}
					sqlString.append(")");
					System.out.println(sqlString.toString());
					int resu =this.commonService.updateBatchBySql(sqlString.toString());
				
					if(resu!=-1){
						if(fileds.length()>0){
							boolean result = this.commonService.executeProForUTable("pro_createIndex", ctInfo.getTableName().toUpperCase(),fileds.toString());
							if(result){
								this.outHtmlString("<script>alert('i18n_MetaDataSetAction.queryCheckTypeSource.addSuccess_n81i');history.back();</script>");
							}else{
								this.outHtmlString("<script>alert('i18n_MetaDataSetAction.queryCheckTypeSource.addFieldIndexFaild_n81i');history.back();</script>");
							}
						}else{
							this.outHtmlString("<script>alert('i18n_MetaDataSetAction.queryCheckTypeSource.addSuccess_n81i');history.back();</script>");
						}
					}else{
						this.outHtmlString("<script>alert('i18n_MetaDataSetAction.queryCheckTypeSource.addFaild_n81i');history.back();</script>");	
						return null;
					}
				}else{
					this.outHtmlString("<script>alert('i18n_MetaDataSetAction.queryCheckTypeSource.pleaseAddField_n81i');history.back();</script>");
					return null;
				}
				
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(e.getStackTrace());
		}
		return this.queryCheckTypeSource();
	}
	//----------------------------------------------------------------------------------------------------------
	
	//生成数据表
	//1.所有的字段名均不可为空
	public void createTable()throws Exception{
		String tableName="";
		String filedName ="";
		String filedType ="";
		StringBuffer sql= new StringBuffer();
		StringBuffer cIndexFileds = new StringBuffer("data_check_time:seq_id:detection_set_info_id:");
		try {
			//所有的字段名均不可为空
			if(typeids!=null&&typeids.length>0) {
				String isFieldNullHql = "from Metadata where checkTypeInfo.id = " + typeids[0] + " and state = '0' and  filedName is null ";
				List list = this.commonService.find(isFieldNullHql);
				if(list!=null&&list.size()>0) {
					this.outHtmlString("<script type='text/javascript'>alert('i18n_MetaDataSetAction.queryCheckTypeSource.cantCreateTable_n81i');history.back();</script>");
					return;
				}
			}
			
			String hql = "from Metadata where 1=1 and checkTypeInfo.id="+typeids[0]+" and state = '0' order by showNum asc";
			CheckTypeInfo cc= (CheckTypeInfo)this.commonService.get(CheckTypeInfo.class, typeids[0]);
			page = this.commonService.findByPage(hql, pageNo, pageSize);
			metadataList = (List<Metadata>)page.getResult();
			if(metadataList.size()>0){
				tableName = cc.getTableName();
				
				/*String csql = "SELECT COUNT(*) from user_tables where table_name = '"+tableName.toUpperCase()+"'";
				List list = this.commonService.executeSQL(csql);
				int num = Integer.parseInt(list.get(0).toString());*/
				//@2018-3-8 11:22:10 mysql适配
				int num = this.commonService.isTableExist(tableName);
				if(num >0){
					//this.outHtmlString("<script>alert('数据表已存在！');history.back();</script>");	
					this.addFiled();
				}else{
					for(int i=0;i<metadataList.size();i++){
						filedName = metadataList.get(i).getFiledName();
						sql.append(filedName+" ");
						filedType = metadataList.get(i).getFiledType();
						if(i != metadataList.size()-1){
							sql.append(toMysqlType(filedType)+",");
						}else{
							sql.append(toMysqlType(filedType));
						}
						//判断是否为统计
						if(metadataList.get(i).getChartState().equals("0")){
							cIndexFileds.append(metadataList.get(i).getFiledName()+":");
						}
					}
					System.out.println(sql);
					boolean resu = this.commonService.executeProForCTable("pro_createTable", tableName, sql.toString(),cIndexFileds.toString());
					if(resu){
						//this.outHtmlString("<script>alert('生成成功！');history.back();</script>");
						//更新监测类别数据表创建状态
						cc.setCreteState("0");
						this.commonService.update(cc);
						outHtmlString("<script type=\"text/javascript\">alert('i18n_MetaDataSetAction.queryCheckTypeSource.success_n81i');this.location='metaDataSet.do?action=query&typeids="+typeids[0]+"'</script>");
					}else{
						this.outHtmlString("<script>alert('i18n_MetaDataSetAction.queryCheckTypeSource.filedToCreate_n81i');history.back();</script>");	
						return;
					}
				}
			}else{
				this.outHtmlString("<script>alert('i18n_MetaDataSetAction.queryCheckTypeSource.pleaseAddField_n81i');history.back();</script>");
				return;
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(e.getStackTrace());
			outHtmlString("<script type=\"text/javascript\">alert('i18n_MetaDataSetAction.queryCheckTypeSource.faild_n81i');this.location='metaDataSet.do?action=query&typeids="+typeids[0]+"'</script>");
		}
		this.checkTable();
	}
	
	private static String toMysqlType(String type){
		if(Constant.IS_MYSQL){
			type = type.trim().toLowerCase();
			if(type.startsWith("date")){
				type = type.replaceAll("date", "datetime");
			}else if(type.startsWith("number")){
				type = type.replaceAll("number", "bigint");
			}else if(type.startsWith("varchar")){
				type = type.replaceAll("varchar2", "varchar");
			}
		}
		return type;
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

	public String getCheckTypeName() {
		return checkTypeName;
	}

	public void setCheckTypeName(String checkTypeName) {
		this.checkTypeName = checkTypeName;
	}

	public Long[] getIds() {
		return ids;
	}

	public void setIds(Long[] ids) {
		this.ids = ids;
	}

	public CheckTypeInfo getCheckTypeInfo() {
		return checkTypeInfo;
	}

	public void setCheckTypeInfo(CheckTypeInfo checkTypeInfo) {
		this.checkTypeInfo = checkTypeInfo;
	}

	public Metadata getMetadata() {
		return metadata;
	}

	public void setMetadata(Metadata metadata) {
		this.metadata = metadata;
	}
	
	public Long[] getTypeids() {
		return typeids;
	}

	public void setTypeids(Long[] typeids) {
		this.typeids = typeids;
	}

	public String getFiledTypeLength() {
		return filedTypeLength;
	}

	public void setFiledTypeLength(String filedTypeLength) {
		this.filedTypeLength = filedTypeLength;
	}

	public String getFiledType() {
		return filedType;
	}

	public void setFiledType(String filedType) {
		this.filedType = filedType;
	}
	public List<Metadata> getMetadataList() {
		return metadataList;
	}
	public void setMetadataList(List<Metadata> metadataList) {
		this.metadataList = metadataList;
	}
	public String getIsNullString() {
		return isNullString;
	}
	public void setIsNullString(String isNullString) {
		this.isNullString = isNullString;
	}
	public String getIsHaveTable() {
		return isHaveTable;
	}
	public void setIsHaveTable(String isHaveTable) {
		this.isHaveTable = isHaveTable;
	}
	public Long getMaxNum() {
		return maxNum;
	}
	public void setMaxNum(Long maxNum) {
		this.maxNum = maxNum;
	}
	
	public String getCtn() {
		return ctn;
	}
	public void setCtn(String ctn) {
		this.ctn = ctn;
	}
	public String getIsSch() {
		return isSch;
	}
	public void setIsSch(String isSch) {
		this.isSch = isSch;
	}
	public String getmState() {
		return mState;
	}
	public void setmState(String mState) {
		this.mState = mState;
	}
	
	public String getIsSnmp()
	{
		return isSnmp;
	}
	
	public void setIsSnmp(String isSnmp)
	{
		this.isSnmp = isSnmp;
	}
	
	public List<TypeTable> getTypeTableList()
	{
		return typeTableList;
	}
	
	public void setTypeTableList(List<TypeTable> typeTableList)
	{
		this.typeTableList = typeTableList;
	}
	
	public List<String> getMetadataIds()
	{
		return metadataIds;
	}
	
	public void setMetadataIds(List<String> metadataIds)
	{
		this.metadataIds = metadataIds;
	}
	
	public int getPageNoSub()
	{
		return pageNoSub;
	}
	
	public void setPageNoSub(int pageNoSub)
	{
		this.pageNoSub = pageNoSub;
	}
	
	public int getPageSizeSub()
	{
		return pageSizeSub;
	}
	
	public void setPageSizeSub(int pageSizeSub)
	{
		this.pageSizeSub = pageSizeSub;
	}
	
	public Page getPageSub()
	{
		return pageSub;
	}
	
	public void setPageSub(Page pageSub)
	{
		this.pageSub = pageSub;
	}
	public Logger getLogger() {
		return logger;
	}

	public void setLogger(Logger logger) {
		this.logger = logger;
	}
	public String getFromWhere() {
		return fromWhere;
	}
	public void setFromWhere(String fromWhere) {
		this.fromWhere = fromWhere;
	}
	public String getIsComplete() {
		return isComplete;
	}
	public void setIsComplete(String isComplete) {
		this.isComplete = isComplete;
	}
	public String getIsJclbComplete() {
		return isJclbComplete;
	}
	public void setIsJclbComplete(String isJclbComplete) {
		this.isJclbComplete = isJclbComplete;
	}
	
}
