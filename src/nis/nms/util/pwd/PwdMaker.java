package nis.nms.util.pwd;

import java.util.Random;

public class PwdMaker {
	/**
	 * @param args
	 */
	public static void main(String[] args) {
		// TODO Auto-generated method stub		
		 System.out.println(genRandomNum(10));
	}
	public static String genRandomNum(int pwd_len){
		//因为数组是从0开始，26个字母加10个数字，数组长度36，下标到35
		final int maxNum = 63;
		int i;//生成的随机数
		int count = 0;//生成的密码长度
		char[] str = { 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k',
			    'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w',
			    'x', 'y', 'z','A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K',
			    'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W',
			    'X', 'Y', 'Z', '0', '1', '2', '3', '4', '5', '6', '7', '8', '9','_' };
		StringBuffer pwd = new StringBuffer("");
		  Random r = new Random();
		  while(count < pwd_len){
		   //生成随机数，取绝对值，防止生成负数，		   
		   i = Math.abs(r.nextInt(maxNum));  //生成的数最大为36-1
		   
		   if (i >= 0 && i < str.length) {
		    pwd.append(str[i]);
		    count ++;
		   }
		  }
		  
		  return pwd.toString();
	 }
	/**
	 * 得到保护密码
	 * @param pwdString
	 * @param yhbh
	 * @return
	 */
	public static String getProtectPwd(String pwdString,String yhbh){
		if(pwdString!=null){
			//如果密码长度小于YHBH不会长度，则直接在密码后添加YHBH
			if(pwdString.length()<yhbh.length()){
				pwdString += pwdString + yhbh;
			}else{//否则在密码的YHBH长度出添加yhbh，其他内容后移
				for(int i = 0; i < pwdString.length(); i++ ){
					if(i == yhbh.length()){
						pwdString = pwdString.substring(0, i)+yhbh+pwdString.substring(i, pwdString.length());
					}
				}
			}
		}
		return pwdString;
	}
}
