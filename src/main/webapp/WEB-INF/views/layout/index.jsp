<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="../header.jsp" />

  <div class="container-fluid" style="margin-bottom: 20px;">
	  <div class="row">
	    <div class="col-sm-6">
	      <button id="create" class="btn btn-primary-outline">创建类别</button>
		  <button id="edit" class="btn btn-primary-outline" disabled>编辑</button>
		  <button id="remove" class="btn btn-primary-outline" disabled>删除</button>
		  <button id="batch" class="btn btn-primary-outline" disabled>批量删除</button>
	    </div>
	    <div class="col-sm-6 text-right">
	      <form class="form-inline">
		  <div class="form-group">
		    <input class="form-control" id="q" placeholder="搜索标题">
		  </div>
		  <button id="search" class="btn btn-primary">搜索</button>
		</form>
	    </div>
	  </div>
  </div>
  
  <div class="container-fluid">
    <table id="dg"></table>
  </div>
</body>
</html>
<script>
var el = {
	create: $('#create'),
	dg: $('#dg'),
	edit: $('#edit'),
	remove: $('#remove'),
	batch: $('#batch'),
	q: $('#q'),
	search: $('#search')
}
// 初始化加载
el.dg.datagrid({
    url:'/admin/groups/list',
    fitColumns: true,
    idField: "id",
    rownumbers: true,
    pagination: true,
    columns:[[
        {field: 'id', checkbox: true},
        {field:'name',title:'名称',width:100, hidden: true},
        {field:'title',title:'标题',width:100},
        {field:'description',title:'描述',width:100},
        {field:'state',title:'状态',width:100, sortable: true},
        {field:'stars',title:'星标记',width:100},
        {field:'count',title:'计数',width:100},
        {field:'parent',title:'父类别',width:100, formatter: function(value, row, index) {
        	if (row.parent) {
				return row.parent.title;
			} 
        }},
        {field:'parentIds',title:'类别树',width:100},
        {field:'created',title:'创建时间',width:100, sortable: true},
        {field:'lastModified',title:'最后更新时间',width:100, sortable: true},
        {field:'createBy',title:'创建用户',width:100},
        {field:'auditBy',title:'责任编辑',width:100},
        {field:'auditRemark',title:'备注',width:100}
    ]],
    // 当选择一行时触发
    onSelect: function(index,row) {
    	var length = el.dg.datagrid("getSelections").length;
    	if (length == 0) { // 全部禁用
    		el.edit.attr("disabled", true);
        	el.remove.attr("disabled", true);
        	el.batch.attr("disabled", true);
		} else if (length == 1) {
			el.edit.removeAttr("disabled");
	    	el.remove.removeAttr("disabled");
		} else {
			el.edit.attr("disabled", true);
        	el.remove.attr("disabled", true);
			el.batch.removeAttr("disabled");
		}
    },
 	// 当取消选择一行时触发
    onUnselect: function(index,row) {
    	var length = el.dg.datagrid("getSelections").length;
    	if (length == 0) { // 全部禁用
    		el.edit.attr("disabled", true);
        	el.remove.attr("disabled", true);
        	el.batch.attr("disabled", true);
		} else if (length == 1) {
			el.edit.removeAttr("disabled");
	    	el.remove.removeAttr("disabled");
		} else {
			el.edit.attr("disabled", true);
        	el.remove.attr("disabled", true);
			el.batch.removeAttr("disabled");
		}
    },
 	// 当全选时触发
    onSelectAll: function(rows) {
    	el.edit.attr("disabled", true);
    	el.remove.attr("disabled", true);
    	el.batch.removeAttr("disabled", true);
    },
 	// 当取消全选时触发
    onUnselectAll: function(rows) {
    	el.edit.attr("disabled", true);
    	el.remove.attr("disabled", true);
    	el.batch.attr("disabled", true);
    },
    // 双击查看
    onDblClickRow: function(index,row) {
    	layer.open({
			type: 2,
			title: "查看详情",
			area: ['640px', '80%'], //宽高
			content: "/admin/groups/" + row.id
		});
    }
});

// 创建
el.create.click(function() {
	//页面层
	layer.open({
	    type: 2,
	    skin: 'layui-layer-rim', //加上边框
	    area: ['640px', '80%'], //宽高
	    title: "创建分类",
	    content: '/admin/groups/new'
	});
});

// 搜索过滤
el.search.click(function() {
	el.dg.datagrid('load', {
		title: el.q.val()
	});
});

// 编辑
el.edit.click(function() {
	var row = el.dg.datagrid("getSelected");
	if (row) {
		layer.open({
		    type: 2,
		    skin: 'layui-layer-rim', //加上边框
		    area: ['640px', '80%'], //宽高
		    title: "编辑分类",
		    content: '/admin/groups/'+row.id+'/edit'
		});
	}
});

// 移除
el.remove.click(function() {
	var row = el.dg.datagrid("getSelected");
	if (row) {
		layer.confirm('确定要删除吗？', {
		    btn: ['删除','取消'] //按钮
		}, function(){
			var url = '/admin/groups/' + row.id +'/delete';
		    $.post(url, function(data) {
		    	var r = $.parseJSON(data);
		    	if (r.success) {
		    		layer.msg(r.result, {icon: 1});
				} else {
					layer.msg('系统错误，删除失败！', {icon: 1});
				}
		    });
		}, function(){
		});
	}
});

// 批量删除
el.batch.click(function() {
	/* //询问框
	layer.confirm('您是如何看待前端开发？', {
	    btn: ['重要','奇葩'] //按钮
	}, function(){
	    layer.msg('的确很重要', {icon: 1});
	}, function(){
	    layer.msg('也可以这样', {
	        time: 20000, //20s后自动关闭
	        btn: ['明白了', '知道了']
	    });
	}); */
});
</script>