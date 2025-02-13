<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="loggedInUser" value="${sessionScope.loggedInUser}" />
    
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="icon" type="image/png" href="images/favicon.png" sizes="16x16">
    <title>ANABADA</title>
    <style>
        header img {
            width: 200px; 
            height: auto; /* 비율 유지 */
        }
        nav {
            display: flex; /* 플렉스 박스를 사용하여 나란히 배치 */
            align-items: center; /* 수직 중앙 정렬 */
        }
        nav ul {
            display: flex; /* 리스트 항목을 나란히 배치 */
            list-style-type: none; /* 리스트 스타일 제거 */
            padding: 0; /* 패딩 제거 */
            margin: 0; /* 마진 제거 */
        }
        nav li {
            margin-right: 20px; /* 항목 간 간격 조정 */
        }
    </style>
    <script>
        function submitSearch() {
            const findType = document.getElementById('findType').value;
            const keyword = document.getElementById('keyword').value.trim();
            
            const form = document.createElement('form');
            form.method = 'GET';
            form.action = '/search';

            const findTypeInput = document.createElement('input');
            findTypeInput.type = 'hidden';
            findTypeInput.name = 'findType';
            findTypeInput.value = findType;

            const keywordInput = document.createElement('input');
            keywordInput.type = 'hidden';
            keywordInput.name = 'keyword';
            keywordInput.value = keyword;

            form.appendChild(findTypeInput);
            form.appendChild(keywordInput);
            document.body.appendChild(form);
            form.submit();
        }
        
        function handleKeyPress(event) {
            if (event.key === 'Enter') {
                submitSearch();
            }
        }
    </script>
</head>
<body>
    <header>
        <a href="/"><img src="../images/logo.png" alt="로고" /></a>
        <div>
            <select id="findType" name="findType">
                <option value="" selected disabled>검색유형</option>
                <option value="itemName">상품명</option>
                <option value="userNick">닉네임(동일)</option> 
            </select>
            <input type="search" id="keyword" name="keyword" placeholder="검색어를 입력하세요" onkeydown="handleKeyPress(event)">
            <input type="button" id="find" value="검색" onclick="submitSearch()">
        </div>
        <nav>
            <ul>
                <li><a href="#">카테고리</a></li>
                <li><a href="/mypage/itemup">상품등록</a></li>
                <c:choose>
					<c:when test="${empty loggedInUser}">
                        <li><a href="<c:url value='/user/join'/>">회원가입</a></li>
                        <li><a href="<c:url value='/user/login'/>">로그인</a></li>
                    </c:when>
                    <c:otherwise>
                    	<li><a href="<c:url value='/mypage'/>">마이페이지</a></li>
                        <li><a href="<c:url value='/user/logout'/>">로그아웃</a></li>
                    </c:otherwise>
                </c:choose>
            </ul>
        </nav>   
    </header>
</body>
</html>
