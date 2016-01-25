package com.hontee.cms.controller;

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
import com.hontee.commons.db.entity.User;
import com.hontee.commons.db.entity.UserExample;
import com.hontee.commons.service.UserService;
import com.hontee.commons.support.Pagination;

@Controller
@RequestMapping("users")
public class UserController {

	@Resource
	private UserService userService;
	
	@RequestMapping(value = "", method = RequestMethod.GET)
	public String userIndex() {
		return "cms/users/index";
	}
	
	@RequestMapping(value = "/list")
	public @ResponseBody DataGrid<User> userIndex(
			@RequestParam(required = false) String title, 
			@RequestParam(required = false, defaultValue = "1") Integer page,
			@RequestParam(required = false, defaultValue = "10") Integer rows) {
		
		UserExample example = new UserExample();
		if (StringUtils.isNotBlank(title)) {
			// 支持标题的模糊查询
			example.createCriteria().andNameEqualTo(title);
		}
		PageInfo<User> pageInfo = userService.findByExample(example, new Pagination(page, rows));
		Preconditions.checkNotNull(pageInfo);
		return new DataGrid<>(pageInfo.getTotal(), pageInfo.getList());
	}
}
