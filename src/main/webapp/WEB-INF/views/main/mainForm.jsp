<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="../header.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>아이템 목록</title>
</head>
<body>
    <label for="sortOrder">정렬 : </label>
    <select id="sortOrder" name="sortOrder" onchange="sortItems()">
        <option value="" selected disabled>선택</option>
        <option value="new">경매시작순</option>    
        <option value="deadline">마감임박순</option>
        <option value="popular">인기순</option>
        <option value="asc">가격 오름차순</option>
        <option value="desc">가격 내림차순</option>
    </select>
    
	<div>${error}</div>
    <ul>
        <c:forEach var="item" items="${itemList}">
            <li>
            	<img src="data:image/png;base64,${item.image}" alt="${item.itemName} 이미지" style="width: 100px; height: auto;"/>
                <a href="#">${item.itemName} - ${item.itemPrice} - ${item.itemStart} - ${item.itemEnd}</a>
            </li>
        </c:forEach>
    </ul>
    
    <jsp:include page="../footer.jsp" /> <!-- footer.jsp 포함 -->
    
    <script>
    	// 페이지 로드될 때 상태값 복원
    	window.onload = function() {
    		const savedSortOrder = sessionStorage.getItem("sortOrder");
    		if (savedSortOrder != null) {
    			document.getElementById("sortOrder").value = savedSortOrder;
    			sessionStorage.removeItem("sortOrder");
    		}
    	};
    
        function sortItems() {
            let sortOrder = document.getElementById("sortOrder");
            let selectedValue = sortOrder.value;
          	
            sessionStorage.setItem("sortOrder", selectedValue);
            
			window.location.href = `?sortOrder=` + selectedValue;
        }     
    </script>
</body>
</html>
