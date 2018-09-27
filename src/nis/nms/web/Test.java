package nis.nms.web;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.InputStream;

import org.apache.log4j.Logger;


public class Test {
	static Logger logger=Logger.getLogger(Test.class);
	public static void main(String[] args) {
		File zh=new File("D:\\Workspaces\\wwrWork\\nmsweb\\WebRoot\\i18n\\globalMessages_zh_CN.properties");
		File ru=new File("D:\\Workspaces\\wwrWork\\nmsweb\\WebRoot\\i18n\\globalMessages_ru_RU.properties");
		if(!zh.exists()||!ru.exists()){
			logger.error("文件未找到");
			return ;
		}
		try {
			BufferedReader zhReader=new BufferedReader(new FileReader(zh));
			BufferedReader ruReader=new BufferedReader(new FileReader(ru));
			
			String zhLine=null;
			String ruLine=null;
			
			int rowNum=0;
			
			while((zhLine=zhReader.readLine())!=null&&(ruLine=ruReader.readLine())!=null){
				if(zhLine.startsWith("#")||ruLine.startsWith("#")){
					rowNum++;
					continue;
				}
				rowNum++;
				
				if(rowNum==4348){
					System.out.println("bug点");
				}
				String[] zhSplit=zhLine.split("=");
				String[] ruSplit=ruLine.split("=");
				
				if((zhSplit==null||zhSplit.length<2)||(ruSplit==null||ruSplit.length<2)){
					if(zhLine.equals(ruLine)){
						continue;
					}else{
						logger.error("此行不匹配："+rowNum);
						return ;
					}
					
				}
				
				String zhKey=zhSplit[0];
				String ruKey=ruSplit[0];
				
				if(zhKey.equals(ruKey)){
					continue;
				}else{
					logger.error("行不匹配："+rowNum);
					return ;
				}
			}
				
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}

}
