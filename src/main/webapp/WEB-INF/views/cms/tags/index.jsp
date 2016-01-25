<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../header.jsp" %>
<title>标签管理 - Hontee.CMS</title>
</head>
<body>
<table id="dg"></table>

<script>
$('#dg').datagrid({
    url:'/cms/tags/list',
    fitColumns: true,
    idField: "id",
    rownumbers: true,
    pagination: true,
    title:'标签管理',
    fit: true,
    columns:[[
        {field: 'id', checkbox: true},
        {field:'name',title:'名称',width:100, hidden: true},
        {field:'title',title:'标题',width:100},
        {field:'description',title:'描述',width:100},
        {field:'state',title:'状态',width:100, sortable: true},
        {field:'created',title:'创建时间',width:100, sortable: true},
        {field:'lastModified',title:'最后更新时间',width:100, sortable: true}
    ]]
});
</script>

</body>
</html>