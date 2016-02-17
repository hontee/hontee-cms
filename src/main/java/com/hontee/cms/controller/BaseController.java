package com.hontee.cms.controller;

public interface BaseController {
	
	/*public void index();
	
	public void dataGrid();*/
	
	public void findById(Long id);
	
	public void view();

	public void addPage();
	
	public void add();
	
	public void delete(long id);
	
	public void delete();
	
	public void editPage();
	
	public void edit();
}
