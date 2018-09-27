package nis.nms.exceptions;

public class ActionException extends Throwable{
	/**
	 * 
	 */
	private static final long serialVersionUID = -5023210023154666241L;

	//在本类中处理Action抛出的所有异常
	public String getMessage(){
		String message = super.getMessage();
		return message;
	}
}
