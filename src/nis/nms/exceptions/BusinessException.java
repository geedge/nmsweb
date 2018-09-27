package nis.nms.exceptions;

/**
 * This exception is used to mark business rule violations.
 *
 * @author Christian Bauer <christian@hibernate.org>
 */
public class BusinessException extends RuntimeException {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1275639675329076996L;

	public BusinessException() {}

	public BusinessException(String message) {
		super(message);
	}

	public BusinessException(String message, Throwable cause) {
		super(message, cause);
	}

	public BusinessException(Throwable cause) {
		super(cause);
	}
}
