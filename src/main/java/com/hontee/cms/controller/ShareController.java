package com.hontee.cms.controller;

import java.util.Arrays;
import java.util.UUID;

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
import com.hontee.commons.db.entity.Share;
import com.hontee.commons.db.entity.ShareExample;
import com.hontee.commons.exception.BusinessException;
import com.hontee.commons.http.FetchUtils;
import com.hontee.commons.http.FetchUtils.WebModel;
import com.hontee.commons.service.ShareService;
import com.hontee.commons.support.Pagination;

@Controller
@RequestMapping("shares")
public class ShareController {

	@Resource
	private ShareService shareService;
	
	@RequestMapping(value = "", method = RequestMethod.GET)
	public String index() {
		return "cms/shares/index";
	}
	
	@RequestMapping(value = "/list")
	public @ResponseBody DataGrid<Share> dataGrid(@RequestParam(required = false) String title, Pagination p)
			throws BusinessException {
		ShareExample example = new ShareExample();
		if (StringUtils.isNotBlank(title)) {
			example.createCriteria().andTitleLike("%" + title + "%"); // 模糊查询
		}
		PageInfo<Share> pageInfo = shareService.findByExample(example, p);
		return new DataGrid<>(pageInfo);
	}
	
	private Share findById(Long id) throws Exception {
		return shareService.findByPrimaryKey(id);
	}
	
	@RequestMapping(value = "/{id}", method = RequestMethod.GET)
	public String view(@PathVariable Long id, Model model) {
		try {
			model.addAttribute("record", findById(id));
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return "cms/shares/view";
	}
	
	@RequestMapping(value = "/share", method = RequestMethod.GET)
	public String sharePage() {
		return "cms/shares/share";
	}
	
	@RequestMapping(value = "/new", method = RequestMethod.GET)
	public String addPage(@RequestParam String url, Model model) {
		WebModel wm = FetchUtils.connect(url);
		model.addAttribute("web", wm);
		return "cms/shares/new";
	}
	
	@RequestMapping(value = "/new", method = RequestMethod.POST)
	public @ResponseBody Result add(
			@RequestParam String url, 
			@RequestParam String title, 
			@RequestParam String keywords, 
			@RequestParam String description) {
		try {
			Share record = new Share();
			record.setCatId(1L);
			record.setCreateBy(1L);
			record.setDescription(description);
			record.setKeywords(keywords);
			record.setName(UUID.randomUUID().toString());
			record.setPlatforms("Web");
			record.setState((byte)1);
			record.setTitle(title);
			record.setUrl(url);
			shareService.add(record);
			return ResultBuilder.ok();
		} catch (Exception e) {
			return ResultBuilder.failed(e);
		}
	}

	
	@RequestMapping(value = "/{id}/delete", method = RequestMethod.POST)
	public @ResponseBody Result delete(@PathVariable Long id) {
		try {
			shareService.deleteByPrimaryKey(id);
			return ResultBuilder.ok();
		} catch (Exception e) {
			return ResultBuilder.failed(e);
		}
	}

	@RequestMapping(value = "/delete/batch", method = RequestMethod.POST)
	public @ResponseBody Result delete(Long[] ids) {
		try {
			shareService.deleteBatch(Arrays.asList(ids));
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
		return "cms/shares/edit";
	}

	@RequestMapping(value = "/{id}/edit", method = RequestMethod.POST)
	public @ResponseBody Result edit(@PathVariable Long id, 
			@RequestParam String title, 
			@RequestParam String keywords, 
			@RequestParam String description,
			@RequestParam(defaultValue = "1") Byte state) {
		try {
			Share record = new Share();
			record.setId(id);
			record.setDescription(description);
			record.setKeywords(keywords);
			record.setState(state);
			record.setTitle(title);
			shareService.updateByPrimaryKey(record);
			return ResultBuilder.ok();
		} catch (Exception e) {
			return ResultBuilder.failed(e);
		}
	}
	
}
