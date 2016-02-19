package com.hontee.cms.controller;

import java.util.Arrays;
import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.pagehelper.PageInfo;
import com.hontee.cms.easyui.vo.DataGrid;
import com.hontee.cms.easyui.vo.Result;
import com.hontee.cms.easyui.vo.ResultBuilder;
import com.hontee.commons.db.entity.Menu;
import com.hontee.commons.db.entity.MenuExample;
import com.hontee.commons.exception.BusinessException;
import com.hontee.commons.service.MenuService;
import com.hontee.commons.support.Pagination;

@Controller
@RequestMapping("menus")
public class MenuController {
	
	@Resource
	private MenuService menuService;
	
	@RequestMapping(value = "", method = RequestMethod.GET)
	public String index() {
		return "cms/menus/index";
	}
	
	@RequestMapping(value = "/list")
	public @ResponseBody DataGrid<Menu> dataGrid(@RequestParam(required = false) String title, Pagination p)
			throws BusinessException {
		MenuExample example = new MenuExample();
		if (StringUtils.isNotBlank(title)) {
			example.createCriteria().andTitleLike("%" + title + "%"); // 模糊查询
		}
		PageInfo<Menu> pageInfo = menuService.findByExample(example, p);
		return new DataGrid<>(pageInfo);
	}
	
	@RequestMapping("/datalist")
	public @ResponseBody List<Menu> datalist() throws Exception {
		return menuService.findByExample(new MenuExample());
	}
	
	private Menu findById(Long id) throws Exception {
		return menuService.findByPrimaryKey(id);
	}
	
	@RequestMapping(value = "/{id}", method = RequestMethod.GET)
	public String view(@PathVariable Long id, Model model) {
		try {
			model.addAttribute("record", findById(id));
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "cms/menus/view";
	}

	@RequestMapping(value = "/new", method = RequestMethod.GET)
	public String addPage() {
		return "cms/menus/new";
	}
	
	@RequestMapping(value = "/new", method = RequestMethod.POST)
	public @ResponseBody Result add(
			@RequestParam String name, 
			@RequestParam String title, 
			@RequestParam String url,
			@RequestParam String groupField, 
			String description, 
			@RequestParam(defaultValue = "1") Byte state) {
		Menu record = new Menu();
		record.setCreateBy(1L);
		record.setDescription(description);
		record.setName(name);
		record.setState(state);
		record.setTitle(title);
		record.setUrl(url);
		record.setGroupField(groupField);
		try {
			menuService.add(record);
			return ResultBuilder.ok();
		} catch (Exception e) {
			return ResultBuilder.failed(e);
		}
	}

	@RequestMapping(value = "/{id}/delete", method = RequestMethod.POST)
	public @ResponseBody Result delete(@PathVariable Long id) {
		try {
			menuService.deleteByPrimaryKey(id);
			return ResultBuilder.ok();
		} catch (Exception e) {
			return ResultBuilder.failed(e);
		}
	}

	@RequestMapping(value = "/delete/batch", method = RequestMethod.POST)
	public @ResponseBody Result delete(Long[] ids) {
		try {
			menuService.deleteBatch(Arrays.asList(ids));
			return ResultBuilder.ok();
		} catch (Exception e) {
			return ResultBuilder.failed(e);
		}
	}

	@RequestMapping(value = "/{id}/edit", method = RequestMethod.GET)
	public String editPage(@PathVariable Long id, Model model) {
		try {
			model.addAttribute("record", findById(id));
		} catch (Exception e) {
		}
		return "cms/menus/edit";
	}

	@RequestMapping(value = "/{id}/edit", method = RequestMethod.POST)
	public @ResponseBody Result edit(@PathVariable Long id, 
			@RequestParam String name, 
			@RequestParam String title, 
			@RequestParam String url,
			@RequestParam String groupField,
			String description, 
			@RequestParam(defaultValue = "1") Byte state) {
		Menu record = new Menu();
		record.setId(id);
		record.setDescription(description);
		record.setName(name);
		record.setState(state);
		record.setTitle(title);
		record.setUrl(url);
		record.setGroupField(groupField);
		try {
			menuService.updateByPrimaryKey(record);
			return ResultBuilder.ok();
		} catch (Exception e) {
			return ResultBuilder.failed(e);
		}
	}

}
