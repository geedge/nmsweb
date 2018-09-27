package nis.nms.util;

import java.io.Serializable;
import java.util.ArrayList;

/**
 * 分页对象. 包含当前页数据及分页信息如总记录数.
 * @author Frank
 */
@SuppressWarnings("serial")
public class Page implements Serializable {

	private static int DEFAULT_PAGE_SIZE = 50;

	private int pageSize = DEFAULT_PAGE_SIZE; // 每页的记录数

	private long start; // 当前页第一条数据在List中的位置,从0开始

	private Object data; // 当前页中存放的记录,类型一般为List

	private long totalCount; // 总记录数
	
	private long totalPage; // 总页数
	
	private int startPage;
	
	private int endPage;
	
	private boolean hasNextPage;
	
	private boolean boo=false;

	/**
	 * 构造方法，只构造空页.
	 */
	@SuppressWarnings("unchecked")
	public Page() {
		this(0, 0, DEFAULT_PAGE_SIZE, new ArrayList());
	}
	
	/**
	 * 默认构造方法.
	 *
	 * @param start	 本页数据在数据库中的起始位置
	 * @param pageSize  本页容量
	 * @param data	  本页包含的数据
	 */
	public Page(long start, int pageSize, Object data) {
		this.pageSize = pageSize;
		this.start = start;
		this.data = data;
		long currentPage = this.getCurrentPageNo();
		int  score = 0;
		if(currentPage%10 != 0){
			score = (int)(currentPage/10L);
		}else{
			score = (int)(currentPage/10L)-1;
		}
		this.setStartPage(score*10 + 1);
	}

	/**
	 * 默认构造方法.
	 *
	 * @param start	 本页数据在数据库中的起始位置
	 * @param totalSize 数据库中总记录条数
	 * @param pageSize  本页容量
	 * @param data	  本页包含的数据
	 */
	public Page(long start, long totalSize, int pageSize, Object data) {
		this.pageSize = pageSize;
		this.start = start;
		this.totalCount = totalSize;
		this.data = data;
		this.totalPage = this.getTotalPageCount();
		long currentPage = this.getCurrentPageNo();
		int  score = 0;
		if(currentPage%10 != 0){
			score = (int)(currentPage/10L);
		}else{
			score = (int)(currentPage/10L)-1;
		}
		//System.out.println("totalPage:"+totalPage+" currentPage:"+currentPage+" score:"+score);;
		this.setEndPage((score+1)*10);
		this.setStartPage(score*10 + 1);
	}
	
	public static void main(String [] args){
		Page page = new Page(40,42,2,null);
		System.out.println("startPage:"+page.getStartPage()+" endPage:"+page.getEndPage());
	}
	
	/**
	 * 判断有无下一页,将判断结果赋给变量
	 */
	public void setHasNextPage(boolean hasNextPage) {
		this.hasNextPage = hasNextPage;
	}
	
	/**
	 * 判断有无下一页,得到结果
	 */
	public boolean getHasNextPage() {
		return this.hasNextPage;
	}
	
	/**
	 * 取总记录数.
	 */
	public long getTotalCount() {
		return this.totalCount;
	}

	/**
	 * 取总页数.
	 */
	public long getTotalPageCount() {
		if (totalCount % pageSize == 0){
			this.totalPage = totalCount / pageSize;
		}
		else{
			this.totalPage = totalCount / pageSize + 1;			
		}
		return this.totalPage;
	}

	/**
	 * 取每页数据容量.
	 */
	public int getPageSize() {
		return pageSize;
	}

	/**
	 * 取当前页中的记录.
	 */
	public Object getResult() {
		return data;
	}

	/**
	 * 取该页当前页码,页码从1开始.
	 */
	public long getCurrentPageNo() {
		return start / pageSize + 1;
	}

	/**
	 * 该页是否有下一页.
	 */
	public boolean hasNextPage() {
		return this.getCurrentPageNo() <= this.getTotalPageCount() - 1;
	}

	/**
	 * 该页是否有上一页.
	 */
	public boolean hasPreviousPage() {
		return this.getCurrentPageNo() > 1;
	}

	/**
	 * 获取任一页第一条数据在数据集的位置，每页条数使用默认值.
	 *
	 * @see #getStartOfPage(int,int)
	 */
	protected static int getStartOfPage(int pageNo) {
		return getStartOfPage(pageNo, DEFAULT_PAGE_SIZE);
	}

	/**
	 * 获取任一页第一条数据在数据集的位置.
	 *
	 * @param pageNo   从1开始的页号
	 * @param pageSize 每页记录条数
	 * @return 该页第一条数据
	 */
	public static int getStartOfPage(int pageNo, int pageSize) {
		return (pageNo - 1) * pageSize;
	}

	public int getEndPage() {
		return endPage;
	}

	public void setEndPage(int endPage) {
		if(endPage >this.getTotalPageCount())
		this.endPage = (int)this.getTotalPageCount();
		else
	    this.endPage = endPage;
	}

	public int getStartPage() {
		return startPage;
	}

	public void setStartPage(int startPage) {
		if(startPage <=0 ) 
			this.startPage = 1;
		else
			this.startPage = startPage;
	}

	public long getTotalPage() {
		return totalPage;
	}

	public void setTotalPage(long totalPage) {
		this.totalPage = totalPage;
	}

	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}

	public void setTotalCount(long totalCount) {
		this.totalCount = totalCount;
	}

	public boolean isBoo() {
		return boo;
	}

	public void setBoo(boolean boo) {
		this.boo = boo;
	}
}