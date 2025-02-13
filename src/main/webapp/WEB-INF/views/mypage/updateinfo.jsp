<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>회원정보 관리</title>
</head>
<body>
<!-- 헤더 -->
<jsp:include page="../header.jsp"/>

<div class="body-container">
    <!-- 브레드 크럼 -->
    <ul class="breadcrumb" id="breadcrumb">
        <li><a href="/">홈</a></li>
        <li><a href="/mypage">마이페이지</a></li>
        <li><a href="/mypage/updateinfo">회원정보 관리</a></li>
    </ul>

    <h1>회원정보 관리</h1>
    
    <a href="/mypage/deactivate">회원 탈퇴</a>

    <!-- 성공 및 에러 메시지 -->
    <c:if test="${not empty success}">
        <p style="color: green;">${success}</p>
    </c:if>
    <c:if test="${not empty error}">
        <p style="color: red;">${error}</p>
    </c:if>
    
    <!-- 회원정보 수정 -->
    <form action="/mypage/updateinfo" method="post">
        <h2>회원정보 수정</h2>
        
        <label for="userName">이름:</label>
        <input type="text" id="userName" name="userName" value="${user.userName}" required><br>

        <label for="userNick">닉네임:</label>
        <input type="text" id="userNick" name="userNick" value="${user.userNick}" required><br>

        <label for="userAdd">주소:</label>
        <input type="text" id="userAdd" name="userAdd" value="${user.userAdd}" required><br>

        <label for="userEmail">이메일:</label>
        <input type="email" id="userEmail" name="userEmail" value="${user.userEmail}" required><br>

        <label for="userPhone">전화번호:</label>
        <input type="tel" id="userPhone" name="userPhone" value="${user.userPhone}" required><br>

        <label for="userPw">비밀번호:</label>
        <input type="password" id="userPw" name="userPw" required><br>

        <button type="submit">수정하기</button>
    </form>

    <!-- 마이페이지로 돌아가기 -->
    <a href="/mypage">마이페이지로 돌아가기</a>
</div>

</body>
</html>
