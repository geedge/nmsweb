package nis.nms.util;

import java.text.ParseException;
import java.text.ParsePosition;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

import org.apache.commons.lang.StringUtils;

public class DateUtil {
	public static final Calendar calendar = Calendar.getInstance();
	public static SimpleDateFormat dfNoSS = new SimpleDateFormat("yyyy-MM-dd HH:mm");
	public static SimpleDateFormat format= new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	public static SimpleDateFormat formatForDate= new SimpleDateFormat("yyyy-MM-dd");
	// 当前时间
	public static long CURRENT_TIME = Calendar.getInstance().getTimeInMillis();
	// 今日零点
	public static long TODAY_ZERO_TIME = calendar.getTimeInMillis()
			- (calendar.get(Calendar.HOUR_OF_DAY) * 1000 * 3600
			+ calendar.get(Calendar.MINUTE) * 1000 * 60 
			+ calendar.get(Calendar.SECOND) * 1000);
	// 昨日零点
	public static long YESTODAY_ZERO_TIME = calendar.getTimeInMillis()
			- (calendar.get(Calendar.HOUR_OF_DAY) * 1000 * 3600
			+ calendar.get(Calendar.MINUTE) * 1000 * 60
			+ calendar.get(Calendar.SECOND) * 1000 + 24 * 1000 * 3600);
	// 一周前零点
	public static long WEEK_ZERO_TIME = calendar.getTimeInMillis()
			- (calendar.get(Calendar.HOUR_OF_DAY) * 1000 * 3600
			+ calendar.get(Calendar.MINUTE) * 1000 * 60
			+ calendar.get(Calendar.SECOND) * 1000 + 7 * 24 * 1000 * 3600);
	/*根据指定日期，得到一周之内星期数*/
	public static String [] converDatetoWeekArray(Calendar c){
		int day = c.get(Calendar.DAY_OF_WEEK);//周日为1
		String [] week = new String[7];
		for(int i=6;i>=0;i--){
			day = day & 7; //八进制循环得到期1-7
			if(day ==0) day = 7;//如果为000改为111
			
			switch(day){
			case 1:
				week[i]=BaseAction.getI18nText("i18n_DateUtil.converDatetoWeekArray.sun_n81i");
				break;
			case 2:
				week[i]=BaseAction.getI18nText("i18n_DateUtil.converDatetoWeekArray.mon_n81i");
				break;
			case 3:
				week[i]=BaseAction.getI18nText("i18n_DateUtil.converDatetoWeekArray.tues_n81i");
				break;
			case 4:
				week[i]=BaseAction.getI18nText("i18n_DateUtil.converDatetoWeekArray.wed_n81i");
				break;
			case 5:
				week[i]=BaseAction.getI18nText("i18n_DateUtil.converDatetoWeekArray.thur_n81i");
				break;
			case 6:
				week[i]=BaseAction.getI18nText("i18n_DateUtil.converDatetoWeekArray.fri_n81i");
				break;
			case 7:
				week[i]=BaseAction.getI18nText("i18n_DateUtil.converDatetoWeekArray.sat_n81i");
			}
			
			day-=1;//与day+=7同效
		}
		return week;
	}
	public static String longToDate(Long longDate,String formateString)
    //将Long性时间转换成String型
    {
		String dateStr = null;
		if(longDate !=null &&!"".equals(formateString) ) {
			SimpleDateFormat time = new SimpleDateFormat(formateString);			
			Date date = new Date(longDate);
			dateStr = time.format(date);
		}
        return dateStr; 
    } 
    
    public static Long dateToLong (Date date){
    	return date.getTime();
    }
    
    //获得时间 yyyy-mm-dd hh:mm
    public static String getFormatDate(Date date) { // 得到当前时间
		if (date != null) {
			return dfNoSS.format(date);
		} else {
			return "";
		}
	}
    
    public static String getCurDateStr() { // 得到当前时间
    	return format.format(new Date());
    }
    
