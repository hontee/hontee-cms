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
import com.hontee.commons.db.entity.Track;
import com.hontee.commons.db.entity.TrackExample;
import com.hontee.commons.exception.BusinessException;
import com.hontee.commons.service.TrackService;
import com.hontee.commons.support.Pagination;

@Controller
@RequestMapping("tracks")
public class TrackController {

	@Resource
	private TrackService trackService;
	
	@RequestMapping(value = "", method = RequestMethod.GET)
	public String index() {
		return "cms/tracks/index";
	}
	
	@RequestMapping(value = "/list")
	public @ResponseBody DataGrid<Track> dataGrid(@RequestParam(required = false) String title, Pagination p)
			throws BusinessException {
		TrackExample example = new TrackExample();
		if (StringUtils.isNotBlank(title)) {
			example.createCriteria().andExceptionLike("%" + title + "%"); // 模糊查询
		}
		PageInfo<Track> pageInfo = trackService.findByExample(example, p);
		return new DataGrid<>(pageInfo.getTotal(), pageInfo.getList());
	}
	
	private Track findById(Long id) throws Exception {
		return trackService.findByPrimaryKey(id);
	}

	@RequestMapping(value = "/{id}", method = RequestMethod.GET)
	public String view(@PathVariable Long id, Model model) {
		try {
			model.addAttribute("record", findById(id));
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "cms/tracks/view";
	}
	
	@RequestMapping(value = "/{id}/delete", method = RequestMethod.POST)
	public @ResponseBody Result delete(@PathVariable Long id) {
		try {
			trackService.deleteByPrimaryKey(id);
			return ResultBuilder.ok();
		} catch (Exception e) {
			return ResultBuilder.failed(e);
		}
	}

	@RequestMapping(value = "/delete/batch", method = RequestMethod.POST)
	public @ResponseBody Result delete(Long[] ids) {
		try {
			trackService.deleteBatch(Arrays.asList(ids));
			return ResultBuilder.ok();
		} catch (Exception e) {
			return ResultBuilder.failed(e);
		}
	}

}
