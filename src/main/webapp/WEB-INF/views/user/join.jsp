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
    <link rel="stylesheet" type="text/css" href="/css/style.css"> <%-- 사이드바 css --%>
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
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
            <form:input path="userAdd" id="userAdd" placeholder="주소" readonly="true" />
            <input type="button" onclick="execDaumPostcode()" value="주소 검색"><br>
            <input type="text" id="detailAddress" placeholder="상세주소" />
        </div>
    <div>
        <label for="userEmail">이메일:</label>
		<form:input type="email" path="userEmail" value="${email}" readonly="true" />
		<span id="userEmailCheckResult"></span>        
        <form:errors path="userEmail"></form:errors>
    </div>
<div>
    <label for="userPhone1">전화번호:</label>
    <input type="text" id="userPhone1" name="userPhone1" maxlength="3" size="3" required/>
    -
    <input type="text" id="userPhone2" name="userPhone2" maxlength="4" size="4" required/>
    -
    <input type="text" id="userPhone3" name="userPhone3" maxlength="4" size="4" required/>
    <form:errors path="userPhone" cssStyle="color:red"/>
</div>

    <button type="submit">회원가입</button>
</form:form>
    <script>
    function execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    addr += extraAddr;
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById("userAdd").value = data.zonecode + ' ' + addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("detailAddress").focus();
            }
        }).open();
    }

    // 폼 제출 전 상세주소를 userAdd에 추가
    document.querySelector('form').onsubmit = function() {
        var userAdd = document.getElementById('userAdd');
        var detailAddress = document.getElementById('detailAddress');
        if (detailAddress.value) {
            userAdd.value += ' ' + detailAddress.value;
        }
        return true;
    };
    </script>
    
</body>
</html>
<%@ include file="../footer.jsp" %>
