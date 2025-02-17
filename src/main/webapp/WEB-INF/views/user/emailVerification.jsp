<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="/WEB-INF/views/header.jsp" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>이메일 인증</title>
	<link rel="stylesheet" type="text/css" href="/css/style.css"> <%-- 사이드바 css --%>
</head>
<body>
    <h2>이메일 인증</h2>
    <form id="emailForm">
        <input type="email" id="email" name="email" required>
        <button type="button" onclick="sendVerificationEmail()">인증 코드 받기</button>
    </form>
    <div id="verificationSection" style="display:none;">
        <input type="text" id="verificationCode" placeholder="인증 코드 입력">
        <button onclick="verifyEmail()">인증하기</button>
    </div>

    <script src="/js/emailVerification.js"></script>
</body>
</html>
<%@ include file="../footer.jsp" %>