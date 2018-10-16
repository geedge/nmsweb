package nis.nms.web.actions.sysManage;

import java.io.IOException;
import java.util.List;

import nis.nms.core.Constants;
import nis.nms.domains.OptionTable;
import nis.nms.domains.SetDetDataCon;
import nis.nms.domains.TypeTable;
import nis.nms.service.CommonService;
import nis.nms.util.BaseAction;
import nis.nms.util.Constant;
import nis.nms.util.Page;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.apache.struts2.config.Result;
import org.apache.struts2.config.Results;

@SuppressWarnings("unchecked")
@Results( { 
	@Result(name="queryDictionaryInfo", value = "/page/system/dictionary/dictionaryInfoList.jsp"),
	@Result(name="queryDeteDataConSet", value = "/page/system/dictionary/deteDataConSetList.jsp"),
	@Result(name="addDictionaryInfo", value = "/page/system/dictionary/addDictionary.jsp"),
	@Result(name="updateDictionaryInfo", value = "/page/system/dictionary/updateDictionary.jsp"),
	@Result(name="updateDetDataConSet", value = "/page/system/dictionary/updateDetDataConSet.jsp"),
	
	@Result(name="queryDictionarySource", value = "/page/system/dictionary/dictionarySourceList.jsp"),
	@Result(name="addDictionarySource", value = "/page/system/dictionary/addDictionarySource.jsp"),
	@Result(name="updDictionarySource", value = "/page/system/dictionary/updateDictionarySource.jsp"),
	@Result(name="updDictionarySourceList", value = "/page/system/dictionary/updateDictionarySource.jsp"),
	@Result(name="detailDictionaryInfo", value = "/page/system/dictionary/detailDictionary.jsp")
})

/**
 * 监测设置相关操作
 */
public class DataDictionaryAction extends BaseAction {
	private Logger logger = Logger.getLogger(DataDictionaryAction.class);
	private static final long serialVersionUID = 1L;
	private CommonService commonService;
	private int pageNo = 1;
	private int pageSize =this.getDefaultPageSize();		//每页显示的记录条数
	private Page page;
	private String action;
	private List<TypeTable> typeTableList;
	private List<OptionTable> optionTableist;
	private TypeTable typeTable;
	private OptionTable optionTable;
	private String ddid;
	private Long did;
	private String optionId;
	private Long didd;
	
	//监测数据列表过滤条件配置相关
	private List<SetDetDataCon> setDetDataConList;
	private String setId;//监测数据列表过滤条件配置的id
	private SetDetDataCon detDataConSet;
	
	@Override
	public String executeAction() throws Exception {
		String resultpage = "";
		if("query".equals(this.action)){
			resultpage = this.queryDictionary();
		}else if("openAdd".equals(this.action)){
			resultpage = "addDictionaryInfo";
		}else if("querySouce".equals(this.action)){
			getTypeTableById();
			resultpage = this.queryDictionarySouce();
		}else if("openAddSource".equals(this.action)){
			getTypeTableById();
			resultpage = "addDictionarySource";
		}else if("doAddSource".equals(this.action)){
			addDataSource();
			return null;
		}else if("doAdd".equals(this.action)){
			addData();
			return null;
		}else if("openUpdate".equals(this.action)){
			resultpage = this.openUpdDD();
		}else if("doUpdate".equals(this.action)){
			doUpdData();
			return null;
		}else if("openUpdateSource".equals(this.action)){
			getTypeTableById();
			resultpage = this.openUpdDDS();
		}else if("doUpdateSource".equals(this.action)){
			doUpdDataSource();
			return null;
		}else if("checkAjax".equals(this.action)){
			checkAjax();
			return null;
		}else if("checkDictionary".equals(this.action)){
			checkDictionary();
			return null;
		}else if("queryDetectConditionSet".equals(this.action)) {//为 业务逻辑拓扑、告警信息、异常服务器、异常网元、系统预警信息菜单 设置过滤条件(告警级别、是否紧急)
			resultpage = this.queryDeteDataConSet();
		}else if("toUpdateDetectConditionSet".equals(this.action)) {//为 业务逻辑拓扑、告警信息、异常服务器、异常网元、系统预警信息菜单 设置过滤条件(告警级别、是否紧急)
			resultpage = this.toUpdateDetectConditionSet();
		}else if("updateDetectConditionSet".equals(this.action)) {//为 业务逻辑拓扑、告警信息、异常服务器、异常网元、系统预警信息菜单 设置过滤条件(告警级别、是否紧急)
			this.updateDetectConditionSet();
			return null;
		}else if("updateCheck".equals(this.action)){
			this.updateCheck();
			return null;
		}else if("updateSourceCheck".equals(this.action)){
			this.updateSourceCheck();
			return null;
		}else{
			resultpage = this.queryDictionary();
		}
		return resultpage;
	}
	
