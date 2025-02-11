<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>ANABADA</title>
	<link rel="stylesheet" type="text/css" href="/css/styleTemp.css">
</head>
<body>
    <!-- 브레드 크럼 -->
    <ul class="breadcrumb" id="breadcrumb">
		<li><a href="/">홈</a></li>
    	<li><a href="/mypage">마이페이지</a></li>
    	<li><a href="/mypage/itemfavor">관심물품</a></li>
    </ul>

	<table>
	    <thead>
	        <tr>
	            <th>번호</th>
	            <th>물품번호</th>
	            <th>이미지</th>
	            <th>물품명</th>
	            <th>현재가</th>
	            <th>입찰</th>
	            <th>조회</th>
	            <th>판매자</th>
	            <th>마감일</th>
	            <th>관리</th>
	        </tr>
	    </thead>
	    <tbody>
	        <c:forEach var="item" items="${list}">
	            <tr>
	                <td>${item.userNo}</td>
	                <td>${item.itemNo}</td>
	                <td><img src="${item.itemNo}" alt="상품 이미지"></td>
	                <td>${item.itemNo}</td>
	                <td>${item.itemNo}원</td>
	                <td>[${item.itemNo}]</td>
	                <td>${item.itemNo}</td>
	                <td>${item.itemNo}</td>
	                <td>${item.itemNo}</td>
	                <td>
	                    <button class="btn btn-bid">입찰</button>
	                    <button id="removeFavor" class="btn btn-delete">삭제</button>
	                </td>
	            </tr>
	        </c:forEach>
	    </tbody>
	</table>
<jsp:include page="../sidebar.jsp" />
<jsp:include page="../footer.jsp" />
</body>
<script type="text/javascript">
	let removeFavor = document.getElementId("removeFavor");
<%-- 도메인 수정필요 --%>
	fetch("http://localhost:8080/api/favor")
</script>
</html>