<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@include file="../../include/publicMeta.jsp"%>
<%@include file="../../include/publicHeader.jsp"%>
<%@include file="../../include/publicMenu.jsp"%>

<body>
<section class="Hui-article-box">
    <nav class="breadcrumb"><i class="Hui-iconfont">&#xe67f;</i> 首页 <span class="c-gray en">&gt;</span> 管理员管理 <span class="c-gray en">&gt;</span> 角色管理 <a class="btn btn-success radius r" style="line-height:1.6em;margin-top:3px" href="javascript:location.replace(location.href);" title="刷新" ><i class="Hui-iconfont">&#xe68f;</i></a></nav>
    <div class="Hui-article">
        <article class="cl pd-20">
            <div class="cl pd-5 bg-1 bk-gray">
                <span class="l">
                    <c:if test="${b}">
                        <a class="btn btn-primary radius" href="javascript:;" onclick="admin_role_add('添加角色','addRoleUI','800')">
                            <i class="Hui-iconfont">&#xe600;</i> 添加角色
                        </a>
                    </c:if>
                </span>
                <span class="r">共有数据：<strong>${roles.size()}</strong> 条</span>
            </div>
            <div class="mt-10">
                <table class="table table-border table-bordered table-hover table-bg">
                    <thead>
                    <tr>
                        <th scope="col" colspan="6">角色管理</th>
                    </tr>
                    <tr class="text-c">
                        <th width="25"><input type="checkbox" value="" name=""></th>
                        <th width="40">ID</th>
                        <th width="200">角色名</th>
                        <th width="200">角色描述</th>
                        <th width="300">权限</th>
                        <th width="70">操作</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${roles}" var="role" varStatus="rs">
                        <tr class="text-c">
                            <td><input type="checkbox" value="" name=""></td>
                            <td>${rs.count}</td>
                            <td>${role.name}</td>
                            <td>${role.desc_}</td>
                            <td>
                                <c:forEach items="${role.permissions}" var="permission">
                                    ${permission.name},
                                </c:forEach>
                            </td>
                            <c:if test="${b}">
                                <td class="f-14">
                                <a title="编辑" href="javascript:;" onclick="admin_role_edit('角色编辑','editRoleUI?id=${role.id}','1')" style="text-decoration:none">
                                    <i class="Hui-iconfont">&#xe6df;</i>
                                </a>
                                <a deleteLink="true" title="删除" href="javascript:deleterole(${role.id})" class="ml-5" style="text-decoration:none">
                                    <i class="Hui-iconfont">&#xe6e2;</i>
                                </a>
                            </td>
                            </c:if>
                            <c:if test="${!b}">
                                <td>无操作权限</td>
                            </c:if>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </article>
    </div>
</section>

<%@include file="../../include/publicFooter.jsp"%>
<script type="text/javascript">

    function deleterole(id) {
        if(confirm("确定要删除吗？")){
            location.href="${pageContext.request.contextPath}/role/deleteRole?id="+id;
        }
    }

    function admin_role_add(title,url,w,h){
        layer_show(title,url,w,h);
    }

    function admin_role_edit(title,url,id,w,h){
        layer_show(title,url,w,h);
    }

</script>
</body>