	public String queryDictionary(){
		try {
			//查询检测类别用字段
			String hql = "from TypeTable order by showNum";
			page = this.commonService.findByPage(hql, pageNo, pageSize);
			typeTableList = (List<TypeTable>)page.getResult();
		} catch (Exception e) {
			logger.error("Query data dictionary information failed",e);
			this.outHtmlString("<script>alert('i18n_DataDictionaryAction.queryDictionary.queryDictInfoErr_n81i！');history.back();</script>");
			return null;
		}
		return "queryDictionaryInfo";
	}
	
	public String queryDeteDataConSet(){
		try {
			//查询检测类别用字段
			String hql = "from SetDetDataCon order by id";
			page = this.commonService.findByPage(hql, pageNo, pageSize);
			setDetDataConList = (List<SetDetDataCon>)page.getResult();
			
			for(SetDetDataCon set:setDetDataConList) {
				String policeLevel = set.getPoliceLevel()==null?"":set.getPoliceLevel().trim();
				String policeEmergent = set.getPoliceEmergent()==null?"":set.getPoliceEmergent().trim();
				if(StringUtils.isNotBlank(policeLevel)) {
					
					String[] policeLevelArray = policeLevel.split(",");
					String policeLevelForShow = "";
					for(String level:policeLevelArray) {
						if(StringUtils.isNotBlank(level)) {
							policeLevelForShow = policeLevelForShow + level.trim() + getI18nText("i18n_DataDictionaryAction.queryDictionary.warningLevel_n81i")+","; 
						}
					}
					if(policeLevelForShow.endsWith(",")) {
						policeLevelForShow = policeLevelForShow.substring(0, policeLevelForShow.length()-1);
					}
					set.setPoliceLevelForShow(policeLevelForShow);
				}
				//是否紧急
				if(StringUtils.isNotBlank(policeEmergent)) {
					if(policeEmergent.contains("0") && policeEmergent.contains("1")) {
						set.setPoliceEmergentFowShow(getI18nText("i18n_DataDictionaryAction.queryDictionary.emergent_n81i")+"、"+getI18nText("i18n_DataDictionaryAction.queryDictionary.nonEmergent_n81i"));
					}else if(policeEmergent.contains("0")) {
						set.setPoliceEmergentFowShow(getI18nText("i18n_DataDictionaryAction.queryDictionary.emergent_n81i"));
					}else if(policeEmergent.contains("1")) {
						set.setPoliceEmergentFowShow(getI18nText("i18n_DataDictionaryAction.queryDictionary.nonEmergent_n81i"));
					}
				}
			}
		} catch (Exception e) {
			logger.error("Query monitoring data list filter condition failed",e);
			this.outHtmlString("<script>alert('i18n_DataDictionaryAction.queryDictionary.selectDetecateDataListErr_n81i！');this.location='dataDictionary.do?action=queryDetectConditionSet;</script>");
			return null;
		}
		return "queryDeteDataConSet";
	}
	
	
	public void checkDictionary(){
		List list = null;
		try {
			list = this.commonService.find("from TypeTable where typeName=?",typeTable.getTypeName());
			if(list!=null && list.size()>0){
				this.outString("error1");
				return ;
			}
			list = this.commonService.find("from TypeTable where typeIdentity=?",typeTable.getTypeIdentity());
			if(list!=null && list.size()>0){
				this.outString("error2");
				return ;
			}
		} catch (Exception e) {
			e.printStackTrace();
			this.outString("exception");
			logger.info("新增数据字典校验异常",e);
		}
		this.outString("success");
	}
	
