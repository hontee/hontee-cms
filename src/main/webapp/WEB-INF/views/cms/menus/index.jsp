<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../_header.jsp" %>
<title>菜单管理 - Hontee.CMS</title>
</head>
<body>
<table id="menus-dg"></table>
<script>
$('#menus-dg').datagrid({
    url:'/cms/menus/list',
    fitColumns: true,
    border: false,
    idField: "id",
    rownumbers: true,
    pagination: true,
    title:'菜单管理',
    fit: true,
    columns:[[
        {field: 'id', checkbox: true},
        {field:'name',title:'名称',width:100, hidden: true},
        {field:'title',title:'标题',width:100},
        {field:'description',title:'描述',width:100},
        {field:'url',title:'链接',width:100},
        {field:'parent',title:'父节点',width:100},
        {field:'state',title:'状态',width:100, sortable: true},
        {field:'created',title:'创建时间',width:100, sortable: true},
        {field:'lastModified',title:'最后更新时间',width:100, sortable: true},
        {field:'createBy',title:'创建人',width:100, sortable: true}
    ]]
});
</script>
</body>
</html>