package nis.nms.datasql;

import org.w3c.dom.Document; 

import javax.xml.parsers.DocumentBuilderFactory; 

import javax.xml.parsers.DocumentBuilder; 

import javax.xml.parsers.*; 

import java.io.InputStream; 

import java.io.FileInputStream; 

import java.io.FileNotFoundException; 

import java.io.IOException; 

import org.xml.sax.SAXException; 

import org.w3c.dom.NodeList; 

import org.w3c.dom.Node; 

import java.io.File; 

import javax.xml.transform.TransformerFactory; 

import javax.xml.transform.Transformer; 

import javax.xml.transform.dom.DOMSource; 

import javax.xml.transform.stream.StreamResult; 

import java.util.Map; 



import java.util.HashMap; 

public class KeyXMLTool { 
    private Map propertyCache=new HashMap(); 
    private static String CMBKeyFileName="system-config.xml"; 

    //得到WEB-INF的绝对路径 

    private static String web_inf_Path=new File(KeyXMLTool.class.getResource("/").getPath()).getParent(); 

    private static String CMBKeyFilePath=web_inf_Path+"\\"+CMBKeyFileName; 

    private static DocumentBuilderFactory domfac=DocumentBuilderFactory.newInstance(); 

    public static String getUrl(){ 

    return CMBKeyFilePath; 

    } 

    public static String getFileUrl(String fileName){ 

        String fileUrl=web_inf_Path+"\\"+fileName; 

        return fileUrl; 

    } 

    public static String getRootWebUrl(){ 

        String rootWebUrl=new File(KeyXMLTool.class.getResource("/").getPath()).getParent(); 

        return rootWebUrl; 

    } 

    /** 

     * 获取一Document对象 

     * @param fileName String 

     * @return Document 

     */ 

    private static Document getDocumentByFileName(final String fileName){ 

        Document doc=null; 

        try { 

            DocumentBuilder dombuilder = domfac.newDocumentBuilder(); 

            InputStream in=new FileInputStream(fileName); 

//            InputStream in=ClassLoader.getSystemResourceAsStream(fileName); 

//            InputStream in = KeyXMLTool.class.getResourceAsStream("/Key.xml"); 

            doc=dombuilder.parse(in); 

        } catch (ParserConfigurationException ex) { 

            ex.printStackTrace(); 

        } catch (FileNotFoundException ex) { 

            ex.printStackTrace(); 

        } catch (IOException ex) { 

            ex.printStackTrace(); 

        } catch (SAXException ex) { 

            ex.printStackTrace(); 

        } 

        return doc; 

    } 

    public static String getPINKey(){ 

        String pinKey=null; 

        Document doc=getDocumentByFileName(CMBKeyFilePath); 

        NodeList pinKeyNodeList=doc.getElementsByTagName("pinkey"); 

        Node pinKeyNode=pinKeyNodeList.item(0); 

        pinKey=pinKeyNode.getFirstChild().getNodeValue(); 

        return pinKey; 

    } 

    public static synchronized void setPINKEY(final String pinKey){ 

        Document doc=getDocumentByFileName(CMBKeyFilePath); 

        NodeList pinKeyNodeList=doc.getElementsByTagName("pinkey"); 

        Node pinKeyNode=pinKeyNodeList.item(0); 

        pinKeyNode.getFirstChild().setNodeValue(pinKey); 

        doc2XmlFile(doc,CMBKeyFilePath); 

    } 



    public static String getMACKEY(){ 

        String macKey=null; 

        Document doc=getDocumentByFileName(CMBKeyFilePath); 

        NodeList pinKeyNodeList=doc.getElementsByTagName("mackey"); 

        Node pinKeyNode=pinKeyNodeList.item(0); 

        macKey=pinKeyNode.getFirstChild().getNodeValue(); 

        return macKey; 



    } 



    public static synchronized void setMACKEY(final String macKey){ 

        Document doc=getDocumentByFileName(CMBKeyFilePath); 

        NodeList pinKeyNodeList=doc.getElementsByTagName("mackey"); 

        Node pinKeyNode=pinKeyNodeList.item(0); 

        pinKeyNode.getFirstChild().setNodeValue(macKey); 

        doc2XmlFile(doc,CMBKeyFilePath); 

    } 



    /** 将document中的内容写入文件中   */ 

    public static boolean doc2XmlFile(Document document,String filename){ 

      boolean flag = true; 

      try { 

             TransformerFactory tFactory = TransformerFactory.newInstance(); 

             Transformer transformer = tFactory.newTransformer(); 

            /** 编码 */ 

            //transformer.setOutputProperty(OutputKeys.ENCODING, "GB2312"); 

             DOMSource source = new DOMSource(document); 

             StreamResult result = new StreamResult(new File(filename)); 

             transformer.transform(source, result); 

         }catch(Exception ex) 

         { 

             flag = false; 

             ex.printStackTrace(); 

         } 

        return flag; 

    } 

} 

