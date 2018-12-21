package nis.nms.persistence;

import java.util.regex.Pattern;

import org.hibernate.EmptyInterceptor;
/**
 * mycat 拦截器，修改select语句强制走主库
 * @author ThinkPad
 *
 */
public class MycatInterceptor extends EmptyInterceptor {
	private static final long serialVersionUID = 1L;
	
	
	
	static Pattern nextValPattern = Pattern.compile(".*\\s+nextval\\s*\\(.*",Pattern.CASE_INSENSITIVE);
	static Pattern currValPattern = Pattern.compile(".*\\s+currval\\s*\\(.*",Pattern.CASE_INSENSITIVE);
	public static String interceptSQL(String sql) {
		//包含currval，nextval function 的sql语句强制走 主库
		if(nextValPattern.matcher(sql).matches() || currValPattern.matcher(sql).matches()) {
			sql ="/*#mycat:db_type=master*/" + sql;
		}
		return sql;
	}
	
	@Override
	public String onPrepareStatement(String sql) {
		sql = interceptSQL(sql);
		return super.onPrepareStatement(sql);
	}

}
