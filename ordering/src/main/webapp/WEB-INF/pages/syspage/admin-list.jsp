<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>

<%@include file="../../include/publicMeta.jsp"%>
<%@include file="../../include/publicHeader.jsp"%>
<%@include file="../../include/publicMenu.jsp"%>
<body>
<section class="Hui-article-box">
    <nav class="breadcrumb"><i class="Hui-iconfont">&#xe67f;</i> 首页
        <span class="c-gray en">&gt;</span>
        管理员管理
        <span class="c-gray en">&gt;</span>
        管理员列表 <a class="btn btn-success radius r" style="line-height:1.6em;margin-top:3px" href="javascript:location.replace(location.href);" title="刷新" ><i class="Hui-iconfont">&#xe68f;</i></a> </nav>
    <div class="Hui-article">
        <article class="cl pd-20">
            <div class="cl pd-5 bg-1 bk-gray mt-20">
                <c:if test="${b}">
                    <span class="l"> <a href="javascript:;" onclick="admin_add('添加管理员','adminAddUI','800','500')" class="btn btn-primary radius"><i class="Hui-iconfont">&#xe600;</i> 添加管理员</a> </span>
                    <span class="r">共有数据：<strong>${total}</strong> 条</span>
                </c:if>
            </div>
            <table class="table table-border table-bordered table-bg" id="mytable">
                <thead>
                <tr>
                    <th scope="col" colspan="10">台后管理员列表</th>
                </tr>
                <tr class="text-c">
                    <th width="25"><input type="checkbox" name="" value=""></th>
                    <th width="">ID</th>
                    <th width="">管理员姓名</th>
                    <th width="">管理员密码</th>
                    <th width="">角色</th>
                    <th width="">地址</th>
                    <th width="">电话</th>
                    <th width="100">是否已启用</th>
                    <th width="100">操作</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${users}" var="u" varStatus="vs">
                <tr class="text-c">
                    <td><input type="checkbox" value="1" name=""></td>
                    <td>${vs.count}</td>
                    <td>${u.name}</td>
                    <td>${u.password}</td>
                    <td>
                        <c:forEach items="${u.roles}" var="role">
                            ${role.name} <br>
                        </c:forEach>
                    </td>
                    <td>${u.address}</td>
                    <td>${u.phone}</td>
                    <td class="td-status">
                       <c:if test="${u.status==1}">
                            <span class="label label-success radius">已启用</span>
                        </c:if>
                        <c:if test="${u.status==0}">
                            <span class="label radius">已停用</span>
                        </c:if>

                    </td>
                    <c:if test="${b || (user.name == u.name)}">
                        <td class="td-manage" >
                                <c:if test="${u.status==0}">
                                <a  title="启用" style="text-decoration:none" onclick="start(this,${u.id})" href="javascript:;">
                                    <i class="Hui-iconfont">
                                        &#xe631;
                                    </i>
                                </a>
                            </c:if>
                            <c:if test="${u.status==1}">
                            <a title="禁用" style="text-decoration:none" onclick="stop(this,${u.id})" href="javascript:;">
                                <i class="Hui-iconfont">
                                    &#xe615;
                                </i>
                            </a>
                            </c:if>
                            <a title="编辑" href="javascript:;" onclick="admin_edit('管理员编辑','editUserUI?id=${u.id}','1','800','500')" class="ml-5" style="text-decoration:none">
                                <i class="Hui-iconfont">&#xe6df;</i>
                            </a>
                            <a deleteLink="true" title="删除" href="javascript:deleteadmin(${u.id})" class="ml-5" style="text-decoration:none">
                                <i class="Hui-iconfont">&#xe6e2;</i>
                            </a>
                        </td>
                    </c:if>
                    <c:if test="${!(b || (u.name == user.name))}">
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

    function deleteadmin(id) {
        if(confirm("确定要删除吗？")){
            location.href="${pageContext.request.contextPath}/user/deleteUser?id="+id;
        }
    }


    function admin_add(title,url,w,h){
        layer_show(title,url,w,h);
    }


    function admin_edit(title,url,id,w,h){
        layer_show(title,url,w,h);
    }


    function start(obj,uid) {
        layer.confirm('确认要启用吗？',function(){
            $.get(
                "startStatus",
                {uid:uid},
                function (result) {
                    if(result == "success"){
                        layer.msg('已启用!', {icon: 6,time:1000});
                        location.reload();
                    }
                }
            );
      });
    }
    function stop(obj,uid) {
        layer.confirm('确认要停用吗？',function(){
            $.get(
                "stopStatus",
                {uid:uid},
                function (result) {
                    if(result == "success"){
                        layer.msg('已停用!', {icon: 6,time:1000});
                        location.reload();
                    }
                }
            );
        });
    }



</script>

</body>

