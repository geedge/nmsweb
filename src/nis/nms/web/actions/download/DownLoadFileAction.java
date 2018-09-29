package nis.nms.web.actions.download;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URLEncoder;
import nis.nms.util.BaseAction;
import org.apache.commons.lang.StringUtils;
import org.apache.struts2.config.Result;
import org.apache.struts2.config.Results;

@SuppressWarnings("unchecked")
@Results( { 
	@Result(name="error", value ="/error.jsp")
})
public class DownLoadFileAction extends BaseAction {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String file;
	private String backPathStr;
	
	/**
	 * 下载结果文件
	 * @return
	 */
	public void download() {
		String path = getServletContext().getRealPath("/")+"/" +file;
		InputStream fis = null;
		OutputStream os =null;
		try{
			File file = new File(path);// path是根据日志路径和文件名拼接出来的
		    String filename = file.getName();// 获取日志文件名称
		    fis = new BufferedInputStream(new FileInputStream(path));
		    byte[] buffer = new byte[fis.available()];
		    fis.read(buffer);
		    getResponse().reset();
		    // 先去掉文件名称中的空格,然后转换编码格式为utf-8,保证不出现乱码,这个文件名称用于浏览器的下载框中自动显示的文件名
		    getResponse().addHeader("Content-Disposition", "attachment;filename=" + new String(filename.replaceAll(" ", "").getBytes("utf-8"),"iso8859-1"));
		    getResponse().addHeader("Content-Length", "" + file.length());
		    os = new BufferedOutputStream(getResponse().getOutputStream());
		    getResponse().setContentType("application/octet-stream");
		    os.write(buffer);// 输出文件
		}catch (Exception e) {
			e.printStackTrace();
			outHtmlString("<script type=\"text/javascript\">alert('i18n_DownLoadFileAction.downloadDevPic.noFile_n81i');history.go(-1);</script>");
		}finally{
			try {
				fis.close();
				os.flush();
			    os.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}
	/*public String download() {
		FileInputStream fis = null;
		BufferedInputStream bis = null;
		OutputStream  fos = null;
		BufferedOutputStream bos = null;
		try {
			String path = getServletContext().getRealPath("/")+"/" +file;
			File uploadFile = new File(path);
			if (!uploadFile.exists()) {
			    this.outHtmlString("<script>alert('下载文件已转移或已删除！');history.back();</script>");
			    return null;
			}
			fis = new FileInputStream(uploadFile);
			bis = new BufferedInputStream(fis);
			fos = getResponse().getOutputStream();
			bos = new BufferedOutputStream(fos);
			String titlePath=new String((path.substring(path.lastIndexOf("\\")+1, path.length())).getBytes());
			getResponse().setContentType("application/octec-stream");
			getResponse().setHeader("Content-disposition",
	                   "attachment;filename=" +
	                   URLEncoder.encode(titlePath, "utf-8"));
			int bytesRead = 0;
	        //同上传类似使用输入输出流这里用的是缓冲输入输出流
	        byte[] buffer = new byte[1024];
	        while ((bytesRead = bis.read(buffer, 0, 1024)) != -1) {
			    bos.write(buffer, 0, bytesRead);
			}
	       
		} catch (Exception e) {
			e.printStackTrace();
			outHtmlString("<script type=\"text/javascript\">alert('文件不存在');history.go(-1);</script>");
			return null;
		}
		finally{
				try {
					bos.flush();
					fis.close();
					bis.close();
					fos.close();
					bos.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
		}
		return null;
	}*/
	
	public String downloadDevPic() {
		
		try {
			String path = getServletContext().getRealPath("/")+"/" +file;
			File uploadFile = new File(path);
			if (!uploadFile.exists()) {
				if(StringUtils.isNotBlank(backPathStr)) {
					this.outHtmlString("<script>alert('i18n_DownLoadFileAction.downloadDevPic.downloadFileIsnull_n81i');this.location='"+backPathStr+"';</script>");
				}else {
					this.outHtmlString("<script>alert('i18n_DownLoadFileAction.downloadDevPic.downloadFileIsnull_n81i');history.back();</script>");
				}
				return null;
			}
			FileInputStream fis = new FileInputStream(uploadFile);
			BufferedInputStream bis = new BufferedInputStream(fis);
			OutputStream  fos = getResponse().getOutputStream();
			BufferedOutputStream bos = new BufferedOutputStream(fos);
			String titlePath = file;
			if(file.contains("\\")) {
				titlePath=new String((file.substring(file.lastIndexOf("\\")+1, file.length())).getBytes());				
			}else if(file.contains("/")){
				titlePath=new String((file.substring(file.lastIndexOf("/")+1, file.length())).getBytes());			
			}
			getResponse().setContentType("application/octec-stream");
			getResponse().setHeader("Content-disposition",
					"attachment;filename=" +
					URLEncoder.encode(titlePath, "utf-8"));
			int bytesRead = 0;
			//同上传类似使用输入输出流这里用的是缓冲输入输出流
			byte[] buffer = new byte[8192];
			while ((bytesRead = bis.read(buffer, 0, 8192)) != -1) {
				bos.write(buffer, 0, bytesRead);
			}
			bos.flush();
			fis.close();
			bis.close();
			fos.close();
			bos.close();
		} catch (Exception e) {
			e.printStackTrace();
			if(StringUtils.isNotBlank(backPathStr)) {
				outHtmlString("<script type=\"text/javascript\">alert('i18n_DownLoadFileAction.downloadDevPic.noFile_n81i');this.location='"+backPathStr+"';</script>");
			}else {
				outHtmlString("<script type=\"text/javascript\">alert('i18n_DownLoadFileAction.downloadDevPic.noFile_n81i');history.go(-1);</script>");
			}
			return null;
		}
		
		
		return null;
	}
	

	/**
	 * 远程连接
	 * 1、流程：先查看是否有指定操作系统类型
	 * 	  A、有，直接连接，Linux下用putty.exe(检查文件是否存在，不存在提供下载),Windows下用mstsc远程桌面
	 *    B、没有，提示选择操作系统类型
	 * 2、操作步骤：
	 *    A、在调用远程连接之前，要在原有的SQL基础上添加对note_table的node_system_type的查询
	 *    B、在调用远程连接的页面，include引入/common/remoteConn.jsp页面
	 *    C、在相应IP连接处调用JS--romoteConn(nodeSysType,ip)
	 * @return
	 */
	public String remoteConn() {
		try {
			String sysType = this.getRequest().getParameter("sysType");//操作系统类型
			String ip = this.getRequest().getParameter("ip");//远程连接的节点IP
			if (sysType != null && !"".equals(sysType)) {
				String cmd = null;
				if ("1".equals(sysType)) {// 1 Linux
					File file = new File("D:\\putty.EXE");
					if(!file.exists()){
						this.outHtmlString("i18n_DownLoadFileAction.downloadDevPic.toDownload_n81i<a href='javascript:download(\"putty.exe\");'>putty.exe</a>，i18n_DownLoadFileAction.downloadDevPic.saveToD_n81i");
						return null;
					}
					cmd = "D:\\putty.EXE " + ip;
				} else if ("2".equals(sysType)) {// 2 Windows
					cmd = "mstsc /v " + ip;
				} else {//其他
					cmd = "telnet " + ip;
				}
				String[] cmdArr = new String[] { "cmd.exe", "/C", cmd };
				Runtime.getRuntime().exec(cmdArr);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		this.outHtmlString("");
		return null;
	}
	
	public String getFile() {
		return file;
	}

	public void setFile(String file) {
		this.file = file;
	}
	
	@Override
	public String executeAction() throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	
	public String getBackPathStr()
	{
		return backPathStr;
	}

	
	public void setBackPathStr(String backPathStr)
	{
		this.backPathStr = backPathStr;
	}
	

}
