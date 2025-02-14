<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>판매현황</title>
<link rel="stylesheet" type="text/css" href="/css/styleTemp.css">
</head>
<body>
<jsp:include page="../header.jsp"/>
<h1>판매현황</h1>

<div class="body-container">
    <!-- 브레드 크럼 -->
    <ul class="breadcrumb" id="breadcrumb">
		<li><a href="/">홈</a></li>
    	<li><a href="/mypage">마이페이지</a></li>
    	<li><a href="/mypage/itemsell">판매현황</a></li>
    </ul>
    
<table border="1">
    <thead>
        <tr>
            <th>물품번호</th>
            <th>제목</th>
            <th>카테고리</th>
            <th>경매 상태</th>
            <th>경매 시작일</th>
            <th>경매 종료일</th>
            <th>가격</th>
            <th>상세보기</th>
            <th>수정하기</th>
            <th>삭제하기</th>
        </tr>
    </thead>
    <tbody>
        <c:forEach var="item" items="${items}">
            <tr>
                <td>${item.itemNo}</td>
                <td>${item.itemName}</td>
                <td>${item.itemCate}</td>
                <td>${item.getItemStatusInKorean()}</td>
                <td>${item.itemStart}</td>
                <td>${item.itemEnd}</td>
                <td>${item.itemPrice}</td>
                <td><a href="<c:url value='/item/detail/${item.itemNo}' />">상세보기</a></td>
                <c:if test="${item.itemAuction != 'sold' && item.itemAuction != 'closed'}">
                    <td><a href="<c:url value='/mypage/itemupdate/${item.itemNo}' />">수정하기</a></td>
                </c:if>
                <c:if test="${item.itemAuction == 'sold' || item.itemAuction == 'closed'}">
                    <td></td>
                </c:if>
                   <td>
                    <form action="<c:url value='/mypage/itemdelete/${item.itemNo}' />" method="post" onsubmit="return confirm('정말로 삭제하시겠습니까?');">
                        <button type="submit">삭제하기</button>
                    </form>
                </td>
            </tr>
        </c:forEach>
    </tbody>
</table>
	<a href="/mypage">마이페이지로 돌아가기</a>
</div>
	<jsp:include page="../sidebar.jsp" />
	<jsp:include page="../footer.jsp" />
	<script src="/js/todaypick.js"></script>
</body>
</html>
