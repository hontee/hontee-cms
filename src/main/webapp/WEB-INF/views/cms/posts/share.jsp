<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="easyui-layout" data-options="fit:true">
  <div data-options="region:'center', border:false" class="cms-wbox">
    <div class="cms-mb20">
      <div class="cms-mb5">URL:</div>
      <input class="easyui-textbox" id="posts-url" name="url" data-options="required:true, prompt:'请输入URL'" style="width:100%; height:32px">
    </div>
    <button class="easyui-linkbutton" onclick="postsShareSubmitForm()" style="width:100%;height:32px">分享</button>
  </div>
</div>
<script>
function postsShareSubmitForm(){
	var postsURL = $('#posts-url').val();
	postsEL.addWin.window('close');
	postsEL.addWin.window({
		width: 480,
		height: 440,
		modal: true,
		title: '新建产品',
		collapsible: false,
		minimizable: false,
		maximizable: false,
		href: '/cms/posts/new?url=' + postsURL,
		method: 'get',
		cache: false
	});
}
</script>
</body>