	public void addData(){
		//List list = null;
		try {
			//判断数据是否存在
			/*list = this.commonService.find("from TypeTable where typeName=?",typeTable.getTypeName());
			if(list!=null && list.size()>0){
				this.outHtmlString("<script>alert('记录已存在，请重新输入！');history.back();</script>");
				return;
			}*/
			//判断字典标识是否存在
			/*list = this.commonService.find("from TypeTable where typeIdentity=?",typeTable.getTypeIdentity());
			if(list!=null && list.size()>0){
				this.outHtmlString("<script>alert('字典标识已存在，请重新输入！');history.back();</script>");
				return;
			}*/
			typeTable.setTypeState(0l);
			this.commonService.save(typeTable);
			outHtmlString("<script type=\"text/javascript\">alert('i18n_DataDictionaryAction.queryDictionary.success_n81i');this.location='dataDictionary.do?action=query&pageNo="+pageNo+"&pageSize="+pageSize+"'</script>");
		} catch (Exception e) {
			logger.error("Failed to add data dictionary",e);
			this.outHtmlString("<script>alert('i18n_DataDictionaryAction.queryDictionary.addDictErr_n81i！');history.back();</script>");
			return;
		}
	}
	
	public String openUpdDD(){
		try {
			if(ddid!=null && !"".equals(ddid)){
				List list = this.commonService.find(
						"from TypeTable where id=?", Long.parseLong(ddid));
				if(list!=null && list.size()>0){
					typeTable = (TypeTable)list.get(0);
				}
			}
		} catch (Exception e) {
			logger.error("Open modified page failed",e);
			this.outHtmlString("<script>alert('i18n_DataDictionaryAction.queryDictionary.openUpdateViewErr_n81i！');history.back();</script>");
			return null;
		}
		return "updateDictionaryInfo";
	}
	
	public String toUpdateDetectConditionSet(){
		try {
			if(StringUtils.isNotBlank(setId)){
				List list = this.commonService.find(
						"from SetDetDataCon where id=?", Long.parseLong(setId));
				if(list!=null && list.size()>0){
					detDataConSet = (SetDetDataCon)list.get(0);
					String level = detDataConSet.getPoliceLevel();
					String emergent = detDataConSet.getPoliceEmergent();
					String levelForShow = ",";
					String emergentForShow = ",";
					if(StringUtils.isNotBlank(level)) {
						String[] levelArray = level.split(",");
						for(String levelTmp:levelArray) {
							if(StringUtils.isNotBlank(levelTmp)) {
								levelForShow = levelForShow + levelTmp.trim() + ","; 
							}
						}
						detDataConSet.setPoliceLevel(levelForShow);
					}
					if(StringUtils.isNotBlank(emergent)) {
						String[] emergentArray = emergent.split(",");
						for(String emergentTmp:emergentArray) {
							if(StringUtils.isNotBlank(emergentTmp)) {
								emergentForShow = emergentForShow + emergentTmp.trim() + ","; 
							}
						}
						detDataConSet.setPoliceEmergent(emergentForShow);
					}
				}
			}
		} catch (Exception e) {
			logger.error("Open modified page failed",e);
			this.outHtmlString("<script>alert('i18n_DataDictionaryAction.queryDictionary.openUpdateViewErr_n81i！');history.back();</script>");
			return null;
		}
		return "updateDetDataConSet";
	}
	
	public String openUpdDDS(){
		try {
			if(optionId!=null && !"".equals(optionId)){
				List list = this.commonService.find(
						"from OptionTable where id=?", Long.parseLong(optionId));
				if(list!=null && list.size()>0){
					optionTable = (OptionTable)list.get(0);
				}
			}
		} catch (Exception e) {
			logger.error("Open modify source data page failed",e);
			this.outHtmlString("<script>alert('i18n_DataDictionaryAction.queryDictionary.openUpdateSourceViewErr_n81i！');history.back();</script>");
			return null;
		}
		return "updDictionarySource";
	}

	public void updateCheck(){
		List list;
		try {
			list = this.commonService.find("from TypeTable where typeName='"+typeTable.getTypeName()+"' and id <> "+typeTable.getId());
			if (list != null && list.size() > 0) {
				this.outString("error");
				return ;
			}
		} catch (Exception e) {
			e.printStackTrace();
			this.outString("exception");
			logger.info("更新数据字典校验异常",e);
		}
		this.outString("success");
	}
	
