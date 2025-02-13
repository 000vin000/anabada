<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<body>
	<div id="categorySearch">
		<%-- 카테고리 선택 --%>
		<select id="gender" name="gender">
			<option value="" selected disabled>선택</option>
			<option value="m">남자</option>
			<option value="w">여자</option>
		</select>
		<select id="clothesType">
			<option value="" selected disabled>옵션</option>
			<option value="top">상의</option>
			<option value="bottom">하의</option>
			<option value="outer">아우터</option>
			<option value="dress">원피스</option>
			<option value="etc">기타</option>
			<option value="set">세트상품</option>
		</select>
		<input type="button" id="cate" value="검색" onclick="updateItem()">
	</div>
	<div>
		<label for="sortOrder">정렬 : </label>
		<select id="sortOrder" name="sortOrder" onchange="sortItems()">
		<option value="" selected disabled>선택</option>
			<option value="new">경매시작순</option>    
			<option value="deadline">마감임박순</option>
			<option value="popular">인기순</option>
			<option value="asc">가격 오름차순</option>
			<option value="desc">가격 내림차순</option>
		</select>
	</div>
	<div>${error}</div>
	<div>
		<ul>
			<c:forEach var="item" items="${itemList}">
				<li>
					<img src="data:image/png;base64,${item.image}" alt="${item.itemName} 이미지" style="width: 100px; height: auto;"/>
					<a href="/item/detail/${item.itemNo}">${item.itemName} ${item.itemPrice}원 ${item.userNick} ${item.getCountDown(item.itemEnd)}</a>
				</li>
			</c:forEach>
		</ul>
	</div>
</body>