    public static String getShortCurDateStr() { // 得到当前时间
    	return formatForDate.format(new Date());
    }
    
    public static String getShortDateStrByMinusDay(int minusDay) { // 得到当前日期减去指定天对应日期的字符串
    	Calendar cal = Calendar.getInstance();
    	int day = cal.get(Calendar.DATE);
    	cal.set(Calendar.DATE, day-minusDay);    	
    	return formatForDate.format(cal.getTime());
    }
    
    //两个日期返回大的
    public static String getBigDate(String date1,String date2) throws Exception{
    	String bigDate = "";
    	if(isDate(date1, "yyyy-MM-dd HH:mm")&&isDate(date2, "yyyy-MM-dd HH:mm")) {
			Date d1 = dfNoSS.parse(date1);
			Date d2 = dfNoSS.parse(date2);
			int rlt = d1.compareTo(d2);
    		if(rlt>=0) {
    			bigDate = date1;
    		}else {
    			bigDate = date2;
    		}
    	}
    	return bigDate;
    }
    
    //两个日期返回小的
    public static String getSmallDate(String date1,String date2) throws Exception{
    	String smallDate = "";
    	if(isDate(date1, "yyyy-MM-dd HH:mm")&&isDate(date2, "yyyy-MM-dd HH:mm")) {
    		Date d1 = dfNoSS.parse(date1);
    		Date d2 = dfNoSS.parse(date2);
    		int rlt = d1.compareTo(d2);
    		if(rlt>=0) {
    			smallDate = date2;
    		}else {
    			smallDate = date1;
    		}
    	}
    	return smallDate;
    }
    
    //获得指定日期前n个小时的日期
    public static Date getBeforeHourDate(Date date,int n) {
    	
    	Calendar cal = Calendar.getInstance();
    	cal.setTime(date);
    	cal.set(Calendar.HOUR, cal.get(Calendar.HOUR)-n);
    	date = cal.getTime();
    	return date; 
    }
    
	/**
	 * 得到过去时间，距当前时间多少天多少小时
	 */
	public static String getDateInterval(Calendar before,Calendar now){
		StringBuffer date = new StringBuffer();
		if(now.get(Calendar.DAY_OF_MONTH) - before.get(Calendar.DAY_OF_MONTH) >0 ){
			date.append(now.get(Calendar.DAY_OF_MONTH) - before.get(Calendar.DAY_OF_MONTH)).append("天");
		}
		if(now.get(Calendar.HOUR_OF_DAY)- before.get(Calendar.HOUR_OF_DAY) > 0){
			date.append(now.get(Calendar.HOUR_OF_DAY)- before.get(Calendar.HOUR_OF_DAY)).append("小时");
		}
		return date.append(BaseAction.getI18nText("i18n_DateUtil.converDatetoWeekArray.before_n81i")).toString();
	}
	 /**   
     *   Get   the   date   of   monday   in   this   week   
     *     
     *   @return   yyyy-MM-dd   
     */   
   public   static   String   getMondayOfThisWeek(Date date)   {   
           String   strTemp   =   "";   
           Calendar   c   =   Calendar.getInstance();   
           c.setTime(date);
           int   dayofweek   =   c.get(Calendar.DAY_OF_WEEK)   -   1;   
           if   (dayofweek   ==   0)   
                   dayofweek   =   7;   
           c.add(Calendar.DATE,   -dayofweek   +   1);   
           strTemp   =   c.get(1)   +   "-";   
           if   (c.get(2)   +   1   <   10)   
                   strTemp   +=   "0";   
           strTemp   =   strTemp   +   (c.get(2)   +   1)   +   "-";   
           if   (c.get(5)   <   10)   
                   strTemp   +=   "0";   
           strTemp   +=   c.get(5);   
           return   strTemp;   
   }   

