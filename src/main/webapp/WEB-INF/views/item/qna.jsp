<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>QnA</title>
    <link rel="stylesheet" type="text/css" href="/css/style.css"> <%-- 사이드바 css --%>
    
    <style>
        /* 수정 폼을 숨기기 위한 스타일 */
        .edit-form {
            display: none;
        }

        /* 나의 문의 목록 표시/숨기기 */
        .my-questions {
            display: none;
        }

        /* 전체 상품 문의목록 표시/숨기기 */
        .all-questions {
            display: none;
        }

        /* 버튼들이 세로로 나열되도록 */
		.button-container {
		    display: flex;
		    flex-direction: column; /* 세로 방향으로 배치 */
		    margin: 25px; /* 버튼 간 간격 */
		}
        
        /* 버튼 스타일 */
        button[type="button"] {
            background-color: #21afbf; /* 버튼 배경 색상 */
            color: white; /* 글자 색상 */
            cursor: pointer; /* 커서 포인터로 변경 */
            transition: background-color 0.3s; /* 배경색 전환 효과 */
            width: 180px;
            border: none;
            padding: 8px 15px; /* 버튼 내부 여백 */
            border-radius: 4px; /* 버튼 테두리 둥글게 */
            font-size: 25px;
        }
        
        button[type="button"]:hover {
            background-color: #199c9b; /* 버튼 hover 시 배경색 */
        }

        /* 문의 등록 폼 */
        form {
            display: flex;
            flex-direction: column;
            gap: 15px;
            max-width: 500px;
            margin-top: 20px;
            padding: 20px;
            background-color: #fff; 
            border: none; 
            border-radius: 8px;
        }

        input[type="text"], textarea {
            padding: 10px;
            font-size: 16px;
            border-radius: 4px;
            border: 1px solid #ddd;
            width: 100%;
        }

        input[type="text"]:focus, textarea:focus {
            border-color: #21afbf;
            outline: none;
        }

        button[type="submit"] {
            background-color: #21afbf; /* 버튼 배경 색상 */
            color: white; /* 글자 색상 */
            cursor: pointer; /* 커서 포인터로 변경 */
            padding: 12px 20px; /* 버튼 내부 여백 */
            border: none;
            border-radius: 4px; /* 버튼 테두리 둥글게 */
            font-size: 16px;
            width: 100%;
        }

        button[type="submit"]:hover {
            background-color: #199c9b; /* 버튼 hover 시 배경색 */
        }

        .login-prompt {
            color: #666;
            font-size: 14px;
            margin-top: 20px;
        }

        .no-data {
            color: #777;
            font-size: 16px;
            text-align: center;
            padding: 20px;
        }
    </style>
    <script>
        // 현재 열린 토글과 버튼을 추적할 변수
        let openToggle = null;
        let openButton = null;

        // 토글 함수 수정
        function toggleEditForm(qNo, button) {
            var form = document.getElementById('editForm-' + qNo);

            // 기존에 열려있는 토글이 있으면 닫고 버튼 색상 원래대로 복구
            if (openToggle && openToggle !== form) {
                openToggle.style.display = "none";
                if (openButton) openButton.style.backgroundColor = "#21afbf"; // 이전 버튼 색상 원래대로
            }

            // 새로운 폼 토글
            if (form.style.display === "none" || form.style.display === "") {
                form.style.display = "table-row"; // 폼 보이기
                button.style.backgroundColor = "#00d4da"; // 버튼 색상 변경
                openToggle = form;
                openButton = button; // 현재 버튼 저장
            } else {
                form.style.display = "none"; // 폼 숨기기
                button.style.backgroundColor = "#21afbf"; // 원래 색상으로 변경
                openToggle = null;
                openButton = null; // 버튼도 초기화
            }
        }

        // 나의 문의 목록을 토글하는 함수
        function toggleMyQuestions(button) {
            var myQuestions = document.getElementById('myQuestions');
            
            // 이미 열려있는 토글을 닫기
            if (openToggle && openToggle !== myQuestions) {
                openToggle.style.display = "none";
                openToggle.previousElementSibling.style.backgroundColor = "#21afbf"; // 이전 버튼 색상 원래대로
            }

            // 새로운 폼 토글
            if (myQuestions.style.display === "none" || myQuestions.style.display === "") {
                myQuestions.style.display = "block"; // 나의 문의 보이기
                button.style.backgroundColor = "#00d4da"; // 버튼 색상 변경
                openToggle = myQuestions;
            } else {
                myQuestions.style.display = "none"; // 나의 문의 숨기기
                button.style.backgroundColor = "#21afbf"; // 원래 색상으로 변경
                openToggle = null;
            }
        }

        // 문의 등록 폼을 토글하는 함수
        function toggleAddQuestionForm(button) {
            var form = document.getElementById('addQuestionForm');
            
            // 이미 열려있는 토글을 닫기
            if (openToggle && openToggle !== form) {
                openToggle.style.display = "none";
                openToggle.previousElementSibling.style.backgroundColor = "#21afbf"; // 이전 버튼 색상 원래대로
            }

            // 새로운 폼 토글
            if (form.style.display === "none" || form.style.display === "") {
                form.style.display = "block"; // 폼 보이기
                button.style.backgroundColor = "#00d4da"; // 버튼 색상 변경
                openToggle = form;
            } else {
                form.style.display = "none"; // 폼 숨기기
                button.style.backgroundColor = "#21afbf"; // 원래 색상으로 변경
                openToggle = null;
            }
        }

        // 전체 상품 문의목록을 토글하는 함수
        function toggleAllQuestions(button) {
            var allQuestions = document.getElementById('allQuestions');
            
            // 이미 열려있는 토글을 닫기
            if (openToggle && openToggle !== allQuestions) {
                openToggle.style.display = "none";
                openToggle.previousElementSibling.style.backgroundColor = "#21afbf"; // 이전 버튼 색상 원래대로
            }

            // 새로운 폼 토글
            if (allQuestions.style.display === "none" || allQuestions.style.display === "") {
                allQuestions.style.display = "block"; // 전체 문의 목록 보이기
                button.style.backgroundColor = "#00d4da"; // 버튼 색상 변경
                openToggle = allQuestions;
            } else {
                allQuestions.style.display = "none"; // 전체 문의 목록 숨기기
                button.style.backgroundColor = "#21afbf"; // 원래 색상으로 변경
                openToggle = null;
            }
        }
    </script>
