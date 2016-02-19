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
import com.hontee.commons.db.entity.Platform;
import com.hontee.commons.db.entity.PlatformExample;
import com.hontee.commons.exception.BusinessException;
import com.hontee.commons.service.PlatformService;
import com.hontee.commons.support.Pagination;

@Controller
@RequestMapping("platforms")
public class PlatformController {
	
	@Resource
	private PlatformService platformService;
	
	// 平台管理首页
	@RequestMapping(value = "", method = RequestMethod.GET)
	public String index() {
		return "cms/platforms/index";
	}
	
	// 数据列表
	@RequestMapping("/list")
	public @ResponseBody DataGrid<Platform> dataGrid(@RequestParam(required = false) String title, Pagination p) throws BusinessException {
		// 构建查询条件
		PlatformExample example = new PlatformExample();

		if (StringUtils.isNotBlank(title)) {
			// 支持标题的模糊查询
			example.createCriteria().andTitleLike("%" + title + "%");
		}
		PageInfo<Platform> pageInfo = platformService.findByExample(example, p);
		return new DataGrid<>(pageInfo);
	}
	
	private Platform findById(Long id) throws Exception {
		return platformService.findByPrimaryKey(id);
	}
	
	@RequestMapping(value = "/{id}", method = RequestMethod.GET)
	public String view(@PathVariable Long id, Model model) {
		try {
			model.addAttribute("record", findById(id));
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return "cms/platforms/view";
	}
	
	// 新建平台页面
	@RequestMapping(value = "/new", method = RequestMethod.GET)
	public String addPage() {
		return "cms/platforms/new";
	}
	
	// 新建平台类型：提交请求
	@RequestMapping(value = "/new", method = RequestMethod.POST)
	public @ResponseBody Result add(
			@RequestParam String name, 
			@RequestParam String title, 
			String description, 
			@RequestParam(defaultValue = "1") Byte state) {
		Platform record = new Platform();
		record.setName(name);
		record.setTitle(title);
		record.setState(state);
		record.setDescription(description);
		try {
			platformService.add(record);
			return ResultBuilder.ok();
		} catch (Exception e) {
			return ResultBuilder.failed(e);
		}
	}
	
	// 删除
	@RequestMapping(value = "/{id}/delete", method = RequestMethod.POST)
	public @ResponseBody Result delete(@PathVariable Long id) {
		try {
			platformService.deleteByPrimaryKey(id);
			return ResultBuilder.ok();
		} catch (Exception e) {
			return ResultBuilder.failed(e);
		}
	}
	
	// 批量删除
	@RequestMapping(value = "/delete/batch", method = RequestMethod.POST)
	public @ResponseBody Result delete(Long[] ids) {
		try {
			platformService.deleteBatch(Arrays.asList(ids));
			return ResultBuilder.ok();
		} catch (Exception e) {
			return ResultBuilder.failed(e);
		}
	}
	
	// 进入编辑页面
	@RequestMapping(value = "/{id}/edit", method = RequestMethod.GET)
	public String editPage(@PathVariable Long id, Model model) throws Exception {
		Platform record = findById(id);
		model.addAttribute("record", record);
		return "cms/platforms/edit";
	}
	
	// 编辑提交
	@RequestMapping(value = "/{id}/edit", method = RequestMethod.POST)
	public @ResponseBody Result edit(@PathVariable Long id, 
			@RequestParam String name, 
			@RequestParam String title, 
			String description, 
			@RequestParam(defaultValue = "1") Byte state) {
		try {
			Platform record = new Platform();
			record.setId(id);
			record.setName(name);
			record.setTitle(title);
			record.setState(state);
			record.setDescription(description);
			platformService.updateByPrimaryKey(record);
			return ResultBuilder.ok();
		} catch (Exception e) {
			return ResultBuilder.failed(e);
		}
	}

}
