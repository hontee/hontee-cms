package com.hontee.cms.controller;

import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.pagehelper.PageInfo;
import com.google.common.base.Preconditions;
import com.hontee.cms.easyui.vo.DataGrid;
import com.hontee.commons.db.entity.Menu;
import com.hontee.commons.db.entity.MenuExample;
import com.hontee.commons.service.MenuService;
import com.hontee.commons.support.Pagination;

@Controller
@RequestMapping("menus")
public class MenuController {
	
	@Resource
	private MenuService menuService;
	
	@RequestMapping(value = "", method = RequestMethod.GET)
	public String menuIndex() {
		return "cms/menus/index";
	}
	
	@RequestMapping(value = "/list")
	public @ResponseBody DataGrid<Menu> menuIndex(
			@RequestParam(required = false) String title, 
			@RequestParam(required = false, defaultValue = "1") Integer page,
			@RequestParam(required = false, defaultValue = "10") Integer rows) {
		
		MenuExample example = new MenuExample();
		if (StringUtils.isNotBlank(title)) {
			// 支持标题的模糊查询
			example.createCriteria().andTitleLike(title);
		}
		PageInfo<Menu> pageInfo = menuService.findByExample(example, new Pagination(page, rows));
		Preconditions.checkNotNull(pageInfo);
		return new DataGrid<>(pageInfo.getTotal(), pageInfo.getList());
	}
	
	@RequestMapping("/datalist")
	public @ResponseBody List<Menu> datalist() {
		return menuService.findByExample(new MenuExample());
	}

}
