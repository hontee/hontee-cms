<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="easyui-layout" data-options="fit:true">
  <div data-options="region:'center', border:false" class="cms-wbox">
  <form id="shares-add-form" action="/cms/shares/new" method="post">
    <div class="cms-mb20">
      <div class="cms-mb5">URL:</div>
      <input class="easyui-textbox" name="url" value="${web.url}" data-options="required:true, prompt:'链接', readonly: true" style="width:100%;height:32px">
    </div>
    <div class="cms-mb20">
      <div class="cms-mb5">标题:</div>
      <input class="easyui-textbox" name="title" value="${web.title}" data-options="required:true, prompt:'标题'" style="width:100%;height:32px">
    </div>
    <div class="cms-mb20">
      <div class="cms-mb5">标签:</div>
      <input class="easyui-textbox" name="keywords"  value="${web.keywords}" data-options="required:true, prompt:'标签'" style="width:100%;height:32px">
    </div>
    <div class="cms-mb20">
      <div class="cms-mb5">描述:</div>
      <input class="easyui-textbox" name="description"  value="${web.description}" data-options="multiline:true" style="width:100%;height:64px">
    </div>
    <button class="easyui-linkbutton" onclick="sharesAddSubmitForm()" style="width:100%;height:32px">确认</button>
  </form>
  </div>
</div>
<script>
function sharesAddSubmitForm(){
  $('#shares-add-form').form({
    success: function(data) {
    	CMS.addSubmitHandler(data, sharesEL);
    }
  });
}
</script>
</body>