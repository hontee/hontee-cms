<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../header.jsp" %>
<title>用户管理 - Hontee.CMS</title>
</head>
<body>
<table id="dg"></table>

<script>
$('#dg').datagrid({
    url:'/cms/users/list',
    fitColumns: true,
    idField: "id",
    rownumbers: true,
    pagination: true,
    title:'用户管理',
    fit: true,
    columns:[[
        {field: 'id', checkbox: true},
        {field:'name',title:'名称',width:100},
        {field:'title',title:'昵称',width:100},
        {field:'description',title:'描述',width:100},
        {field:'password',title:'密码',width:100},
        {field:'salt',title:'盐',width:100},
        {field:'email',title:'邮箱',width:100},
        {field:'isEmailSet',title:'邮箱状态',width:100},
        {field:'userType',title:'用户类型',width:100},
        {field:'state',title:'状态',width:100, sortable: true},
        {field:'created',title:'创建时间',width:100, sortable: true},
        {field:'lastModified',title:'最后更新时间',width:100, sortable: true}
    ]]
});
</script>

</body>
</html>