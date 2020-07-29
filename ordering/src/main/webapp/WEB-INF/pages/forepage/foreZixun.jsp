<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ include file="../../foreinclude/foreHeader.jsp"%>


<div class="breadcrumb-area pt-15 pb-15">
    <div class="container">
        <div class="row">
            <div class="col-lg-12">

                <div class="breadcrumb-container">
                    <nav>
                        <ul>
                            <li class="parent-page"><a href="${pageContext.request.contextPath}/fore/foreIndex">Home</a></li>
                            <li>information</li>
                        </ul>
                    </nav>
                </div>

            </div>
        </div>
    </div>
</div>


<div class="blog-page-content mb-50">
    <div class="container">
        <div class="row">


            <div class="col-lg-12 order-1">

                <div class="blog-single-post-container mb-30">

                    <h3 class="post-title">网站资讯</h3>

                    <div class="post-content mb-40">

                        <blockquote>
                            <p>
                                用户可发布自己的问题，管理员审核通过后进行显示
                                <button style="float:right" class="btn btn-default"><a href="javascript:;" onclick="fabuzixun();">发布</a></button>
                            </p>

                        </blockquote>

                    </div>

                </div>



                <div class="comment-section mb-md-30 mb-sm-30">

                    <div class="comment-container mb-40">
                        <c:forEach items="${list}" var="z">
                        <div class="single-comment">
                            <div class="image">
                                <img src="${pageContext.request.contextPath}/images/featured-category/05.png" alt="">
                            </div>
                            <div class="content">
                                <h3 class="user">${z.customer.name} <span class="comment-time"><fmt:formatDate value="${z.fabudate}" pattern="yyyy年MM月dd日" /></span></h3>
                                <p class="comment-text">${z.content}.</p>
                            </div>

                        </div>
                        </c:forEach>

                    </div>

                </div>

            </div>
        </div>
    </div>
</div>

<!-- 模态框（Modal） -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog"  id="myModal" aria-labelledby="myModalLabel" aria-hidden="true" data-backdrop="true">
    <div class="modal-dialog">
        <div class="modal-content">

            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    ×
                </button>
                <h4 class="modal-title" id="myModalLabel">
                    发布资讯！
                </h4>
            </div>

            <div class="modal-body">

                <div class="form-group">
                    <label for="contents" class="col-sm-4 control-label">输入信息</label>
                    <div class="col-sm-12">
                        <textarea class="form-control" name="content" id="contents" placeholder="" required="required"></textarea>
                    </div>
                </div>
                <input type="hidden" name="cstid" value="${cst.id}"/>

                <div class="form-group">
                    <div class="col-sm-offset-2 col-sm-10">
                        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                        <button type="button" class="btn btn-default"  id="modalFabu">发布</button>
                    </div>
                </div>

            </div>
        </div>
    </div>
</div>

<script src="${pageContext.request.contextPath}/js/jquery/2.0.0/jquery.min.js"></script>
<script>
    function fabuzixun(){
        $('#myModal').modal('show');
    }
    $(function () {

        $("#modalFabu").click(function () {
            $.get(
                "foreIsLogin",
                function(result) {
                    if (result!="true"){
                        alert("请先登陆!")
                    }
                }
            );
            var content = $("#contents").val();
            $.get(
                "foreZixunadd",
                {"content":content},
                function (result) {
                    if(result=="success"){
                        alert("已提交，请等待管理员审核！");
                        $('#myModal').modal('hide');
                    }
                }
            );
        });
    })
</script>

<%@ include file="../../foreinclude/foreFooter.jsp"%>