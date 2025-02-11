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
<h1>Item List</h1>

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
            </tr>
        </thead>
        <tbody>
            <c:forEach var="item" items="${items}">
                <tr>
                    <td>${item.itemNo}</td>
                    <td>${item.userNo}</td>
                    <td>${item.itemGender}</td>
                    <td>${item.itemCate}</td>
                    <td>${item.itemAuction}</td>
                    <td>${item.itemStart}</td>
                    <td>${item.itemEnd}</td>
                    <td>${item.itemPrice}</td>
                     <td><a href="<c:url value='/mypage/itemdetail/${item.itemNo}' />">상세보기</a></td>
                </tr>
            </c:forEach>
        </tbody>
    </table>

</body>
</html>