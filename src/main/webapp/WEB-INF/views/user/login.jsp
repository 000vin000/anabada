<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="../header.jsp" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>로그인</title>
</head>
<body>
<h2>로그인</h2>
<form action="<c:url value='/user/login'/>" method="post">
    <c:if test="${not empty error}">
        <div style="color: red;">${error}</div>
    </c:if>
    <div>
        <label for="userId">아이디:</label>
        <input type="text" id="userId" name="userId" required />
    </div>
    <div>
        <label for="userPw">비밀번호:</label>
        <input type="password" id="userPw" name="userPw" required />
    </div>
    <button type="submit">로그인</button>
</form>
<a href="<c:url value='/user/join'/>">회원가입</a>
</body>
</html>
