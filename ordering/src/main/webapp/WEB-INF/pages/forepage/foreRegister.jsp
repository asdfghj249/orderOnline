<%@ page contentType="text/html;charset=UTF-8" language="java"  isELIgnored="false"%>
<%@ include file="../../foreinclude/foreHeader.jsp"%>


<div class="breadcrumb-area pt-15 pb-15">
    <div class="container">
        <div class="row">
            <div class="col-lg-12">

                <div class="breadcrumb-container">
                    <nav>
                        <ul>
                            <li class="parent-page"><a href="${pageContext.request.contextPath}/fore/foreIndex">Home</a></li>
                            <li>Register</li>
                        </ul>
                    </nav>
                </div>

            </div>
        </div>
    </div>
</div>


<div class="page-section mb-50">
    <div class="container">

        <div class="row">
            <div class="col-sm-12 col-md-12 col-lg-3 col-xs-12"></div>
            <div class="col-sm-12 col-md-12 col-lg-6 col-xs-12">
                <form action="${pageContext.request.contextPath}/fore/foreRegister" method="post" class="registerForm" >

                    <div class="login-form">
                        <h4 class="login-title">注册</h4>

                        <div class="row">
                            <div class="col-md-6 col-12 mb-20">
                                <label>用户名</label>
                                <input type="hidden" value="${error}" id="error">
                                <input class="mb-0" type="text" name="name" id="name" >
                            </div>
                            <div class="col-md-6 col-12 mb-20">
                                <label>密码</label>
                                <input class="mb-0" type="password" name="password" id="password" >
                            </div>
                            <div class="col-md-12 mb-20">
                                <label>地址:</label>
                                <input class="mb-0" type="text" name="address" id="address" >
                            </div>
                            <div class="col-md-6 mb-20">
                                <label>手机:</label>
                                <input class="mb-0" type="text"  name="phone" id="phone" >
                            </div>

                            <div class="col-12">
                                <button type="submit" class="register-button mt-0">注册</button>
                            </div>
                        </div>
                    </div>

                </form>
            </div>
        </div>
    </div>
</div>

<script src="${pageContext.request.contextPath}/js/jquery/2.0.0/jquery.min.js"></script>
<script type="text/javascript">

    $(function () {
        $("form.registerForm").submit(function () {

            var password = $("#password").val();
            var rg_password = /^\w{6,12}$/;
            var flag = rg_password.test(password);

            if (!flag){
                alert("密码必须为6-12位！");
                return false;
            }

            if($("#name").val().length === 0 ){
                alert("用户名不能为空");
                return false;
            }
            if ($("#address").val().length === 0 ){
                alert("地址不能为空");
                return false;
            }
            if ($("#phone").val().length === 0 ){
                alert("手机号不能为空");
                return false;
            }
            return true;
        });

        var error = $("#error").val();
        if (error === "true"){
            alert("用户名已存在！");
        }

    });
</script>

<%@ include file="../../foreinclude/foreFooter.jsp"%>
