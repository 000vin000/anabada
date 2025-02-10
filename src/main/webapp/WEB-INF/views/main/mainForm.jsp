<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="../header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
</head>
<body>
	<ul>
        <c:forEach var="item" items="${itemList}">
            <li>${item.itemName} - ${item.itemPrice}</li> 
        </c:forEach>
    </ul>
    <jsp:include page="../footer.jsp" /> <!-- footer.jsp 포함 -->
</body>
</html>