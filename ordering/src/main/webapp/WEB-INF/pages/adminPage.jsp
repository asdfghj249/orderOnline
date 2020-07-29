<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false"%>
<style>
    #menu{float: right}
    #menu li {
        display: inline;
        width: 50px;
        height: 40px;
        border: 1px solid rgba(28, 9, 9, 0.34);
        margin-left: 8px;
    }

</style>
<div class="hui-list" style="margin-top:22px;">
    <ul id="menu">
        <div class="pagination-area pageNum">
            <ul>
                <li>
                    <a href="?start=0">首页</a>
                </li>
                <li class="threeword">
                    <c:if test="${page.hasPrevious}">
                        <a href="?start=${page.start-page.count}">上一页</a>
                    </c:if>
                    <c:if test="${!page.hasPrevious}">
                        <a href="?start=0">上一页</a>
                    </c:if>

                </li>

                <c:forEach begin="${begin}" end="${end}" varStatus="vs" var="i">

                    <li  <c:if test="${(vs.index-1)*page.count==page.start}">class="curPage"</c:if>>
                        <a href="?start=${(vs.index -1)*page.count}"
                        >${i}</a>
                    </li>
                </c:forEach>


                <li class="threeword">
                    <c:if test="${page.hasNext}">
                        <a href="?start=${page.start+page.count}">下一页</a>
                    </c:if>
                    <c:if test="${!page.hasNext}">
                        <a href="?start=${page.last}">下一页</a>
                    </c:if>
                </li>

                <li class="threeword">
                    <a href="?start=${page.last}">末页</a>
                </li>
            </ul>
        </div>
    </ul>
</div>
