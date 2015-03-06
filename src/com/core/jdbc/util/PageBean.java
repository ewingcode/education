package com.core.jdbc.util;

import java.io.Serializable;
import java.util.ArrayList;

public class PageBean implements Serializable {

	private static final long serialVersionUID = 1L;
	private static int DEFAULT_PAGE_SIZE = 30;
	private int pageSize = DEFAULT_PAGE_SIZE;
	private long start;
	private Object data;
	private int totalCount;

	public PageBean(long start, int totalCount, int pageSize, Object data) {
		this.start = start;
		this.totalCount = totalCount;
		this.pageSize = pageSize;
		this.data = data;
	}

	public PageBean() {
		new PageBean(0, 0, DEFAULT_PAGE_SIZE, new ArrayList());
	}

	public int getTotalCount() {
		return this.totalCount;
	}

	public long getTotalPageCount() {
		if (this.totalCount % this.pageSize == 0L) {
			return this.totalCount / this.pageSize;
		}
		return this.totalCount / this.pageSize + 1L;
	}

	public int getPageSize() {
		return this.pageSize;
	}

	public Object getResult() {
		return this.data;
	}

	public void setResult(Object data) {
		this.data = data;
	}

	public long getCurrentPageNo() {
		return this.start / this.pageSize + 1L;
	}

	public boolean hasPreviousPage() {
		return getCurrentPageNo() > 1L;
	}

	public boolean hasNextPage() {
		return getCurrentPageNo() <= getTotalPageCount() - 1L;
	}

	protected static int getStartOfPage(int pageNo) {
		return getStartOfPage(pageNo, DEFAULT_PAGE_SIZE);
	}

	public static int getStartOfPage(int pageNo, int pageSize) {
		return (pageNo - 1) * pageSize;
	}
}