package nis.nms.web.actions.detection;

import java.util.List;

import nis.nms.domains.CheckTypeInfo;
import nis.nms.domains.DataPoliceRelation;
import nis.nms.domains.DetectionSetInfo;
import nis.nms.domains.Metadata;
import nis.nms.domains.OptionTable;
import nis.nms.service.CommonService;
import nis.nms.util.BaseAction;
import nis.nms.util.Page;

import org.apache.log4j.Logger;
import org.apache.struts2.config.Result;
import org.apache.struts2.config.Results;


@SuppressWarnings("unchecked")
@Results( {
		@Result(name = "queryPoliceRelationInfo", value = "/page/detection/policeRelation/policeRelationList.jsp"),
		@Result(name = "addPoliceRelation", value = "/page/detection/policeRelation/addPoliceRelation.jsp"),
		@Result(name = "updatePoliceRelation", value = "/page/detection/policeRelation/updatePoliceRelation.jsp"),
		@Result(name = "error", value = "/error.jsp") })
/**
 *  报警设置相关操作
 */
public class PoliceSetAction extends BaseAction {
	private Logger logger = Logger.getLogger(PoliceSetAction.class);
	private static final long serialVersionUID = 1L;
	private CommonService commonService;
	private int pageNo = 1;
	private int pageSize = this.getDefaultPageSize(); // 每页显示的记录条数
	private Page page;
	private String action;
	private List<DataPoliceRelation> dataPoliceRelationList;
	private DataPoliceRelation dataPoliceRelation;
	private Metadata metadata;
	private List<Metadata> allMetadata;
	private List<OptionTable> allpoliceEmergent;
	private List<CheckTypeInfo> allCheckTypeInfo;
	private Long[] ids;
	private Long setId;
	private String ctn;
	private String pIden;
	private String ip;
	private CheckTypeInfo checkTypeInfo;
	private DetectionSetInfo detectionSetInfo;
	private String detectionSetInfoId;
	private String policeRelationId;
	
	
	public String getPIden() {
		return pIden;
	}

	public void setPIden(String iden) {
		pIden = iden;
	}

	public String getIp() {
		return ip;
	}

	public void setIp(String ip) {
		this.ip = ip;
	}

	public String getDetectionSetInfoId() {
		return detectionSetInfoId;
	}

	public void setDetectionSetInfoId(String detectionSetInfoId) {
		this.detectionSetInfoId = detectionSetInfoId;
	}

	public String getCtn() {
		return ctn;
	}

	public void setCtn(String ctn) {
		this.ctn = ctn;
	}

	public String getpIden() {
		return pIden;
	}

	public void setpIden(String pIden) {
		this.pIden = pIden;
	}

	@Override
	public String executeAction() throws Exception {
		String resultpage = "";
		if ("query".equals(this.action)) {
			queryCheckTypeInfo();
			resultpage = this.queryPoliceSetInfo();
		} else if ("openAdd".equals(this.action)) {
			this.getDetectionSetInfoAndMetadata();
			resultpage = "addPoliceRelation";
		} else if ("doAdd".equals(this.action)) {
			addPoliceSetInfo();
			return null;
		} else if ("openUpdate".equals(this.action)) {
			this.getDetectionSetInfoAndMetadata();
			resultpage = this.openUpdatePoliceSet();
		} else if ("doUpdate".equals(this.action)) {
			doUpdatePoliceSet();
			return null;
		} else {
			resultpage = this.queryPoliceSetInfo();
		}
		return resultpage;
	}

