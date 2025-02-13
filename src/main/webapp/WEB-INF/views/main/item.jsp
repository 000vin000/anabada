<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<style>
    #itemOption {
        display: flex;
        flex-wrap: wrap;
        justify-content: center; /* 카드 중앙 정렬 */
        margin: 0 auto; /* 가운데 정렬을 위한 마진 */
        max-width: 1200px; /* 최대 너비 설정 (필요에 따라 조정) */
    }
    #itemOption ul {
        list-style: none;
        padding: 0;
        margin: 0;
        display: flex;
        flex-wrap: wrap;
        justify-content: center; /* 카드 중앙 정렬 */
    }
    #itemOption li {
        background-color: #fff; /* 카드 배경색 */
        border-radius: 8px; /* 카드 모서리 둥글게 */
        box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1); /* 그림자 효과 */
        padding: 16px; /* 카드 내부 여백 */
        width: 170px; /* 한 줄에 6개 (100%/6 - 간격) */
        height: 270px;
        margin: 10px; /* 카드 간의 간격 */
        text-align: center; /* 텍스트 중앙 정렬 */
        box-sizing: border-box; /* 패딩과 테두리가 너비에 포함되도록 설정 */
    }
    #itemOption img {
        max-width: 100%; /* 이미지가 카드 너비에 맞게 조정 */
        height: auto; /* 비율 유지 */
        border-radius: 4px; /* 이미지 모서리 둥글게 */
    }
    #itemOption p {
    margin: 1px 0; /* 위아래 간격을 8px로 설정 */
	}
</style>

<body>
	<div id="categorySearchOption">
		<%-- 카테고리 선택 --%>
		<select id="gender" name="gender">
			<option value="" selected disabled>선택</option>
			<option value="m">남자</option>
			<option value="w">여자</option>
		</select>
		<select id="clothesType">
			<option value="top">상의</option>
			<option value="bottom">하의</option>
			<option value="outer">아우터</option>
			<option value="dress">원피스</option>
			<option value="etc">기타</option>
			<option value="set">세트상품</option>
		</select>
		<input type="button" id="cate" value="검색" onclick="updateItem()">
	</div>
	<div id="sortOption">
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
	<div id="itemOption">
		<ul>
			<c:if test="${not empty itemList}">
				<c:forEach var="item" items="${itemList}">
					<li>
						<a href="/item/detail/${item.itemNo}">
							<img src="data:image/png;base64,${item.image}" alt="${item.itemName} 이미지"/>
							<p id="itemName">${item.itemName}</p> 
							<p id="itemPrice">${item.itemPrice}원 </p>
							<p id="itemUserNick">${item.userNick} </p>
							<p id="itemAuction">${item.getItemAuctionStr(item.itemAuction)}</p>
						</a>
					</li>
				</c:forEach>
			</c:if>
			<c:if test="${empty itemList }">
				<div>${error}</div>
			</c:if>
		</ul>
	</div>
</body>