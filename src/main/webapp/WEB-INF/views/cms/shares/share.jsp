<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="easyui-layout" data-options="fit:true">
  <div data-options="region:'center', border:false" class="cms-wbox">
    <div class="cms-mb20">
      <div class="cms-mb5">URL:</div>
      <input class="easyui-textbox" id="shares-url" name="url" data-options="required:true, prompt:'请输入URL'" style="width:100%; height:32px">
    </div>
    <button class="easyui-linkbutton" onclick="sharesShareSubmitForm()" style="width:100%;height:32px">分享</button>
  </div>
</div>
<script>
function sharesShareSubmitForm(){
	var sharesURL = $('#shares-url').val();
	sharesEL.addWin.window('close');
	sharesEL.addWin.window({
		width: 480,
		height: 440,
		modal: true,
		title: '新建分享',
		collapsible: false,
		minimizable: false,
		maximizable: false,
		href: '/cms/shares/new?url=' + sharesURL,
		method: 'get',
		cache: false
	});
}
</script>
</body>