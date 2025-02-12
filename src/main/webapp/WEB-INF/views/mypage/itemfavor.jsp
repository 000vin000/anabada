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
	<jsp:include page="../header.jsp"/>
	
<div class="body-container">
    <!-- 브레드 크럼 -->
    <ul class="breadcrumb" id="breadcrumb">
		<li><a href="/">홈</a></li>
    	<li><a href="/mypage">마이페이지</a></li>
    	<li><a href="/mypage/itemfavor">관심물품</a></li>
    </ul>

	<table class="tableFavor">
	    <thead>
	        <tr>
	            <th>이미지</th>
	            <th>물품명</th>
	            <th>현재가</th>
	            <th>입찰</th>
	            <th>판매자</th>
	            <th>마감일</th>
	            <th>관리</th>
	        </tr>
	    </thead>
	    <tbody>
	        <c:forEach var="item" items="${list}">
	            <tr>
	                <td><a href="#" class="no-style"><img src="data:image/png;base64,${item.image}" alt="상품 이미지"></a></td>
	                <td><a href="#" class="no-style">${item.itemName}</a></td>
	                <td>${item.itemPrice} 원 </td>
	                <td>[입찰수]</td>
	                <td>${item.userNick}</td>
	                <td>${item.itemEnd}</td>
	                <td>
	                    <button id="removeFavor" class="btn btn-delete" onclick="removeFavor(${item.itemNo})">x</button>
	                </td>
	            </tr>
	        </c:forEach>
	    </tbody>
	</table>
</div>
	
	<jsp:include page="../sidebar.jsp" />
	<jsp:include page="../footer.jsp" />
</body>
<script type="text/javascript">
	function removeFavor(itemNo) {
		if(!confirm("삭제하시겠습니까?")) {
			return;
		}
		
		fetch("/api/favor/" + itemNo, {method : "delete"})
			.then(response => response.text())
			.then(data => {
				alert(data); // 삭제 결과
				location.reload(); // 페이지 리로드
			}).catch(error => console.error("삭제 실패 : ", error));
	}
</script>
</html>