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

	<h1>마이페이지</h1>
	<!-- 네비게이션 -->
	<div class="mypage-nav">
		<a href="/mypage/updateinfo">
			<img src="/images/board.png" alt="정보 수정">
			<span>정보 수정</span>
		</a>
		<a href="#">
			<img src="/images/shoppingcart.png" alt="구매 현황">
			<span>구매 현황</span>
		</a>
		<a href="/mypage/itemsell">
			<img src="/images/moneybag.png" alt="판매 현황">
			<span>판매 현황</span>
		</a>
	    <a href="/mypage/itemfavor">
	    	<img src="/images/star.png" alt="관심 물품">
	    	<span>관심 물품</span>
    	</a>
	    <a href="/mypage/q">
	    	<img src="/images/qchar.png" alt="나의 문의 목록">
	    	<span>나의 문의</span>
	    </a>
	    <a href="/mypage/a">
	    	<img src="/images/achar.png" alt="내 상품의 문의 목록">
	    	<span>내 상품 문의</span>
    	</a>
	</div>
<!-- 
	<div>
		구매현황 리스트
	</div>
	<div>
		판매현황 리스트
	</div>
 -->
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