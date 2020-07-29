<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"  isELIgnored="false"%>

<%@include file="../../include/publicMeta.jsp"%>
<%@include file="../../include/publicHeader.jsp"%>
<%@include file="../../include/publicMenu.jsp"%>

<section class="Hui-article-box">
    <nav class="breadcrumb"><i class="Hui-iconfont">&#xe67f;</i> 首页
        <span class="c-gray en">&gt;</span>
        资讯管理
        <span class="c-gray en">&gt;</span>
        资讯列表 <a class="btn btn-success radius r" style="line-height:1.6em;margin-top:3px" href="javascript:location.replace(location.href);" title="刷新" ><i class="Hui-iconfont">&#xe68f;</i></a> </nav>
    <div class="Hui-article">
        <article class="cl pd-20">
            <div class="cl pd-5 bg-1 bk-gray mt-20">
                <span class="r">共有数据：<strong>${total}</strong> 条</span>
            </div>
            <table class="table table-border table-bordered table-bg" id="mytable">
                <thead>
                <tr>
                    <th scope="col" colspan="10">台后资讯列表</th>
                </tr>
                <tr class="text-c">
                    <th width="">ID</th>
                    <th>发布者</th>
                    <th>发布内容</th>
                    <th>发布时间</th>
                    <th>审核状态</th>
                    <th width="150">操作</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${ziXuns}" var="ziXun" varStatus="vs">
                <tr class="text-c">
                    <td>${vs.count + page.count*(page.currentPage-1) }</td>
                    <td>${ziXun.customer.name}</td>
                    <td>${ziXun.content}</td>
                    <td><fmt:formatDate value="${ziXun.fabudate}" pattern="yyyy年MM月dd日"/></td>
                    <td>
                        <c:if test="${ziXun.status==0}">
                            未审核
                        </c:if>
                        <c:if test="${ziXun.status==1}">
                            已审核
                        </c:if>

                    </td>
                    <td>
                        <c:if test="${ziXun.status==0}">
                            <a title="审核" href="javascript:;"
                               onclick="zixunSH(${ziXun.id})"
                               class="ml-5" style="text-decoration:none">
                                    <span class="label label-success radius">通过</span>
                            </a>
                        </c:if>
                        <c:if test="${ziXun.status==1}">
                            <span class="label radius">已通过</span>
                        </c:if>
                        <a deleteLink="true" title="删除" href="javascript:deleteZixun(${ziXun.id})"
                           class="ml-5" style="text-decoration:none">
                            <span class="label label-success radius">删除</span>
                        </a>
                    </td>
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

    function deleteZixun(id) {
        if(confirm("确定要删除吗？")){
            location.href="${pageContext.request.contextPath}/zixun/del?id="+id;
        }
    }
    /*资讯审核*/
    function zixunSH(zid){
        layer.confirm('确认通过审核吗吗？',function(){
            $.get(
                "zixunshenhe",
                {zid:zid},
                function (result) {
                    if(result == "success"){
                        layer.msg('已审核!', {icon: 6,time:1000});
                        location.reload();
                    }
                }
            );
        });
    }


</script>


