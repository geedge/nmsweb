package com.nms.thread.utils;

import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Iterator;
import java.util.NoSuchElementException;
import java.util.concurrent.atomic.AtomicReferenceFieldUpdater;

public class SQLExecuteTimeoutException extends SQLException implements Iterable<Throwable>{

    /**
     *  Constructs a <code>SQLExecuteTimeoutExeception</code> object with a given
     * <code>reason</code>, <code>SQLState</code>  and 
     * <code>vendorCode</code>.
     *
     * The <code>cause</code> is not initialized, and may subsequently be
     * initialized by a call to the 
     * {@link Throwable#initCause(java.lang.Throwable)} method.
     * <p>
     * @param reason a description of the exception 
     * @param SQLState an XOPEN or SQL:2003 code identifying the exception
     * @param vendorCode a database vendor-specific exception code
     */
    public SQLExecuteTimeoutException(String reason, String SQLState, int vendorCode) {
	super(reason);
	this.SQLState = SQLState;
	this.vendorCode = vendorCode;
//	if (!(this instanceof SQLWarning)) {
	    if (DriverManager.getLogWriter() != null) {
		DriverManager.println("SQLState(" + SQLState +
						") vendor code(" + vendorCode + ")");
		printStackTrace(DriverManager.getLogWriter());
	    }
//	}
    }


    /**
     * Constructs a <code>SQLExecuteTimeoutExeception</code> object with a given
     * <code>reason</code> and <code>SQLState</code>.
     *
     * The <code>cause</code> is not initialized, and may subsequently be
     * initialized by a call to the 
     * {@link Throwable#initCause(java.lang.Throwable)} method. The vendor code
     * is initialized to 0.
     * <p>
     * @param reason a description of the exception 
     * @param SQLState an XOPEN or SQL:2003 code identifying the exception 
     */
    public SQLExecuteTimeoutException(String reason, String SQLState) {
	super(reason);
	this.SQLState = SQLState;
	this.vendorCode = 0;
//	if (!(this instanceof SQLWarning)) {
	    if (DriverManager.getLogWriter() != null) {
		printStackTrace(DriverManager.getLogWriter());
		DriverManager.println("SQLExecuteTimeoutExeception: SQLState(" + SQLState + ")");
	    }
//	}
    }

    /**
     *  Constructs a <code>SQLExecuteTimeoutExeception</code> object with a given
     * <code>reason</code>. The  <code>SQLState</code>  is initialized to
     * <code>null</code> and the vender code is initialized to 0.
     *
     * The <code>cause</code> is not initialized, and may subsequently be
     * initialized by a call to the 
     * {@link Throwable#initCause(java.lang.Throwable)} method.
     * <p>
     * @param reason a description of the exception 
     */
    public SQLExecuteTimeoutException(String reason) {
	super(reason);
	this.SQLState = null;
	this.vendorCode = 0;
//	if (!(this instanceof SQLWarning)) {
	    if (DriverManager.getLogWriter() != null) {
		printStackTrace(DriverManager.getLogWriter());
	    }
//	}
    }

    /**
     * Constructs a <code>SQLExecuteTimeoutExeception</code> object. 
     * The <code>reason</code>, <code>SQLState</code> are initialized
     * to <code>null</code> and the vendor code is initialized to 0.
     *
     * The <code>cause</code> is not initialized, and may subsequently be
     * initialized by a call to the 
     * {@link Throwable#initCause(java.lang.Throwable)} method.
     * <p>
     */
    public SQLExecuteTimeoutException() {
	super();
	this.SQLState = null;
	this.vendorCode = 0;
//	if (!(this instanceof SQLWarning)) {
	    if (DriverManager.getLogWriter() != null) {
		printStackTrace(DriverManager.getLogWriter());
	    }
//	}
    }
    
    /**
     *  Constructs a <code>SQLExecuteTimeoutExeception</code> object with a given
     * <code>cause</code>.
     * The <code>SQLState</code> is initialized
     * to <code>null</code> and the vendor code is initialized to 0. 
     * The <code>reason</code>  is initialized to <code>null</code> if 
     * <code>cause==null</code> or to <code>cause.toString()</code> if 
     * <code>cause!=null</code>.
     * <p>
     * @param cause the underlying reason for this <code>SQLExecuteTimeoutExeception</code> 
     * (which is saved for later retrieval by the <code>getCause()</code> method); 
     * may be null indicating the cause is non-existent or unknown.
     * @since 1.6
     */
    public SQLExecuteTimeoutException(Throwable cause) {
        super(cause);

//        if (!(this instanceof SQLWarning)) {
	    if (DriverManager.getLogWriter() != null) {
		printStackTrace(DriverManager.getLogWriter());
	    }
//	}
    }

    /**
     * Constructs a <code>SQLExecuteTimeoutExeception</code> object with a given
     * <code>reason</code> and  <code>cause</code>.  
     * The <code>SQLState</code> is  initialized to <code>null</code>
     * and the vendor code is initialized to 0.
     * <p>
     * @param reason a description of the exception. 
     * @param cause the underlying reason for this <code>SQLExecuteTimeoutExeception</code> 
     * (which is saved for later retrieval by the <code>getCause()</code> method); 
     * may be null indicating the cause is non-existent or unknown.
     * @since 1.6
     */
    public SQLExecuteTimeoutException(String reason, Throwable cause) {
    	super(reason,cause);

//        if (!(this instanceof SQLWarning)) {
	    if (DriverManager.getLogWriter() != null) {
		    printStackTrace(DriverManager.getLogWriter());
	    }
//	}
    }
    
