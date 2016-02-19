<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../_header.jsp" %>
<title>标签管理 - Hontee.CMS</title>
</head>
<body>
<header id="tags-header" class="cms-dg-header">
	<button id="tags-add" class="easyui-linkbutton" data-options="iconCls:'icon-add'">新建</button>
	<button id="tags-edit" class="easyui-linkbutton" data-options="iconCls:'icon-edit',disabled:true">编辑</button>
	<button id="tags-remove" class="easyui-linkbutton" data-options="iconCls:'icon-remove',disabled:true">删除</button>
	<button id="tags-cut" class="easyui-linkbutton" data-options="iconCls:'icon-cut',disabled:true">批量删除</button>
	<button id="tags-reload" class="easyui-linkbutton" data-options="iconCls:'icon-reload'">刷新</button>
	
	<span class="cms-dg-search">
	  <input class="easyui-searchbox" data-options="prompt:'输入标题', searcher:tagsEL.search" style="width:200px" />
	</span>
</header>
<table id="tags-dg"></table>
<footer>
    <div id="tags-add-win"></div>
    <div id="tags-edit-win"></div>
</footer>
<script>
// 变量取值要唯一
var tagsEL = {
	add: $("#tags-add"),
	edit: $("#tags-edit"),
	remove: $("#tags-remove"),
	cut: $("#tags-cut"),
	reload: $("#tags-reload"),
	dg: $("#tags-dg"),
	addWin: $("#tags-add-win"),
	editWin: $("#tags-edit-win")
};

// DataGrid
tagsEL.dg.datagrid({
    url:'/cms/tags/list',
    fitColumns: true,
    border: false,
    idField: "id",
    rownumbers: true,
    pagination: true,
    title:'标签管理',
    header: '#tags-header',
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
        }}
    ]],
 	// 当选择一行时触发
    onSelect: function(index,row) {
    	tagsEL.reset();
    },
 	// 当取消选择一行时触发
    onUnselect: function(index,row) {
    	tagsEL.reset();
    },
 	// 当全选时触发
    onSelectAll: function(rows) {
    	tagsEL.reset();
    },
 	// 当取消全选时触发
    onUnselectAll: function(rows) {
    	tagsEL.reset();
    },
    // 双击查看
    onDblClickRow: function(index,row) {
    	console.log("view detail");
    }
});

// 根据选择记录触发: 重置按钮状态
tagsEL.reset = function() {
	var length = tagsEL.dg.datagrid("getSelections").length;
	if (length == 0) { // 全部禁用
		tagsEL.linkButton(true, true, true);
	} else if (length == 1) { // 可编辑和删除
		tagsEL.linkButton(false, false, true);
	} else { // 可批量操作
		tagsEL.linkButton(true, true, false);
	}
}

// 设置按钮是否可用
tagsEL.linkButton = function(a, b, c) {
	tagsEL.edit.linkbutton({disabled: a});
	tagsEL.remove.linkbutton({disabled: b});
	tagsEL.cut.linkbutton({disabled: c});
}

// 搜索
tagsEL.search = function(value){
	tagsEL.dg.datagrid('load',{
		title: value
	});
}

// 新建
tagsEL.add.click(function() {
	tagsEL.addWin.window({
		width: 480,
		height: 440,
		modal: true,
		title: '新建标签',
		collapsible: false,
		minimizable: false,
		maximizable: false,
		href: '/cms/tags/new',
		method: 'get',
		cache: false
	});
});

// 编辑
tagsEL.edit.click(function() {
	var row = tagsEL.dg.datagrid('getSelected');
	if (row) {
		tagsEL.editWin.window({
			width: 480,
			height: 440,
			modal: true,
			title: '编辑标签',
			collapsible: false,
			minimizable: false,
			maximizable: false,
			href: '/cms/tags/' + row.id + '/edit',
			method: 'get',
			cache: false
		});
	}
});

// 删除
tagsEL.remove.click(function() {
	CMS.removeSubmitHandler(tagsEL, 'tags');
});

// 批量删除
tagsEL.cut.click(function() {
	CMS.batchDeleteSubmitHandler(tagsEL, 'tags');
});

// 重载
tagsEL.reload.click(function() {
	tagsEL.dg.datagrid('reload',{});
});
</script>
</body>
</html>