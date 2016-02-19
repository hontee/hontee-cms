<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../_header.jsp" %>
<title>权限管理 - Hontee.CMS</title>
</head>
<body>
<header id="perms-header" class="cms-dg-header">
	<button id="perms-add" class="easyui-linkbutton" data-options="iconCls:'icon-add'">新建</button>
	<button id="perms-edit" class="easyui-linkbutton" data-options="iconCls:'icon-edit',disabled:true">编辑</button>
	<button id="perms-remove" class="easyui-linkbutton" data-options="iconCls:'icon-remove',disabled:true">删除</button>
	<button id="perms-cut" class="easyui-linkbutton" data-options="iconCls:'icon-cut',disabled:true">批量删除</button>
	<button id="perms-reload" class="easyui-linkbutton" data-options="iconCls:'icon-reload'">刷新</button>
	
	<span class="cms-dg-search">
	  <input class="easyui-searchbox" data-options="prompt:'输入标题', searcher:permsEL.search" style="width:200px" />
	</span>
</header>
<table id="perms-dg"></table>
<footer>
    <div id="perms-add-win"></div>
    <div id="perms-edit-win"></div>
</footer>
<script>
// 变量取值要唯一
var permsEL = {
	add: $("#perms-add"),
	edit: $("#perms-edit"),
	remove: $("#perms-remove"),
	cut: $("#perms-cut"),
	reload: $("#perms-reload"),
	dg: $("#perms-dg"),
	addWin: $("#perms-add-win"),
	editWin: $("#perms-edit-win")
};

// DataGrid
permsEL.dg.datagrid({
    url:'/cms/perms/list',
    fitColumns: true,
    border: false,
    idField: "id",
    rownumbers: true,
    pagination: true,
    title:'权限管理',
    header: '#perms-header',
    fit: true,
    columns:[[
        {field: 'id', checkbox: true},
        {field:'name',title:'名称',width:100, sortable: true},
        {field:'title',title:'标题',width:100, sortable: true},
        {field:'description',title:'描述',width:100},
        {field:'state',title:'状态',width:100, sortable: true, formatter: function(value,row,index) {
        	if (value == '1') {
				return '启用';
			} else {
				return '禁用';
			}
        }},
        {field:'created',title:'创建时间',width:100, sortable: true, formatter: function(value,row,index) {
        	return new Date(value).format();  
        }},
        {field:'lastModified',title:'最后更新时间',width:100, sortable: true, formatter: function(value,row,index) {
        	return new Date(value).format();  
        }},
        {field:'createBy',title:'创建人',width:100, sortable: true, formatter: function(value,row,index) {
        	return row.extCreateName;
        }},
        {field:'extCreateName',title:'用户名', hidden: true}
    ]],
 	// 当选择一行时触发
    onSelect: function(index,row) {
    	permsEL.reset();
    },
 	// 当取消选择一行时触发
    onUnselect: function(index,row) {
    	permsEL.reset();
    },
 	// 当全选时触发
    onSelectAll: function(rows) {
    	permsEL.reset();
    },
 	// 当取消全选时触发
    onUnselectAll: function(rows) {
    	permsEL.reset();
    },
    // 双击查看
    onDblClickRow: function(index,row) {
    	console.log("view detail");
    }
});

// 根据选择记录触发: 重置按钮状态
permsEL.reset = function() {
	var length = permsEL.dg.datagrid("getSelections").length;
	if (length == 0) { // 全部禁用
		permsEL.linkButton(true, true, true);
	} else if (length == 1) { // 可编辑和删除
		permsEL.linkButton(false, false, true);
	} else { // 可批量操作
		permsEL.linkButton(true, true, false);
	}
}

// 设置按钮是否可用
permsEL.linkButton = function(a, b, c) {
	permsEL.edit.linkbutton({disabled: a});
	permsEL.remove.linkbutton({disabled: b});
	permsEL.cut.linkbutton({disabled: c});
}

// 搜索
permsEL.search = function(value){
	permsEL.dg.datagrid('load',{
		title: value
	});
}

// 新建
permsEL.add.click(function() {
	permsEL.addWin.window({
		width: 480,
		height: 440,
		modal: true,
		title: '新建权限',
		collapsible: false,
		minimizable: false,
		maximizable: false,
		href: '/cms/perms/new',
		method: 'get',
		cache: false
	});
});

// 编辑
permsEL.edit.click(function() {
	var row = permsEL.dg.datagrid('getSelected');
	if (row) {
		permsEL.editWin.window({
			width: 480,
			height: 440,
			modal: true,
			title: '编辑权限',
			collapsible: false,
			minimizable: false,
			maximizable: false,
			href: '/cms/perms/' + row.id + '/edit',
			method: 'get',
			cache: false
		});
	}
});

// 删除
permsEL.remove.click(function() {
	CMS.removeSubmitHandler(permsEL, 'perms');
});

// 批量删除
permsEL.cut.click(function() {
	CMS.batchDeleteSubmitHandler(permsEL, 'perms');
});

// 重载
permsEL.reload.click(function() {
	permsEL.dg.datagrid('reload',{});
});
</script>
</body>
</html>