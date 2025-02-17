<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="../header.jsp" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>내가 한 문의 리스트</title>
    <link rel="stylesheet" type="text/css" href="/css/style.css"> <%-- 사이드바 css --%>

</head>
<body >

    <div class="body-container">
    <h1>내가 한 문의 리스트</h1>
        <c:if test="${ not empty list }">
            <table>
                <thead>
                    <tr>
                    	<th>상품이름</th>
                        <th>문의제목</th>
                        <th>문의내용</th>
                        <th>문의등록일</th>
                        <th>답변내용</th>
                        <th>답변등록일</th>  
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="item" items="${ list }">
                        <tr>                     
					        <td><a href="/item/detail/${item.itemNo}">${item.itemName}</a></td>
					        <td>${ item.getQTitle() }</td>   
					        <td>${ item.getQContent() }</td>  
					        <td>${ item.getFormattedQDate(item.getQDate()) }</td>     
					        <td>${ item.getAContent() }</td>   
					        <td>${ item.getFormattedADate(item.getADate()) }</td>    
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </c:if>
        <c:if test="${ empty list }">
            <div class="no-data">문의내역이 없습니다.</div>
        </c:if>
    </div>
    <jsp:include page="../sidebar.jsp" />
	<jsp:include page="../footer.jsp"/>
</body>
<script src="/js/todaypick.js"></script>
</html>
