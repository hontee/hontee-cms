<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="easyui-layout" data-options="fit:true">
  <div data-options="region:'center', border:false" class="cms-wbox">
  <form id="users-add-form" action="/cms/users/new" method="post">
    <div class="cms-mb20">
      <div class="cms-mb5">用户名:</div>
      <input class="easyui-textbox" name="name" data-options="required:true, prompt:'用户名'" style="width:100%; height:32px">
    </div>
    <div class="cms-mb20">
      <div class="cms-mb5">邮箱:</div>
      <input class="easyui-textbox" name="email" data-options="required:true, prompt:'邮箱'" style="width:100%; height:32px">
    </div>
    <div class="cms-mb20">
      <div class="cms-mb5">密码:</div>
      <input class="easyui-textbox" type="password" name="password" data-options="required:true" style="width:100%; height:32px">
    </div>
    <div class="cms-mb20">
      <div class="cms-mb5">用户类型:</div>
      <select class="easyui-combobox" data-options="panelHeight:'auto',editable: false" name="userType" style="width:100%; height:32px">
        <option value="1">普通用户</option>
        <option value="2">管理员</option>
      </select>
    </div>
    <div class="cms-mb20">
      <div class="cms-mb5">状态:</div>
      <select class="easyui-combobox" data-options="panelHeight:'auto',editable: false" name="state" style="width:100%; height:32px">
        <option value="1">启动</option>
        <option value="0">禁用</option>
      </select>
    </div>
    <button class="easyui-linkbutton" onclick="usersAddSubmitForm()" style="width:100%;height:32px">创建</button>
  </form>
  </div>
</div>
<script>
function usersAddSubmitForm(){
  $('#users-add-form').form({
    success: function(data) {
    	CMS.addSubmitHandler(data, usersEL);
    }
  });
}
</script>
</body>