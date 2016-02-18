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
import com.hontee.commons.db.entity.Post;
import com.hontee.commons.db.entity.PostExample;
import com.hontee.commons.exception.BusinessException;
import com.hontee.commons.http.FetchUtils;
import com.hontee.commons.http.FetchUtils.WebModel;
import com.hontee.commons.service.PostService;
import com.hontee.commons.support.Pagination;

@Controller
@RequestMapping("posts")
public class PostController {

	@Resource
	private PostService postService;
	
	@RequestMapping(value = "", method = RequestMethod.GET)
	public String index() {
		return "cms/posts/index";
	}
	
	@RequestMapping(value = "/list")
	public @ResponseBody DataGrid<Post> dataGrid(@RequestParam(required = false) String title, Pagination p)
			throws BusinessException {
		PostExample example = new PostExample();
		if (StringUtils.isNotBlank(title)) {
			example.createCriteria().andTitleLike("%" + title + "%"); // 模糊查询
		}
		PageInfo<Post> pageInfo = postService.findByExample(example, p);
		return new DataGrid<>(pageInfo.getTotal(), pageInfo.getList());
	}
	
	private Post findById(Long id) throws Exception {
		return postService.findByPrimaryKey(id);
	}

	
	@RequestMapping(value = "/{id}", method = RequestMethod.GET)
	public String view(@PathVariable Long id, Model model) {
		try {
			model.addAttribute("record", findById(id));
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "cms/posts/view";
	}

	@RequestMapping(value = "/share", method = RequestMethod.GET)
	public String sharePage() {
		return "cms/posts/share";
	}
	
	@RequestMapping(value = "/new", method = RequestMethod.GET)
	public String addPage(@RequestParam String url, Model model) {
		WebModel wm = FetchUtils.connect(url);
		model.addAttribute("web", wm);
		return "cms/posts/new";
	}
	
	@RequestMapping(value = "/new", method = RequestMethod.POST)
	public @ResponseBody Result add(
			@RequestParam String url, 
			@RequestParam String title, 
			@RequestParam String tags, 
			@RequestParam String description) {
		try {
			Post record = new Post();
			record.setCatId(1L);
			record.setCreateBy(1L);
			record.setDescription(description);
			record.setTags(tags);
			record.setName(UUID.randomUUID().toString());
			record.setPlatforms("Web");
			record.setState((byte)1);
			record.setTitle(title);
			record.setUrl(url);
			record.setHit(0);
			record.setStars(0);
			postService.add(record);
			return ResultBuilder.ok();
		} catch (Exception e) {
			return ResultBuilder.failed(e);
		}
	}

	
	@RequestMapping(value = "/{id}/delete", method = RequestMethod.POST)
	public @ResponseBody Result delete(@PathVariable Long id) {
		try {
			postService.deleteByPrimaryKey(id);
			return ResultBuilder.ok();
		} catch (Exception e) {
			return ResultBuilder.failed(e);
		}
	}

	@RequestMapping(value = "/delete/batch", method = RequestMethod.POST)
	public @ResponseBody Result delete(Long[] ids) {
		try {
			postService.deleteBatch(Arrays.asList(ids));
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
		return "cms/posts/edit";
	}

	@RequestMapping(value = "/{id}/edit", method = RequestMethod.POST)
	public @ResponseBody Result edit(@PathVariable Long id, 
			@RequestParam String title, 
			@RequestParam String tags, 
			@RequestParam String description,
			@RequestParam(defaultValue = "1") Byte state) {
		try {
			Post record = new Post();
			record.setId(id);
			record.setDescription(description);
			record.setTags(tags);
			record.setState(state);
			record.setTitle(title);
			postService.updateByPrimaryKey(record);
			return ResultBuilder.ok();
		} catch (Exception e) {
			return ResultBuilder.failed(e);
		}
	}
}
