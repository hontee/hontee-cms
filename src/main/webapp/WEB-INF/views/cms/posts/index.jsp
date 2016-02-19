<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../_header.jsp" %>
<title>产品管理 - Hontee.CMS</title>
</head>
<body>
<header id="posts-header" class="cms-dg-header">
	<button id="posts-add" class="easyui-linkbutton" data-options="iconCls:'icon-add'">新建</button>
	<button id="posts-edit" class="easyui-linkbutton" data-options="iconCls:'icon-edit',disabled:true">编辑</button>
	<button id="posts-remove" class="easyui-linkbutton" data-options="iconCls:'icon-remove',disabled:true">删除</button>
	<button id="posts-cut" class="easyui-linkbutton" data-options="iconCls:'icon-cut',disabled:true">批量删除</button>
	<button id="posts-reload" class="easyui-linkbutton" data-options="iconCls:'icon-reload'">刷新</button>
	
	<span class="cms-dg-search">
	  <input class="easyui-searchbox" data-options="prompt:'输入标题', searcher:postsEL.search" style="width:200px" />
	</span>
</header>
<table id="posts-dg"></table>
<footer>
    <div id="posts-add-win"></div>
    <div id="posts-edit-win"></div>
</footer>
<script>
// 变量取值要唯一
var postsEL = {
	add: $("#posts-add"),
	edit: $("#posts-edit"),
	remove: $("#posts-remove"),
	cut: $("#posts-cut"),
	reload: $("#posts-reload"),
	dg: $("#posts-dg"),
	addWin: $("#posts-add-win"),
	editWin: $("#posts-edit-win")
};

// DataGrid
postsEL.dg.datagrid({
    url:'/cms/posts/list',
    fitColumns: true,
    border: false,
    idField: "id",
    rownumbers: true,
    pagination: true,
    title:'产品管理',
    header: '#posts-header',
    fit: true,
    columns:[[
        {field: 'id', checkbox: true},
        {field:'name',title:'名称',width:100, hidden: true},
        {field:'title',title:'标题',width:100, sortable: true},
        {field:'description',title:'描述',width:100},
        {field:'tags',title:'标签',width:100},
        {field:'url',title:'链接',width:100},
        {field:'hit',title:'点击率',width:100},
        {field:'stars',title:'星',width:100},
        {field:'catId',title:'所属分类',width:100, sortable: true, formatter: function(value,row,index) {
        	return row.extCatTitle;
        }},
        {field:'platforms',title:'支持平台',width:100},
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
        {field:'extCreateName',title:'用户名', hidden: true},
        {field:'extCatTitle',title:'分类标题', hidden: true}
    ]],
 	// 当选择一行时触发
    onSelect: function(index,row) {
    	postsEL.reset();
    },
 	// 当取消选择一行时触发
    onUnselect: function(index,row) {
    	postsEL.reset();
    },
 	// 当全选时触发
    onSelectAll: function(rows) {
    	postsEL.reset();
    },
 	// 当取消全选时触发
    onUnselectAll: function(rows) {
    	postsEL.reset();
    },
    // 双击查看
    onDblClickRow: function(index,row) {
    	console.log("view detail");
    }
});

// 根据选择记录触发: 重置按钮状态
postsEL.reset = function() {
	var length = postsEL.dg.datagrid("getSelections").length;
	if (length == 0) { // 全部禁用
		postsEL.linkButton(true, true, true);
	} else if (length == 1) { // 可编辑和删除
		postsEL.linkButton(false, false, true);
	} else { // 可批量操作
		postsEL.linkButton(true, true, false);
	}
}

// 设置按钮是否可用
postsEL.linkButton = function(a, b, c) {
	postsEL.edit.linkbutton({disabled: a});
	postsEL.remove.linkbutton({disabled: b});
	postsEL.cut.linkbutton({disabled: c});
}

// 搜索
postsEL.search = function(value){
	postsEL.dg.datagrid('load',{
		title: value
	});
}

// 新建
postsEL.add.click(function() {
	postsEL.addWin.window({
		width: 480,
		height: 180,
		modal: true,
		title: '新建产品',
		collapsible: false,
		minimizable: false,
		maximizable: false,
		href: '/cms/posts/share',
		method: 'get',
		cache: false
	});
});

// 编辑
postsEL.edit.click(function() {
	var row = postsEL.dg.datagrid('getSelected');
	if (row) {
		postsEL.editWin.window({
			width: 480,
			height: 520,
			modal: true,
			title: '编辑产品',
			collapsible: false,
			minimizable: false,
			maximizable: false,
			href: '/cms/posts/' + row.id + '/edit',
			method: 'get',
			cache: false
		});
	}
});

// 删除
postsEL.remove.click(function() {
	CMS.removeSubmitHandler(postsEL, 'posts');
});

// 批量删除
postsEL.cut.click(function() {
	CMS.batchDeleteSubmitHandler(postsEL, 'posts');
});

// 重载
postsEL.reload.click(function() {
	postsEL.dg.datagrid('reload',{});
});
</script>
</body>
</html>