	public String queryPoliceSetInfo() {
		try {
				String operator="all";// 用于判断查询设置告警是从监测设置告警页面进入还是监测配置下进入    从监测设置告警页面进入值为all查询所有告警  监测配置下进入只查询当前监测的告警
				String hql = "from DataPoliceRelation where 1=1";
				if (setId != null && !"".equals(setId)) {
					operator = "";
					hql +=" and detectionSetInfo.id="+ setId;
				}
				if (ctn != null && !"".equals(ctn)) {
					hql +=" and detectionSetInfo.checkTypeInfo.id = " + ctn;
				}

				if (pIden != null && !"".equals(pIden)) {
					hql +=" and Upper(detectionSetInfo.processIdenName) like '%" + pIden.trim().toUpperCase() + "%'";
				}
				
				if (this.getAdminMark()) {// 如果是admin登陆则无限制
					hql +=" and detectionSetInfo.checkTypeInfo.isSchedule<>2";
				} else {
					//使用监测设置权限
					hql +=" and detectionSetInfo.checkTypeInfo.isSchedule<>2 and (( detectionSetInfo.viewLevel=1 and detectionSetInfo.createUserId=";
					hql +=this.getUserID();
					hql +=" and detectionSetInfo.systemId ="+this.getSystemID()+")";
					hql +=" or ( detectionSetInfo.viewLevel=2 and detectionSetInfo.createUserGroupId in (select  x.jsbh from  XtYhJsIndex  x  where x.yhbh='";
					hql +=this.getUser().getYhbh();
					hql +="' and x.type = 1) and detectionSetInfo.systemId = "+this.getSystemID()+") or (detectionSetInfo.viewLevel=3 and detectionSetInfo.systemId = "+this.getSystemID()+")";
					//hql +=" or (detectionSetInfo.viewLevel=4 )";
					hql +=") ";
				}
				
				hql +="order by policeState asc";
				page = this.commonService.findByPage(hql, pageNo, pageSize);
				dataPoliceRelationList = (List<DataPoliceRelation>) page
						.getResult();
				
				getRequest().setAttribute("operator", operator);
		} catch (Exception e) {
			logger.error(e.getStackTrace());
			e.printStackTrace();
			outHtmlString("<script type=\"text/javascript\">alert('i18n_PoliceSetAction.queryPoliceSetInfo.faild_n81i');this.location='detectionSet.do?action=query'</script>");
		}

		return "queryPoliceRelationInfo";

	}
	
	private void queryCheckTypeInfo() throws Exception {		
		try {
			StringBuffer hql = new StringBuffer();
			if (this.getAdminMark()) {// 如果是admin登陆则无限制
				hql.append("from CheckTypeInfo where isSchedule<>2 ");
			} else {
				//权限控制--------begin
				hql.append("from CheckTypeInfo t where isSchedule<>2 and (( t.viewLevel=1 and t.userId=");
				hql.append(this.getUserID());
				hql.append(" and t.systemId ="+this.getSystemID()+")");
				hql.append(" or ( t.viewLevel=2 and t.groupId in (select  x.jsbh from  XtYhJsIndex  x  where x.yhbh='");
				hql.append(this.getUser().getYhbh());
				hql.append("' and x.type = 1) and t.systemId = "+this.getSystemID()+") or (t.viewLevel=3 and t.systemId = "+this.getSystemID()+")");
				hql.append(" or (t.viewLevel=4 )");
				hql.append(") ");
				//----------------end
			}
			hql.append(" and creteState = 0 order by decode(isSchedule,0,0,2,0,1,1,2) asc ,decode(isSnmp,2,0,null,0,1) asc, ID asc");
			allCheckTypeInfo = this.commonService.find(hql.toString());
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(e.getStackTrace());
		}
	}

	public void getDetectionSetInfoAndMetadata()throws Exception {
		try {
			if (setId != null && !"".equals(setId)) {
				List list = this.commonService.find(
						"from DetectionSetInfo where id=?", setId);
				if (list != null && list.size() > 0) {
					detectionSetInfo = (DetectionSetInfo) list.get(0);
					allMetadata = this.commonService.find(
							"from Metadata where checkTypeInfo.id=?",
							detectionSetInfo.getCheckTypeInfo().getId());
					allpoliceEmergent = this.commonService.find(
							"from OptionTable where typeIdentity='emergent'");;
				}
			} else if (ids != null && !"".equals(ids)) {
				List<DataPoliceRelation> datapolicerelationList = this.commonService
						.find("from DataPoliceRelation where id = ?", ids[0]);
				if (datapolicerelationList != null
						&& datapolicerelationList.size() > 0) {
					long setId = datapolicerelationList.get(0)
							.getDetectionSetInfo().getId();

					List list = this.commonService.find(
							"from DetectionSetInfo where id=?", setId);
					if (list != null && list.size() > 0) {
						detectionSetInfo = (DetectionSetInfo) list.get(0);
						allMetadata = this.commonService.find(
								"from Metadata where checkTypeInfo.id=?",
								detectionSetInfo.getCheckTypeInfo().getId());
						allpoliceEmergent = this.commonService
								.find("from OptionTable where typeIdentity='emergent'");
					}
				}
			}
		} catch (Exception e) {
			logger.error(e.getStackTrace());
			e.printStackTrace();
		}
	}

