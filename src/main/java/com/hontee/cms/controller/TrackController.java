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
import com.hontee.commons.db.entity.Track;
import com.hontee.commons.db.entity.TrackExample;
import com.hontee.commons.service.TrackService;
import com.hontee.commons.support.Pagination;

@Controller
@RequestMapping("tracks")
public class TrackController {

	@Resource
	private TrackService trackService;
	
	@RequestMapping(value = "", method = RequestMethod.GET)
	public String trackIndex() {
		return "cms/tracks/index";
	}
	
	@RequestMapping(value = "/list")
	public @ResponseBody DataGrid<Track> trackIndex(
			@RequestParam(required = false) String title, 
			@RequestParam(required = false, defaultValue = "1") Integer page,
			@RequestParam(required = false, defaultValue = "10") Integer rows) {
		
		TrackExample example = new TrackExample();
		if (StringUtils.isNotBlank(title)) {
			// 支持标题的模糊查询
			example.createCriteria().andExceptionEqualTo(title);
		}
		PageInfo<Track> pageInfo = trackService.findByExample(example, new Pagination(page, rows));
		Preconditions.checkNotNull(pageInfo);
		return new DataGrid<>(pageInfo.getTotal(), pageInfo.getList());
	}
}
