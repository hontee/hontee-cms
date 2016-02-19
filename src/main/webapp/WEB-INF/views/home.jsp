<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="_header.jsp" %>
<title>Hontee.CMS</title>
</head>
<body class="easyui-layout">
<!--   <div data-options="region:'north'" style="height:80px;"></div>
 -->  <div data-options="region:'west',title:'菜单管理'" style="width:180px;">
    <div id="menu-datalist"></div>
  </div>
  <div data-options="region:'center'">
    <div id="homeTabs" class="easyui-tabs">
	    <div title="首页" style="padding:10px">
	        <p style="font-size:14px">jQuery EasyUI framework helps you build your web pages easily.</p>
	        <ul>
	            <li>easyui is a collection of user-interface plugin based on jQuery.</li>
	            <li>easyui provides essential functionality for building modem, interactive, javascript applications.</li>
	            <li>using easyui you don't need to write many javascript code, you usually defines user-interface by writing some HTML markup.</li>
	            <li>complete framework for HTML5 web page.</li>
	            <li>easyui save your time and scales while developing your products.</li>
	            <li>easyui is very easy but powerful.</li>
	        </ul>
	    </div>
	</div>
  </div>
  
<script>
var homeTabs = $('#homeTabs').tabs({
  fit:true,
  border:false
});
	
var datalist = $("#menu-datalist").datalist({
    url: '/cms/menus/datalist',
    checkbox: false,
    lines: false,
    border:false,
    valueField: 'name',
    textField: 'title',
    groupField: 'groupField',
    textFormatter: function(value, row, index) {
    	return "<span style='padding-left: 20px;'>" + value + "</span>"
    },
    onClickRow: function(index, row) {
    	if (homeTabs.tabs("exists", row.title)) {
    		homeTabs.tabs('select', row.title);
		} else {
			homeTabs.tabs('add', {
	          id: row.name,
	          title : row.title,
	          href: row.url,
	          closable : true
	        });
		}
    }
});
</script>
</body>
</html>