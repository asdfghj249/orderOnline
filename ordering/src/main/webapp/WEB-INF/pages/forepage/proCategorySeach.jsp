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
                            <li>${category.name}</li>
                        </ul>
                    </nav>
                </div>

            </div>
        </div>
    </div>
</div>


<div class="shop-page-content mb-50">
    <div class="container">
        <div class="row">
            <div class="col-lg-12 order-1 order-lg-2">

                <div class="shop-header mb-30">
                    <div class="row">
                        <div class="col-lg-4 col-md-4 col-sm-12 d-flex align-items-center">

                            <div class="view-mode-icons mb-xs-10">
                                <a class="active"  href="#" data-target="list"><i class="icon ion-ios-list"></i></a>
                            </div>

                        </div>
                        <div class="col-lg-8 col-md-8 col-sm-12 d-flex flex-column flex-sm-row justify-content-between align-items-left align-items-sm-center">

                            <div class="sort-by-dropdown d-flex align-items-center mb-xs-10"></div>
                            <p class="result-show-message">搜索结果${total}条</p>
                        </div>
                    </div>
                </div>

                <div class="shop-product-wrap list row mb-30 no-gutters">
                    <c:forEach items="${products}" var="p">
                        <div class="col-lg-3 col-md-6 col-sm-6 col-12">

                            <div class="fl-product shop-grid-view-product">
                                <div class="image">
                                    <a href="fore/foreDetailUI?id=${p.id}">
                                        <img src="${pageContext.request.contextPath}/${p.imageurl}" class="img-fluid" alt="">
                                        <img src="${pageContext.request.contextPath}/${p.imageurl}" class="img-fluid" alt="">
                                    </a>

                                    <span class="wishlist-icon">
                                            <a href="#" ><i class="icon ion-md-heart-empty"></i></a>
                                    </span>
                                </div>
                                <div class="content">
                                    <h2 class="product-title"> <a href="${pageContext.request.contextPath}/fore/foreDetailUI?id=${p.id}">${p.name}</a></h2>
                                    <div class="rating">
                                        <i class="fa fa-star active"></i>
                                        <i class="fa fa-star active"></i>
                                        <i class="fa fa-star active"></i>
                                        <i class="fa fa-star"></i>
                                        <i class="fa fa-star"></i>
                                    </div>
                                    <p class="product-price">
                                        <span class="main-price discounted">$${p.price+15}</span>
                                        <span class="discounted-price">$${p.price}</span>
                                    </p>

                                </div>
                            </div>

                            <div class="fl-product shop-list-view-product">
                                <div class="image">
                                    <a href="${pageContext.request.contextPath}/fore/foreDetailUI?id=${p.id}">
                                        <img src="${pageContext.request.contextPath}/${p.imageurl}" class="img-fluid" alt="" width="50px" height="50px">
                                        <img src="${pageContext.request.contextPath}/${p.imageurl}" class="img-fluid" alt="" width="50px" height="50px">
                                    </a>
                                </div>
                                <div class="content" style="padding-top: 55px">
                                    <h2 class="product-title"> <a href="${pageContext.request.contextPath}/fore/foreDetailUI?id=${p.id}">${p.name}</a></h2>
                                    <div class="rating">
                                        <i class="fa fa-star active"></i>
                                        <i class="fa fa-star active"></i>
                                        <i class="fa fa-star active"></i>
                                        <i class="fa fa-star"></i>
                                        <i class="fa fa-star"></i>
                                    </div>
                                    <br/>
                                    <p>${p.miaoshu}</p>
                                    <p class="product-price">
                                        <span class="main-price discounted">$${p.price+15}</span>
                                        <span class="discounted-price">$${p.price}</span>
                                    </p>
                                </div>
                            </div>

                        </div>
                    </c:forEach>

                </div>

                <div class="pagination-area ">
                    <ul>
                        <div class="pagination-area pageNum">
                            <ul>
                                <li class="threeword">
                                    <a href="?id=${category.id}&start=0">首页</a>
                                </li>
                                <li class="threeword">
                                    <c:if test="${page.hasPrevious}">
                                        <a href="?id=${category.id}&start=${page.start-page.count}">上一页</a>
                                    </c:if>
                                    <c:if test="${!page.hasPrevious}">
                                        <a href="?id=${category.id}&start=0">上一页</a>
                                    </c:if>

                                </li>

                                <c:forEach begin="${begin}" end="${end}" varStatus="vs" var="i">

                                    <li  <c:if test="${(vs.index-1)*page.count==page.start}">class="curPage"</c:if>>
                                        <a href="?id=${category.id}&start=${(vs.index -1)*page.count}"
                                        >${i}</a>
                                    </li>
                                </c:forEach>


                                <li class="threeword">
                                    <c:if test="${page.hasNext}">
                                        <a href="?id=${category.id}&start=${page.start+page.count}">下一页</a>
                                    </c:if>
                                    <c:if test="${!page.hasNext}">
                                        <a href="?id=${category.id}&start=${page.last}">下一页</a>
                                    </c:if>
                                </li>

                                <li class="threeword">
                                    <a href="?id=${category.id}&start=${page.last}">末页</a>
                                </li>
                            </ul>
                        </div>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</div>

<%@ include file="../../foreinclude/foreFooter.jsp"%>