	public void doUpdData(){
		try {
			commonService.beginTransaction();
			TypeTable nbt = (TypeTable) this.commonService.get(
					TypeTable.class, typeTable.getId());
			nbt.setShowNum(typeTable.getShowNum());
			nbt.setTypeName(typeTable.getTypeName());
			nbt.setTypeDesc(typeTable.getTypeDesc());
			Long oldState = nbt.getTypeState();
			nbt.setTypeState(typeTable.getTypeState());
			this.commonService.update(nbt);
			//2018-08-30如果是email，需要修改session中的emailflag
			if(nbt.getTypeIdentity()!=null&&nbt.getTypeIdentity().equals("emailflag")){
				this.getRequest().getSession().setAttribute(Constant.EMAIL_FLAG	, nbt.getTypeState());
			}
			
			//2018-09-19如果是dept，需要修改session中的deptflag，并将更新菜单 部门管理显示状态
			if(nbt.getTypeIdentity()!=null&&nbt.getTypeIdentity().equals("deptflag")){
				Long deptflag = nbt.getTypeState();
				this.getRequest().getSession().setAttribute(Constant.DEPT_FLAG, deptflag);
				String sql="update xt_mk_jbxx set zxbz=? where id=?";
				this.commonService.updateBySql(sql, deptflag,Constants.DEPT_MK_ID);
			}
			
			//改变是否显示主动告警的启用状态时，需要和各个nc通信：SHOW_AUTO_ALARM_FLAG
			if(nbt.getTypeIdentity().toLowerCase().equals(Constants.SHOW_AUTO_ALARM_FLAG.toLowerCase())
					&& typeTable.getTypeState()!=oldState) {
				// 用来实现即时向客户端发送：节点是否报主动报警（给DC发送信息，通知各个ＮＣ）:默认不报主动告警
				boolean startActiveAlarm = (typeTable.getTypeState()==null || typeTable.getTypeState()==1 )? false : true;
				logger.info("NC端是否报主动告警："+startActiveAlarm);
				sendStartActiveAlarmState(startActiveAlarm, commonService);
			}
			
			outHtmlString("<script type=\"text/javascript\">alert('i18n_DataDictionaryAction.queryDictionary.success_n81i');this.location='dataDictionary.do?action=query&pageNo="+pageNo+"&pageSize="+pageSize+"'</script>");
			commonService.commit();
		} catch (Exception e) {
			commonService.rollback();
			logger.error("Update failed",e);
			this.outHtmlString("<script>alert('i18n_DataDictionaryAction.queryDictionary.updateErr_n81i！');history.back();</script>");
			return;
		}
	}
	
	public void updateDetectConditionSet(){
		try {
			SetDetDataCon set = (SetDetDataCon) this.commonService.get(  
					SetDetDataCon.class, detDataConSet.getId());
			//根据多选组合值？？？？？？？
			String level = detDataConSet.getPoliceLevel();
			String emergent = detDataConSet.getPoliceEmergent();
			String levelForDB = "";
			String emergentForDB = "";
			
			if(StringUtils.isNotBlank(emergent)) {
				emergentForDB = ",";
				String[] emergentArray = emergent.split(",");
				for(String emergentTmp:emergentArray) {
					if(StringUtils.isNotBlank(emergentTmp)) {
						emergentForDB = emergentForDB + emergentTmp.trim() + ","; 
					}
				}
			}
			
			if(emergentForDB.contains(",1,") && StringUtils.isNotBlank(level) ) {//选择了非紧急，才有级别
				levelForDB = ",";
				String[] levelArray = level.split(",");
				for(String levelTmp:levelArray) {
					if(StringUtils.isNotBlank(levelTmp)) {
						levelForDB = levelForDB + levelTmp.trim() + ","; 
					}
				}
			}
			
			set.setPoliceEmergent(emergentForDB);
			set.setPoliceLevel(levelForDB);			
			
			this.commonService.update(set);
			outHtmlString("<script type=\"text/javascript\">alert('i18n_DataDictionaryAction.queryDictionary.success_n81i');this.location='dataDictionary.do?action=queryDetectConditionSet&pageNo="+pageNo+"&pageSize="+pageSize+"'</script>");
		} catch (Exception e) {
			logger.error("Update failed",e);
			this.outHtmlString("<script>alert('i18n_DataDictionaryAction.queryDictionary.updateErr_n81i！');this.location='dataDictionary.do?action=queryDetectConditionSet;</script>");
			return;
		}
	}
	
