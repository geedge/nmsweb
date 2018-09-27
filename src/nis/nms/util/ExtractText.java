package nis.nms.util;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
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

public class ExtractText
{

	public static String extractText(String path)
	{
		String content = "";
		
		File file = new File(path);
		if(!file.exists())
			return "";
		else {
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
		}
		return content;
	}
	
	
	/**
	 * 从 text、htm、html、xhtml 中，提取文本内容
	 * @param path 文件路径
	 * @return
	 */
	public static String extractFromOther(String path)
	{
		BufferedReader reader = null ;
		StringBuilder sb = new StringBuilder("");
		try
		{
			reader = new BufferedReader(new InputStreamReader(new FileInputStream(path)));
			String s  = null;
			while((s = reader.readLine()) != null)
				sb.append(s).append("\r\n");
		} catch (FileNotFoundException e)
		{
			e.printStackTrace();
		} catch (IOException e)
		{
			e.printStackTrace();
		}  finally {
			if(reader != null)
				try
				{
					reader.close();
				} catch (IOException e)
				{
					e.printStackTrace();
				}
		}
		return sb.toString();
	}
	
	/**
	 * 从 office 2003 或者 office 2007 中，提取文本内容
	 * @param  path 文件路径
	 * @return
	 */
	public static String extractFromOffice(String path)
	{
		try
		{
			POITextExtractor extractor = ExtractorFactory.createExtractor(new File(path));
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
	 * 从 pdf 中，提取文本内容
	 * @param  path 文件路径
	 * @return
	 */
	public static String extractFromPDF(String path)
	{
		String context = "";
		FileInputStream instream = null;
		PDDocument pdfdocument = null;
		try
		{
			File file = new File(path);
			instream = new FileInputStream(file);
			PDFParser parser = new PDFParser(instream);
			parser.parse();
			pdfdocument = parser.getPDDocument();
			PDFTextStripper pdfstripper = new PDFTextStripper();
			context = pdfstripper.getText(pdfdocument);

		} catch (Exception e)
		{
			e.printStackTrace();
		} finally
		{
			if (instream != null)
				try
				{
					instream.close();
				} catch (IOException e)
				{
					e.printStackTrace();
				}
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
	 * 从 xml 中，提取文本内容
	 * @param  path 文件路径
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public static String extractFromXml(String path)
	{
		String content = "", value = "";
		try
		{
			File file = new File(path);
			if (!file.exists())
			{
				return content;
			}
			SAXReader saxReader = new SAXReader();
			Document document = saxReader.read(file);
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
	 * 从 rtf 中，提取文本内容
	 * @param  path 文件路径
	 * @return
	 */
	public static String extractFromRtf(String path)
	{
		String result = "";
		File file = new File(path);
		RTFEditorKit rtf = new RTFEditorKit();
		InputStream is = null;
		try
		{
			DefaultStyledDocument styledDoc = new DefaultStyledDocument();
			is = new FileInputStream(file);
			rtf.read(is, styledDoc, 0);
			// 提取文本，读取中文需要使用ISO8859_1编码，否则会出现乱码
			result = new String(styledDoc.getText(0, styledDoc.getLength()).getBytes("ISO-8859-1"), "GBK");
		} catch (IOException e)
		{
			e.printStackTrace();
		} catch (BadLocationException e)
		{
			e.printStackTrace();
		} finally {
			if(is != null)
				try
				{
					is.close();
				} catch (IOException e)
				{
					e.printStackTrace();
				}
		}
		
		return result;
	}
	
	public static void main(String[] args) throws Exception
	{
		System.out.println(extractText("C:/Tomcat 6.0/webapps/testnn/files/tempFiles/年度评估-2011-孙玉和(z).doc"));
	}

}
