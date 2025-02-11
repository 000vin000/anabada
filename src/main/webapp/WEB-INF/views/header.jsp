<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="icon" type="image/png" href="images/favicon.png" sizes="16x16">
    <title>ANABADA</title>
</head>
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
<body>
    <header>
        <a href="/"><img src="images/logo.png" alt="로고" /></a>
        <nav>
            <ul>
                <li><a href="#">카테고리</a></li>
                <li><a href="#">상품등록</a></li>
                <%-- 회원가입, 로그인 기능 추가 --%>
                <c:choose>
                    <c:when test="${empty sessionScope.loggedInUser}">
                        <li><a href="<c:url value='/user/join'/>">회원가입</a></li>
                        <li><a href="<c:url value='/user/login'/>">로그인</a></li>
                    </c:when>
                    <c:otherwise>
                        <li><a href="<c:url value='/user/logout'/>">로그아웃</a></li>
                    </c:otherwise>
                </c:choose>    
                <%-- 검색 기능 추가해야 함 --%>
            </ul>
        </nav>   
    </header>
</body>
</html>


<%--
	header 필요한 파일 상단에
	<%@ include file="../header.jsp" %> 추가!!!!!!!!!!!
 --%>
