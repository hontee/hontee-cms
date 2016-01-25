<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>
<title>Hontee.CMS</title>
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