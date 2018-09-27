package nis.nms.exceptions;

/**
 * This exception is used to mark access violations.
 *
 * @author Christian Bauer <christian@hibernate.org>
 */
public class PermissionException extends RuntimeException {

	/**
	 * 
	 */
	private static final long serialVersionUID = -772079756143217225L;

	public PermissionException() {}

	public PermissionException(String message) {
		super(message);
	}

	public PermissionException(String message, Throwable cause) {
		super(message, cause);
	}

	public PermissionException(Throwable cause) {
		super(cause);
	}
}
