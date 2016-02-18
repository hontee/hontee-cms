package com.hontee.cms.controller;

import java.util.Arrays;

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
import com.hontee.commons.db.entity.Role;
import com.hontee.commons.db.entity.RoleExample;
import com.hontee.commons.exception.BusinessException;
import com.hontee.commons.service.RoleService;
import com.hontee.commons.support.Pagination;

@Controller
@RequestMapping("roles")
public class RoleController {
	
	@Resource
	private RoleService roleService;
	
	@RequestMapping(value = "", method = RequestMethod.GET)
	public String index() {
		return "cms/roles/index";
	}
	
	@RequestMapping(value = "/list")
	public @ResponseBody DataGrid<Role> dataGrid(@RequestParam(required = false) String title, Pagination p)
			throws BusinessException {
		RoleExample example = new RoleExample();
		if (StringUtils.isNotBlank(title)) {
			example.createCriteria().andTitleLike("%" + title + "%"); // 模糊查询
		}
		PageInfo<Role> pageInfo = roleService.findByExample(example, p);
		return new DataGrid<>(pageInfo.getTotal(), pageInfo.getList());
	}
	
	private Role findById(Long id) throws Exception {
		return roleService.findByPrimaryKey(id);
	}
	
	@RequestMapping(value = "/{id}", method = RequestMethod.GET)
	public String view(@PathVariable Long id, Model model) {
		try {
			model.addAttribute("record", findById(id));
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "cms/roles/view";
	}

	@RequestMapping(value = "/new", method = RequestMethod.GET)
	public String addPage() {
		return "cms/roles/new";
	}
	
	@RequestMapping(value = "/new", method = RequestMethod.POST)
	public @ResponseBody Result add(
			@RequestParam String name, 
			@RequestParam String title, 
			String description, 
			@RequestParam(defaultValue = "1") Byte state) {
		Role record = new Role();
		record.setCreateBy(1L);
		record.setDescription(description);
		record.setName(name);
		record.setState(state);
		record.setTitle(title);
		try {
			roleService.add(record);
			return ResultBuilder.ok();
		} catch (Exception e) {
			return ResultBuilder.failed(e);
		}
	}

	
	@RequestMapping(value = "/{id}/delete", method = RequestMethod.POST)
	public @ResponseBody Result delete(@PathVariable Long id) {
		try {
			roleService.deleteByPrimaryKey(id);
			return ResultBuilder.ok();
		} catch (Exception e) {
			return ResultBuilder.failed(e);
		}
	}

	@RequestMapping(value = "/delete/batch", method = RequestMethod.POST)
	public @ResponseBody Result delete(Long[] ids) {
		try {
			roleService.deleteBatch(Arrays.asList(ids));
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
		return "cms/roles/edit";
	}

	@RequestMapping(value = "/{id}/edit", method = RequestMethod.POST)
	public @ResponseBody Result edit(@PathVariable Long id, 
			@RequestParam String name, 
			@RequestParam String title, 
			String description, 
			@RequestParam(defaultValue = "1") Byte state) {
		try {
			Role record = new Role();
			record.setId(id);
			record.setDescription(description);
			record.setName(name);
			record.setState(state);
			record.setTitle(title);
			roleService.updateByPrimaryKeySelective(record);
			return ResultBuilder.ok();
		} catch (Exception e) {
			return ResultBuilder.failed(e);
		}
	}

}
