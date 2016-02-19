package com.hontee.cms;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hontee.cms.easyui.vo.Result;
import com.hontee.cms.easyui.vo.ResultBuilder;

/**
 * Handles requests for the application security page.
 */
@Controller
public class SecurityController {
	
	private static final Logger logger = LoggerFactory.getLogger(SecurityController.class);

	/**
	 * 进入登陆页面
	 * @return
	 */
	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public String login() {
		logger.info("Enter login controller page.");
		return "login";
	}
	
	/**
	 * 登录提交
	 * @param username
	 * @param password
	 * @return
	 */
	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public @ResponseBody Result login(
			@RequestParam String username, 
			@RequestParam String password) {
		logger.info("Handles requests for user login.");
		
		try {
			UsernamePasswordToken token = new UsernamePasswordToken(username, password);
			SecurityUtils.getSubject().login(token);
		} catch (AuthenticationException e) {
			return ResultBuilder.failed(e);
		}
		
		return ResultBuilder.ok();
	}

}
