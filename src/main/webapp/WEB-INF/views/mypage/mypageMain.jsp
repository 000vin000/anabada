<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>    
<%@ include file="../header.jsp" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>ANABADA</title>
	<link rel="stylesheet" type="text/css" href="/css/style.css">
</head>
<body>
<div class="body-container">
	<!-- 브레드 크럼 -->
    <ul class="breadcrumb" id="breadcrumb">
		<li><a href="/">홈</a></li>
    	<li><a href="/mypage">마이페이지</a></li>
    </ul>

	<!-- 네비게이션 -->
	<div>
		<a href="/mypage/updateinfo">정보 수정</a>
		<a href="#">구매 현황</a>
		<a href="/mypage/itemsell">판매 현황</a>
		<a href="/mypage/itemfavor">관심 물품</a>
		<a href="/mypage/q">나의 문의 목록</a>
		<a href="/mypage/a">내 상품의 문의 목록</a>
	</div>

</div>

	<!-- 사이드바 -->	
	<jsp:include page="../sidebar.jsp"/>
	<!-- 푸터 -->
	<jsp:include page="../footer.jsp"/>
</body>
<script src="/js/todaypick.js"></script>
<%--
<script type="text/javascript">
	document.addEventListener("DOMContentLoaded", function () {
	    const path = window.location.pathname.split("/").filter(Boolean);
	    const breadcrumbContainer = document.getElementById("breadcrumb");
	
	    let fullPath = "/";
	    breadcrumbContainer.innerHTML = `<li><a href="/">홈</a></li>`;
	
	    path.forEach((segment, index) => {
	        fullPath += segment + "/";
	        if (index === path.length - 1) {
	            breadcrumbContainer.innerHTML += `<li>${decodeURIComponent(segment)}</li>`;
	        } else {
	            breadcrumbContainer.innerHTML += `<li><a href="${fullPath}">${decodeURIComponent(segment)}</a></li>`;
	        }
	    });
	});
</script>
 --%>
</html>