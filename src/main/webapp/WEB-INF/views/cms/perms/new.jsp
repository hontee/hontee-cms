<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="easyui-layout" data-options="fit:true">
  <div data-options="region:'center', border:false" class="cms-wbox">
  <form id="perms-add-form" action="/cms/perms/new" method="post">
    <div class="cms-mb20">
      <div class="cms-mb5">名称:</div>
      <input class="easyui-textbox" name="name" data-options="required:true, prompt:'唯一的名称'" style="width:100%; height:32px">
    </div>
    <div class="cms-mb20">
      <div class="cms-mb5">标题:</div>
      <input class="easyui-textbox" name="title" data-options="required:true, prompt:'唯一的标题'" style="width:100%;height:32px">
    </div>
    <div class="cms-mb20">
      <div class="cms-mb5">状态:</div>
      <select class="easyui-combobox" data-options="panelHeight:'auto',editable: false" name="state" style="width:100%; height:32px">
        <option value="1">启动</option>
        <option value="0">禁用</option>
      </select>
    </div>
    <div class="cms-mb20">
      <div class="cms-mb5">描述:</div>
      <input class="easyui-textbox" name="description" data-options="multiline:true" style="width:100%;height:64px">
    </div>
    <button class="easyui-linkbutton" onclick="permsAddSubmitForm()" style="width:100%;height:32px">创建</button>
  </form>
  </div>
</div>
<script>
function permsAddSubmitForm(){
  $('#perms-add-form').form({
    success: function(data) {
    	CMS.addSubmitHandler(data, permsEL);
    }
  });
}
</script>
</body>