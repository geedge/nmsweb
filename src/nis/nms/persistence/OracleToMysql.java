package nis.nms.persistence;

import java.util.LinkedHashMap;
import java.util.Objects;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import nis.nms.util.Constant;

import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;

/**
 * oracle 特殊函数 适配 mysql 数据库 sql 转换工具
 * @author fang
 *
 */
public class OracleToMysql {
	static final Logger logger = Logger.getLogger(OracleToMysql.class);
	/**
	 * decode函数正则匹配，不支持括号嵌套
	 */
	static final Pattern DECODE_PATTERN = Pattern.compile("([^\\w]+)decode\\s*\\(([^\\(\\)]*)\\)",Pattern.CASE_INSENSITIVE);
	/**
	 * nvl函数正则匹配
	 */
	static final Pattern NVL_PATTERN = Pattern.compile("[^\\w]+(nvl)\\s*\\(",Pattern.CASE_INSENSITIVE);
	/**
	 * sysdate 
	 */
	static final Pattern SYSDATE_PATTERN = Pattern.compile("[^\\w]+(sysdate)[^\\w]+",Pattern.CASE_INSENSITIVE);
	/**
	 * sysdate-1 oracle 日期加减
	 * ([^\\w]+)(sysdate\\s*([-+])\\s*(\\w+))([^\\w]+)
	 */
	static final Pattern DATE_CAL_PATTERN = Pattern.compile("([^\\w]+)(sysdate\\s*([-+])\\s*([0-9/]+))([^\\w]+|$)",Pattern.CASE_INSENSITIVE);
	
	/**
	 * nextval 
	 */
	static final Pattern NEXTVAL_PATTERN = Pattern.compile("([^\\w]+)([\\w]+)\\s*\\.\\s*nextval([^\\w]+)",Pattern.CASE_INSENSITIVE);
	/**
	 * currval 
	 */
	static final Pattern CURRVAL_PATTERN = Pattern.compile("([^\\w]+)([\\w]+)\\s*\\.\\s*currval([^\\w]+)",Pattern.CASE_INSENSITIVE);
	
	/**
	 * to_date 
	 */
	static final Pattern TO_DATE_PATTERN = Pattern.compile("([\\W])to_date\\s*\\(([^\\)]+),([^\\)]+)",Pattern.CASE_INSENSITIVE);
	
	/**
	 * to_char 
	 */
	static final Pattern TO_CHAR_PATTERN = Pattern.compile("([\\W])to_char\\s*\\(([^\\)]+),([^\\)]+)",Pattern.CASE_INSENSITIVE);
	/**
	 * 数字 转字符 
	 */
	static final Pattern TO_CHAR_CAST_PATTERN = Pattern.compile("([\\W])to_char\\s*\\(([^\\),]+)",Pattern.CASE_INSENSITIVE);
	
	/**
	 * trunc 函数截取日期 只匹配 sysdate 转换成 date_add 的语句
	 */
	static final Pattern TRUNC_DATE_PATTERN = Pattern.compile("[^\\w]+(trunc)\\s*\\(\\s*date_add",Pattern.CASE_INSENSITIVE);
	
	/**
	 * instr函数
	 */
	static final Pattern INSTR_PATTERN = Pattern.compile("([^\\w]+)(instr)\\s*\\(([^\\)]+)\\)",Pattern.CASE_INSENSITIVE);
	
	
	/**
	 * where 条件中的rownum 
	 */
	//static final Pattern WHERE_ROWNUM_PATTERN = Pattern.compile("([^\\w]+)where([^\\)]+)rownum\\s*(<?=?)\\s*(\\d+)([^\\)]*)",Pattern.CASE_INSENSITIVE);
	
	/**
	 * 有些函数参数会出现如下情况 '1,' ，无法正常通过逗号分割 
	 */
	static final Pattern DYH_PATTERN = Pattern.compile("('.+')",Pattern.CASE_INSENSITIVE);
	
	
	