	// 新增
	public void addPoliceSetInfo() throws Exception{
		DetectionSetInfo dsi = null;
		try {
			commonService.beginTransaction();
			String sql = "select count(*) from data_police_relation t where DETECTION_SET_INFO_ID ="
					+ setId
					+ " and METADATA_ID ="
					+ dataPoliceRelation.getMetadata().getId();
			List list = this.commonService.executeSQL(sql);
			int num = Integer.parseInt(list.get(0).toString());
			if (num > 0) {
				this.outHtmlString("<script>alert('i18n_PoliceSetAction.queryPoliceSetInfo.recordExists_n81i');this.location='policeSet.do?action=query&pIden="+pIden+"&ctn="+ctn+"&ip="+ip+"&pageNo="+pageNo+"&pageSize="+pageSize+"&setId="+setId+"'</script>");
				return;
			}

			Metadata metadata = (Metadata) this.commonService.get(
					Metadata.class, dataPoliceRelation.getMetadata().getId());
			dsi = (DetectionSetInfo) this.commonService.get(DetectionSetInfo.class, setId);
			dataPoliceRelation.setMetadata(metadata);
			dataPoliceRelation.setDetectionSetInfo(dsi);
			this.commonService.save(dataPoliceRelation);
			// 将更新操作写到操作日志中
			this.addDBOperationRpt(commonService,"data_police_relation", "INSERT", dataPoliceRelation.getId());
			commonService.commit();
		    outHtmlString("<script type=\"text/javascript\">alert('i18n_PoliceSetAction.queryPoliceSetInfo.success_n81i');this.location='policeSet.do?action=query&pIden="+pIden+"&ctn="+ctn+"&ip="+ip+"&pageNo="+pageNo+"&pageSize="+pageSize+"&setId="+setId+"'</script>");
		} catch (Exception e) {
			commonService.rollback();
			e.printStackTrace();
			logger.error(e.getStackTrace());
			outHtmlString("<script type=\"text/javascript\">alert('i18n_PoliceSetAction.queryPoliceSetInfo.faild_n81i');this.location='policeSet.do?action=query&pIden="+pIden+"&ctn="+ctn+"&ip="+ip+"&pageNo="+pageNo+"&pageSize="+pageSize+"&setId="+setId+"'</script>");
		}
		sendSetInfo(null,dsi,commonService);
	}

	public String openUpdatePoliceSet() {
		try {
			if (ids != null && ids.length > 0) {
				policeRelationId=String.valueOf(ids[0]);
				List list = this.commonService.find(
						"from DataPoliceRelation where id=?", ids[0]);
				if (list != null && list.size() > 0) {
					dataPoliceRelation = (DataPoliceRelation) list.get(0);
				}
			}
		} catch (Exception e) {
			logger.error(e.getStackTrace());
			e.printStackTrace();
			outHtmlString("<script type=\"text/javascript\">alert('i18n_PoliceSetAction.queryPoliceSetInfo.faild_n81i');this.location='detectionSet.do?action=query'</script>");
		}
		return "updatePoliceRelation";
	}

