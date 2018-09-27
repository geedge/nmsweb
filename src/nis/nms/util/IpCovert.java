package nis.nms.util;

import java.util.regex.Pattern;

public class IpCovert {
	
	public static long ipToLong(String strIP)
     //将127.0.0.1 形式的IP地址转换成10进制整数，这里没有进行任何错误处理
     {
          int j=0;
          int i=0;
          long [] ip=new long[4];
          int position1=strIP.indexOf(".");
          int position2=strIP.indexOf(".",position1+1);
          int position3=strIP.indexOf(".",position2+1);  
          ip[0]=Long.parseLong(strIP.substring(0,position1));
          ip[1]=Long.parseLong(strIP.substring(position1+1,position2));
          ip[2]=Long.parseLong(strIP.substring(position2+1,position3));
          ip[3]=Long.parseLong(strIP.substring(position3+1));
          return (ip[0]<<24)+(ip[1]<<16)+(ip[2]<<8)+ip[3]; 
     }
     public static String longToIP(long longIP)
     //将10进制整数形式转换成127.0.0.1形式的IP地址，按主机序
     {
          StringBuffer sb=new StringBuffer("");
          sb.append(String.valueOf(longIP>>>24&0xFF));//直接右移24位
          sb.append(".");          //将高8位置0，然后右移16位
          sb.append(String.valueOf((longIP&0x00FFFFFF)>>>16)); 
          sb.append(".");
          sb.append(String.valueOf((longIP&0x0000FFFF)>>>8));
          sb.append(".");
          sb.append(String.valueOf(longIP&0x000000FF));
          //sb.append(".");
          return sb.toString(); 
     } 
     //将10进制整数形式转换成127.0.0.1形式的IP地址，按网络序
     public static String longToNetIp(long longIP){
    	 StringBuffer sb=new StringBuffer("");
    	 sb.append(String.valueOf(longIP&0x000000FF));         
         sb.append(".");          
         sb.append(String.valueOf((longIP&0x0000FFFF)>>>8));         
         sb.append(".");//将高8位置0，然后右移16位
         sb.append(String.valueOf((longIP&0x00FFFFFF)>>>16));
         sb.append(".");
         sb.append(String.valueOf(longIP>>>24&0xFF));//直接右移24位
         //sb.append(".");
         return sb.toString(); 
     }
     public static long netIpToLong(String strIP)
     //将127.0.0.1 形式的IP地址转换成10进制整数，这里没有进行任何错误处理
     {
          int j=0;
          int i=0;
          long [] ip=new long[4];
          int position1=strIP.indexOf(".");
          int position2=strIP.indexOf(".",position1+1);
          int position3=strIP.indexOf(".",position2+1);  
          ip[0]=Long.parseLong(strIP.substring(0,position1));
          ip[1]=Long.parseLong(strIP.substring(position1+1,position2));
          ip[2]=Long.parseLong(strIP.substring(position2+1,position3));
          ip[3]=Long.parseLong(strIP.substring(position3+1));
          return (ip[0])+(ip[1]<<8)+(ip[2]<<16)+(ip[3]<<24); 
     }
//     public static String longToPort(long longPort){
//    	 StringBuffer sb=new StringBuffer("");
//    	 sb.append(String.valueOf(longPort&0x000000FF));  
//    	 
//         //sb.append(".");          
//         sb.append(String.valueOf((longPort&0x0000FF00)>>>8));  
//         return sb.toString();
//     }
     
   //测试IP地址是否合法 
     public boolean isIp(String ipAddress){ 
//         String test = "([1-9]|[1-9]\\d|1\\d{2}|2[0-1]\\d|22[0-3])(\\.(\\d|[1-9]\\d|1\\d{2}|2[0-4]\\d|25[0-5])){3}"; 
//         Pattern pattern = Pattern.compile(test); 
//         Matcher matcher = pattern.matcher(ipAddress); 
//         return matcher.matches();          
         String regex0 = "(2[0-4]\\d)" + "|(25[0-5])";
 		 String regex1 = "1\\d{2}";
 		 String regex2 = "[1-9]\\d";
 		 String regex3 = "\\d";
 		 String regex = "(" + regex0 + ")|(" + regex1 + ")|(" + regex2 + ")|(" + regex3 + ")";
 		 regex = "(" + regex + ").(" + regex + ").(" + regex + ").(" + regex + ")";
 		 String[] str = ipAddress.split("\\.");//根据@拆分IP地址
 		 if (!Pattern.matches(regex, ipAddress))
			return false;
 		 else if(str!=null && str.length!=4){//如果IP地址拆分后的数组长度不为4则不是正确的IP地址
 			 return false;
 		 }else{
			return true; 
 		 }
     }

}