	static final LinkedHashMap<String, String> DATEFORMAT_MAPPING = new LinkedHashMap<String, String>();
	static{
		/*DATEFORMAT_MAPPING.put("","%a");//工作日的缩写名称  (Sun..Sat)
		DATEFORMAT_MAPPING.put("","%b");//月份的缩写名称  (Jan..Dec)
		DATEFORMAT_MAPPING.put("","%c");//月份，数字形式(0..12)
		DATEFORMAT_MAPPING.put("","%D");//带有英语后缀的该月日期  (0th, 1st, 2nd, 3rd, ...)
		DATEFORMAT_MAPPING.put("","%d");//该月日期, 数字形式 (00..31)
		DATEFORMAT_MAPPING.put("","%e");//该月日期, 数字形式(0..31)
		DATEFORMAT_MAPPING.put("","%f");//微秒 (000000..999999)
		DATEFORMAT_MAPPING.put("","%H");//小时(00..23)
		DATEFORMAT_MAPPING.put("","%h");//小时(01..12)
		DATEFORMAT_MAPPING.put("","%I");//小时 (01..12)
		DATEFORMAT_MAPPING.put("","%i");//分钟,数字形式 (00..59)
		DATEFORMAT_MAPPING.put("","%j");//一年中的天数 (001..366)
		DATEFORMAT_MAPPING.put("","%k");//小时 (0..23)
		DATEFORMAT_MAPPING.put("","%l");//小时 (1..12)
		DATEFORMAT_MAPPING.put("","%M");//月份名称 (January..December)
		DATEFORMAT_MAPPING.put("","%m");//月份, 数字形式 (00..12)
		DATEFORMAT_MAPPING.put("","%p");//上午（AM）或下午（ PM）
		DATEFORMAT_MAPPING.put("","%r");//时间 , 12小时制 (小时hh:分钟mm:秒数ss 后加 AM或PM)
		DATEFORMAT_MAPPING.put("","%S");//秒 (00..59)
		DATEFORMAT_MAPPING.put("","%s");//秒 (00..59)
		DATEFORMAT_MAPPING.put("","%T");//时间 , 24小时制 (小时hh:分钟mm:秒数ss)
		DATEFORMAT_MAPPING.put("","%U");//周 (00..53), 其中周日为每周的第一天
		DATEFORMAT_MAPPING.put("","%u");//周 (00..53), 其中周一为每周的第一天 
		DATEFORMAT_MAPPING.put("","%V");//周 (01..53), 其中周日为每周的第一天 ; 和 %X同时使用
		DATEFORMAT_MAPPING.put("","%v");//周 (01..53), 其中周一为每周的第一天 ; 和 %x同时使用
		DATEFORMAT_MAPPING.put("","%W");//工作日名称 (周日..周六)
		DATEFORMAT_MAPPING.put("","%w");//一周中的每日 (0=周日..6=周六)
		DATEFORMAT_MAPPING.put("","%X");//该周的年份，其中周日为每周的第一天, 数字形式,4位数;和%V同时使用
		DATEFORMAT_MAPPING.put("","%x");//该周的年份，其中周一为每周的第一天, 数字形式,4位数;和%v同时使用
		DATEFORMAT_MAPPING.put("","%Y");//年份, 数字形式,4位数
		DATEFORMAT_MAPPING.put("","%y");//年份, 数字形式 (2位数)
		*/
		DATEFORMAT_MAPPING.put("YYYY-MM-DD HH24:MI:SS","%Y-%m-%d %H:%i:%s");
		DATEFORMAT_MAPPING.put("YYYY-MM-DD HH24:MI","%Y-%m-%d %H:%i");
		DATEFORMAT_MAPPING.put("YYYY-MM-DD","%Y-%m-%d");
		DATEFORMAT_MAPPING.put("HH24:MI:SS","%H:%i:%s");
	}
	
