<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ include file="../../foreinclude/foreHeader.jsp"%>

<div class="hero-area home-four mb-30">
    <div class="slider-container">
        <div class="slider-style-2">
            <div class="hero-slider-item slider-bg-9">
                <div class="d-flex flex-column justify-content-center align-items-start h-100">
                    <div class="container">
                        <div class="row">
                            <div class="col-lg-7 col-xl-6 col-md-7 text-center">
                                <div class="slider-content">
                                    <p>舌尖美食，一步到位</p>
                                    <h1>美味无法抵挡</h1>
                                    <p>现在下单满299元即可优惠30元,限时优惠.</p>
                                    <a href="${pageContext.request.contextPath}/fore/foreDetailUI?id=30" class="slider-btn">查看详情</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>



            <div class="hero-slider-item slider-bg-10">

                <div class="d-flex flex-column justify-content-center align-items-start h-100">
                    <div class="container">
                        <div class="row">
                            <div class="col-lg-7 col-xl-6 col-md-7 text-center">
                                <div class="slider-content">
                                    <p>新客户享受八折优惠</p>
                                    <h1>巧克力蛋糕</h1>
                                    <p>chocolate cake 美食上新.</p>
                                    <a href="${pageContext.request.contextPath}/fore/foreDetailUI?id=13" class="slider-btn">查看详情</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

            </div>


            <div class="hero-slider-item slider-bg-11">

                <div class="d-flex flex-column justify-content-center align-items-start h-100">
                    <div class="container">
                        <div class="row">
                            <div class="col-lg-7 col-xl-6 col-md-7 text-center">
                                <div class="slider-content">
                                    <p>周年庆牛排特惠</p>
                                    <h1>极致美食</h1>
                                    <p>新品享乐惠，品尝好滋味.</p>
                                    <a href="${pageContext.request.contextPath}/fore/foreDetailUI?id=31" class="slider-btn">查看详情</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

            </div>

        </div>

    </div>

</div>


<c:forEach items="${categories}" var="category" varStatus="vs">

    <div class="slider-banner-sidebar-three mb-50">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="slider-banner-sidebar-three-container">
                        <div class="sidebar-container">
                            <div class="section-title-three">
                                <h3 id="${category.id}">${category.name}</h3>
                            </div>
                            <div class="sidebar">快捷每一天</div>
                        </div>

                        <div class="slider-banner home-four-banner slider-border banner-bg banner-bg-${vs.count}">
                            <div class="banner-text h-100"></div>
                        </div>

                            <div class="fl-slider tab-product-slider">
                                <c:forEach items="${category.product}" var="product">
                                <div class="fl-product">
                                    <div class="image">
                                        <a href="${pageContext.request.contextPath}/fore/foreDetailUI?id=${product.id}">
                                            <img src="${pageContext.request.contextPath}/${product.imageurl}" class="img-fluid" alt="">
                                            <img src="${pageContext.request.contextPath}/${product.imageurl}" class="img-fluid" alt="">
                                        </a>
                                        <span class="wishlist-icon">
												<a href="#" ><i class="icon ion-md-heart-empty"></i></a>
										 </span>
                                    </div>
                                    <div class="content">
                                        <h2 class="product-title"> <a href="${pageContext.request.contextPath}/fore/foreDetailUI?id=${product.id}">${product.name}</a></h2>
                                        <div class="rating">
                                            <i class="fa fa-star active"></i>
                                            <i class="fa fa-star active"></i>
                                            <i class="fa fa-star active"></i>
                                            <i class="fa fa-star"></i>
                                            <i class="fa fa-star"></i>
                                        </div>
                                        <p class="product-price">
                                            <span class="main-price discounted">
                                                $<fmt:formatNumber type="number" value="${product.price+15.00}" pattern="0.00" maxFractionDigits="2"/>
                                            </span>
                                            <span class="discounted-price">
                                                $<fmt:formatNumber type="number" value="${product.price}" pattern="0.00" maxFractionDigits="2"/>
                                            </span>
                                        </p>

                                        <div class="hover-icons">
                                            <ul>
                                                <input class="hid" type="hidden" value="${product.id}" id="pro${product.id}">

                                                <li><a href="#" data-target="#quick-view-modal-container" data-tooltip="立即购买" id="nowPayment${product.id}" onclick="buyNow(${product.id})"  ><i class="icon ion-md-options"></i></a></li>
                                                <li>
                                                    <a href="#" data-toggle = "modal" data-target="#quick-view-modal-container" data-tooltip="添加到购物车"
                                                        onclick="addCart(${product.id});">
                                                        <i class="icon ion-md-cart"></i>
                                                    </a>
                                                </li>
                                            </ul>
                                        </div>
                                    </div>
                                </div>
                                </c:forEach>
                            </div>

                    </div>
                </div>
            </div>
        </div>
    </div>
