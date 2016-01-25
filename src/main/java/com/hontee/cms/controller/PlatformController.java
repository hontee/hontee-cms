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
import com.hontee.commons.db.entity.Platform;
import com.hontee.commons.db.entity.PlatformExample;
import com.hontee.commons.service.PlatformService;
import com.hontee.commons.support.Pagination;

@Controller
@RequestMapping("platforms")
public class PlatformController {
	
	@Resource
	private PlatformService platformService;
	
	/**
	 * 平台管理首页
	 * @return
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String platformIndex() {
		return "cms/platforms/index";
	}
	
	@RequestMapping("/list")
	public @ResponseBody DataGrid<Platform> platformIndex(
			@RequestParam(required = false) String title, 
			@RequestParam(required = false, defaultValue = "1") Integer page,
			@RequestParam(required = false, defaultValue = "10") Integer rows) {
		// 构建查询条件
		PlatformExample example = new PlatformExample();
		if (StringUtils.isNotBlank(title)) {
			// 支持标题的模糊查询
			example.createCriteria().andTitleLike(title);
		}
		PageInfo<Platform> pageInfo = platformService.findByExample(example, new Pagination(page, rows));
		Preconditions.checkNotNull(pageInfo, "结果集不能为空");
		return new DataGrid<>(pageInfo.getTotal(), pageInfo.getList());
	}

}
