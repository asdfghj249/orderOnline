<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>

<%@include file="../../include/publicMeta.jsp"%>
<body>
<section class="Hui-article-box">
    <div class="">
        <article class="cl pd-20">
            <div class="cl pd-5 bg-1 bk-gray">
                <span class="r">共有数据：<strong>${total}</strong> 条</span>
            </div>
            <table class="table table-border table-bordered table-bg" id="mytable">
                <thead>
                <tr class="text-c">
                    <th width="">ID</th>
                    <th width="">商品名</th>
                    <th width="">价格</th>
                    <th width="">数量</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${orderItems}" var="orderItem" varStatus="list">
                    <tr class="text-c">
                        <td>${list.count}</td>
                        <td>${orderItem.product.name}</td>
                        <c:if test="${customer.status == 1}">
                            <td>${orderItem.product.price * 0.8}</td>
                        </c:if>
                        <c:if test="${customer.status != 1}">
                            <td>${orderItem.product.price }</td>
                        </c:if>

                        <td>${orderItem.number}</td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
            <div class="cl pd-5 bg-1 bk-gray">
                <span class="r">总价(含运费10元)：<strong>${totalPrice}</strong>元</span>
            </div>
        </article>
    </div>
</section>




</body>

