<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="easyui-layout" data-options="fit:true">
  <div data-options="region:'center', border:false" class="cms-wbox">
  <form id="posts-edit-form" action="/cms/posts/${record.id}/edit" method="post">
    <div class="cms-mb20">
      <div class="cms-mb5">URL:</div>
      <input class="easyui-textbox" name="url" value="${record.url}" data-options="required:true, readonly: true" style="width:100%; height:32px">
    </div>
    <div class="cms-mb20">
      <div class="cms-mb5">标题:</div>
      <input class="easyui-textbox" name="title" value="${record.title}" data-options="required:true, prompt:'唯一的标题'" style="width:100%;height:32px">
    </div>
    <div class="cms-mb20">
      <div class="cms-mb5">标签:</div>
      <input class="easyui-textbox" name="tags"  value="${record.tags}" data-options="required:true, prompt:'标签'" style="width:100%;height:32px">
    </div>
    <div class="cms-mb20">
      <div class="cms-mb5">状态:</div>
      <select class="easyui-combobox" name="state" data-options="panelHeight:'auto',editable: false" style="width:100%; height:32px">
        <option value="1" <c:if test="${record.state == 1}">selected</c:if>>启动</option>
        <option value="0" <c:if test="${record.state == 0}">selected</c:if>>禁用</option>
      </select>
    </div>
    <div class="cms-mb20">
      <div class="cms-mb5">描述:</div>
      <input class="easyui-textbox" name="description"  value="${record.description}" data-options="multiline:true" style="width:100%;height:64px">
    </div>
    <button class="easyui-linkbutton" onclick="postsEditSubmitForm()" style="width:100%;height:32px">更新</button>
  </form>
  </div>
</div>
<script>
function postsEditSubmitForm(){
  $('#posts-edit-form').form({
    success: function(data) {
    	CMS.editSubmitHandler(data, postsEL);
    }
  });
}
</script>
</body>