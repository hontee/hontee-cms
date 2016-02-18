<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../_header.jsp" %>
<title>角色管理 - Hontee.CMS</title>
</head>
<body>
<header id="roles-header" class="cms-dg-header">
	<button id="roles-add" class="easyui-linkbutton" data-options="iconCls:'icon-add'">新建</button>
	<button id="roles-edit" class="easyui-linkbutton" data-options="iconCls:'icon-edit',disabled:true">编辑</button>
	<button id="roles-remove" class="easyui-linkbutton" data-options="iconCls:'icon-remove',disabled:true">删除</button>
	<button id="roles-cut" class="easyui-linkbutton" data-options="iconCls:'icon-cut',disabled:true">批量删除</button>
	<button id="roles-reload" class="easyui-linkbutton" data-options="iconCls:'icon-reload'">刷新</button>
	
	<span class="cms-dg-search">
	  <input class="easyui-searchbox" data-options="prompt:'输入标题', searcher:rolesEL.search" style="width:200px" />
	</span>
</header>
<table id="roles-dg"></table>
<footer>
    <div id="roles-add-win"></div>
    <div id="roles-edit-win"></div>
</footer>
<script>
// 变量取值要唯一
var rolesEL = {
	add: $("#roles-add"),
	edit: $("#roles-edit"),
	remove: $("#roles-remove"),
	cut: $("#roles-cut"),
	reload: $("#roles-reload"),
	dg: $("#roles-dg"),
	addWin: $("#roles-add-win"),
	editWin: $("#roles-edit-win")
};

// DataGrid
rolesEL.dg.datagrid({
    url:'/cms/roles/list',
    fitColumns: true,
    border: false,
    idField: "id",
    rownumbers: true,
    pagination: true,
    title:'角色管理',
    header: '#roles-header',
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
        	return new Date(value).format('yyyy-MM-dd HH:mm');  
        }},
        {field:'lastModified',title:'最后更新时间',width:100, sortable: true, formatter: function(value,row,index) {
        	return new Date(value).format('yyyy-MM-dd HH:mm');  
        }},
        {field:'createBy',title:'创建人',width:100, sortable: true}
    ]],
 	// 当选择一行时触发
    onSelect: function(index,row) {
    	rolesEL.reset();
    },
 	// 当取消选择一行时触发
    onUnselect: function(index,row) {
    	rolesEL.reset();
    },
 	// 当全选时触发
    onSelectAll: function(rows) {
    	rolesEL.reset();
    },
 	// 当取消全选时触发
    onUnselectAll: function(rows) {
    	rolesEL.reset();
    },
    // 双击查看
    onDblClickRow: function(index,row) {
    	console.log("view detail");
    }
});

// 根据选择记录触发: 重置按钮状态
rolesEL.reset = function() {
	var length = rolesEL.dg.datagrid("getSelections").length;
	if (length == 0) { // 全部禁用
		rolesEL.linkButton(true, true, true);
	} else if (length == 1) { // 可编辑和删除
		rolesEL.linkButton(false, false, true);
	} else { // 可批量操作
		rolesEL.linkButton(true, true, false);
	}
}

// 设置按钮是否可用
rolesEL.linkButton = function(a, b, c) {
	rolesEL.edit.linkbutton({disabled: a});
	rolesEL.remove.linkbutton({disabled: b});
	rolesEL.cut.linkbutton({disabled: c});
}

// 搜索
rolesEL.search = function(value){
	rolesEL.dg.datagrid('load',{
		title: value
	});
}

// 新建
rolesEL.add.click(function() {
	rolesEL.addWin.window({
		width: 480,
		height: 440,
		modal: true,
		title: '新建角色',
		collapsible: false,
		minimizable: false,
		maximizable: false,
		href: '/cms/roles/new',
		method: 'get',
		cache: false
	});
});

// 编辑
rolesEL.edit.click(function() {
	var row = rolesEL.dg.datagrid('getSelected');
	if (row) {
		rolesEL.editWin.window({
			width: 480,
			height: 440,
			modal: true,
			title: '编辑角色',
			collapsible: false,
			minimizable: false,
			maximizable: false,
			href: '/cms/roles/' + row.id + '/edit',
			method: 'get',
			cache: false
		});
	}
});

// 删除
rolesEL.remove.click(function() {
	CMS.removeSubmitHandler(rolesEL, 'roles');
});

// 批量删除
rolesEL.cut.click(function() {
	CMS.batchDeleteSubmitHandler(rolesEL, 'roles');
});

// 重载
rolesEL.reload.click(function() {
	rolesEL.dg.datagrid('reload',{});
});
</script>
</body>
</html>