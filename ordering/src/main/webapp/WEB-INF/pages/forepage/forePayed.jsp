<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ include file="../../foreinclude/foreHeader.jsp"%>
<style type="text/css">
    #mydiv{width: 100%;height: 170px;}
    #mycart{width:450px;height:140px;margin: 135px auto;font-size: 25px}
</style>
<div id="mydiv" class="checkout-title">
    <div id="mycart">您已支付成功,共计${total}元<a href="${pageContext.request.contextPath}/fore/forebought" style="color: red">查看订单》</a></div>
</div>
<%@ include file="../../foreinclude/foreFooter.jsp"%>
