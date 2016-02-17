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
import com.google.common.base.Preconditions;
import com.hontee.cms.easyui.vo.DataGrid;
import com.hontee.cms.easyui.vo.Result;
import com.hontee.cms.easyui.vo.ResultBuilder;
import com.hontee.commons.db.entity.Permission;
import com.hontee.commons.db.entity.PermissionExample;
import com.hontee.commons.exception.BusinessException;
import com.hontee.commons.service.PermissionService;
import com.hontee.commons.support.Pagination;

@Controller
@RequestMapping("perms")
public class PermissionController {
	
	@Resource
	private PermissionService permissionService;
	
	@RequestMapping(value = "", method = RequestMethod.GET)
	public String index() {
		return "cms/perms/index";
	}
	
	@RequestMapping(value = "/list")
	public @ResponseBody DataGrid<Permission> dataGrid(
			@RequestParam(required = false) String title, 
			@RequestParam(required = false, defaultValue = "1") Integer page,
			@RequestParam(required = false, defaultValue = "10") Integer rows) throws BusinessException {
		
		PermissionExample example = new PermissionExample();
		if (StringUtils.isNotBlank(title)) {
			// 支持标题的模糊查询
			example.createCriteria().andTitleLike(title);
		}
		PageInfo<Permission> pageInfo = permissionService.findByExample(example, new Pagination(page, rows));
		Preconditions.checkNotNull(pageInfo);
		return new DataGrid<>(pageInfo.getTotal(), pageInfo.getList());
	}
	
	private Permission findById(Long id) throws Exception {
		return permissionService.findByPrimaryKey(id);
	}

	
	@RequestMapping(value = "/{id}", method = RequestMethod.GET)
	public String view(@PathVariable Long id, Model model) {
		try {
			model.addAttribute("record", findById(id));
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return "cms/perms/view";
	}

	@RequestMapping(value = "/new", method = RequestMethod.GET)
	public String addPage() {
		return "cms/perms/new";
	}
	
	@RequestMapping(value = "/new", method = RequestMethod.POST)
	public @ResponseBody Result add() {
		Permission record = new Permission();
		/*record.setCreateBy(createBy);
		record.setDescription(description);
		record.setName(name);
		record.setParent(parent);
		record.setState(state);
		record.setTitle(title);*/
		try {
			permissionService.addSelective(record);
			return ResultBuilder.ok();
		} catch (Exception e) {
			return ResultBuilder.failed(e);
		}
	}

	
	@RequestMapping(value = "/{id}/delete", method = RequestMethod.POST)
	public @ResponseBody Result delete(@PathVariable Long id) {
		try {
			permissionService.deleteByPrimaryKey(id);
			return ResultBuilder.ok();
		} catch (Exception e) {
			return ResultBuilder.failed(e);
		}
	}

	@RequestMapping(value = "/delete/batch", method = RequestMethod.POST)
	public @ResponseBody Result delete(Long[] ids) {
		try {
			permissionService.deleteBatch(Arrays.asList(ids));
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
			// TODO
		}
		return "cms/perms/edit";
	}

	@RequestMapping(value = "/{id}/edit", method = RequestMethod.POST)
	public @ResponseBody Result edit(@PathVariable Long id, Permission record) {
		try {
			permissionService.updateByPrimaryKey(record);
			return ResultBuilder.ok();
		} catch (Exception e) {
			return ResultBuilder.failed(e);
		}
	}

}
