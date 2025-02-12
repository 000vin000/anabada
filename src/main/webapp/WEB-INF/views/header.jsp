<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
</head>
<body>
    <header>
        <a href="/"><img src="../images/logo.png" alt="로고" /></a>
        <div>
            <select id="findType" name="findType">
                <option value="" selected disabled>검색유형</option>
                <option value="itemName">상품명</option>
                <option value="userNick">닉네임</option> 
            </select>
            <input type="search" id="keyword" name="keyword" placeholder="검색어를 입력하세요">
            <input type="button" id="find" value="검색">
        </div>
        <nav>
            <ul>
                <li><a href="#">카테고리</a></li>
                <li><a href="/mypage/itemup">상품등록</a></li>
                <c:choose>
                    <c:when test="${empty sessionScope.loggedInUser}">
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
    
    <script>
        const findType = document.getElementById("findType");
        const keyword = document.getElementById("keyword");
        const search = document.getElementById("find");
        
        search.addEventListener("click", function(e) {
            let findValue = findType.value;
            let keyValue = keyword.value;
            
            if (!findValue) {
                alert("검색 유형을 선택해주세요.");
                return;
            } else if (!keyValue) {
                alert("검색어를 입력하세요.");
                return;
            }
            
            let searchRequest = {
                findType: findValue,
                keyword: keyValue,
            }
            console.log(searchRequest); // 문제 X

            // 서버에 데이터 전송하기
            fetch('/search', {
                method: 'POST',
                headers: { 
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify(searchRequest),
            })
            .then(response => {
                if (response.ok) {
                    // 성공적으로 응답을 받으면 페이지 리다이렉트
                    window.location.href = '/search'; // 페이지 이동
                } else {
                    throw new Error('서버에서 오류가 발생했습니다.'); // 오류 처리
                }
            })
            .catch((error) => {
                console.log('실패', error);
            });
        });
    </script>
</body>
<%-- 
    header 필요한 파일 상단에
    <%@ include file="../header.jsp" %> 추가!!!!!!!!!!!
--%>
</html>