	/**
	 * oracle sql 转换 成 mysql 
	 * @param sql
	 * @return
	 */
	public static String trans(String sql){
//		Objects.requireNonNull(sql, "sql语句不能为空");
		Objects.requireNonNull(sql, "The SQL statement cannot be empty");
		logger.debug("before sql -> ：" + sql);
		if(Constant.IS_MYSQL){
			sql = decodeToCaseWhen(sql);
			sql = nextvalToFunction(sql);
			sql = currvalToFunction(sql);
			sql = toCharToDateFormat(sql);
			sql = toDateToStrtodate(sql);
			sql = nvlToIfnull(sql);
			sql = sysdateCal(sql);
			sql = sysdateToNow(sql);
			sql = truncSysdate(sql);
			//sql = instr(sql); //@2018年4月19日15:46:47 直接修改 sql 语句，将 第3,4个参数删除，都是默认 ：1
			sql = toChar(sql);
			logger.debug("after sql -> ：" + sql);
		}
		return sql;
	}
	
	
	/**
	 * oracle decode函数 转换为 case when 语句
	 * @param decode
	 * @return
	 */
	public static String decodeToCaseWhen(String sql){
//		Objects.requireNonNull(sql, "sql语句不能为空");
		Objects.requireNonNull(sql, "The SQL statement cannot be empty");
		Matcher m = DECODE_PATTERN.matcher(sql);
		StringBuffer sb = new StringBuffer();
		while(m.find()){
			String group = m.group(2);
			String[] split = group.split(",");
			int len = split.length;
			StringBuilder caseWhen = new StringBuilder(m.group(1));
			caseWhen.append(" ( case ");
			caseWhen.append(split[0]);
			for(int i = 1;i<len-1;i=i+2){
				caseWhen.append(" when ");
				caseWhen.append(split[i]);
				caseWhen.append(" then ");
				caseWhen.append(split[i+1]);
			}
			if(len%2 == 0){
				caseWhen.append(" else ");
				caseWhen.append(split[len-1]);
			}
			caseWhen.append(" end ) ");
			logger.debug(m.group() +" --> "+caseWhen.toString());
			m.appendReplacement(sb, caseWhen.toString());
		}
		m.appendTail(sb);
		return sb.toString();
	}
	
	/**
	 * oracle nvl 转成 mysql ifNull
	 * @param sql
	 * @return
	 */
	public static String nvlToIfnull(String sql){
		return regexReplace(sql, NVL_PATTERN, "IFNULL" ,1);
	}
	
	/**
	 * sysdate 转成 now()
	 * @param sql
	 * @return
	 */
	public static String sysdateToNow(String sql){
		return regexReplace(sql, SYSDATE_PATTERN, "now()" ,1);
	}
	
	/**
	 * trunc 函数截取日期 只匹配 sysdate 转换成 date_add 的语句
	 * @param sql
	 * @return
	 */
	public static String truncSysdate(String sql){
		return regexReplace(sql, TRUNC_DATE_PATTERN, "date" ,1);
	}
	/**
	 * sysdate 日期加减
	 * ([^\\w]+)(sysdate\\s*([-+])\\s*((\\d+/)*\\d+))([^\\w]+)
	 * @param sql
	 * @return
	 */
	public static String sysdateCal(String sql){
//		Objects.requireNonNull(sql, "sql语句不能为空");
		Objects.requireNonNull(sql, "The SQL statement cannot be empty");
		Matcher m = DATE_CAL_PATTERN.matcher(sql);
		StringBuffer sb = new StringBuffer();
		while(m.find()){
			StringBuilder temp = new StringBuilder();
			String signal = m.group(3);//signal - +
			String number = m.group(4);// \\d+
			temp.append(m.group(1));
			temp.append("date_add(now(),interval ");
			temp.append(signal);
			temp.append(number);
			temp.append("*24*60*60 second)");
			temp.append(m.group(5));
			logger.debug(m.group() +" --> "+temp.toString());
			m.appendReplacement(sb, temp.toString());
		}
		m.appendTail(sb);
		return sb.toString();
	}
	
	/**
	 * oracle 序列 转成 mysql 自定义函数 nextval('')
	 * @return
	 */
	public static String nextvalToFunction(String sql){
//		Objects.requireNonNull(sql, "sql语句不能为空");
		Objects.requireNonNull(sql, "The SQL statement cannot be empty");
		Matcher m = NEXTVAL_PATTERN.matcher(sql);
		StringBuffer sb = new StringBuffer();
		while(m.find()){
			StringBuilder temp = new StringBuilder();
			String seqName = m.group(2);//seq name
			temp.append(m.group(1));
			temp.append(Constant.NEXTVAL_FUNCTION_NAME);
			temp.append("('");
			temp.append(seqName);
			temp.append("')");
			temp.append(m.group(3));
			logger.debug(m.group() +" --> "+temp.toString());
			m.appendReplacement(sb, temp.toString());
		}
		m.appendTail(sb);
		return sb.toString();
	}
	
	
	/**
	 * oracle 序列 转成 mysql 自定义函数 currval('')
	 * @return
	 */
	public static String currvalToFunction(String sql){
//		Objects.requireNonNull(sql, "sql语句不能为空");
		Objects.requireNonNull(sql, "The SQL statement cannot be empty");
		Matcher m = CURRVAL_PATTERN.matcher(sql);
		StringBuffer sb = new StringBuffer();
		while(m.find()){
			StringBuilder temp = new StringBuilder();
			String seqName = m.group(2);//seq name
			temp.append(m.group(1));
			temp.append(Constant.CURRVAL_FUNCTION_NAME);
			temp.append("('");
			temp.append(seqName);
			temp.append("')");
			temp.append(m.group(3));
			logger.debug(m.group() +" --> "+temp.toString());
			m.appendReplacement(sb, temp.toString());
		}
		m.appendTail(sb);
		return sb.toString();
	}
	
