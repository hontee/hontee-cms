<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="_header.jsp" %>
<title>登录 - Hontee.CMS</title>
<style>
.login-ul{list-style: none;}
.login-ul li {margin: 20px auto;}
.login-ul label {display: inline-block; width: 50px; text-align: right; float: left; line-height: 24px;}
.easyui-linkbutton {padding: 0 15px;}
</style>
</head>
<body>
  <div id="login-window">
    <form id="login-form" class="easyui-form" method="post" data-options="novalidate:true">
    <ul class="login-ul">
      <li>
        <label>用户名：</label>
        <input class="easyui-textbox" name="username" data-options="required:true,validType:['length[3,20]']" />
      </li>
      <li>
        <label>密码：</label>
        <input class="easyui-textbox" type="password" name="password" data-options="required:true,validType:['length[6,20]']" />
      </li>
    </ul>
    </form>
	<div id="login-footer" style="text-align: center; padding: 10px 0;">
      <button class="easyui-linkbutton" onclick="submit()">登录</button>
    </div>
</div>
<script type="text/javascript">
$('#login-window').window({
    width:320,
    height:180,
    title: "请登录",
    modal: true,
    collapsible: false,
    minimizable: false,
    maximizable: false,
    closable: false,
    footer: '#login-footer'
});

function submit() {

  $('#login-form').form('submit',{
	  url: '/cms/login',
      onSubmit:function(){
    	  var isValid = $(this).form('enableValidation').form('validate');
    	  return isValid;
      },
      success: function(data) {
    	  console.log(data);
      }
  });
}
</script>
</body>
</html>