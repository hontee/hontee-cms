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
import com.hontee.commons.db.entity.User;
import com.hontee.commons.db.entity.UserExample;
import com.hontee.commons.exception.BusinessException;
import com.hontee.commons.security.EncryptUtils;
import com.hontee.commons.service.UserService;
import com.hontee.commons.support.Pagination;

@Controller
@RequestMapping("users")
public class UserController {

	@Resource
	private UserService userService;
	
	@RequestMapping(value = "", method = RequestMethod.GET)
	public String index() {
		return "cms/users/index";
	}
	
	@RequestMapping(value = "/list")
	public @ResponseBody DataGrid<User> dataGrid(@RequestParam(required = false) String title, Pagination p)
			throws BusinessException {
		UserExample example = new UserExample();
		if (StringUtils.isNotBlank(title)) {
			example.createCriteria().andTitleLike("%" + title + "%"); // 模糊查询
		}
		PageInfo<User> pageInfo = userService.findByExample(example, p);
		return new DataGrid<>(pageInfo);
	}
	
	private User findById(Long id) throws Exception {
		return userService.findByPrimaryKey(id);
	}
	
	@RequestMapping(value = "/{id}", method = RequestMethod.GET)
	public String view(@PathVariable Long id, Model model) {
		try {
			model.addAttribute("record", findById(id));
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return "cms/users/view";
	}

	@RequestMapping(value = "/new", method = RequestMethod.GET)
	public String addPage() {
		return "cms/users/new";
	}
	
	@RequestMapping(value = "/new", method = RequestMethod.POST)
	public @ResponseBody Result add(
			@RequestParam String name, 
			@RequestParam String email, 
			@RequestParam String password, 
			@RequestParam(defaultValue = "1") Byte userType, 
			@RequestParam(defaultValue = "1") Byte state) {
		try {
			User record = new User();
			record.setEmail(email);
			record.setIsEmailSet((byte)0);
			record.setSalt(EncryptUtils.getRandomSalt()); // 随机盐值
			record.setPassword(EncryptUtils.encrypt(password, record.getSalt())); // 密码加密
			record.setUserType(userType);
			record.setName(name);
			record.setState(state);
			record.setTitle(name);
			userService.add(record);
			return ResultBuilder.ok();
		} catch (Exception e) {
			return ResultBuilder.failed(e);
		}
	}

	@RequestMapping(value = "/{id}/delete", method = RequestMethod.POST)
	public @ResponseBody Result delete(@PathVariable Long id) {
		try {
			userService.deleteByPrimaryKey(id);
			return ResultBuilder.ok();
		} catch (Exception e) {
			return ResultBuilder.failed(e);
		}
	}

	@RequestMapping(value = "/delete/batch", method = RequestMethod.POST)
	public @ResponseBody Result delete(Long[] ids) {
		try {
			userService.deleteBatch(Arrays.asList(ids));
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
		return "cms/users/edit";
	}

	@RequestMapping(value = "/{id}/edit", method = RequestMethod.POST)
	public @ResponseBody Result edit(@PathVariable Long id, 
			@RequestParam String name, 
			@RequestParam String title, 
			String description, 
			@RequestParam String email, 
			@RequestParam(defaultValue = "1") Byte userType, 
			@RequestParam(defaultValue = "1") Byte state ) {
		try {
			User record = new User();
			record.setId(id);
			record.setEmail(email);
			record.setUserType(userType);
			record.setName(name);
			record.setState(state);
			record.setTitle(title);
			record.setDescription(description);
			userService.updateByPrimaryKey(record);
			return ResultBuilder.ok();
		} catch (Exception e) {
			return ResultBuilder.failed(e);
		}
	}
}
