<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="../header.jsp" %>
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
        
                /* 버튼 스타일 */
        button[type="button"] {
            background-color: #000000; /* 버튼 배경 색상 */
            color: white; /* 글자 색상 */
            cursor: pointer; /* 커서 포인터로 변경 */
            transition: background-color 0.3s; /* 배경색 전환 효과 */
            width: 80px;
        }
        
        
    </style>
    <script>
        // 수정 폼을 토글하는 함수
        function toggleEditForm(qNo) {
            var form = document.getElementById('editForm-' + qNo);
            if (form) {  
                if (form.style.display === "none" || form.style.display === "") {
                    form.style.display = "table-row"; // 폼 보이기
                } else {
                    form.style.display = "none"; // 폼 숨기기
                }
            }
        }

        // 나의 문의 목록을 토글하는 함수
        function toggleMyQuestions() {
            var myQuestions = document.getElementById('myQuestions');
            if (myQuestions.style.display === "none" || myQuestions.style.display === "") {
                myQuestions.style.display = "block"; // 나의 문의 보이기
            } else {
                myQuestions.style.display = "none"; // 나의 문의 숨기기
            }
        }
    </script>
</head>
<body class="body-container">
<h1>QnA</h1>

<div class="container">
   <!-- 나의 문의 링크: 상품 주인이 아닐 때만 보이도록 -->
	<c:if test="${ not empty sessionScope.loggedInUser && canAnswer == false }">
	    <button type="button" onclick="toggleMyQuestions()">나의 문의</button>
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


    <!-- 로그인 상태 체크 -->
    <c:if test="${ empty sessionScope.loggedInUser }">
        <div class="login-prompt">로그인 후 문의사항을 등록하실 수 있습니다.</div>
    </c:if>

    <!-- 문의 등록 폼: 로그인한 사용자만 보이도록 -->
    <c:if test="${ not empty sessionScope.loggedInUser && canAnswer == false }">
        <h3>문의 등록</h3>
        <form action="/item/detail/insertQ/${itemNo}" method="post">
            <input type="hidden" name="itemNo" value="${itemNo}">
            <input type="text" name="qTitle" placeholder="문의 제목" required>
            <textarea name="qContent" placeholder="문의 내용을 입력하세요." required></textarea>
            <button type="submit">문의 등록</button>
        </form>
    </c:if>

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
                    <th></th>
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
					
                        <td>
						    <c:if test="${ empty item.getAContent() && canAnswer }">
						        <button type="button" onclick="toggleEditForm(${item.getQNo()})">답변하기</button>
						    </c:if>
						</td>

                    </tr>

                    <tr id="editForm-${item.getQNo()}" class="edit-form">
                        <td colspan="7">
                            <form action="/item/detail/insertA/${item.getQNo()}" method="post">
                                <input type="hidden" name="qNo" value="${item.getQNo()}">
                                <label for="aContent">답변 내용</label>
                                <textarea name="aContent" required>${item.getAContent()}</textarea><br><br>
                                <button type="submit">답변 등록</button>
                            </form>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </c:if>

    <c:if test="${ empty list }">
        <div class="no-data">문의내역이 없습니다.</div>
    </c:if>
</div>
	<jsp:include page="../sidebar.jsp" />
	<jsp:include page="../footer.jsp"/>
</body>
</html>
