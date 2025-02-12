<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<title>입찰기록</title>
</head>
<body>
<h1>입찰기록</h1>
    <div class="container">
        <c:if test="${ not empty list }">
            <table>
               <thead>
                <tr>                 
                    <th>입찰시간</th>
                    <th>입찰가</th>
                    <th>입찰자</th>             
                </tr>
            </thead>
            <tbody>
                <c:forEach var="item" items="${ list }">
                    <tr>                        
                        <td>${ item.getBidTime() }</td>
                        <td>${ item.getBidPrice() }</td>
                        <td>${ item.getUserNick() }</td>
                        
                    </tr>
                </c:forEach>
            </tbody>
            </table>
        </c:if> 
        <c:if test="${ empty list }">
            <div class="no-data">입찰내역이 없습니다.</div>
        </c:if>
    </div>
</body>
</html>