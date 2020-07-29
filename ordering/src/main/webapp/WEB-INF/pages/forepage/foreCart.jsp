<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ include file="../../foreinclude/foreHeader.jsp"%>


<div class="breadcrumb-area pt-15 pb-15">
    <div class="container">
        <div class="row">
            <div class="col-lg-12">
                <div class="breadcrumb-container">
                    <nav>
                        <ul>
                            <li class="parent-page"><a href="${pageContext.request.contextPath}/fore/foreIndex">Home</a></li>
                            <li>Cart</li>
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
                <div class="col-12">
                    <form action="#">

                        <div class="cart-table table-responsive mb-40">
                            <table class="table">
                                <thead>
                                <tr>
                                    <th></th>
                                    <th class="pro-thumbnail">图片</th>
                                    <th class="pro-title">名称</th>
                                    <th class="pro-price">单价</th>
                                    <th class="pro-quantity">数量</th>
                                    <th class="pro-subtotal">总计</th>
                                    <th class="pro-remove">删除</th>
                                </tr>
                                </thead>
                                <tbody>
                            <c:forEach items="${ois}" var="oi">
                                <tr>
                                    <td><input style="width: 20px;height: 20px;margin-top: 23px" type="checkbox" name="crrent" id="check${oi.id}" onclick="dianji(this,${oi.id});"></td>
                                    <td class="pro-thumbnail">
                                        <a href="${pageContext.request.contextPath}/fore/foreDetailUI?id=${oi.product.id}"><img src="${pageContext.request.contextPath}/${oi.product.imageurl}" class="img-fluid" alt="Product"></a>
                                    </td>
                                    <td class="pro-title"><a href="${pageContext.request.contextPath}/fore/foreDetailUI?id=${oi.product.id}">${oi.product.name}</a></td>
                                    <c:if test="${cst.status==0}"><td class="pro-price"><span>$${oi.product.price}</span></td></c:if>
                                    <c:if test="${cst.status==1}"><td class="pro-price"><span>$${oi.product.price*0.8}</span></td></c:if>

                                    <td class="pro-quantity">
                                        <div class="pro-qty" >
                                            <input  type="text" id="num${oi.id}" value="${oi.number}" readonly="readonly">
                                            <a class="inc qty-btn" href="#" id="inc" onclick="inc(${oi.id})">+</a>
                                            <a class="dec qty-btn" href="#" id="dec" onclick="dec(${oi.id})">-</a>
                                       </div>
                                    </td>


                                    <c:if test="${cst.status==0}">
                                        <td class="pro-subtotal" id="jg${oi.id}"><span id="zongji1" style="display: inline">$<span id="zj1" style="display: inline">${oi.number*oi.product.price}</span></span></td>
                                    </c:if>
                                    <c:if test="${cst.status==1} ">
                                        <td class="pro-subtotal" id="jg${oi.id}"><span id="zongji2">$<span id="zj2">${oi.number*oi.product.price*0.8}</span></span></td>
                                    </c:if>
                                    <td class="pro-remove"  id="delOrderItem${oi.id}"><a href="javascript:;" onclick="delOrderItem(${oi.id});"><i class="fa fa-trash-o"></i></a></td>
                                </tr>
                            </c:forEach>
                                </tbody>
                            </table>
                        </div>


                    </form>

                    <div class="row">

                        <div class="col-lg-6 col-12">

                            <div class="discount-coupon">
                                <h4>优惠卷代码</h4>
                                <form action="#">
                                    <div class="row">
                                        <div class="col-md-6 col-12 mb-25">
                                            <input type="text" placeholder="Coupon Code">
                                        </div>
                                        <div class="col-md-6 col-12 mb-25">
                                            <input type="submit" value="应用代码">
                                        </div>
                                    </div>
                                </form>
                            </div>

                        </div>


                        <div class="col-lg-6 col-12 d-flex">

                            <div class="cart-summary">
                                <div class="cart-summary-wrap">
                                    <h4>购物车信息</h4>
                                    <p>数量总计 <span id="OisNum"></span></p>
                                    <h2>总计(不含运费) <span id="OisTotal"></span></h2>
                                </div>
                                <div class="cart-summary-button">
                                    <button class="update-btn" onclick="subMyOrder();">下单</button>
                                </div>
                            </div>


                        </div>

                    </div>

                </div>
        </div>
    </div>
</div>

<script src="${pageContext.request.contextPath}/js/jquery/2.0.0/jquery.min.js"></script>
<script type="text/javascript">


    var oiids = [];
    var totalPrice = 0;
    var totalNum = 0;

    function dianji(obj,oiid) {
       //获得input的选中状态
        var checked = $("#check"+oiid).prop("checked");

        if(checked == true){
            //获取当前订单项的购买商品数量
            var num = $("#num"+oiid).val()*1;
            //获得当前订单项的总价格
            var total = $("#jg"+oiid+" span span").html()*1;
            totalNum += num;
            totalPrice += total;
            //更新订单价格
            $("#OisTotal").text("$"+totalPrice);
            //更新下单的购买数量
            $("#OisNum").text(totalNum);
            oiids.push(oiid);
        }else {
            //获取当前订单项的购买商品数量
            var num1 = $("#num"+oiid).val()*1;
            //获得当前订单项的总价格
            var total1 = $("#jg"+oiid+" span span").html()*1;
            totalNum -= num1;
            totalPrice -= total1;
            //更新订单价格
            $("#OisTotal").text("$"+totalPrice);
            //更新下单的购买数量
            $("#OisNum").text(totalNum);
            removeById(oiids,oiid);
        }
    }
    //删除oiids中的oiid
    function removeById(arr, val) {
        for(var i=0; i<arr.length; i++) {
            if(arr[i] == val) {
                arr.splice(i, 1);
                break;
            }
        }
    }

    //增加数量
    function inc(id) {
        var num = $("#num"+id).val() * 1 + 1;
        location.href = "${pageContext.request.contextPath}/fore/changeCartNum?number="+num+"&oiid="+id;
    }

    //减少数量
    function dec(id) {
        var num = $("#num"+id).val() * 1 - 1;
        location.href = "${pageContext.request.contextPath}/fore/changeCartNum?number="+num+"&oiid="+id;
    }

    //提交购物车订单
    function subMyOrder() {
        if(oiids.length===0){
            alert("请勾选要买的商品");
            return false;
        }
        location.href="${pageContext.request.contextPath}/fore/forebuy?oiid="+oiids;
    }

    //删除商品
    function delOrderItem(oiid) {
        $.get(
            "foreDelOrderItem",
            {"oiid":oiid},
            function (result) {
                if(result="success"){
                    $("#delOrderItem"+oiid).parent().remove();
                }else{
                    alert("登陆过期，请登录");
                }
            }
        );
    }
</script>

<%@ include file="../../foreinclude/foreFooter.jsp"%>