   /**   
     *   Get   the   date   of   sunday   in   this   week   
     *     
     *   @return   yyyy-MM-dd   
     */   
   public   static   String   getSundayOfThisWeek(Date date)   {   
           String   strTemp   =   "";   
           Calendar   c   =   Calendar.getInstance();   
           c.setTime(date);
           int   dayofweek   =   c.get(Calendar.DAY_OF_WEEK)   -   1;   
           if   (dayofweek   ==   0)   
                   dayofweek   =   7;   
           c.add(Calendar.DATE,   -dayofweek   +   7);   
           strTemp   =   c.get(1)   +   "-";   
           if   (c.get(2)   +   1   <   10)   
                   strTemp   +=   "0";   
           strTemp   =   strTemp   +   (c.get(2)   +   1)   +   "-";   
           if   (c.get(5)   <   10)   
                   strTemp   +=   "0";   
           strTemp   +=   c.get(5);   
           return   strTemp;   
   }
   
   /**   
    *   Get   the   date   of   firstDay   in   this   month   
    *     
    *   @return   yyyy-MM-dd   
    */   
  public   static   String   getFirtDayOfThisMonth(Date date)   {   
          String   strTemp   =   "";   
          Calendar   c   =   Calendar.getInstance();   
          c.setTime(date);
          SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
          int days = c.getActualMinimum(Calendar.DAY_OF_MONTH);
          c.set(Calendar.DAY_OF_MONTH, days);
          strTemp = format.format(c.getTime());
          return   strTemp;   
  }
	  /**   
	   *   Get   the   date   of   endDay   in   this   month   
	   *     
	   *   @return   yyyy-MM-dd   
	   */   
	 public   static   String   getEndDayOfThisMonth(Date date)   {   
	         String   strTemp   =   "";   
	         Calendar   c   =   Calendar.getInstance();   
	         c.setTime(date);
	         SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
             int days = c.getActualMaximum(Calendar.DAY_OF_MONTH);
             c.set(Calendar.DAY_OF_MONTH, days);
             strTemp = format.format(c.getTime()); 
	         return   strTemp;   
	 }
	 /**   
	    *   Get   the   date   of   firstDay   in   this   year   
	    *     
	    *   @return   yyyy-MM-dd   
	    */   
	  public   static   String   getFirtDayOfThisYear(Date date)   {   
	          String   strTemp   =   "";   
	          Calendar   c   =   Calendar.getInstance();   
	          c.setTime(date);
	          SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
	          int days = c.getActualMinimum(Calendar.DAY_OF_YEAR);
	          c.set(Calendar.DAY_OF_YEAR, days);
	          strTemp = format.format(c.getTime());
	          return   strTemp;   
	  }
		  /**   
		   *   Get   the   date   of   endDay   in   this   year   
		   *     
		   *   @return   yyyy-MM-dd   
		   */   
	 public   static   String   getEndDayOfThisYear(Date date)   {   
	         String   strTemp   =   "";   
	         Calendar   c   =   Calendar.getInstance();   
	         c.setTime(date);
	         SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
	         int days = c.getActualMaximum(Calendar.DAY_OF_YEAR);
	         c.set(Calendar.DAY_OF_YEAR, days);
	         strTemp = format.format(c.getTime());   
	         return   strTemp;   
	 }
	 /**
		 * 将日期由字符串转成日期型
		 * @param s yyyy-MM-dd HH:mm:ss
		 * @return yyyy-MM-dd HH:mm:ss
		 */
		public static Date getDateD(String s) {
			SimpleDateFormat dateFormatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			ParsePosition pos = new ParsePosition(0);
			return dateFormatter.parse(s, pos);
		}
		/**
		 * 校验是否为时间类型
		 * @param str_input
		 * @param rDateFormat
		 * @return
		 */
		public static boolean isDate(String str_input,String rDateFormat){
			if (StringUtils.isNotBlank(str_input)) {
		         SimpleDateFormat formatter = new SimpleDateFormat(rDateFormat);
		         formatter.setLenient(false);
		         try {
		             formatter.format(formatter.parse(str_input));
		             return true;
		         } catch (Exception e) {
		             return false;
		         }
		     }
			return false;
		}
}
