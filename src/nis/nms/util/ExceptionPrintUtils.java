package nis.nms.util;

public class ExceptionPrintUtils {
    public static String printExceptionStack(Exception e){
    	StackTraceElement[] ste = e.getStackTrace();
    	StringBuffer sb = new StringBuffer();
    	sb.append("\n\t" + e.toString() + "\n");
    	for(StackTraceElement element : ste){
    		sb.append("\t" + element.toString() + "\n");
    	}
    	return sb.toString();
    }
}
