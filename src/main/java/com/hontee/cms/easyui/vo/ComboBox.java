package com.hontee.cms.easyui.vo;

import java.io.Serializable;

/**
 * 下拉框组件
 * @author larry.qi
 *
 */
public class ComboBox implements Serializable {

	private static final long serialVersionUID = -1253013244364461209L;
	
	/**
	 * 下拉框的隐藏值
	 */
	private Long id;
	
	/**
	 * 下拉框的显示文本
	 */
	private String title;

	public ComboBox(Long id, String title) {
		this.id = id;
		this.title = title;
	}

	public ComboBox() {
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

}
