<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../header.jsp" %>
<title>分享管理 - Hontee.CMS</title>
</head>
<body>
<table id="dg"></table>

<script>
$('#dg').datagrid({
    url:'/cms/shares/list',
    fitColumns: true,
    idField: "id",
    rownumbers: true,
    pagination: true,
    title:'分享管理',
    fit: true,
    columns:[[
        {field: 'id', checkbox: true},
        {field:'name',title:'名称',width:100, hidden: true},
        {field:'title',title:'标题',width:100},
        {field:'description',title:'描述',width:100},
        {field:'keywords',title:'标签',width:100},
        {field:'url',title:'链接',width:100},
        {field:'state',title:'状态',width:100, sortable: true},
        {field:'created',title:'创建时间',width:100, sortable: true},
        {field:'lastModified',title:'最后更新时间',width:100, sortable: true},
        {field:'catId',title:'类别ID',width:100},
        {field:'platforms',title:'支持平台',width:100},
        {field:'createBy',title:'创建人',width:100, sortable: true}
    ]]
});
</script>

</body>
</html>