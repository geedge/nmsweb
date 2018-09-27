package nis.nms.web.actions.pluginManage;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import nis.nms.domains.PluginInfo;
import nis.nms.domains.XtYhJbxx;
import nis.nms.service.CommonService;
import nis.nms.util.BaseAction;
import nis.nms.util.Page;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.apache.struts2.config.Result;
import org.apache.struts2.config.Results;

import com.nis.util.StringUtil;

@SuppressWarnings("unchecked")
@Results( {
		@Result(name = "queryPluginInfoChild", value = "/page/pluginInfo/pluginInfoListChild.jsp"),
		@Result(name = "queryPluginInfo", value = "/page/pluginInfo/pluginInfoList.jsp"),
		@Result(name = "addPluginInfo", value = "/page/pluginInfo/addPluginInfo.jsp"),
		@Result(name = "updatePluginInfo", value = "/page/pluginInfo/updatePluginInfo.jsp"),
		@Result(name = "error", value = "/error.jsp") })
public class PluginManageAction extends BaseAction {
	private Logger logger = Logger.getLogger(PluginManageAction.class);
	private static final long serialVersionUID = 1L;
	private CommonService commonService;
	private int pageNo = 1;
	private int pageSize = this.getDefaultPageSize(); // 每页显示的记录条数
	private Page page;
	private String action;
	private List<PluginInfo> pluginList;
	private PluginInfo pluginInfo;
	private Long[] ids;
	private String name;
	private String fileName;
	private Map<String, String> userMap = new HashMap<String, String>();
	private String pluginId;

