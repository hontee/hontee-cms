<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="easyui-tabs" data-options="fit:true,border:false">
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
    <div title="My Documents" style="padding:10px">
        <ul class="easyui-tree" data-options="url:'tree_data1.json',method:'get',animate:true"></ul>
    </div>
    <div title="Help" data-options="closable:true" style="padding:10px">
        This is the help content.
    </div>
</div>