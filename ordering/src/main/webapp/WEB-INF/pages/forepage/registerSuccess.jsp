<%@ page contentType="text/html;charset=UTF-8" language="java"  isELIgnored="false"%>
<%@ include file="../../foreinclude/foreHeader.jsp"%>
<style type="text/css">
    #mydiv{width: 100%;height: 170px;}
    #mycart{width:450px;height:140px;margin: 135px auto;font-size: 25px}
</style>
<div id="mydiv" class="checkout-title">
    <div id="mycart">注册成功，前往<a href="${pageContext.request.contextPath}/fore/foreLoginUI" style="color: red">登录</a></div>
</div>
<%@ include file="../../foreinclude/foreFooter.jsp"%>