	public void doUpdatePoliceSet() throws Exception{
		try {
			commonService.beginTransaction();
			List list = this.commonService
					.find(
							"from DataPoliceRelation where detectionSetInfo.id=? and metadata.id=? and id<>?",
							Long.valueOf(detectionSetInfoId), dataPoliceRelation.getMetadata().getId(), dataPoliceRelation
									.getId());
			if (list != null && list.size() > 0) {
				this.outHtmlString("<script>alert('i18n_PoliceSetAction.queryPoliceSetInfo.recordExists_n81i');this.location='policeSet.do?action=openUpdate&ids="+policeRelationId+"&detectionSetInfoId="+detectionSetInfoId+"'</script>");
				return;
			}
			DataPoliceRelation dpRelation = (DataPoliceRelation) this.commonService
					.get(DataPoliceRelation.class, dataPoliceRelation.getId());
			DetectionSetInfo ds = null;
			if(null!=detectionSetInfoId&&!detectionSetInfoId.equals("")){
				ds = (DetectionSetInfo) this.commonService.get(
						DetectionSetInfo.class, Long.parseLong(detectionSetInfoId.trim()));
			}else{
				ds = (DetectionSetInfo) this.commonService.get(
						DetectionSetInfo.class, setId);
			}
			Metadata me = (Metadata) this.commonService.get(Metadata.class,
					dataPoliceRelation.getMetadata().getId());
			dpRelation.setPoliceState(dataPoliceRelation.getPoliceState());
			dpRelation.setPoliceLevel(dataPoliceRelation.getPoliceLevel());
			dpRelation.setPoliceValue(dataPoliceRelation.getPoliceValue());
			dpRelation.setPoliceUnit(dataPoliceRelation.getPoliceUnit());
			dpRelation.setPoliceSymbols(dataPoliceRelation.getPoliceSymbols());
			dpRelation.setDetectionSetInfo(ds);
			dpRelation.setPoliceShowInfo(dataPoliceRelation.getPoliceShowInfo());
			dpRelation.setMetadata(me);
			dpRelation.setPoliceEmergent(dataPoliceRelation.getPoliceEmergent());
			dpRelation.setMarker(dataPoliceRelation.getMarker());
			dpRelation.setMarkerFiledId(dataPoliceRelation.getMarkerFiledId());
			this.commonService.update(dpRelation);
			commonService.commit();
			// 将更新操作写到操作日志中
			this.addDBOperationRpt(commonService,"data_police_relation", "UPDATE", dpRelation.getId());
			sendSetInfo(null,ds,commonService);
			String setIdStr = "";
			if(setId != null){
				setIdStr = "&setId="+setId;
			}
			
			String str = "<script type=\"text/javascript\">alert('i18n_PoliceSetAction.queryPoliceSetInfo.success_n81i');this.location='policeSet.do?action=query&pIden="+pIden+"&ctn="+ctn+"&ip="+ip+"&pageNo="+pageNo+"&pageSize="+pageSize+setIdStr+"'</script>";
			outHtmlString(str);
		} catch (Exception e) {
			commonService.rollback();
			e.printStackTrace();
			logger.error(e.getStackTrace());
			String setIdStr = "";
			if(setId != null){
				setIdStr = "&setId="+setId;
			}
			String str = "<script type=\"text/javascript\">alert('i18n_PoliceSetAction.queryPoliceSetInfo.faild_n81i');this.location='policeSet.do?action=query&pIden="+pIden+"&ctn="+ctn+"&ip="+ip+"&pageNo="+pageNo+"&pageSize="+pageSize+setIdStr+"'</script>";
			outHtmlString(str);
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

	public List<CheckTypeInfo> getAllCheckTypeInfo() {
		return allCheckTypeInfo;
	}

	public void setAllCheckTypeInfo(List<CheckTypeInfo> allCheckTypeInfo) {
		this.allCheckTypeInfo = allCheckTypeInfo;
	}

	public Long[] getIds() {
		return ids;
	}

	public List<Metadata> getAllMetadata() {
		return allMetadata;
	}

	public List<OptionTable> getAllpoliceEmergent() {
		return allpoliceEmergent;
	}

	public void setAllpoliceEmergent(List<OptionTable> allpoliceEmergent) {
		this.allpoliceEmergent = allpoliceEmergent;
	}

	public void setAllMetadata(List<Metadata> allMetadata) {
		this.allMetadata = allMetadata;
	}

	public DetectionSetInfo getDetectionSetInfo() {
		return detectionSetInfo;
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

	public List<DataPoliceRelation> getDataPoliceRelationList() {
		return dataPoliceRelationList;
	}

	public void setDataPoliceRelationList(
			List<DataPoliceRelation> dataPoliceRelationList) {
		this.dataPoliceRelationList = dataPoliceRelationList;
	}

	public DataPoliceRelation getDataPoliceRelation() {
		return dataPoliceRelation;
	}

	public void setDataPoliceRelation(DataPoliceRelation dataPoliceRelation) {
		this.dataPoliceRelation = dataPoliceRelation;
	}

	public void setDetectionSetInfo(DetectionSetInfo detectionSetInfo) {
		this.detectionSetInfo = detectionSetInfo;
	}

	public Long getSetId() {
		return setId;
	}

	public void setSetId(Long setId) {
		this.setId = setId;
	}

	public Logger getLogger() {
		return logger;
	}

	public void setLogger(Logger logger) {
		this.logger = logger;
	}

	public String getPoliceRelationId() {
		return policeRelationId;
	}

	public void setPoliceRelationId(String policeRelationId) {
		this.policeRelationId = policeRelationId;
	}

}
