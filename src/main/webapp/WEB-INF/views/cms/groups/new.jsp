<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="easyui-layout" data-options="fit:true">
  <div data-options="region:'center', border:false" class="cms-wbox">
  <form id="groups-add-form" action="/cms/groups/new" method="post">
    <div class="cms-mb20">
      <div class="cms-mb5">标题:</div>
      <input class="easyui-textbox" name="title" data-options="required:true, prompt:'唯一的标题'" style="width:100%;height:32px">
    </div>
    <div class="cms-mb20">
      <div class="cms-mb5">标签:</div>
      <input class="easyui-textbox" name="tags" data-options="required:true, prompt:'标签，使用逗号(,)分隔'" style="width:100%;height:32px">
    </div>
    <div class="cms-mb20">
      <div class="cms-mb5">描述:</div>
      <input class="easyui-textbox" name="description" data-options="multiline:true" style="width:100%;height:64px">
    </div>
    <button class="easyui-linkbutton" onclick="groupsAddSubmitForm()" style="width:100%;height:32px">创建</button>
  </form>
  </div>
</div>
<script>
function groupsAddSubmitForm(){
  $('#groups-add-form').form({
    success: function(data) {
    	CMS.addSubmitHandler(data, groupsEL);
    }
  });
}
</script>
</body>