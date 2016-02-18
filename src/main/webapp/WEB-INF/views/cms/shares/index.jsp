<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../_header.jsp" %>
<title>分享管理 - Hontee.CMS</title>
</head>
<body>
<header id="shares-header" class="cms-dg-header">
	<button id="shares-add" class="easyui-linkbutton" data-options="iconCls:'icon-add'">新建</button>
	<button id="shares-edit" class="easyui-linkbutton" data-options="iconCls:'icon-edit',disabled:true">编辑</button>
	<button id="shares-remove" class="easyui-linkbutton" data-options="iconCls:'icon-remove',disabled:true">删除</button>
	<button id="shares-cut" class="easyui-linkbutton" data-options="iconCls:'icon-cut',disabled:true">批量删除</button>
	<button id="shares-reload" class="easyui-linkbutton" data-options="iconCls:'icon-reload'">刷新</button>
	
	<span class="cms-dg-search">
	  <input class="easyui-searchbox" data-options="prompt:'输入标题', searcher:sharesEL.search" style="width:200px" />
	</span>
</header>
<table id="shares-dg"></table>
<footer>
    <div id="shares-add-win"></div>
    <div id="shares-edit-win"></div>
</footer>
<script>
// 变量取值要唯一
var sharesEL = {
	add: $("#shares-add"),
	edit: $("#shares-edit"),
	remove: $("#shares-remove"),
	cut: $("#shares-cut"),
	reload: $("#shares-reload"),
	dg: $("#shares-dg"),
	addWin: $("#shares-add-win"),
	editWin: $("#shares-edit-win")
};

// DataGrid
sharesEL.dg.datagrid({
    url:'/cms/shares/list',
    fitColumns: true,
    border: false,
    idField: "id",
    rownumbers: true,
    pagination: true,
    title:'分享管理',
    header: '#shares-header',
    fit: true,
    columns:[[
        {field: 'id', checkbox: true},
        {field:'name',title:'名称',width:100, hidden: true},
        {field:'title',title:'标题',width:100, sortable: true},
        {field:'description',title:'描述',width:100},
        {field:'keywords',title:'标签',width:100},
        {field:'url',title:'链接',width:100},
        {field:'catId',title:'类别ID',width:100, sortable: true},
        {field:'platforms',title:'支持平台',width:100},
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
    	sharesEL.reset();
    },
 	// 当取消选择一行时触发
    onUnselect: function(index,row) {
    	sharesEL.reset();
    },
 	// 当全选时触发
    onSelectAll: function(rows) {
    	sharesEL.reset();
    },
 	// 当取消全选时触发
    onUnselectAll: function(rows) {
    	sharesEL.reset();
    },
    // 双击查看
    onDblClickRow: function(index,row) {
    	console.log("view detail");
    }
});

// 根据选择记录触发: 重置按钮状态
sharesEL.reset = function() {
	var length = sharesEL.dg.datagrid("getSelections").length;
	if (length == 0) { // 全部禁用
		sharesEL.linkButton(true, true, true);
	} else if (length == 1) { // 可编辑和删除
		sharesEL.linkButton(false, false, true);
	} else { // 可批量操作
		sharesEL.linkButton(true, true, false);
	}
}

// 设置按钮是否可用
sharesEL.linkButton = function(a, b, c) {
	sharesEL.edit.linkbutton({disabled: a});
	sharesEL.remove.linkbutton({disabled: b});
	sharesEL.cut.linkbutton({disabled: c});
}

// 搜索
sharesEL.search = function(value){
	sharesEL.dg.datagrid('load',{
		title: value
	});
}

// 新建
sharesEL.add.click(function() {
	sharesEL.addWin.window({
		width: 480,
		height: 180,
		modal: true,
		title: '分享链接',
		collapsible: false,
		minimizable: false,
		maximizable: false,
		href: '/cms/shares/share',
		method: 'get',
		cache: false
	});
});

// 编辑
sharesEL.edit.click(function() {
	var row = sharesEL.dg.datagrid('getSelected');
	if (row) {
		sharesEL.editWin.window({
			width: 480,
			height: 440,
			modal: true,
			title: '编辑分享',
			collapsible: false,
			minimizable: false,
			maximizable: false,
			href: '/cms/shares/' + row.id + '/edit',
			method: 'get',
			cache: false
		});
	}
});

// 删除
sharesEL.remove.click(function() {
	CMS.removeSubmitHandler(sharesEL, 'shares');
});

// 批量删除
sharesEL.cut.click(function() {
	CMS.batchDeleteSubmitHandler(sharesEL, 'shares');
});

// 重载
sharesEL.reload.click(function() {
	sharesEL.dg.datagrid('reload',{});
});
</script>
</body>
</html>