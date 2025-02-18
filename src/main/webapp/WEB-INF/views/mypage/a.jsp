<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../header.jsp" %>
<html>
<head>
    <title>내가 받은 문의 리스트</title>
    <link rel="stylesheet" type="text/css" href="/css/style.css"> <%-- 사이드바 css --%>
    <style>
        /* 수정 폼 숨김 처리 */
        .edit-form {
            display: none;
        }
               
        
		/* 버튼 스타일 */
        button[type="button"] {
            background-color: #21afbf; /* 버튼 배경 색상 */
            color: white; /* 글자 색상 */
            cursor: pointer; /* 커서 포인터로 변경 */
            transition: background-color 0.3s; /* 배경색 전환 효과 */           
            width: 80px;
            border: none;
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
    </script>
</head>

<body >


<div class="body-container">
<h1>내가 받은 문의 리스트</h1>
    <c:if test="${ not empty list }">
        <table>
            <thead>
                <tr>
                    <th>상품이름</th>
                    <th>질문자</th>
                    <th>문의제목</th>
                    <th>문의등록일</th>
                    <th>문의내용</th>                     
                    <th>답변등록일</th>
                    <th>답변내용</th>  
                </tr>
            </thead>
            <tbody>
                <c:forEach var="item" items="${ list }">
                    <tr>
                        <td><a href="/item/detail/${item.itemNo}">${item.itemName}</a></td>
                        <td>${ item.getUserNick() }</td>
                        <td>${ item.getQTitle() }</td>   
                        <td>${ item.getFormattedQDate(item.getQDate()) }</td>
                        <td>${ item.getQContent() }</td>  	                    
                        <td>${ item.getFormattedADate(item.getADate()) }</td>				             
                        <td>${ item.getAContent() }</td>
                        
						<td style="border: none;">
						    <c:if test="${ empty item.getAContent() }">
						        <button type="button" onclick="toggleEditForm(${item.getQNo()})">답변하기</button>
						    </c:if>
						</td>				
                    </tr>

                    <!-- 답변 입력 폼 (기본적으로 숨겨져 있음) -->
                    <tr id="editForm-${item.getQNo()}" class="edit-form">
                        <td colspan="8">
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
<script src="/js/todaypick.js"></script>
</html>
