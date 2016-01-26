<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../_header.jsp" %>
<title>专辑管理 - Hontee.CMS</title>
</head>
<body>
<table id="groups-dg"></table>
<script>
$('#groups-dg').datagrid({
    url:'/cms/groups/list',
    fitColumns: true,
    border: false,
    idField: "id",
    rownumbers: true,
    pagination: true,
    title:'专辑管理',
    fit: true,
    columns:[[
        {field: 'id', checkbox: true},
        {field:'name',title:'名称',width:100, hidden: true},
        {field:'title',title:'标题',width:100},
        {field:'description',title:'描述',width:100},
        {field:'tags',title:'标签',width:100},
        {field:'stars',title:'星',width:100},
        {field:'count',title:'产品数',width:100},
        {field:'state',title:'状态',width:100, sortable: true},
        {field:'orgType',title:'类型',width:100, sortable: true},
        {field:'created',title:'创建时间',width:100, sortable: true},
        {field:'lastModified',title:'最后更新时间',width:100, sortable: true},
        {field:'createBy',title:'创建人',width:100, sortable: true}
    ]]
});
</script>
</body>
</html>