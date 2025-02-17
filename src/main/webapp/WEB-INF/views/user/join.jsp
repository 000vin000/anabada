<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="/WEB-INF/views/header.jsp" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>회원가입</title>
    <!-- jQuery 추가 -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
<h2>회원가입</h2>
<form:form method="post" modelAttribute="user">
    <c:if test="${not empty error}">
        <div style="color: red;">${error}</div>
    </c:if>
	<!-- 중복확인 -->
	<script src="/js/userJoinIdCheck.js"></script>
	<div>
	    <label for="userId">아이디:</label>
	    <form:input type="text" id="userId" path="userId"/>
	    <!-- 중복 확인 버튼 추가 -->
	    <button type="button" id="checkDuplicateUserId">중복 확인</button>
	    <!-- 결과 메시지를 표시할 영역 -->
	    <span id="userIdCheckResult"></span>
	    <form:errors path="userId"></form:errors>
	</div>
	<div>
	    <label for="userPw">비밀번호:</label>
	    <form:password id="userPw" path="userPw"/>
	    <span id="passwordRuleResult"></span>
	    <form:errors path="userPw"></form:errors>
	</div>
	<div>
	    <label for="userPw2">비밀번호 확인:</label>
	    <form:password id="userPw2" path="userPw2"/>
	    <span id="passwordMatchResult"></span>
	    <form:errors path="userPw2"></form:errors>
	</div>
    <div>
        <label for="userName">이름:</label>
        <form:input type="text" id="userName" path="userName" />
        <form:errors path="userName"></form:errors>
    </div>
	<div>
	    <label for="userNick">닉네임:</label>
	    <form:input type="text" id="userNick" path="userNick" />
	    <!-- 결과 메시지를 표시할 영역 -->
	    <span id="userNickCheckResult"></span>
	    <form:errors path="userNick"></form:errors>
	</div>	
    <div>
        <label for="userAdd">주소:</label>
        <form:input type="text" id="userAdd" path="userAdd" />
        <form:errors path="userAdd"></form:errors>
    </div>
    <div>
        <label for="userEmail">이메일:</label>
        <form:input type="email" id="userEmail" path="userEmail"/>
		<span id="userEmailCheckResult"></span>        
        <form:errors path="userEmail"></form:errors>
    </div>
	<div>
	    <label for="userPhone1">전화번호:</label>
	    <input type="text" id="userPhone1" name="userPhone1" maxlength="3" size="3"/>
	    -
	    <input type="text" id="userPhone2" name="userPhone2" maxlength="4" size="4"/>
	    -
	    <input type="text" id="userPhone3" name="userPhone3" maxlength="4" size="4"/>
	    <span id="userPhoneCheckResult"></span>
	    <form:errors path="userPhone"></form:errors>
	</div>
    <button type="submit">회원가입</button>
</form:form>

<%@ include file="../footer.jsp" %>
</body>
</html>
