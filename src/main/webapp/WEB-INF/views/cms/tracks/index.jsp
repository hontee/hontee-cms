<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../header.jsp" %>
<title>异常管理与追踪 - Hontee.CMS</title>
</head>
<body>
<table id="dg"></table>

<script>
$('#dg').datagrid({
    url:'/cms/tracks/list',
    fitColumns: true,
    idField: "id",
    rownumbers: true,
    pagination: true,
    title:'异常管理与追踪',
    fit: true,
    columns:[[
        {field: 'id', checkbox: true},
        {field:'exception',title:'异常',width:100},
        {field:'object',title:'异常信息',width:100},
        {field:'state',title:'状态',width:100, sortable: true},
        {field:'created',title:'创建时间',width:100, sortable: true},
        {field:'lastModified',title:'最后更新时间',width:100, sortable: true},
        {field:'remark',title:'备注',width:100}
    ]]
});
</script>

</body>
</html>