package nis.nms.util;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLConnection;
import java.util.Iterator;

import javax.swing.text.BadLocationException;
import javax.swing.text.DefaultStyledDocument;
import javax.swing.text.rtf.RTFEditorKit;

import org.apache.pdfbox.pdfparser.PDFParser;
import org.apache.pdfbox.pdmodel.PDDocument;
import org.apache.pdfbox.util.PDFTextStripper;
import org.apache.poi.POITextExtractor;
import org.apache.poi.extractor.ExtractorFactory;
import org.apache.poi.openxml4j.exceptions.InvalidFormatException;
import org.apache.poi.openxml4j.exceptions.OpenXML4JException;
import org.apache.xmlbeans.XmlException;
import org.dom4j.Document;
import org.dom4j.Element;
import org.dom4j.io.SAXReader;

public class ReadOnlineResource
{
	
	public static String extractText(String path)
	{
		/// 得到文件的扩展名
		int index = path.lastIndexOf(".");
		String extendName = path.substring(index + 1, path.length()).toLowerCase();
		
		// 根据 扩展名，获取文件内容
		if("txt".equals(extendName) || "htm".equals(extendName) || 
				"html".equals(extendName) || "xhtml".equals(extendName))
			return extractFromOther(path);
		if("doc".equals(extendName) || "docx".equals(extendName) || "xls".equals(extendName) ||
				"xlsx".equals(extendName) || "ppt".equals(extendName) || "pptx".equals(extendName))
			return extractFromOffice(path);
		if("xml".equals(extendName))
			return extractFromXml(path);
		if("pdf".equals(extendName))
			return extractFromPDF(path);
		if("rtf".equals(extendName))
			return extractFromRtf(path);
		if("gif".equals(extendName) || "jpg".equals(extendName) || "png".equals(extendName))
		{
			String name = getFileName(path);
			return "<img src='" + path + "' alt='" + name + "' />";
		}
		return "";
	}
	
	
	/**
	 * 读取 txt、html或者xhtml等网页内容
	 * @param path URL 路径
	 * @return
	 */
	public static String extractFromOther(String path) 
	{
		StringBuilder sb = new StringBuilder("");
		InputStream in = null;
		BufferedReader reader = null;
		try
		{
			URL url = new URL(path);
			in = url.openStream();
			reader = new BufferedReader(new InputStreamReader(in));
			String str = null;
			while( (str = reader.readLine() ) != null) 
				sb.append(str).append("\r\n");
		} catch (MalformedURLException e)
		{
			e.printStackTrace();
		} catch (IOException e)
		{
			e.printStackTrace();
		} finally {
			if(reader != null)
				try
				{
					reader.close();
				} catch (IOException e)
				{
					e.printStackTrace();
				}
			if(in != null)
				try
				{
					in.close();
				} catch (IOException e)
				{
					e.printStackTrace();
				}
		}
		return sb.toString();
	}
	
	/**
	 * 读取网络中的 office 内容，包括office 2003 格式和 office 2007
	 * @param path 以doc、docx、xls、xlsx、ppt、pptx 格式结尾的 URL.
	 * @return
	 */
	public static String extractFromOffice(String path)
	{
		try
		{
			URL url = new URL(path);
			URLConnection conn = url.openConnection();
			POITextExtractor extractor = ExtractorFactory.createExtractor(conn.getInputStream());
			return extractor.getText();
		} catch (InvalidFormatException e)
		{
			e.printStackTrace();
		} catch (IOException e)
		{
			e.printStackTrace();
		} catch (OpenXML4JException e)
		{
			e.printStackTrace();
		} catch (XmlException e)
		{
			e.printStackTrace();
		}
		
		return "";
	}
	
	/**
	 * 读取网络上的pdf内容
	 * @param path　以pdf结尾的URL
	 * @return
	 */
	public static String extractFromPDF(String path)
	{
		String context = "";
		PDDocument pdfdocument = null;
		try
		{
			URL url = new URL(path);
			URLConnection conn = url.openConnection();
			PDFParser parser = new PDFParser(conn.getInputStream());
			parser.parse();
			pdfdocument = parser.getPDDocument();
			PDFTextStripper pdfstripper = new PDFTextStripper();
			context = pdfstripper.getText(pdfdocument);
		} catch (Exception e)
		{
			e.printStackTrace();
		} finally
		{
			if (pdfdocument != null)
				try
				{
					pdfdocument.close();
				} catch (IOException e)
				{
					e.printStackTrace();
				}
		} 
		return context;
	}
	
	
	/**
	 * 读取网络上的xml内容
	 * @param  path 以xml结尾的URL
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public static String extractFromXml(String path)
	{
		String content = "", value = "";
		try
		{
			URL url = new URL(path);
			URLConnection conn = url.openConnection();
			SAXReader saxReader = new SAXReader();
			Document document = saxReader.read(conn.getInputStream());
			Element root = document.getRootElement();
			Iterator<Element> iter = root.elementIterator();
			while (iter.hasNext())
			{
				Element element = (Element) iter.next();
				value = element.getStringValue();
				if (!value.trim().equals(""))
					content = content + value;
			}
		} catch (Exception e)
		{
			e.printStackTrace();
		}
		
		return content;
	}
	
	
	/**
	 * 读取网络中的 rtf 内容
	 * @param  path 以 rtf 结尾的URL
	 * @return
	 */
	public static String extractFromRtf(String path)
	{
		String result = "";
		RTFEditorKit rtf = new RTFEditorKit();
		try
		{
			DefaultStyledDocument styledDoc = new DefaultStyledDocument();
			URL url = new URL(path);
			URLConnection conn = url.openConnection();
			rtf.read(conn.getInputStream(), styledDoc, 0);
			// 提取文本，读取中文需要使用ISO8859_1编码，否则会出现乱码
			result = new String(styledDoc.getText(0, styledDoc.getLength()).getBytes("ISO-8859-1"), "GBK");
		} catch (IOException e)
		{
			e.printStackTrace();
		} catch (BadLocationException e)
		{
			e.printStackTrace();
		} finally {
			
		}
		
		return result;
	}
	
	public static String getFileName(String path)
	{
		int start = path.lastIndexOf("/");
		int end = path.lastIndexOf(".");
		return path.substring(start + 1, end);
	}
	
	public static void main(String[] args)
	{
		
	}
}
