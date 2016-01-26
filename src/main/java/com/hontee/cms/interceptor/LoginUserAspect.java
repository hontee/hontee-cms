package com.hontee.cms.interceptor;

import java.lang.reflect.Method;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.AfterReturning;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.aspectj.lang.annotation.Pointcut;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.aop.AfterReturningAdvice;
import org.springframework.stereotype.Component;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * @LoginUser
 * 处理用户登录
 * @author larry.qi
 */
@Aspect
@Component
public class LoginUserAspect {
	
	static final Logger logger = LoggerFactory.getLogger(LoginUserAspect.class);
	
	@Pointcut("@annotation(org.springframework.web.bind.annotation.ResponseBody)")
	public void responseBody() {}
	
	@AfterReturning(pointcut = "responseBody()", returning = "returnValue")
	public void afterReturning(Object returnValue) {
		logger.info("=======================================");
	}

}
