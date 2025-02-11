<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="/WEB-INF/views/header.jsp" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>회원가입</title>
</head>
<body>
<h2>회원가입</h2>
<form action="<c:url value='/user/join' />" method="post">
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
    <div>
        <label for="userName">이름:</label>
        <input type="text" id="userName" name="userName" />
    </div>
    <div>
        <label for="userNick">닉네임:</label>
        <input type="text" id="userNick" name="userNick" />
    </div>
    <div>
        <label for="userAdd">주소:</label>
        <input type="text" id="userAdd" name="userAdd" />
    </div>
    <div>
        <label for="userEmail">이메일:</label>
        <input type="email" id="userEmail" name="userEmail" />
    </div>
    <div>
        <label for="userPhone">전화번호:</label>
        <input type="text" id="userPhone" name="userPhone" />
    </div>
    <button type="submit">회원가입</button>
</form>

<%@ include file="../footer.jsp" %>
</body>
</html>
