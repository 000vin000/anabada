<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>회원탈퇴</title>
</head>
<body>
<jsp:include page="../header.jsp"/>

<div class="body-container">
    <ul class="breadcrumb" id="breadcrumb">
        <li><a href="/">홈</a></li>
        <li><a href="/mypage">마이페이지</a></li>
        <li><a href="/mypage/updateinfo">회원정보 관리</a></li>
    </ul>

    <h1>회원정보 관리</h1>
    
    <a href="/mypage/updateinfo">회원정보수정</a>

    <form action="/mypage/deactivate" method="post">
        <h2>회원 탈퇴</h2>
        <p>정말로 회원 탈퇴를 하시겠습니까?</p>
        
        <button type="submit" style="color: red;">탈퇴하기</button>
    </form>

    <a href="/mypage">마이페이지로 돌아가기</a>
</div>
</body>
</html>