	public void updateSourceCheck(){
		List list;
		try {
			list = this.commonService.find("from OptionTable where (typeValue='"+optionTable.getTypeValue()+"' or typeCode='"+optionTable.getTypeCode()+"') and id <> "+optionTable.getId()+" and typeIdentity ='"+ddid+"'");
			if (list != null && list.size() > 0) {
				this.outString("error");
				return ;
			}
		} catch (Exception e) {
			e.printStackTrace();
			this.outString("exception");
			logger.info("更新数据字典校验异常",e);
		}
		this.outString("success");
	}
	
	public void doUpdDataSource(){
		try {
			/*List list = this.commonService.find("from OptionTable where typeCode='"+optionTable.getTypeCode()+"' and id <> "+optionTable.getId()+" and typeIdentity ='"+ddid+"'");
			if (list != null && list.size() > 0) {
				this.outHtmlString("<script>alert('记录已存在，请重新输入！');history.back();</script>");
				return;
			}*/
			
			OptionTable nbt = (OptionTable) this.commonService.get(
					OptionTable.class, optionTable.getId());
			nbt.setShowNum(optionTable.getShowNum());
			nbt.setTypeCode(optionTable.getTypeCode());
			nbt.setTypeValue(optionTable.getTypeValue());
			nbt.setTypeState(optionTable.getTypeState());
			nbt.setTypeIdentity(ddid);
			if(optionTable.getDelayTime()==null||optionTable.getDelayTime().equals("")){
				optionTable.setDelayTime("0");
			}
			nbt.setDelayTime(optionTable.getDelayTime());
			this.commonService.update(nbt);
			outHtmlString("<script type=\"text/javascript\">alert('i18n_DataDictionaryAction.queryDictionary.success_n81i');this.location='dataDictionary.do?action=querySouce&ddid="+ddid+"&did="+did+"&pageNo="+pageNo+"&pageSize="+pageSize+"'</script>");
		} catch (Exception e) {
			logger.error("Update failed",e);
			this.outHtmlString("<script>alert('i18n_DataDictionaryAction.queryDictionary.updateErr_n81i！');history.back();</script>");
			return;
		}
	}
	
	public String queryDictionarySouce(){
		try {
			if(ddid!=null){
				String hql="from OptionTable where typeIdentity='"+ddid+"' order by showNum asc";
				page = this.commonService.findByPage(hql, pageNo, pageSize);
				optionTableist = (List<OptionTable>)page.getResult();
			}
		} catch (Exception e) {
			logger.error("Query data dictionary source data information failed",e);
			this.outHtmlString("<script>alert('i18n_DataDictionaryAction.queryDictionary.queryDictSourceInfoErr_n81i');history.back();</script>");
			return null;
		}
		return "queryDictionarySource";
	}
	
	public void getTypeTableById(){
		try {
			if(did!=null){
				List list = this.commonService.find(
						"from TypeTable where id="+did);
				if(list!=null && list.size()>0){
					typeTable = (TypeTable)list.get(0);
				}
			}
		} catch (Exception e) {
			logger.error("Fetching category dictionary failed",e);
		}
	}
	
	public void checkAjax(){
		List list = null;
		try {
			list = this.commonService.find("from OptionTable where (typeCode=? or typeValue=?) and typeIdentity=?",optionTable.getTypeCode(),optionTable.getTypeValue(),ddid);
			if(list!=null && list.size()>0){
				this.outString("error");
				return ;
			}
		} catch (Exception e) {
			e.printStackTrace();
			this.outString("exception");
			logger.info("新增数据字典校验异常",e);
		}
		this.outString("success");
	}
	
