<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../_header.jsp" %>
<title>平台管理 - Hontee.CMS</title>
</head>
<body>
<header class="cms-dg-header">
	<button id="platforms-add" class="easyui-linkbutton" data-options="iconCls:'icon-add'">新建</button>
	<button id="platforms-edit" class="easyui-linkbutton" data-options="iconCls:'icon-edit',disabled:true">编辑</button>
	<button id="platforms-remove" class="easyui-linkbutton" data-options="iconCls:'icon-remove',disabled:true">删除</button>
	<button id="platforms-cut" class="easyui-linkbutton" data-options="iconCls:'icon-cut',disabled:true">批量删除</button>
	<button id="platforms-reload" class="easyui-linkbutton" data-options="iconCls:'icon-reload'">刷新</button>
	
	<span class="cms-dg-search">
	  <input class="easyui-searchbox" data-options="prompt:'输入标题', searcher:search" style="width:200px" />
	</span>
</header>
<table id="platforms-dg"></table>
<footer>
    <div id="platforms-add-win"></div>
</footer>
<script>
// 变量取值要唯一
var platformsEL = {
	add: $("#platforms-add"),
	edit: $("#platforms-edit"),
	remove: $("#platforms-remove"),
	cut: $("#platforms-cut"),
	reload: $("#platforms-reload"),
	dg: $("#platforms-dg"),
	addWin: $("#platforms-add-win")
};

// DataGrid
platformsEL.dg.datagrid({
    url:'/cms/platforms/list',
    fitColumns: true,
    border: false,
    idField: "id",
    rownumbers: true,
    pagination: true,
    title:'平台管理',
    header: 'header',
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
        }}
    ]],
 	// 当选择一行时触发
    onSelect: function(index,row) {
    	setButton();
    },
 	// 当取消选择一行时触发
    onUnselect: function(index,row) {
    	setButton();
    },
 	// 当全选时触发
    onSelectAll: function(rows) {
    	setButton();
    },
 	// 当取消全选时触发
    onUnselectAll: function(rows) {
    	setButton();
    },
    // 双击查看
    onDblClickRow: function(index,row) {
    	console.log("onDblClickRow");
    }
});

// 根据选择记录触发
function setButton() {
	var length = platformsEL.dg.datagrid("getSelections").length;
	if (length == 0) { // 全部禁用
		linkButton(true, true, true);
	} else if (length == 1) { // 可编辑和删除
		linkButton(false, false, true);
	} else { // 可批量操作
		linkButton(true, true, false);
	}
}

// 设置按钮是否可用
function linkButton(a, b, c) {
	platformsEL.edit.linkbutton({disabled: a});
	platformsEL.remove.linkbutton({disabled: b});
	platformsEL.cut.linkbutton({disabled: c});
}

// 搜索
function search(value){
	platformsEL.dg.datagrid('load',{
		title: value
	});
}

// 新建
platformsEL.add.click(function() {
	platformsEL.addWin.window({
		width: 360,
		height: 440,
		modal: true,
		title: '新建平台类型',
		collapsible: false,
		minimizable: false,
		maximizable: false,
		href: '/cms/platforms/new',
		method: 'get',
		cache: false
	});
});

// 编辑
platformsEL.edit.click(function() {
	alert("edit");
});

// 删除
platformsEL.remove.click(function() {
	var row = platformsEL.dg.datagrid('getSelected');
	if (row) {
		$.messager.confirm('提示信息', '确定要删除吗?', function(ok){
			if (ok){
				var url = '/cms/platforms/'+row.id +'/delete';
				$.post(url, function(data) {
					var r = $.parseJSON(data);
					if (r.success) {
						$.messager.alert("提示信息", "删除成功！", "info");
						platformsEL.dg.datagrid('reload',{}); // 重新加载
					} else {
						$.messager.alert("删除失败", r.error.message, "error");
					}
				});
			} 
		});
	}
});

// 批量删除
platformsEL.cut.click(function() {
	alert("cut");
});

// 重载
platformsEL.reload.click(function() {
	platformsEL.dg.datagrid('reload',{});
});
</script>
</body>
</html>