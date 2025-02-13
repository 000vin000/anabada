<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>판매현황</title>
</head>
<body>
<h1>판매현황</h1>

<table border="1">
    <thead>
        <tr>
            <th>번호</th>
            <th>물품번호</th>
            <th>성별</th>
            <th>카테고리</th>
            <th>경매 상태</th>
            <th>경매 시작일</th>
            <th>경매 종료일</th>
            <th>가격</th>
            <th>상세보기</th>
            <th>수정하기</th>
            <th>삭제하기</th> <!-- 삭제 버튼을 위한 열 추가 -->
        </tr>
    </thead>
    <tbody>
        <c:forEach var="item" items="${items}">
            <tr>
                <td>${item.itemNo}</td>
                <td>${item.userNo}</td>
                <td>${item.itemGender}</td>
                <td>${item.itemCate}</td>
                <td>${item.getItemAuctionStr(item.itemAuction)}</td>
                <td>${item.itemStart}</td>
                <td>${item.itemEnd}</td>
                <td>${item.itemPrice}</td>
                <td><a href="<c:url value='/mypage/itemdetail/${item.itemNo}' />">상세보기</a></td>
                <td><a href="<c:url value='/mypage/itemupdate/${item.itemNo}' />">수정하기</a></td>
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
</body>
</html>
