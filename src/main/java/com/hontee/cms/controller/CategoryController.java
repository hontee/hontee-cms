package com.hontee.cms.controller;

import java.util.ArrayList;
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
import com.hontee.cms.easyui.vo.ComboBox;
import com.hontee.cms.easyui.vo.DataGrid;
import com.hontee.cms.easyui.vo.Result;
import com.hontee.cms.easyui.vo.ResultBuilder;
import com.hontee.commons.db.entity.Category;
import com.hontee.commons.db.entity.CategoryExample;
import com.hontee.commons.exception.BusinessException;
import com.hontee.commons.service.CategoryService;
import com.hontee.commons.support.Pagination;

@Controller
@RequestMapping("cates")
public class CategoryController {

	@Resource
	private CategoryService categoryService;
	
	/**
	 * 分类首页
	 * @return
	 */
	@RequestMapping(value = "", method = RequestMethod.GET)
	public String index() {
		return "cms/cates/index";
	}
	
	/**
	 * 分类数据列表
	 * @param title
	 * @param page
	 * @param rows
	 * @return
	 * @throws BusinessException
	 */
	@RequestMapping(value = "/list")
	public @ResponseBody DataGrid<Category> dataGrid(@RequestParam(required = false) String title, Pagination p)
			throws BusinessException {
		CategoryExample example = new CategoryExample();
		if (StringUtils.isNotBlank(title)) {
			example.createCriteria().andTitleLike("%" + title + "%"); // 模糊查询
		}
		PageInfo<Category> pageInfo = categoryService.findByExample(example, p);
		return new DataGrid<>(pageInfo.getTotal(), pageInfo.getList());
	}
	
	@RequestMapping(value = "/comboGrid")
	public @ResponseBody List<ComboBox> comboGrid() throws Exception {
		CategoryExample example = new CategoryExample();
		example.createCriteria().andParentIsNull().andStateEqualTo((byte)1); // parent is null and state = 1
		List<Category> list = categoryService.findByExample(example);
		List<ComboBox> boxes = new ArrayList<>();
		boxes.add(new ComboBox(0L, "无"));
		list.forEach((c) -> boxes.add(new ComboBox(c.getId(), c.getTitle())));
		return boxes;
	}
	
	/**
	 * 根据ID查询
	 * @param id
	 * @return
	 * @throws Exception
	 */
	private Category findById(Long id) throws Exception {
		return categoryService.findByPrimaryKey(id);
	}

	/**
	 * 查看分类详情
	 * @param id
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/{id}", method = RequestMethod.GET)
	public String view(@PathVariable Long id, Model model) {
		try {
			model.addAttribute("record", findById(id));
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return "cms/cates/view";
	}

	/**
	 * 新建分类页面
	 * @return
	 */
	@RequestMapping(value = "/new", method = RequestMethod.GET)
	public String addPage() {
		return "cms/cates/new";
	}

	/**
	 * 新建分类提交
	 * @param name
	 * @param title
	 * @param description
	 * @param parent
	 * @param state
	 * @return
	 */
	@RequestMapping(value = "/new", method = RequestMethod.POST)
	public @ResponseBody Result add(
			@RequestParam String name, 
			@RequestParam String title, 
			String description,
			@RequestParam(defaultValue = "0") Long parent, 
			@RequestParam(defaultValue = "1") Byte state) {
		Category record = new Category();
		record.setCreateBy(1L); // 创建人
		record.setDescription(description);
		record.setName(name);
		record.setState(state);
		record.setTitle(title);
		if (parent != 0L) {
			record.setParent(parent);
		}
		
		try {
			categoryService.addSelective(record);
			return ResultBuilder.ok();
		} catch (Exception e) {
			return ResultBuilder.failed(e);
		}
	}

	@RequestMapping(value = "/{id}/delete", method = RequestMethod.POST)
	public @ResponseBody Result delete(@PathVariable Long id) {
		try {
			categoryService.deleteByPrimaryKey(id);
			return ResultBuilder.ok();
		} catch (Exception e) {
			return ResultBuilder.failed(e);
		}
	}

	@RequestMapping(value = "/delete/batch", method = RequestMethod.POST)
	public @ResponseBody Result delete(Long[] ids) {
		try {
			categoryService.deleteBatch(Arrays.asList(ids));
			return ResultBuilder.ok();
		} catch (Exception e) {
			return ResultBuilder.failed(e);
		}
	}

	@RequestMapping(value = "/{id}/edit", method = RequestMethod.GET)
	public String editPage(@PathVariable Long id, Model model) {
		try {
			Category record = findById(id);
			if (record.getParent() == null) {
				record.setParent(0L);
			}
			model.addAttribute("record", record);
		} catch (Exception e) {
		}
		return "cms/cates/edit";
	}

	@RequestMapping(value = "/{id}/edit", method = RequestMethod.POST)
	public @ResponseBody Result edit(@PathVariable Long id, 
			@RequestParam String name, 
			@RequestParam String title, 
			String description,
			@RequestParam(defaultValue = "0") Long parent, 
			@RequestParam(defaultValue = "1") Byte state) {
		try {
			Category record = new Category();
			record.setId(id);
			record.setDescription(description);
			record.setName(name);
			record.setParent(parent);
			record.setState(state);
			record.setTitle(title);
			if (parent != 0L) {
				record.setParent(parent);
			} else {
				record.setParent(null);
			}
			
			categoryService.updateByPrimaryKeySelective(record);
			return ResultBuilder.ok();
		} catch (Exception e) {
			return ResultBuilder.failed(e);
		}
	}

}