</c:forEach>


<div class="brand-logo-slider home-four-brand-slider mb-50">
    <div class="container">
        <div class="row">
            <div class="col-lg-12">

                <div class="brand-logo-slider-container">

                    <div class="single-brand">
                        <a href="#">
                            <img src="${pageContext.request.contextPath}/images/brands/01.png" class="img-fluid" alt="">
                        </a>
                    </div>


                    <div class="single-brand">
                        <a href="#">
                            <img src="${pageContext.request.contextPath}/images/brands/02.png" class="img-fluid" alt="">
                        </a>
                    </div>


                    <div class="single-brand">
                        <a href="#">
                            <img src="${pageContext.request.contextPath}/images/brands/03.png" class="img-fluid" alt="">
                        </a>
                    </div>

                    <div class="single-brand">
                        <a href="#">
                            <img src="${pageContext.request.contextPath}/images/brands/04.png" class="img-fluid" alt="">
                        </a>
                    </div>


                    <div class="single-brand">
                        <a href="#">
                            <img src="${pageContext.request.contextPath}/images/brands/05.png" class="img-fluid" alt="">
                        </a>
                    </div>


                    <div class="single-brand">
                        <a href="#">
                            <img src="${pageContext.request.contextPath}/images/brands/06.png" class="img-fluid" alt="">
                        </a>
                    </div>


                    <div class="single-brand">
                        <a href="#">
                            <img src="${pageContext.request.contextPath}/images/brands/07.png" class="img-fluid" alt="">
                        </a>
                    </div>

                </div>

            </div>
        </div>
    </div>
</div>


<!-- 模态框（Modal） -->
<div class="modal fade"  tabindex="-1" role="dialog"  id="myModal" aria-labelledby="myModalLabel" aria-hidden="true" data-backdrop="true">
    <div class="modal-dialog">
        <div class="modal-content">

            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    ×
                </button>
                <h4 class="modal-title" id="myModalLabel">
                    欢迎登陆！
                </h4>
            </div>

            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="loginErrorMessageDiv">
                        <div class="alert alert-danger" >
                            <span class="errorMessage"></span>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="name" class="col-sm-2 control-label">用户名</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" name="name" id="name">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="password" class="col-sm-2 control-label" >密码</label>
                        <div class="col-sm-10">
                            <input type="password" class="form-control" id="password" name="password">
                        </div>
                    </div>

                    <div class="form-group">
                        <div class="col-sm-offset-2 col-sm-10">
                            <button type="button" class="btn btn-default" id="modalLogin">登录</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>


<script src="${pageContext.request.contextPath}/js/vendor/jquery.min.js"></script>
<script type="text/javascript">

    $("div.loginErrorMessageDiv").hide();
    //立即购买
    function buyNow(id) {
        $.get(
            "foreIsLogin",
            function (result) {
                if(result === "true"){
                    location.href = "forebuyone?pid="+id+"&number=1";
                }else {
                   //alert("请先登录！");
                    $('#myModal').modal('show')
                }
            }
        )
    }

    //添加购物车
    function addCart(id) {
        $.get(
            "foreAddCart",
            {pid:id,number:1},
            function (result) {
                if(result === "success"){
                    alert("添加购物车成功！");
                }else {
                    //alert("请先登录！");
                    $('#myModal').modal('show')
                }
            }
        );
    }

    //模态窗口登陆
    $("#modalLogin").click(function () {
        var name = $("#name").val();
        var password = $("#password").val();

        if(name.length == 0 ||password.length == 0){
            $("span.errorMessage").html("账号或密码不能为空");
            $("div.loginErrorMessageDiv").show();
            return false;
        }

        $.get(
            "foreMtLogin",
            {name:name,password:password},
            function (result) {
                if(result == "true"){
                    location.reload();
                }else{
                    $("span.errorMessage").html("账号或密码错误");
                    $("div.loginErrorMessageDiv").show();
                }
            }
        );
    });



</script>
<%@ include file="../../foreinclude/foreFooter.jsp"%>

