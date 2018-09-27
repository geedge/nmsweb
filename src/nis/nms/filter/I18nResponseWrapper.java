package nis.nms.filter;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpServletResponseWrapper;

public class I18nResponseWrapper extends HttpServletResponseWrapper{

	private ServletOutputStream superOut;
	private ByteArrayOutputStream bos;
	//private StringBuilder content;
	private PrintWriter myWriter;
	private ServletOutputStream myOut;
	private boolean trans = false;//是否开启 响应内容缓存
	
	public I18nResponseWrapper(HttpServletResponse response) {
		super(response);
		//content =  new StringBuilder();
		bos = new ByteArrayOutputStream();
	}

	@Override
	public void reset() {
		super.reset();
		bos.reset();
		//content.setLength(0);//清空缓存
	}
	
	@Override
	public void setContentType(String type) {
		super.setContentType(type);
		if(type.startsWith("text") || I18n.TRANS_CONTENT_TYPE.contains(type)){
			trans = true;
		}else{
			trans = false;
		}
	}
	
	public boolean isTrans() {
		return trans;
	}

	public void setTrans(boolean trans) {
		this.trans = trans;
	}

	public String getContent() {
		if(myWriter != null){
			myWriter.flush();
		}
		return bos.toString();
	}

	@Override
	public ServletOutputStream getOutputStream() throws IOException {
		if(myOut == null){
			myOut = new I18nOutputStream(getSuperOut());
		}
		return myOut;
	}
	
	public ServletOutputStream getSuperOut() throws IOException{
		if(superOut == null){
			superOut = super.getOutputStream();
		}
		return superOut;
	}
	

	
	@Override
	public PrintWriter getWriter() throws IOException {
		if(myWriter == null){
			myWriter = new I18nWriter(getOutputStream());
			trans = true;
		}
		return myWriter;
	}
	
	
	
	class I18nWriter extends PrintWriter{
		public I18nWriter(OutputStream out) {
			super(out,true);
		}
	}
	
	/**
	 * 重写 字节输出流 
	 * 当输出类型为 字符时，缓存输出内容
	 * @author dell
	 *
	 */
	class I18nOutputStream extends ServletOutputStream{
		private ServletOutputStream out;
		public I18nOutputStream(ServletOutputStream out) {
			this.out = out;
		}
		
		@Override
		public void write(int b) throws IOException {
			if(trans){//字符内容
				bos.write(b);
			}else{
				out.write(b);
			}
		}
	}
	
}


