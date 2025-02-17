<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="/WEB-INF/views/header.jsp" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>비밀번호 확인</title>
	<link rel="stylesheet" type="text/css" href="/css/style.css"> <%-- 사이드바 css --%>
</head>
<body>

<div class="body-container">
    <h1>비밀번호 확인</h1>
	<link rel="stylesheet" type="text/css" href="/css/style.css"> <%-- 사이드바 css --%>
    <p>회원정보를 수정하거나 탈퇴하려면 비밀번호를 입력하세요.</p>

    <form action="/mypage/passwordcheck" method="post">
        <label for="userPw">비밀번호:</label>
        <input type="password" id="userPw" name="userPw" required><br>
        <input type="hidden" name="redirectTo" value="${param.redirectTo}">
        <button type="submit">확인</button>
    </form>

    <c:if test="${not empty error}">
        <p style="color: red;">${error}</p>
    </c:if>

    <a href="/mypage">마이페이지로 돌아가기</a>
</div>
</body>
</html>
<%@ include file="../footer.jsp" %>
