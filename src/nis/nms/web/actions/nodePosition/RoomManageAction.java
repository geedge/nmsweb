package nis.nms.web.actions.nodePosition;                        
import java.io.File;
import java.io.FileInputStream;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;

import nis.nms.domains.NodeRoomLatticeTable;
import nis.nms.domains.NodeRoomTable;
import nis.nms.service.CommonService;
import nis.nms.util.BaseAction;
import nis.nms.util.Constant;
import nis.nms.util.ExportUtils;
import nis.nms.util.Page;

import org.apache.log4j.Logger;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.apache.struts2.config.Result;
import org.apache.struts2.config.Results;


@SuppressWarnings("unchecked")
@Results( { 
	@Result(name="queryRoomInfo", value = "/page/show/nodeRoom/roomInfoList.jsp"),
	@Result(name="addRoomInfo", value = "/page/show/nodeRoom/addRoomInfo.jsp"),
	@Result(name="updateRoomInfo", value = "/page/show/nodeRoom/updateRoomInfo.jsp"),
	@Result(name = "showError", value = "/showImportError.jsp"),
	@Result(name="error", value ="/error.jsp")
})

/**
 * 机房管理相关操作
 */
public class RoomManageAction extends BaseAction {
	private Logger logger = Logger.getLogger(RoomManageAction.class);
	private static final long serialVersionUID = 1L;
	private CommonService commonService;
	private int pageNo = 1;
	private int pageSize =this.getDefaultPageSize();		//每页显示的记录条数
	private Page page;
	private String action;
	private List<NodeRoomTable> nodeRoomList;
	private NodeRoomTable nodeRoom;
	private Long[] ids;
	private String rIspn;
	private String descinfo;
	
	private String fromWhere;
	private String isComplete;

	// 导入节点文件
	private File myFile;
	private String myFileFileName;

	private String roomid;
	
	private String roomIspn;
	
	
	
	public String getRoomid() {
		return roomid;
	}

	public void setRoomid(String roomid) {
		this.roomid = roomid;
	}

	public String getRoomIspn() {
		return roomIspn;
	}

	public void setRoomIspn(String roomIspn) {
		this.roomIspn = roomIspn;
	}

	public File getMyFile() {
		return myFile;
	}

	public void setMyFile(File myFile) {
		this.myFile = myFile;
	}

	public String getMyFileFileName() {
		return myFileFileName;
	}

	public void setMyFileFileName(String myFileFileName) {
		this.myFileFileName = myFileFileName;
	}

	@Override
	public String executeAction() throws Exception {
		try{
			String resultpage = "";
			this.getRequest().setAttribute("fromWhere", fromWhere);
			if("query".equals(this.action)){
				resultpage = this.queryRoomInfo();
			}else if("openAdd".equals(this.action)){
				this.getRequest().setAttribute("fromWhere", fromWhere);
				this.getRequest().setAttribute("maxRoomRows", Constant.MAX_ROOM_ROWS);
				this.getRequest().setAttribute("maxRoomCols", Constant.MAX_ROOM_Cols);
				resultpage = "addRoomInfo";
			}else if("doAdd".equals(this.action)){
				resultpage = this.addRoomInfo();
			}else if("openUpdate".equals(this.action)){
				this.getRequest().setAttribute("maxRoomRows", Constant.MAX_ROOM_ROWS);
				this.getRequest().setAttribute("maxRoomCols", Constant.MAX_ROOM_Cols);
				resultpage = this.openUpdRoom();
			}else if("doUpdate".equals(this.action)){
				this.doUpdRoom();
			}else if("del".equals(this.action)){
				resultpage = this.delRoomInfo();
			}else if ("downloadExample".equals(this.action)) {
				resultpage = downloadExample();
			}else if ("importXls".equals(this.action)) {
				resultpage = importXls();
			}else if ("emportCurrentXls".equals(this.action)) {
				resultpage = emportCurrentXls();
			}else if ("emportAllXls".equals(this.action)) {
				resultpage = emportAllXls();
			}else if("AjaxCheck".equals(this.action)){
				ajaxCheck();
				resultpage = null;
			}else if("roomManagerCheck".equals(this.action)){
				roomManagerCheck();
				return null;
			}else{
				resultpage = this.queryRoomInfo();
			}
			return resultpage;
		} catch (Exception e) {
			e.printStackTrace();
			return "error";
		}
		
	}
	

