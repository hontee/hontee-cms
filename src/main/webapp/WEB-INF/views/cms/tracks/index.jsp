<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../_header.jsp" %>
<title>异常管理 - Hontee.CMS</title>
</head>
<body>
<header id="tracks-header" class="cms-dg-header">
	<button id="tracks-remove" class="easyui-linkbutton" data-options="iconCls:'icon-remove',disabled:true">删除</button>
	<button id="tracks-cut" class="easyui-linkbutton" data-options="iconCls:'icon-cut',disabled:true">批量删除</button>
	<button id="tracks-reload" class="easyui-linkbutton" data-options="iconCls:'icon-reload'">刷新</button>
	
	<span class="cms-dg-search">
	  <input class="easyui-searchbox" data-options="prompt:'搜索异常', searcher:tracksEL.search" style="width:200px" />
	</span>
</header>
<table id="tracks-dg"></table>
<script>
// 变量取值要唯一
var tracksEL = {
	remove: $("#tracks-remove"),
	cut: $("#tracks-cut"),
	reload: $("#tracks-reload"),
	dg: $("#tracks-dg")
};

// DataGrid
tracksEL.dg.datagrid({
    url:'/cms/tracks/list',
    fitColumns: true,
    border: false,
    idField: "id",
    rownumbers: true,
    pagination: true,
    title:'异常管理',
    header: '#tracks-header',
    fit: true,
    columns:[[
       {field: 'id', checkbox: true},
       {field:'exception',title:'异常',width:100},
       {field:'object',title:'异常信息',width:100},
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
       {field:'remark',title:'备注',width:100}
    ]],
 	// 当选择一行时触发
    onSelect: function(index,row) {
    	tracksEL.reset();
    },
 	// 当取消选择一行时触发
    onUnselect: function(index,row) {
    	tracksEL.reset();
    },
 	// 当全选时触发
    onSelectAll: function(rows) {
    	tracksEL.reset();
    },
 	// 当取消全选时触发
    onUnselectAll: function(rows) {
    	tracksEL.reset();
    },
    // 双击查看
    onDblClickRow: function(index,row) {
    	console.log("view detail");
    }
});

// 根据选择记录触发: 重置按钮状态
tracksEL.reset = function() {
	var length = tracksEL.dg.datagrid("getSelections").length;
	if (length == 0) { // 全部禁用
		tracksEL.linkButton(true, true);
	} else if (length == 1) { // 删除
		tracksEL.linkButton(false, true);
	} else { // 可批量操作
		tracksEL.linkButton(true, false);
	}
}

// 设置按钮是否可用
tracksEL.linkButton = function(b, c) {
	tracksEL.remove.linkbutton({disabled: b});
	tracksEL.cut.linkbutton({disabled: c});
}

// 搜索
tracksEL.search = function(value){
	tracksEL.dg.datagrid('load',{
		title: value
	});
}

// 删除
tracksEL.remove.click(function() {
	CMS.removeSubmitHandler(tracksEL, 'tracks');
});

// 批量删除
tracksEL.cut.click(function() {
	CMS.batchDeleteSubmitHandler(tracksEL, 'tracks');
});

// 重载
tracksEL.reload.click(function() {
	tracksEL.dg.datagrid('reload',{});
});
</script>
</body>
</html>