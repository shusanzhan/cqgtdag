package com.ystech.cqgtdag.model.news;

// Generated 2014-5-22 17:10:33 by Hibernate Tools 4.0.0

import java.util.Date;

/**
 * Slide generated by hbm2java
 */
public class Slide implements java.io.Serializable {

	private Integer dbid;
	private Integer typeid;
	private String picUrl;
	private String title;
	private String description;
	private String url;
	private Boolean display;
	private Short orderNum;
	private Date createTime;
	private Date modifyTime;

	public Slide() {
	}

	public Slide(Integer bussiId, Integer typeid, String picUrl, String title,
			String description, String url, Boolean display, Short sort,
			Date createTime, Date modifyTime) {
		this.typeid = typeid;
		this.picUrl = picUrl;
		this.title = title;
		this.description = description;
		this.url = url;
		this.display = display;
		this.createTime = createTime;
		this.modifyTime = modifyTime;
	}

	public Integer getDbid() {
		return this.dbid;
	}

	public void setDbid(Integer dbid) {
		this.dbid = dbid;
	}


	public Integer getTypeid() {
		return this.typeid;
	}

	public void setTypeid(Integer typeid) {
		this.typeid = typeid;
	}

	public String getPicUrl() {
		return this.picUrl;
	}

	public void setPicUrl(String picUrl) {
		this.picUrl = picUrl;
	}

	public String getTitle() {
		return this.title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getDescription() {
		return this.description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getUrl() {
		return this.url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public Boolean getDisplay() {
		return this.display;
	}

	public void setDisplay(Boolean display) {
		this.display = display;
	}


	public Short getOrderNum() {
		return orderNum;
	}

	public void setOrderNum(Short orderNum) {
		this.orderNum = orderNum;
	}

	public Date getCreateTime() {
		return this.createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	public Date getModifyTime() {
		return this.modifyTime;
	}

	public void setModifyTime(Date modifyTime) {
		this.modifyTime = modifyTime;
	}

}