    /**
     * Constructs a <code>SQLExecuteTimeoutExeception</code> object with a given
     * <code>reason</code>, <code>SQLState</code> and  <code>cause</code>.  
     * The vendor code is initialized to 0.
     * <p>  
     * @param reason a description of the exception. 
     * @param sqlState an XOPEN or SQL:2003 code identifying the exception 
     * @param cause the underlying reason for this <code>SQLExecuteTimeoutExeception</code>
     * (which is saved for later retrieval by the 
     * <code>getCause()</code> method); may be null indicating
     *     the cause is non-existent or unknown.
     * @since 1.6
     */
    public SQLExecuteTimeoutException(String reason, String sqlState, Throwable cause) {
        super(reason,cause);

        this.SQLState = sqlState;
        this.vendorCode = 0;
//        if (!(this instanceof SQLWarning)) {
	    if (DriverManager.getLogWriter() != null) {
		printStackTrace(DriverManager.getLogWriter());
		DriverManager.println("SQLState(" + SQLState + ")");
	    }
//	}
    }
    
    /**
     * Constructs a <code>SQLExecuteTimeoutExeception</code> object with a given
     * <code>reason</code>, <code>SQLState</code>, <code>vendorCode</code>
     * and  <code>cause</code>.  
     * <p> 
     * @param reason a description of the exception 
     * @param sqlState an XOPEN or SQL:2003 code identifying the exception
     * @param vendorCode a database vendor-specific exception code
     * @param cause the underlying reason for this <code>SQLExecuteTimeoutExeception</code> 
     * (which is saved for later retrieval by the <code>getCause()</code> method); 
     * may be null indicating the cause is non-existent or unknown.
     * @since 1.6
     */
    public SQLExecuteTimeoutException(String reason, String sqlState, int vendorCode, Throwable cause) {
    	super(reason,cause);

        this.SQLState = sqlState;
        this.vendorCode = vendorCode;
//        if (!(this instanceof SQLWarning)) {
	    if (DriverManager.getLogWriter() != null) {
		DriverManager.println("SQLState(" + SQLState +
						") vendor code(" + vendorCode + ")");
		printStackTrace(DriverManager.getLogWriter());
	    }
//	}
    }
    
    /**
     * Retrieves the SQLState for this <code>SQLExecuteTimeoutExeception</code> object.
     *
     * @return the SQLState value
     */
    public String getSQLState() {
	return (SQLState);
    }	

    /**
     * Retrieves the vendor-specific exception code
     * for this <code>SQLExecuteTimeoutExeception</code> object.
     *
     * @return the vendor's error code
     */
    public int getErrorCode() {
	return (vendorCode);
    }

    /**
     * Retrieves the exception chained to this 
     * <code>SQLExecuteTimeoutExeception</code> object by setNextException(SQLExecuteTimeoutExeception ex).
     *
     * @return the next <code>SQLExecuteTimeoutExeception</code> object in the chain; 
     *         <code>null</code> if there are none
     * @see #setNextException
     */
    public SQLExecuteTimeoutException getNextException() {
	return (next);
    }

    /**
     * Adds an <code>SQLExecuteTimeoutExeception</code> object to the end of the chain.
     *
     * @param ex the new exception that will be added to the end of
     *            the <code>SQLExecuteTimeoutExeception</code> chain
     * @see #getNextException
     */
    public void setNextException(SQLExecuteTimeoutException ex) {
     
	SQLExecuteTimeoutException current = this;
        for(;;) {
            SQLExecuteTimeoutException next=current.next;
            if (next != null) {
                current = next;
                continue;
            }

            if (nextUpdater.compareAndSet(current,null,ex)) {
                return;
            }
            current=current.next;
        }
    }
 
    /**
     * Returns an iterator over the chained SQLExecuteTimeoutExeceptions.  The iterator will
     * be used to iterate over each SQLExecuteTimeoutExeception and its underlying cause 
     * (if any).
     *
     * @return an iterator over the chained SQLExecuteTimeoutExeceptions and causes in the proper 
     * order
     *
     * @since 1.6
     */
    public Iterator<Throwable> iterator() {
       
       return new Iterator<Throwable>() {
           
           SQLExecuteTimeoutException firstException = SQLExecuteTimeoutException.this;
           SQLExecuteTimeoutException nextException = firstException.getNextException(); 
           Throwable cause = firstException.getCause();
           
           public boolean hasNext() {
               if(firstException != null || nextException != null || cause != null)
                   return true;
               return false;
           }
           
           public Throwable next() {
               Throwable throwable = null;
               if(firstException != null){
                   throwable = firstException;
                   firstException = null;
               }
               else if(cause != null){
                   throwable = cause;
                   cause = cause.getCause();
               }
               else if(nextException != null){
                   throwable = nextException;
                   cause = nextException.getCause();
                   nextException = nextException.getNextException();
               }
               else
                   throw new NoSuchElementException();
               return throwable;
           }
           
           public void remove() {
               throw new UnsupportedOperationException();
           }
       
       };
        
    }
    
    /**
	 * @serial
	 */
    private String SQLState;

	/**
	 * @serial
	 */
    private int vendorCode;

	/**
	 * @serial
	 */
    private volatile SQLExecuteTimeoutException next;
    
    private static final AtomicReferenceFieldUpdater<SQLExecuteTimeoutException,SQLExecuteTimeoutException> nextUpdater = 
            AtomicReferenceFieldUpdater.newUpdater(SQLExecuteTimeoutException.class,SQLExecuteTimeoutException.class,"next");
    
    private static final long serialVersionUID = 2135244094396331484L;
}
