<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Basic Layout - jQuery EasyUI Demo</title>
    <link rel="stylesheet" href="/assets/jeasyui/themes/default/easyui.css">
    <link rel="stylesheet" href="/assets/jeasyui/themes/icon.css">
    <script src="/assets/jeasyui/jquery.min.js"></script>
    <script src="/assets/jeasyui/jquery.easyui.min.js"></script>
</head>
<body class="easyui-layout">
    <div data-options="region:'north'" style="height:80px;"></div>
    <div data-options="region:'west',title:'菜单管理'" style="width:200px;">
    	<jsp:include page="layout/accordion.jsp" />
    </div>
    <div data-options="region:'center'">
    	<jsp:include page="layout/tabs.jsp" />
	</div>
</body>
</html>