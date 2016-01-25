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
import com.hontee.commons.db.entity.Share;
import com.hontee.commons.db.entity.ShareExample;
import com.hontee.commons.service.ShareService;
import com.hontee.commons.support.Pagination;

@Controller
@RequestMapping("shares")
public class ShareController {

	@Resource
	private ShareService shareService;
	
	@RequestMapping(value = "", method = RequestMethod.GET)
	public String shareIndex() {
		return "cms/shares/index";
	}
	
	@RequestMapping(value = "/list")
	public @ResponseBody DataGrid<Share> shareIndex(
			@RequestParam(required = false) String title, 
			@RequestParam(required = false, defaultValue = "1") Integer page,
			@RequestParam(required = false, defaultValue = "10") Integer rows) {
		
		ShareExample example = new ShareExample();
		if (StringUtils.isNotBlank(title)) {
			// 支持标题的模糊查询
			example.createCriteria().andTitleLike(title);
		}
		PageInfo<Share> pageInfo = shareService.findByExample(example, new Pagination(page, rows));
		Preconditions.checkNotNull(pageInfo);
		return new DataGrid<>(pageInfo.getTotal(), pageInfo.getList());
	}
}
