package nis.nms.util;

public class UpdateParams extends java.util.ListResourceBundle {
	public static String CONFIG_UPDATE_FLAG = "config.update.flag";		//更新标示 固定 判断配置文件指定值更新 建议自增1操作
	public static String CONFIG_UPDATE_FLAG_VALUE = "6";
    static final String[][] contents = new String[][]{
    	{CONFIG_UPDATE_FLAG,CONFIG_UPDATE_FLAG_VALUE},		//更新标示 固定 判断配置文件指定值更新 建议自增1操作
//    	{"detec.switch.str","switchport"},		//	更新switch 监测类别
//    	{"detec.ping.str","ping"},	//	更新ping 监测类别
//    	{"detec.systeminfo.str","systeminfo"},	//	更新systeminfo 监测类别
//    	{"detec.system.str","system"},	//	更新systeminfo 监测类别
//    	{"detec.nmsclient.str","nmsclient"},	//	更新nmsclient 监测类别
//    	{"email.flag","1"},
    	//2014-1-2 hyx add
//    	{"detec.timeout.police.emergent","0"}, //超周期告警紧急状态
//    	{"detec.timeout.police.level","0"}, //告警级别
//    	{"default.search.history.detect.data.day","3"}//默认查询历史监测数据的时间：单位天,3天
    };
    public Object[][] getContents() {
        return contents;
    }
}
