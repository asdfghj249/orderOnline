<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>

<%@include file="../../include/publicMeta.jsp"%>
<%@include file="../../include/publicHeader.jsp"%>
<%@include file="../../include/publicMenu.jsp"%>
<body>
<section class="Hui-article-box">
    <nav class="breadcrumb"><i class="Hui-iconfont">&#xe67f;</i> 首页 <span class="c-gray en">&gt;</span> 管理员管理 <span class="c-gray en">&gt;</span> 权限管理 <a class="btn btn-success radius r" style="line-height:1.6em;margin-top:3px" href="javascript:location.replace(location.href);" title="刷新" ><i class="Hui-iconfont">&#xe68f;</i></a></nav>
    <div class="Hui-article">
        <article class="cl pd-20">
            <div class="cl pd-5 bg-1 bk-gray mt-20">
                <span class="l">
                    <c:if test="${b}">
                        <a href="javascript:;" onclick="admin_permission_add('添加权限节点','adminPerAddUI','','310')" class="btn btn-primary radius">
                            <i class="Hui-iconfont">&#xe600;</i> 添加权限节点
                        </a>
                    </c:if>
                </span>
                <span class="r">共有数据：<strong>${total}</strong> 条</span> </div>
            <table class="table table-border table-bordered table-bg">
                <thead>
                <tr>
                    <th scope="col" colspan="7">权限节点</th>
                </tr>
                <tr class="text-c">
                    <th width="25"><input type="checkbox" name="" value=""></th>
                    <th width="40">ID</th>
                    <th width="100">权限名称</th>
                    <th width="100">描述</th>
                    <th width="100">操作</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${permissions}" var="permission" varStatus="vs">
                    <tr class="text-c">
                        <td><input type="checkbox" value="1" name=""></td>
                        <td>${vs.count + page.count * (page.currentPage-1)}</td>
                        <td>${permission.name}</td>
                        <td>${permission.desc_}</td>
                        <c:if test="${b}">
                            <td>
                                <a title="编辑" href="javascript:;" onclick="admin_permission_edit('角色编辑','editPermissionUI?id=${permission.id}','1','','310')" class="ml-5" style="text-decoration:none">
                                <i class="Hui-iconfont">&#xe6df;</i></a> <a deleteLink="true" title="删除" href="javascript:deletepermission(${permission.id})" class="ml-5" style="text-decoration:none"><i class="Hui-iconfont">&#xe6e2;</i></a>
                            </td>
                        </c:if>
                        <c:if test="${!b}">
                            <td>无操作权限</td>
                        </c:if>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </article>
        <article class="cl pd-20">
            <%@include file="../adminPage.jsp"%>
        </article>
    </div>
</section>

<%@include file="../../include/publicFooter.jsp"%>
<script type="text/javascript">
    function deletepermission(id) {
        if(confirm("确定要删除吗？")){
            location.href="${pageContext.request.contextPath}/permission/deletePermission?id="+id;
        }
    }

    function admin_permission_add(title,url,w,h){
        layer_show(title,url,w,h);
    }

    function admin_permission_edit(title,url,id,w,h){
        layer_show(title,url,w,h);
    }

</script>

</body>

