<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="/WEB-INF/views/header.jsp" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>회원가입</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link rel="stylesheet" type="text/css" href="/css/style.css">
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
</head>
<body>
<div class="join-container">
    <h2>회원가입</h2>
    <form:form method="post" modelAttribute="user">
        <c:if test="${not empty error}">
            <div class="error-message">${error}</div>
        </c:if>

        <script src="/js/userJoinIdCheck.js"></script>
        <div>
            <label for="userId">아이디:</label>
            <form:input type="text" id="userId" path="userId"/>
            <span class="error-message" id="userIdCheckResult"></span>
            <button type="button" id="checkDuplicateUserId">중복 확인</button>
            <form:errors path="userId" cssClass="error-message" />
        </div>
        <div>
            <label for="userPw">비밀번호:</label>
            <form:password id="userPw" path="userPw"/>
            <span id="passwordRuleResult"></span>
            <form:errors path="userPw" cssClass="error-message" />
        </div>
        <div>
            <label for="userPw2">비밀번호 확인:</label>
            <form:password id="userPw2" path="userPw2"/>
            <span id="passwordMatchResult"></span>
            <form:errors path="userPw2" cssClass="error-message" />
        </div>
        <div>
            <label for="userName">이름:</label>
            <form:input type="text" id="userName" path="userName" />
            <form:errors path="userName" cssClass="error-message" />
        </div>
        <div>
            <label for="userNick">닉네임:</label>
            <form:input type="text" id="userNick" path="userNick" />
            <span id="userNickCheckResult"></span>
            <form:errors path="userNick" cssClass="error-message" />
        </div>
        <div>
            <input type="button" onclick="execDaumPostcode()" value="주소 검색" />
            <form:input path="userAdd" id="userAdd" placeholder="주소" readonly="true" />
            <input type="text" id="detailAddress" placeholder="상세주소" />
        </div>
        <div>
            <label for="userEmail">이메일:</label>
            <form:input type="email" path="userEmail" value="${email}" readonly="true" />
            <span id="userEmailCheckResult"></span>
            <form:errors path="userEmail" cssClass="error-message" />
        </div>
        <div>
            <label for="userPhone1">전화번호:</label>
            <input type="text" id="userPhone1" name="userPhone1" maxlength="3" required/>
            <input type="text" id="userPhone2" name="userPhone2" maxlength="4" required/>
            <input type="text" id="userPhone3" name="userPhone3" maxlength="4" required/>
            <form:errors path="userPhone" cssClass="error-message" />
        </div>

        <button type="submit">회원가입</button>
    </form:form>
</div>

<script>
    // 주소 검색 및 폼 제출 관련 스크립트
    // (기존 스크립트 내용 유지)
</script>
</body>
</html>
<%@ include file="../footer.jsp" %>