	// 导入节点文件
	private File myFile;
	private String myFileFileName;

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
		String resultpage = "";
		if ("queryInfo".equals(this.action)) {
			resultpage = this.queryPluginInfo();
		} else if ("queryChild".equals(this.action)) {
			resultpage = this.queryPluginInfoChild();
		} else if ("openAdd".equals(this.action)) {
			resultpage = "addPluginInfo";
		} else if ("doAdd".equals(this.action)) {
			resultpage = addPluginInfo();
		} else if ("openUpdate".equals(this.action)) {
			resultpage = this.openUpdatePlugin();
		} else if ("doUpdate".equals(this.action)) {
			resultpage = doUpdatePlugin();
		} else if ("del".equals(this.action)) {
			resultpage = delPluginInfo();
		} else if ("downloadPlugin".equals(this.action)) {
			resultpage = downloadPlugin();
		} else if ("checkName".equals(this.action)) {
			resultpage = checkName();
		} else {
			resultpage = this.queryPluginInfo();
		}
		return resultpage;
	}

	private String downloadPlugin() {
		try {
			if (ids != null && ids.length == 1) {
				Long pid = ids[0];
				PluginInfo pluginInfo = (PluginInfo) commonService.get(
						PluginInfo.class, pid);
				String fileName = pluginInfo.getFileName();

				FileInputStream fis = null;
				BufferedInputStream bis = null;
				OutputStream fos = null;
				BufferedOutputStream bos = null;
				try {
					if (!StringUtil.isBlank(fileName)) {
						String uploadFilePath = getValue("serverPath")
								+ getValue("uploadFilePath");
						String realPath = uploadFilePath + fileName;
						File uploadFile = new File(realPath);
						String downFileName = "";
						if (fileName.contains("_")) {
							downFileName = fileName.substring(fileName.indexOf("_")+1);
						}else {
							downFileName = fileName;
						}

						if (uploadFile.exists()) {
							fis = new FileInputStream(uploadFile);
							bis = new BufferedInputStream(fis);
							fos = getResponse().getOutputStream();
							bos = new BufferedOutputStream(fos);
							getResponse().setContentType(
									"application/octec-stream");
							getResponse().setHeader(
									"Content-Disposition",
									"attachment; filename=\""
											+ new String(downFileName
													.getBytes("gb2312"),
													"ISO8859-1") + "\"");

							getResponse().setContentLength(
									(int) uploadFile.length());

							int bytesRead = 0;
							// 同上传类似使用输入输出流这里用的是缓冲输入输出流
							byte[] buffer = new byte[8192];
							while ((bytesRead = bis.read(buffer, 0, 8192)) != -1) {
								bos.write(buffer, 0, bytesRead);
							}
							bos.flush();

						} else {
							outHtmlString("<script type=\"text/javascript\">alert('i18n_PluginManageAction.downloadPlugin.targetFileIsNull_n81i');this.location='pluginManage.do?action=queryInfo&pageNo="
									+ pageNo
									+ "&pageSize="
									+ pageSize
									+ "'</script>");
							return null;
						}
					}
				} catch (Exception e) {
					logger.error("Attachment failed to download", e);
					e.printStackTrace();
					outHtmlString("<script type=\"text/javascript\">alert('i18n_PluginManageAction.downloadPlugin.fileReadFaild_n81i');this.location='pluginManage.do?action=queryInfo&pageNo="
							+ pageNo + "&pageSize=" + pageSize + "'</script>");
					return null;
				} finally {
					try {

						if (fis != null) {
							fis.close();
						}
						if (bis != null) {
							bis.close();
						}
						if (fos != null) {
							fos.close();
						}
						if (bos != null) {
							bos.close();
						}
					} catch (Exception e) {
						// TODO: handle exception
					}
				}
			} else {
				outHtmlString("<script type=\"text/javascript\">alert('i18n_PluginManageAction.downloadPlugin.onlyOneToolToUse_n81i。');this.location='pluginManage.do?action=queryInfo&pageNo="
						+ pageNo + "&pageSize=" + pageSize + "'</script>");
			}
		} catch (Exception e) {
			logger.error(e.getStackTrace());
			outHtmlString("<script type=\"text/javascript\">alert('i18n_PluginManageAction.downloadPlugin.faild_n81i');this.location='pluginManage.do?action=queryInfo&pageNo="
					+ pageNo + "&pageSize=" + pageSize + "'</script>");
		}
		return null;
	}

	public String queryPluginInfo() {
		try {
			initMap();

			String hql = "from PluginInfo";

			if (!StringUtils.isBlank(name)) {
				hql += " where name like '%" + name + "%'";
			}
			if (!StringUtils.isBlank(fileName)) {
				if (!hql.contains("where")) {
					hql += " where fileName like '%" + fileName + "%'";
				} else {
					hql += " and fileName like '%" + fileName + "%'";
				}
			}
			hql +=" order by updateTime desc";
			page = commonService.findByPage(hql, pageNo, pageSize);
			pluginList = (List<PluginInfo>) page.getResult();
			formatPlugin();
		} catch (Exception e) {
			e.printStackTrace();
			outHtmlString("<script type=\"text/javascript\">alert('i18n_PluginManageAction.downloadPlugin.faild_n81i');this.location='pluginManage.do?action=queryInfo&pageNo="
					+ pageNo + "&pageSize=" + pageSize + "'</script>");
			logger.error(e.getStackTrace());
		}
		return "queryPluginInfo";
	}

	private void formatPlugin() {
		// TODO Auto-generated method stub
		if (userMap.isEmpty()) {
			return;
		}
		for (int i = 0; i < pluginList.size(); i++) {
			pluginList.get(i).setCreatUserName(
					userMap.get(pluginList.get(i).getCreatUserId().intValue()
							+ ""));
			pluginList.get(i).setUpdateUserName(
					userMap.get(pluginList.get(i).getUpdateUserId().intValue()
							+ ""));
			String downFileName = "";
			if (pluginList.get(i).getFileName().contains("_")) {
				downFileName = pluginList.get(i).getFileName().substring(pluginList.get(i).getFileName().indexOf("_")+1);
			}else {
				downFileName = pluginList.get(i).getFileName();
			}
			pluginList.get(i).setFileName(downFileName);
		}
	}

	private void initMap() {
		// TODO Auto-generated method stub
		try {
			String hql = "from XtYhJbxx where zxbz=0";
			List<XtYhJbxx> yhList = commonService.find(hql);

			for (int i = 0; i < yhList.size(); i++) {
				userMap.put("" + yhList.get(i).getYhid(), yhList.get(i)
						.getYhmc());
			}
		} catch (Exception e) {
			// TODO: handle exception
			logger.error(e);
		}
	}

	public String queryPluginInfoChild() {
		try {
			initMap();
			String hql = "from PluginInfo";

			if (!StringUtils.isBlank(name)) {
				hql += " where Name like '%" + name + "%'";
			}
			if (!StringUtils.isBlank(fileName)) {
				if (!hql.contains("where")) {
					hql += " where fileName like '%" + fileName + "%'";
				} else {
					hql += " and fileName like '%" + fileName + "%'";
				}
			}
			hql +=" order by updateTime desc";
			page = commonService.findByPage(hql, pageNo, pageSize);
			pluginList = (List<PluginInfo>) page.getResult();
			formatPlugin();
		} catch (Exception e) {
			e.printStackTrace();
			outHtmlString("<script type=\"text/javascript\">alert('i18n_PluginManageAction.downloadPlugin.faild_n81i');this.location='pluginManage.do?action=queryInfo&pageNo="
					+ pageNo + "&pageSize=" + pageSize + "'</script>");
			logger.error(e.getStackTrace());
		}
		return "queryPluginInfoChild";
	}

	// 新增
	public String addPluginInfo() throws Exception {
		try {
			pluginInfo.setCreatTime(new Date());
			pluginInfo.setCreatUserId(getUserID());
			pluginInfo.setUpdateTime(new Date());
			pluginInfo.setUpdateUserId(getUserID());

			if (!StringUtils.isBlank(myFileFileName)) {
				pluginInfo.setFileName(myFileFileName);
				commonService.save(pluginInfo);
				pluginInfo.setFileName(pluginInfo.getId() + "_"
						+ myFileFileName);// 文件名加上id前缀防止文件名重复。
				commonService.saveOrUpdate(pluginInfo);

				// ------ 处理附件 start
				// 物理上传文件
				// -- 获取上传路径
				String uploadFilePath = getValue("serverPath")
						+ getValue("uploadFilePath");

				// -- 上传路径设置
				File itemDirFile = new File(uploadFilePath);
				if (!itemDirFile.exists()) {
					itemDirFile.mkdirs();
				}
				String filePath = uploadFilePath + pluginInfo.getFileName();
				// -- 拷贝文件
				this.copy(myFile, new File(filePath));
				logger.info(myFile.getAbsolutePath() + "文件上传到" + filePath
						+ "成功");

			} else {
				outHtmlString("<script type=\"text/javascript\">alert('i18n_PluginManageAction.downloadPlugin.noTools_n81i');this.location='pluginManage.do?action=openAdd&pluginInfo="
						+ pluginInfo + "'</script>");
			}
		} catch (Exception e) {
			logger.error(e.getStackTrace());
			outHtmlString("<script type=\"text/javascript\">alert('i18n_PluginManageAction.downloadPlugin.faild_n81i');this.location='pluginManage.do?action=queryInfo'</script>");
		}
		outHtmlString("<script type=\"text/javascript\">alert('i18n_PluginManageAction.downloadPlugin.success_n81i');this.location='pluginManage.do?action=queryInfo'</script>");
		return null;
	}

	public String openUpdatePlugin() {
		try {
			if (ids != null && ids.length > 0) {
				pluginId = String.valueOf(ids[0].intValue());

				pluginInfo = (PluginInfo) commonService.get(PluginInfo.class,
						ids[0]);
				
				String downFileName = "";
				if (pluginInfo.getFileName().contains("_")) {
					downFileName = pluginInfo.getFileName().substring(pluginInfo.getFileName().indexOf("_")+1);
				}else {
					downFileName = pluginInfo.getFileName();
				}
				
				pluginInfo.setFileName(downFileName);
			}
		} catch (Exception e) {
			logger.error(e.getStackTrace());
			outHtmlString("<script type=\"text/javascript\">alert('i18n_PluginManageAction.downloadPlugin.faild_n81i');this.location='pluginManage.do?action=queryInfo&pageNo="
					+ pageNo + "&pageSize=" + pageSize + "'</script>");
		}
		return "updatePluginInfo";
	}

	public String doUpdatePlugin() throws Exception {
		try {
			PluginInfo info = (PluginInfo) commonService.get(PluginInfo.class, pluginInfo.getId());
			info.setUpdateTime(new Date());
			info.setUpdateUserId(getUserID());
			info.setDes(pluginInfo.getDes());
//			info.setFileName(pluginInfo.getFileName());
			info.setName(pluginInfo.getName());

			if (!StringUtils.isBlank(myFileFileName)) {

				String uploadFilePath = getValue("serverPath")
						+ getValue("uploadFilePath");
				// 删除旧的附件
				File oldFile = new File(uploadFilePath
						+ info.getFileName());
				if (oldFile.exists()) {
					oldFile.delete();
				}
				info.setFileName(info.getId() + "_"
						+ myFileFileName);
				commonService.saveOrUpdate(info);

				// 保存新的附件
				File itemDirFile = new File(uploadFilePath);
				if (!itemDirFile.exists()) {
					itemDirFile.mkdirs();
				}
				String filePath = uploadFilePath + info.getFileName();
				// -- 拷贝文件
				this.copy(myFile, new File(filePath));
				logger.info(myFile.getAbsolutePath() + "文件上传到" + filePath
						+ "成功");
			} else {
				commonService.saveOrUpdate(info);
			}
		} catch (Exception e) {
			logger.error(e.getStackTrace());
			e.printStackTrace();
			outHtmlString("<script type=\"text/javascript\">alert('i18n_PluginManageAction.downloadPlugin.faild_n81i');this.location='pluginManage.do?action=queryInfo&pageNo="
					+ pageNo + "&pageSize=" + pageSize + "'</script>");
		}
		outHtmlString("<script type=\"text/javascript\">alert('i18n_PluginManageAction.downloadPlugin.success_n81i');this.location='pluginManage.do?action=queryInfo'</script>");
		return null;
	}

	public String delPluginInfo() throws Exception {
		try {
			if (ids != null && ids.length > 0) {
				for (Long pid : ids) {
					PluginInfo pluginInfo = (PluginInfo) commonService.get(
							PluginInfo.class, pid);

					String uploadFilePath = getValue("serverPath")
							+ getValue("uploadFilePath");
					// 删除附件
					File oldFile = new File(uploadFilePath
							+ pluginInfo.getFileName());
					if (oldFile.exists()) {
						oldFile.delete();
					}
//					commonService.delete(pluginInfo);
					 commonService.delete("PluginInfo", pid);
				}
			}
			outHtmlString("<script type=\"text/javascript\">alert('i18n_PluginManageAction.downloadPlugin.success_n81i');this.location='pluginManage.do?action=queryInfo'</script>");
		} catch (Exception e) {
			logger.error(e.getStackTrace());
			outHtmlString("<script type=\"text/javascript\">alert('i18n_PluginManageAction.downloadPlugin.faild_n81i');this.location='pluginManage.do?action=queryInfo&pageNo="
					+ pageNo + "&pageSize=" + pageSize + "'</script>");
		}
		return null;
	}

	public String checkName() {
		try {
			String errorInfo = "";

			if (!StringUtils.isBlank(name)) {
				String hql = "from PluginInfo where name like '%" + name + "%'";

				if (!StringUtils.isBlank(pluginId)) {
					hql += " and ID!=" + pluginId;
				}

				System.out.println(hql);
				List<PluginInfo> list = commonService.find(hql);
				if (list != null && list.size() > 0) {
					errorInfo = getI18nText("i18n_PluginManageAction.downloadPlugin.toolNameRepeat_n81i");
				}
			}
			if (!StringUtil.isBlank(errorInfo)) {
				outString(errorInfo);
			}

		} catch (Exception e) {
			logger.error("File name validation failed", e);
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

	public List<PluginInfo> getPluginList() {
		return pluginList;
	}

	public void setPluginList(List<PluginInfo> pluginList) {
		this.pluginList = pluginList;
	}

	public PluginInfo getPluginInfo() {
		return pluginInfo;
	}

	public void setPluginInfo(PluginInfo pluginInfo) {
		this.pluginInfo = pluginInfo;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public String getPluginId() {
		return pluginId;
	}

	public void setPluginId(String pluginId) {
		this.pluginId = pluginId;
	}

}
