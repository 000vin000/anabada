<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>내가 한 문의 리스트</title>

</head>
<body>
<h1>내가 한 문의 리스트</h1>
    <div class="container">
        <c:if test="${ not empty list }">
            <table>
                <thead>
                    <tr>
                    	<th>상품이름</th>
                        <th>문의제목</th>
                        <th>문의내용</th>
                        <th>문의등록일</th>
                        <th>답변내용</th>
                        <th>답변등록일</th>  
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="item" items="${ list }">
                        <tr>
					        <td>${ item.getItemName() }</td> 
					        <td>${ item.getQTitle() }</td>   
					        <td>${ item.getQContent() }</td>  
					        <td>${ item.getQDate() }</td>     
					        <td>${ item.getAContent() }</td>   
					        <td>${ item.getADate() }</td>    
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </c:if>
        <c:if test="${ empty list }">
            <div class="no-data">문의내역이 없습니다.</div>
        </c:if>
    </div>
</body>
</html>
