<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@include file="../../include/publicMeta.jsp"%>

<article class="cl pd-20">
    <form action="${pageContext.request.contextPath}/category/updateCategory" method="post" class="form form-horizontal" id="form-category-add" target="_parent">
        <div class="row cl">
            <label class="form-label col-xs-4 col-sm-3"><span class="c-red"></span>分类名称：</label>
            <div class="formControls col-xs-8 col-sm-9">
                <input type="text" class="input-text" value="${category.name}" placeholder="" id="name" name="name">
            </div>
        </div>
        <div>
            <input type="hidden" name="id" value="${category.id}">
        </div>

        <div class="row cl">
            <div class="col-xs-8 col-sm-9 col-xs-offset-4 col-sm-offset-3">
                <input class="btn btn-primary radius" type="submit" value="&nbsp;&nbsp;提交&nbsp;&nbsp;">
            </div>
        </div>
    </form>
</article>
<%@include file="../../include/publicFooter.jsp"%>


