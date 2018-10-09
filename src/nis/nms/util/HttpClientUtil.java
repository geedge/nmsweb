package nis.nms.util;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.apache.http.HttpStatus;
import org.apache.http.NameValuePair;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.util.EntityUtils;
import org.apache.log4j.Logger;


public class HttpClientUtil {
	
	protected static Logger logger = Logger.getLogger(HttpClientUtil.class);
	
	 /** 
     * 处理get请求. 
     * @param url  请求路径 
     * @return  json 
	 * @throws IOException 
	 * @throws ClientProtocolException 
     */  
    public static String get(String url) throws ClientProtocolException, IOException{  
        //实例化httpclient  
        CloseableHttpClient httpclient = HttpClients.createDefault();  
        //实例化get方法  
        HttpGet httpget = new HttpGet(url);   
        //请求结果  
        CloseableHttpResponse response = null;  
        String content = "";
        try {  
            //执行get方法  
            response = httpclient.execute(httpget);  
            if(response.getStatusLine().getStatusCode()==HttpStatus.SC_OK){  
                content = EntityUtils.toString(response.getEntity(),"utf-8");
                logger.debug("获取消息成功，相应内容如下： " + content);
            }  
        } catch (ClientProtocolException e) {  
            e.printStackTrace();  
        } catch (IOException e) {  
            e.printStackTrace();  
        }  
        return content;  
    }  
    
    /** 
     * 处理post请求. 
     * @param url  请求路径 
     * @param josn 参数 
     * @return  json 
     * @throws IOException 
     * @throws ClientProtocolException 
     */  
    public String post(String url, String json) throws ClientProtocolException, IOException{  
        //实例化httpClient  
    	logger.info("发送post请求：" + url);
    	logger.debug("发送post请求：" + url + ":::" + json);
        CloseableHttpClient httpclient = HttpClients.createDefault();  
        //实例化post方法  
        HttpPost httpPost = new HttpPost(url);   
        StringEntity entity = new StringEntity(json, "utf-8");
        entity.setContentEncoding("utf-8");
        httpPost.setHeader("Content-type", "application/json");
        httpPost.setEntity(entity);
        //结果  
        CloseableHttpResponse response = null;  
        String content = "";  
        //执行post方法  
        response = httpclient.execute(httpPost);  
        content = EntityUtils.toString(response.getEntity(), "utf-8");
        logger.info("post请求结束：" + response.getStatusLine().getStatusCode());
        logger.debug("post请求结束：" + response.getStatusLine().getStatusCode() + ":::" + content);
        return content;  
    }  
}
