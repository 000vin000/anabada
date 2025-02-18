<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="/WEB-INF/views/header.jsp" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>회원정보 수정</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link rel="stylesheet" type="text/css" href="/css/style.css">
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <script src="/js/updateinfoCheck.js"></script>
</head>
<body>

<div class="body-container">
    <ul class="breadcrumb" id="breadcrumb">
        <li><a href="/">홈</a></li>
        <li><a href="/mypage">마이페이지</a></li>
        <li><a href="/mypage/updateinfo">회원정보 관리</a></li>
    </ul>
    <h1>회원정보 관리</h1>
    <a href="/mypage/deactivate">회원탈퇴</a>
    
    <c:if test="${not empty success}">
        <p style="color: green;">${success}</p>
    </c:if>
    <c:if test="${not empty error}">
        <p style="color: red;">${error}</p>
    </c:if>
    <form:form action="/mypage/updateinfo" method="post" modelAttribute="user">
        <h2>회원정보 수정</h2>
        
        <form:hidden path="userId" value="${user.userId}"/>

        <div>
            <label for="userName">이름:</label>
            <form:input type="text" id="userName" path="userName" required="true"/>
            <form:errors path="userName" cssStyle="color:red"/>
        </div>

        <div>
            <label for="userNick">닉네임:</label>
            <form:input type="text" id="userNick" path="userNick" required="true"/>
            <form:errors path="userNick" cssStyle="color:red"/>
        </div>

        <div>
            <label for="userAdd">주소:</label>
            <form:input path="userAdd" id="userAdd" placeholder="주소" readonly="true" />
            <input type="button" onclick="execDaumPostcode()" value="주소 검색"><br>
            <input type="text" id="detailAddress" name="detailAddress" placeholder="상세주소" />
            <form:errors path="userAdd" cssStyle="color:red"/>
        </div>
        
        <div>
            <label for="userEmail">이메일:</label>
            <form:input type="email" path="userEmail" value="${userEmail}" readonly="true"/>
            <form:errors path="userEmail" cssStyle="color:red"/>
        </div>

        <div>
            <label for="userPhone1">전화번호:</label>
            <input type="text" id="userPhone1" name="userPhone1" maxlength="3" size="3" value="${phone1}" required="true"/>
            -
            <input type="text" id="userPhone2" name="userPhone2" maxlength="4" size="4" value="${phone2}" required="true"/>
            -
            <input type="text" id="userPhone3" name="userPhone3" maxlength="4" size="4" value="${phone3}" required="true"/>
            <form:errors path="userPhone" cssStyle="color:red"/>
        </div>
        
       <div>
            <label for="userPw">새 비밀번호:</label>
            <form:password id="userPw" path="userPw" />
            <span id="passwordRuleResult"></span>
            <form:errors path="userPw" cssStyle="color:red"/>
        </div>

        <div>
            <label for="userPw2">새 비밀번호 확인:</label>
            <form:password id="userPw2" path="userPw2"/>
            <span id="passwordMatchResult"></span>
            <form:errors path="userPw2" cssStyle="color:red"/>
        </div>
        
        <button type="submit">수정하기</button>
    </form:form>

    <a href="/mypage">마이페이지로 돌아가기</a>
</div>
</body>
</html>
<%@ include file="../footer.jsp" %>