	public void addDataSource(){
	//	List list = null;
		try {
			//判断数据是否存在
			/*list = this.commonService.find("from OptionTable where typeCode=? and typeIdentity=?",optionTable.getTypeCode(),ddid);
			if(list!=null && list.size()>0){
				this.outHtmlString("<script>alert('记录已存在，请重新输入！');history.back();</script>");
				return;
			}*/
			optionTable.setTypeState(0l);
			optionTable.setTypeIdentity(ddid);
			if(optionTable.getDelayTime()==null||optionTable.getDelayTime().equals("")){
				optionTable.setDelayTime("0");
			}
			this.commonService.save(optionTable);
			outHtmlString("<script type=\"text/javascript\">alert('i18n_DataDictionaryAction.queryDictionary.success_n81i');this.location='dataDictionary.do?action=querySouce&ddid="+ddid+"&did="+did+"&pageNo="+pageNo+"&pageSize="+pageSize+"'</script>");
		} catch (Exception e) {
			logger.error("Failed to add data dictionary source data",e);
			this.outHtmlString("<script>alert('i18n_DataDictionaryAction.queryDictionary.addDictSourceErr_n81i！');history.back();</script>");
			return;
		}
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

	public List<TypeTable> getTypeTableList() {
		return typeTableList;
	}

	public void setTypeTableList(List<TypeTable> typeTableList) {
		this.typeTableList = typeTableList;
	}

	public TypeTable getTypeTable() {
		return typeTable;
	}

	public void setTypeTable(TypeTable typeTable) {
		this.typeTable = typeTable;
	}

	public String getDdid() {
		return ddid;
	}

	public void setDdid(String ddid) {
		this.ddid = ddid;
	}

	public Long getDid() {
		return did;
	}

	public void setDid(Long did) {
		this.did = did;
	}
	public List<OptionTable> getOptionTableist() {
		return optionTableist;
	}

	public void setOptionTableist(List<OptionTable> optionTableist) {
		this.optionTableist = optionTableist;
	}

	public OptionTable getOptionTable() {
		return optionTable;
	}

	public void setOptionTable(OptionTable optionTable) {
		this.optionTable = optionTable;
	}

	public String getOptionId() {
		return optionId;
	}

	public void setOptionId(String optionId) {
		this.optionId = optionId;
	}

	public Long getDidd() {
		return didd;
	}

	public void setDidd(Long didd) {
		this.didd = didd;
	}

	
	public List<SetDetDataCon> getSetDetDataConList()
	{
		return setDetDataConList;
	}

	
	public void setSetDetDataConList(List<SetDetDataCon> setDetDataConList)
	{
		this.setDetDataConList = setDetDataConList;
	}

	
	public String getSetId()
	{
		return setId;
	}

	
	public void setSetId(String setId)
	{
		this.setId = setId;
	}

	
	public SetDetDataCon getDetDataConSet()
	{
		return detDataConSet;
	}

	
	public void setDetDataConSet(SetDetDataCon detDataConSet)
	{
		this.detDataConSet = detDataConSet;
	}
	
	/**
	 * Parameter ddid 父级数据字典标识<br>
	 * Parameter nameLike 字典数据类型名称<br>
	 * 
	 * @return 字典数据类型代码
	 */
	public String querySouceForAjax() {
		String ddid = this.getRequest().getParameter("ddid").trim();
		String nameLike = this.getRequest().getParameter("nameLike").trim();
		try {
			String sql = "select o.type_code from type_table t, option_table o"
				+ " where t.type_identity = '" + ddid + "'"
				+ " and t.type_state = 0"
				+ " and t.type_identity = o.type_identity"
				+ " and o.type_state = 0"
				+ " and o.type_value like '%" + nameLike + "%'"
				+ " order by o.show_num";

			List<Object> list = this.commonService.createSQLQuery(sql).list();
			
			StringBuffer sb = new StringBuffer();
			if(!com.nis.util.StringUtil.isEmpty(list)){
				for (Object node : list) {
					sb.append(node).append(",");
				}
				sb.delete(sb.length()-1, sb.length());
			}
			
			this.getResponse().getWriter().write(sb.toString());
			this.getResponse().getWriter().close();
		}
		catch (IOException e) {
			logger.error("获取配置参数失败！", e);
		}
		return null;
	}
}
