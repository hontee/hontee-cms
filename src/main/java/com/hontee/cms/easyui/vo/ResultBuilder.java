package com.hontee.cms.easyui.vo;

import javax.ws.rs.core.Response;

import com.hontee.commons.exception.BusinessException;

public interface ResultBuilder {
	
	/**
	 * 成功
	 * @return
	 */
	public static Result ok() {
		Response response = Response.ok().build();
		return new Result(response.getStatusInfo());
	}
	
	/**
	 * 成功
	 * @param entity
	 * @return
	 */
	public static Result ok(Object entity) {
		Response response = Response.ok(entity).build();
		return new Result(response.getEntity());
	}
	
	/**
	 * 失败
	 * @param message
	 * @return
	 */
	public static Result failed(String message) {
		return new Result(1001, message);
	}
	
	/**
	 * 失败
	 * @param e
	 * @return
	 */
	public static Result failed(Throwable e) {
		String message = "系统错误";
		if (e instanceof BusinessException) {
			BusinessException be = (BusinessException) e;
			message = be.getMessage();
		}
		return failed(message);
	}
	
}