	/**
	 * oracle to_date 函数 转换为 str_to_date
	 * @param sql
	 * @return
	 */
	public static String toDateToStrtodate(String sql){
//		Objects.requireNonNull(sql, "sql语句不能为空");
		Objects.requireNonNull(sql, "The SQL statement cannot be empty");
		Matcher m = TO_DATE_PATTERN.matcher(sql);
		StringBuffer sb = new StringBuffer();
		while(m.find()){
			StringBuilder temp = new StringBuilder();
			String fm = m.group(3);//seq name
			String mfm = DATEFORMAT_MAPPING.get(fm.replaceAll("'", "").trim().toUpperCase());
//			Objects.requireNonNull(mfm, fm + " 没有mysql格式化映射");
			Objects.requireNonNull(mfm, fm + " No MySQL formatting mappings");
			temp.append(m.group(1));
			temp.append("str_to_date(");
			temp.append(m.group(2));
			temp.append(",'");
			temp.append(mfm);
			temp.append("'");
			logger.debug(m.group() +" --> "+temp.toString());
			m.appendReplacement(sb, temp.toString());
		}
		m.appendTail(sb);
		return sb.toString();
	}
	
	/**
	 * oracle to_char 函数 转换为 date_format
	 * @param sql
	 * @return
	 */
	public static String toCharToDateFormat(String sql){
//		Objects.requireNonNull(sql, "sql语句不能为空");
		Objects.requireNonNull(sql, "The SQL statement cannot be empty");
		Matcher m = TO_CHAR_PATTERN.matcher(sql);
		StringBuffer sb = new StringBuffer();
		while(m.find()){
			StringBuilder temp = new StringBuilder();
			String fm = m.group(3);//seq name
			String mfm = DATEFORMAT_MAPPING.get(fm.replaceAll("'", "").trim().toUpperCase());
//			Objects.requireNonNull(mfm, fm + " 没有mysql格式化映射");
			Objects.requireNonNull(mfm, fm + " No MySQL formatting mappings");
			temp.append(m.group(1));
			temp.append("date_format(");
			temp.append(m.group(2));
			temp.append(",'");
			temp.append(mfm);
			temp.append("'");
			logger.debug(m.group() +" --> "+temp.toString());
			m.appendReplacement(sb, temp.toString());
		}
		m.appendTail(sb);
		return sb.toString();
	}
	