</head>
<body>

<div class="body-container">

    <h1>QnA</h1>
    
<!-- 상품 전체 문의목록 제목 추가 -->
<div class="button-container">
    <button type="button" onclick="toggleAllQuestions(this)">전체문의</button>
</div>

<!-- 전체 문의 목록 -->
<div id="allQuestions" class="all-questions">
    <c:if test="${ not empty list }">
        <table>
            <thead>
                <tr>
                    <th>문의제목</th>
                    <th>문의내용</th>
                    <th>문의등록일</th>
                    <th>답변내용</th>
                    <th>답변등록일</th> 
                    <th>질문자</th> 
                </tr>
            </thead>
            <tbody>
                <c:forEach var="item" items="${ list }">
                    <tr>
                        <td>${ item.getQTitle() }</td>
                        <td>${ item.getQContent() }</td>
                        <td>${ item.getQDate() }</td>
                        <td>${ item.getAContent() }</td>
                        <td>${ item.getADate() }</td>
                        <td>${ item.getUserNick() }</td>					
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </c:if>
    
    <c:if test="${ empty list }">
        <p>문의내역이 없습니다.</p>
    </c:if>
</div>

<!-- 문의 등록 버튼: 로그인한 사용자만 보이도록 -->
<c:if test="${ not empty sessionScope.loggedInUser && canAnswer == false }">
    <div class="button-container">
        <button type="button" onclick="toggleAddQuestionForm(this)">문의 등록</button>
    </div>
</c:if>

<!-- 문의 등록 폼: 로그인한 사용자만 보이도록 -->
<c:if test="${ not empty sessionScope.loggedInUser && canAnswer == false }">
    <div id="addQuestionForm" class="edit-form">
        <form action="/item/detail/insertQ/${itemNo}" method="post">
            <input type="hidden" name="itemNo" value="${itemNo}">
            <input type="text" name="qTitle" placeholder="문의 제목" required>
            <textarea name="qContent" placeholder="문의 내용을 입력하세요." required></textarea>
            <button type="submit">문의 등록</button>
        </form>
    </div>
</c:if>

<!-- 나의 문의 링크: 상품 주인이 아닐 때만 보이도록 -->
<c:if test="${ not empty sessionScope.loggedInUser && canAnswer == false }">
    <div class="button-container">
        <button type="button" onclick="toggleMyQuestions(this)">나의 문의</button>
    </div>
</c:if>

<!-- 나의 문의 목록: 상품 주인이 아닐 때만 보이도록 -->
<c:if test="${ not empty sessionScope.loggedInUser && canAnswer == false }">
    <div id="myQuestions" class="my-questions">
        <c:if test="${ not empty myQuestionsList }">
            <table>
                <thead>
                    <tr>
                        <th>문의제목</th>
                        <th>문의내용</th>
                        <th>문의등록일</th>
                        <th>답변내용</th>
                        <th>답변등록일</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="item" items="${ myQuestionsList }">
                        <tr>
                            <td>${ item.getQTitle() }</td>
                            <td>${ item.getQContent() }</td>
                            <td>${ item.getQDate() }</td>
                            <td>${ item.getAContent() }</td>
                            <td>${ item.getADate() }</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </c:if>

        <c:if test="${ empty myQuestionsList }">
            <div class="no-data">등록한 문의가 없습니다.</div>
        </c:if>
    </div>
</c:if>
<!-- 상품 주인일 때만 답변하기 버튼 보이도록 수정 -->
<c:if test="${ not empty sessionScope.loggedInUser && canAnswer == true }">
    <div class="button-container">
        <a href="/mypage/a">
            <button type="button">답변하러가기</button>
        </a>
    </div>
</c:if>
</div>

</body>
</html>