	// 模板下载   程辉 2013-5-13新增
	public String downloadExample() {
		try {
			String hql = "select roomIspn,roomRows,roomCols,roomDesc from NodeRoomTable";
			page = this.commonService.findByPage(hql, 1, 3);
			List st = (List) page.getResult();
			
			String[] title = { getI18nText("i18n_RoomManageAction.downloadExample.title.roomId_n81i"), 
								getI18nText("i18n_RoomManageAction.downloadExample.title.roomRows_n81i"),
								getI18nText("i18n_RoomManageAction.downloadExample.title.roomColumns_n81i"),
								getI18nText("i18n_RoomManageAction.downloadExample.title.rootDesc_n81i") };
	
			String[] colu = { "0", "1","2","3" };
			ExportUtils m = new ExportUtils();
			m.setAutoSizeColumn(true);
			m.exportExcel(getI18nText("i18n_RoomManageAction.downloadExample.roomInfoTable_n81i"), st, title, colu,"downloadExample");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	// 导入 程辉 2013-5-8新增
	public String importXls() {
		String errorInfo = "";
		try {
			List<String> headerList = new ArrayList<String>();
			List<List<String>> rowList = new ArrayList<List<String>>();

			Workbook workbook = null;
			if (myFileFileName.endsWith(".xlsx")) {
				workbook = new XSSFWorkbook(new FileInputStream(myFile));
			} else {
				// 创建对Excel工作簿文件的引用
				workbook = new HSSFWorkbook(new FileInputStream(myFile));
			}

			// 创建对工作表的引用，得到表的第一页
			Sheet sheet = workbook.getSheetAt(0);
			// 读取左上端单元

			// 记录存储数据条数
			int count = 0;
			// 记录读入excel数据条数
			int sum = (sheet.getLastRowNum());
			for (short i = 1; i <= sheet.getLastRowNum(); i++) {
				String roomIspn ="";
				double roomRows =0;
				double roomCols =0;
				String roomDesc ="";
				List<String> errorList = new ArrayList<String>();
				Row row = sheet.getRow(i);
				Cell cell_1 = row.getCell((short) 0);
				Cell cell_2 = row.getCell((short) 1);
				Cell cell_3 = row.getCell((short) 2);
				Cell cell_4 = row.getCell((short) 3);
				if ((null == cell_1 || 3 == cell_1.getCellType())
						&& (null == cell_2 || 3 == cell_2.getCellType())
						&& (null == cell_3 || 3 == cell_3.getCellType())
						&& (null == cell_4 || 3 == cell_4.getCellType())){
					sum--;
				}else {
					// 机房编号
					if (null == cell_1) {
						errorInfo +=  getI18nText("i18n_RoomManageAction.downloadExample.errorInfo1_n81i",i+"");
					} else if (cell_1.getCellType() == Cell.CELL_TYPE_STRING) {
						if ("".equals(cell_1.getStringCellValue())) {
							errorInfo +=  getI18nText("i18n_RoomManageAction.downloadExample.errorInfo1_n81i",i+"");
						} else {
							roomIspn = cell_1.getStringCellValue().trim();
						}
					}else if (cell_1.getCellType() == Cell.CELL_TYPE_NUMERIC) {
							roomIspn = String.valueOf((int)cell_1.getNumericCellValue());
					} else {
						errorInfo +=  getI18nText("i18n_RoomManageAction.downloadExample.errorInfo2_n81i",i+"");
					}

					// 机房行数
					if (null == cell_2) {
						errorInfo +=  getI18nText("i18n_RoomManageAction.downloadExample.errorInfo3_n81i",i+"");
					} else if (cell_2.getCellType() == Cell.CELL_TYPE_NUMERIC) {
							roomRows = cell_2.getNumericCellValue();							
							if(roomRows>Constant.MAX_ROOM_ROWS){
								errorInfo +=  getI18nText("i18n_RoomManageAction.downloadExample.errorInfo4_n81i",i+"")+Constant.MAX_ROOM_ROWS+";";
							}
					}else{
						errorInfo +=  getI18nText("i18n_RoomManageAction.downloadExample.errorInfo5_n81i",i+"");
					}
					// 机房列数
					if(null == cell_3){
						errorInfo +=  getI18nText("i18n_RoomManageAction.downloadExample.errorInfo6_n81i",i+"");
					}else if (cell_3.getCellType() == Cell.CELL_TYPE_NUMERIC) {
							roomCols = cell_3.getNumericCellValue();
							if(roomCols>Constant.MAX_ROOM_Cols){
								errorInfo +=  getI18nText("i18n_RoomManageAction.downloadExample.errorInfo7_n81i",i+"")+Constant.MAX_ROOM_Cols+";";
							}
					} else {
						errorInfo +=  getI18nText("i18n_RoomManageAction.downloadExample.errorInfo8_n81i",i+"");
					}
					// 机房描述
					if(null == cell_4){
					}else if (cell_4.getCellType() == Cell.CELL_TYPE_STRING) {
						if ("".equals(cell_4.getStringCellValue())) {
						} else {
							roomDesc = cell_4.getStringCellValue().trim();
							if(roomDesc.length()>100){
								errorInfo +=  getI18nText("i18n_RoomManageAction.downloadExample.errorInfo9_n81i",i+"");
							}
						}
					}
					
					if ("".equals(errorInfo)) {// 保存节点
						errorInfo = this.saveNode(roomIspn,roomRows,roomCols,roomDesc);
					}
					if ("".equals(errorInfo)) {
						count++;
					} else {
						errorList.add(roomIspn);
						errorList.add(String.valueOf((int)roomRows));
						errorList.add(String.valueOf((int)roomCols));
						errorList.add(roomDesc);
						errorList.add(errorInfo);
						rowList.add(errorList);
						errorInfo = "";

					}
				}
			}
			headerList.add(getI18nText("i18n_RoomManageAction.downloadExample.roomId_n81i"));
			headerList.add(getI18nText("i18n_RoomManageAction.downloadExample.roomRows_n81i"));
			headerList.add(getI18nText("i18n_RoomManageAction.downloadExample.roomColumns_n81i"));
			headerList.add(getI18nText("i18n_RoomManageAction.downloadExample.roomDesc_n81i"));
			headerList.add(getI18nText("i18n_RoomManageAction.downloadExample.errorInfo_n81i"));
			this.getRequest().setAttribute("rowList", rowList);
			this.getRequest().setAttribute("headerList", headerList);
			if (count == sum && sum > 0) {
				outHtmlString("<script type=\"text/javascript\">alert('i18n_RoomManageAction.downloadExample.success_n81i');this.location='roomManage.do?action=query'</script>");
				return null;
				//this.getRequest().setAttribute("MSG", 1);
				//return  this.queryRoomInfo();
			} else if (sum == 0) {
				this
						.outHtmlString("<script>alert('i18n_RoomManageAction.downloadExample.selectFileIsNull_n81i');history.back();</script>");
				return null;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "showError";
	}

	private String saveNode(String roomIspn,double roomRows,double roomCols,String roomDesc) {
		String desc = "";
		NodeRoomTable nodeRoomTable = new NodeRoomTable();
		try {
			// 保存节点信息
			nodeRoomTable.setCreateDatetime(new Date());
			nodeRoomTable.setCreateUserId(getUserID());
			nodeRoomTable.setRoomCols((long)roomCols);
			nodeRoomTable.setRoomRows((long)roomRows);
			nodeRoomTable.setRoomIspn(roomIspn);
			nodeRoomTable.setRoomDesc(roomDesc);

			//判断机房编号是否已存在
			List<NodeRoomTable> NodeRoomTableList = this.commonService.find(
					"from NodeRoomTable where roomIspn=?", nodeRoomTable.getRoomIspn());
			if (NodeRoomTableList != null && NodeRoomTableList.size() > 0) {
				return getI18nText("i18n_RoomManageAction.downloadExample.roomIdExists_n81i");
			}			
			this.commonService.save(nodeRoomTable);
			
			//-----初始化机房位置表
			List<Object> list2 = new ArrayList<Object>();
			for(long i=1; i<=nodeRoomTable.getRoomRows(); i++){
				for(long j=1; j<=nodeRoomTable.getRoomCols(); j++){
					NodeRoomLatticeTable nlt = new NodeRoomLatticeTable();
					nlt.setRoomId(nodeRoomTable.getRoomId());
					nlt.setLatticeRowPosition(i);
					nlt.setLatticeColPosition(j);
					list2.add(nlt);
				}
			}			
			this.commonService.saveOrUpdate(list2);
		} catch (Exception e) {
			e.printStackTrace();
			desc = getI18nText("i18n_RoomManageAction.downloadExample.nodeInfoImportErr_n81i");
		}
		return desc;
	}
	
	// 当前页导出   程辉 2013-5-8新增
	public String emportCurrentXls() {
		try {
			String hql = "from NodeRoomTable where 1=1";
			if(rIspn!=null && !"".equals(rIspn)){
				hql += " and Upper(roomIspn) like '%" + rIspn.trim().toUpperCase() + "%'";
			}
			hql += " order by roomId desc";
			page = this.commonService.findByPage(hql, pageNo, pageSize);
			List<NodeRoomTable> nodeRoomList = (List<NodeRoomTable>)page.getResult(); 
			
			String[] title = { getI18nText("i18n_RoomManageAction.downloadExample.roomId_n81i"),
								getI18nText("i18n_RoomManageAction.downloadExample.roomRows_n81i"),
								getI18nText("i18n_RoomManageAction.downloadExample.roomColumns_n81i"),
								getI18nText("i18n_RoomManageAction.downloadExample.roomDesc_n81i") };
	
			String[] colu = { "roomIspn","roomRows","roomCols","roomDesc" };
			String url = "roomManage.do?action=query&rIspn="+rIspn+"&pageSize="+pageSize+"&pageNo="+pageNo;
			ExportUtils m = new ExportUtils();
			m.setAutoSizeColumn(true);
			m.exportExcel(url,getI18nText("i18n_RoomManageAction.downloadExample.roomInfoTable_n81i"), nodeRoomList, title, colu);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	// 导出全部   程辉 2013-5-8新增
	public String emportAllXls() {
		try {
			String hql = "from NodeRoomTable where 1=1";
			if(rIspn!=null && !"".equals(rIspn)){
				hql += " and Upper(roomIspn) like '%" + rIspn.trim().toUpperCase() + "%'";
			}
			hql += " order by roomId desc";
			List<NodeRoomTable> nodeRoomList = this.commonService.find(hql);
			
			String[] title = { getI18nText("i18n_RoomManageAction.downloadExample.roomId_n81i"),
					getI18nText("i18n_RoomManageAction.downloadExample.roomRows_n81i"),
					getI18nText("i18n_RoomManageAction.downloadExample.roomColumns_n81i"),
					getI18nText("i18n_RoomManageAction.downloadExample.roomDesc_n81i") };
	
			String[] colu = { "roomIspn","roomRows","roomCols","roomDesc" };
			String url = "roomManage.do?action=query&rIspn="+rIspn+"&pageSize="+pageSize+"&pageNo="+pageNo;
			ExportUtils m = new ExportUtils();
			m.setAutoSizeColumn(true);
			m.exportExcel(url,getI18nText("i18n_RoomManageAction.downloadExample.roomInfoTable_n81i"), nodeRoomList, title, colu);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	
	public String queryRoomInfo(){
		try {
			isComplete = this.getRequest().getParameter("isComplete");
			String hql = "from NodeRoomTable where 1=1";
			if(rIspn!=null && !"".equals(rIspn)){
				hql += " and Upper(roomIspn) like '%" + rIspn.trim().toUpperCase() + "%'";
			}
			hql += " order by roomId desc";
			page = this.commonService.findByPage(hql, pageNo, pageSize);
			nodeRoomList = (List<NodeRoomTable>)page.getResult(); 
			
		} catch (Exception e) {
			logger.error("Query room information is abnormal", e);
			return "error";
		}
		
		return "queryRoomInfo";
		
	}
	
	public void ajaxCheck(){
		List list = null;
		try {
			list = this.commonService.find("from NodeRoomTable where roomIspn=?",nodeRoom.getRoomIspn());
			if(list!=null && list.size()>0){
				this.outString("error");
				return ;
			}
		} catch (Exception e) {
			e.printStackTrace();
			logger.info("添加机房配置校验异常",e);
			this.outString("exception");
		}
		this.outString("success");
	}
	
	
	/**
	 * 新增机房：初始化机房位置表，机房有M行N列就插入M*N条数据，初始化时NodeBoxID为空（即表示未存放机柜）
	 * @return
	 */
	public String addRoomInfo(){
	//	List list = null;
		try {
			//判断数据是否存在
			/*list = this.commonService.find("from NodeRoomTable where roomIspn=?",nodeRoom.getRoomIspn());
			if(list!=null && list.size()>0){
				this.outHtmlString("<script>alert('记录已存在，请重新输入！');history.back();</script>");
				return null;
			}*/
			
			nodeRoom.setCreateUserId(this.getUserID());
			nodeRoom.setCreateDatetime(new Date());
			this.commonService.save(nodeRoom);
			
			//-----初始化机房位置表
			List<Object> list2 = new ArrayList<Object>();
			for(long i=1; i<=nodeRoom.getRoomRows(); i++){
				for(long j=1; j<=nodeRoom.getRoomCols(); j++){
					NodeRoomLatticeTable nlt = new NodeRoomLatticeTable();
					nlt.setRoomId(nodeRoom.getRoomId());
					nlt.setLatticeRowPosition(i);
					nlt.setLatticeColPosition(j);
					list2.add(nlt);
				}
			}
			
			this.commonService.saveOrUpdate(list2);
			//记录用户操作用于设置向导
			if(fromWhere!=null && !"".equals(fromWhere)){
				if(fromWhere.equals("formGuide")){
					outHtmlString("<script type=\"text/javascript\">alert('i18n_RoomManageAction.downloadExample.success_n81i');this.location='roomManage.do?action=query&isComplete=0'</script>");
				}
			}else{
				outHtmlString("<script type=\"text/javascript\">alert('i18n_RoomManageAction.downloadExample.success_n81i');this.location='roomManage.do?action=query'</script>");
			}
		} catch (Exception e) {
			logger.error("Failed to add room information", e);
		}
		return null;
	}
	
	public String openUpdRoom(){
		try {
			if(ids!=null && ids.length>0){
				List list = this.commonService.find(
						"from NodeRoomTable where roomId=?", ids[0]);
				if(list!=null && list.size()>0){
					nodeRoom = (NodeRoomTable)list.get(0);
				}
			}
		} catch (Exception e) {
			logger.error("Query room modification error", e);
			return "error";
		}
		
		return "updateRoomInfo";
		
	}
	
	public void roomManagerCheck(){
		List list;
		try {
			list = this.commonService.find("from NodeRoomTable where roomIspn='"+nodeRoom.getRoomIspn()+"' and roomId <> "+nodeRoom.getRoomId());
			if (list != null && list.size() > 0) {
				this.outString("error");
				return ;
			}
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("Ajax query verification room number abnormal", e);
			this.outString("exception");
		}
		this.outString("success");
	}
	
	/**
	 * 修改机房：
	 * 1、机房行列变更范围若已存放了机柜，则不允许修改  
	 * 2、机房行或列若是增大，则直接在位置表中插入增大的记录；机房行或列若是减小，减小的范围若未放置机柜，则删除位置表记录
	 * @return
	 */
	public void doUpdRoom(){
		try {
			NodeRoomTable nrt = (NodeRoomTable) this.commonService.get(
					NodeRoomTable.class, nodeRoom.getRoomId());
			String ispn = nrt.getRoomIspn();
			nrt.setRoomIspn(nodeRoom.getRoomIspn());
			nrt.setRoomDesc(nodeRoom.getRoomDesc());
			nrt.setUpdateUserId(this.getUserID());
			nrt.setUpdateDatetime(new Date());
			
			String historyBack = "roomManage!executeAction.do?action=openUpdate"
					+ "&ids=" + nodeRoom.getRoomId()
					+ "&pageNo=" + pageNo + "&pageSize=" + pageSize;
			
			List list;
			// 若行列中至少有一个是减小的情况，先检查减小的部分是否存放了机柜
			if(nodeRoom.getRoomRows()<nrt.getRoomRows()){//行数减小
				String hql = "from NodeRoomLatticeTable where roomId=? and nodeBoxId is not null and latticeRowPosition>?";
				list = this.commonService.find(hql, nodeRoom.getRoomId(), nodeRoom.getRoomRows());
				if (list != null && list.size() > 0) {
					this.outHtmlString("<script>alert('i18n_RoomManageAction.downloadExample.changeRowsErr_n81i');this.location='" + historyBack + "';</script>");
					return;
				}
			}
			if(nodeRoom.getRoomCols()<nrt.getRoomCols()){//列数减小
				String hql = "from NodeRoomLatticeTable where roomId=? and nodeBoxId is not null and latticeColPosition>?";
				list = this.commonService.find(hql, nodeRoom.getRoomId(), nodeRoom.getRoomCols());
				if (list != null && list.size() > 0) {
					this.outHtmlString("<script>alert('i18n_RoomManageAction.downloadExample.changecolumnssErr_n81i');this.location='" + historyBack + "';</script>");
					return;
				}
			}
			List<Object> list2 = new ArrayList<Object>();
			if(nodeRoom.getRoomRows()>nrt.getRoomRows()){//行数增大
				for(long i=(nrt.getRoomRows()+1); i<=nodeRoom.getRoomRows(); i++){
					for(long j=1; j<=nodeRoom.getRoomCols(); j++){//列数以新修改的列数为准
						NodeRoomLatticeTable nlt = new NodeRoomLatticeTable();
						nlt.setRoomId(nodeRoom.getRoomId());
						nlt.setLatticeRowPosition(i);
						nlt.setLatticeColPosition(j);
						list2.add(nlt);
					}
				}
			}else if(nodeRoom.getRoomRows()<nrt.getRoomRows()){//行数减小,上面已作检查，此处可以直接删除
				String hql = "delete from NodeRoomLatticeTable where roomId=? and latticeRowPosition>?";
				this.commonService.delete(hql, nodeRoom.getRoomId(), nodeRoom.getRoomRows());
			}
			if(nodeRoom.getRoomCols()>nrt.getRoomCols()){//列数增大,直接添加机房位置表
				long rowSize = nodeRoom.getRoomRows();//行数以新修改的为准
				if(nodeRoom.getRoomRows()>nrt.getRoomRows()){//如果行列同时都增大，在增大行时已经按新修改的列数插入数据了，这里的行数就要按原来的行
					rowSize = nrt.getRoomRows();
				}
				for(long i=1; i<=rowSize; i++){
					for(long j=(nrt.getRoomCols()+1); j<=nodeRoom.getRoomCols(); j++){
						NodeRoomLatticeTable nlt = new NodeRoomLatticeTable();
						nlt.setRoomId(nodeRoom.getRoomId());
						nlt.setLatticeRowPosition(i);
						nlt.setLatticeColPosition(j);
						list2.add(nlt);
					}
				}
			}else if(nodeRoom.getRoomCols()<nrt.getRoomCols()){//列减小,上面已作检查，此处可以直接删除
				String hql = "delete from NodeRoomLatticeTable where roomId=? and latticeColPosition>?";
				this.commonService.delete(hql, nodeRoom.getRoomId(), nodeRoom.getRoomCols());
			}
			if(list2.size()>0){//若有增大的，则保存
				this.commonService.saveOrUpdate(list2);
			}
			// 设置行列并更新
			nrt.setRoomRows(nodeRoom.getRoomRows());
			nrt.setRoomCols(nodeRoom.getRoomCols());
			this.commonService.update(nrt);
			this.getRequest().setAttribute("MSG", 1);
			if(!ispn.equals(nodeRoom.getRoomIspn())){
				String sql = "update node_box_table set ROOM_ISPN = ? where ROOM_ISPN = ?";
				this.commonService.updateBySql(sql, nodeRoom.getRoomIspn(),ispn);
			}
		} catch (Exception e) {
			logger.error("Failed to update room information", e);
		}
		outHtmlString("<script type=\"text/javascript\">alert('i18n_RoomManageAction.downloadExample.success_n81i');this.location='roomManage.do?action=query&rIspn="+rIspn+"&pageNo="+pageNo+"&pageSize="+pageSize+"'</script>");
	}
	
	public String delRoomInfo(){
		try {
			if(ids!=null && ids.length>0){
				for(Long id : ids){
					List list = this.commonService.find(
							"from NodeRoomLatticeTable where roomId=? and nodeBoxId is not null", id);
					if(list!=null && list.size()>0){
						NodeRoomTable nrt = (NodeRoomTable)this.commonService.get(NodeRoomTable.class, id);
						this.outHtmlString("<script>alert('i18n_RoomManageAction.downloadExample.deleteUnable1_n81i[" +nrt.getRoomIspn()+ "]i18n_RoomManageAction.downloadExample.deleteUnable2_n81i');history.back();</script>");
						return null;
					}
				}
				//删除node_room_lattice_table记录
				this.commonService.updateBatchBySql("delete from node_room_lattice_table where ROOM_ID=?", Arrays.asList(ids));
				
				//删除记录
				this.commonService.updateBatchBySql("delete from NODE_ROOM_TABLE where ROOM_ID=?", Arrays.asList(ids));
				outHtmlString("<script type=\"text/javascript\">alert('i18n_RoomManageAction.downloadExample.success_n81i');this.location='roomManage.do?action=query&pageNo="+pageNo+"&pageSize="+pageSize+"'</script>");
			}
		} catch (Exception e) {
			logger.error("Failed to delete room information", e);
			return "error";
		}
		
		return this.queryRoomInfo();
	}
	
	/**
	 * Ajax请求，获取所有机柜编号
	 * @return
	 */
	public String getAllRoomIspn(){
		try {
			String hql = "select distinct roomIspn from NodeRoomTable order by roomIspn ";
			List<Long> allList = (List<Long>)this.commonService.find(hql);
			String getIspn = "";
			for (int i = 0; i < allList.size(); i++) {
				if (allList.get(i) != null && !"".equals(allList.get(i))) {
					getIspn += allList.get(i) + ";";
				}
			}
			outString(getIspn);
			System.out.println("--------room free cols: " + Arrays.toString(allList.toArray()));
			//this.outJsonArray(allList);
		} catch (Exception e) {
			logger.error(e.getStackTrace());
			e.printStackTrace();
		}
		return null;
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

	public Long[] getIds() {
		return ids;
	}

	public void setIds(Long[] ids) {
		this.ids = ids;
	}

	public String getRIspn() {
		return rIspn;
	}

	public void setRIspn(String ispn) {
		rIspn = ispn;
	}

	public String getDescinfo() {
		return descinfo;
	}

	public void setDescinfo(String descinfo) {
		this.descinfo = descinfo;
	}

	public List<NodeRoomTable> getNodeRoomList() {
		return nodeRoomList;
	}

	public void setNodeRoomList(List<NodeRoomTable> nodeRoomList) {
		this.nodeRoomList = nodeRoomList;
	}

	public NodeRoomTable getNodeRoom() {
		return nodeRoom;
	}

	public void setNodeRoom(NodeRoomTable nodeRoom) {
		this.nodeRoom = nodeRoom;
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
}