	/**
	 *  数字转字符，只匹配 to_char 有一个参数的
	 *  ([\\W]+)to_char\\s*\\(([^\\),]+))
	 * @param sql
	 * @return
	 */
	public static String toChar(String sql){
//		Objects.requireNonNull(sql, "sql语句不能为空");
		Objects.requireNonNull(sql, "The SQL statement cannot be empty");
		Matcher m = TO_CHAR_CAST_PATTERN.matcher(sql);
		StringBuffer sb = new StringBuffer();
		while(m.find()){
			StringBuilder temp = new StringBuilder();
			temp.append(m.group(1));
			temp.append(" convert(");
			temp.append(m.group(2));
			temp.append(" , CHAR ");
			logger.debug(m.group() +" --> "+temp.toString());
			m.appendReplacement(sb, temp.toString());
		}
		m.appendTail(sb);
		return sb.toString();
	}
	
	
	/**
	 * instr mysql 只有两个参数
	 * 查遍所有 instr 函数，第三四个参数都为 1可以省略，若不为 1 则不能使用此函数
	 * ([^\\w]+)(instr)\\s*\\(([^\\)]+)\\)
	 * @param sql
	 * @return
	 */
	public static String instr(String sql){
//		Objects.requireNonNull(sql, "sql语句不能为空");
		Objects.requireNonNull(sql, "The SQL statement cannot be empty");
		Matcher m = INSTR_PATTERN.matcher(sql);
		StringBuffer sb = new StringBuffer();
		while(m.find()){
			StringBuilder temp = new StringBuilder();
			String param = m.group(3);//seq name
			Matcher dyh = DYH_PATTERN.matcher(param);
			StringBuffer ss = new StringBuffer();
			while(dyh.find()){
				String group = dyh.group(1);
				group = group.replaceAll(",", "@@@");
				dyh.appendReplacement(ss, group);
			}
			dyh.appendTail(ss);
			String[] params = ss.toString().split(",");
			temp.append(m.group(1));
			temp.append("instr(");
			temp.append(params[0].replaceAll("@@@", ","));
			temp.append(",");
			temp.append(params[1].replaceAll("@@@", ","));
			temp.append(")");
			logger.debug(m.group() +" --> "+temp.toString());
			m.appendReplacement(sb, temp.toString());
		}
		m.appendTail(sb);
		return sb.toString();
	}
	
	
	/**
	 * 替换 rownum -> limit
	 * ([^\\w]+)where([^\\)]+)rownum\\s*(<?=?)\\s*(\\d+)([^\\)]*)
	 * @param sql
	 * @return
	 */
	/*public static String whereRownum(String sql){
		Objects.requireNonNull(sql, "sql语句不能为空");
		Matcher m = WHERE_ROWNUM_PATTERN.matcher(sql);
		StringBuffer sb = new StringBuffer();
		while(m.find()){
			StringBuilder temp = new StringBuilder();
			String signal = m.group(3);
			int num = Integer.valueOf(m.group(4).trim());
			if(!signal.contains("=")){
				num = num -1;
			}
			temp.append(m.group(1));
			temp.append("where");
			temp.append(m.group(2));
			temp.append(" 1=1 ");
			temp.append(m.group(5));
			temp.append(" limit ");
			temp.append(num);
			logger.debug(m.group() +" --> "+temp.toString());
			m.appendReplacement(sb, temp.toString());
		}
		m.appendTail(sb);
		return sb.toString();
	}*/
	
	/**
	 * 正则替换
	 * @param sql
	 * @param p
	 * @param replace
	 * @return
	 */
	private static String regexReplace(String sql,Pattern p,String replace,Integer groupNum){
//		Objects.requireNonNull(sql, "sql语句不能为空");
		Objects.requireNonNull(sql, "The SQL statement cannot be empty");
		Matcher m = p.matcher(sql);
		StringBuffer sb = new StringBuffer();
		while(m.find()){
			String group = m.group();
			if(groupNum != null && groupNum > 0){
				String gn = m.group(groupNum);
				group = group.replace(gn, replace);
			}
			logger.debug(m.group() +" --> "+group);
			m.appendReplacement(sb, group);
		}
		m.appendTail(sb);
		return sb.toString();
	}
	
	
	
	
	
	
	/**
	 * @param args
	 */
	public static void main(String[] args) {
		PropertyConfigurator.configure("D:\\Workspaces\\nmsweb\\src\\conf\\log4j.properties");
		String sql = "select seq.nextval,t,test,hahh,, to_char(test,'yyyy-mm-dd') ,decode (field,1,2) d, nvl(aa,'1'),sysdate from dual where  rownum < 4 order by id desc ";
		sql = "select count(*) as col_0_0_ from mission_state_table missionsta0_ where missionsta0_.mission_id>0 and missionsta0_.mission_id=8441 and (missionsta0_.Mission_State=3 or missionsta0_.Mission_State=30 or missionsta0_.Mission_State=31 or missionsta0_.Mission_State=32) and (missionsta0_.IS_LOOK is null or missionsta0_.IS_LOOK='1' or missionsta0_.IS_LOOK='0' and instr(missionsta0_.LOOK_USER_ID, '1')=0 and instr(missionsta0_.LOOK_USER_ID, to_char(missionsta0_.user_id), 1)=0 or missionsta0_.IS_LOOK='0' and (missionsta0_.LOOK_USER_ID is null))";
		//String str = trans(sql);
		//str = whereRownum(str);
		String str = trans(sql);
		System.out.println(str);
		//([^\\w]+)(instr)\\s*\\(([^\\)]+)\\)
		/*Pattern p = Pattern.compile("([^\\w]+)(instr)\\s*\\((?!)(('.+',)|([^,\\)]+,)){1,3}(?!)(('.+')|([^,\\)]+))\\)");
		String str1 = " instr(t.lookUserIds,'1,',12,13) ";
		String instr = instr(str1);
		System.out.println(instr);*/
		
	}

}
