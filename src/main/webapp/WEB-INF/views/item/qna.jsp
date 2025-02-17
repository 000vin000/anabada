<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>QnA</title>
    <style>
        /* 수정 폼을 숨기기 위한 스타일 */
        .edit-form {
            display: none;
        }
    </style>
    <script>
        // 수정 폼을 토글하는 함수 (각 질문별 폼을 개별적으로 열기)
        function toggleEditForm(qNo) {
            var form = document.getElementById('editForm-' + qNo);
            if (form) {  // form 요소가 있는지 체크
                if (form.style.display === "none" || form.style.display === "") {
                    form.style.display = "table-row"; // 폼 보이기
                } else {
                    form.style.display = "none"; // 폼 숨기기
                }
            }
        }
    </script>
</head>
<body>
<h1>해당 상품의 문의 리스트</h1>

<div class="container">
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
                    <th>답변하기</th>  
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
                            <!-- 답변하기 버튼: 아이템 주인만 보이도록 -->
							<c:if test="${ canAnswer }">
							    <button type="button" onclick="toggleEditForm(${item.getQNo()})">답변하기</button>
							</c:if>
                        </td>
                    </tr>
                    
                    <!-- 답변 폼: 각 폼에 id를 사용하여 개별적으로 토글 -->
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

<!-- 문의 등록 폼: 아이템 주인이 아닌 사용자만 보이도록 -->
<c:if test="${ canAnswer == false }">
    <h3>문의 등록</h3>
    <form action="/item/detail/insertQ/${itemNo}" method="post">
        <input type="hidden" name="itemNo" value="${itemNo}">
        <input type="text" name="qTitle" placeholder="문의 제목" required>
        <textarea name="qContent" placeholder="문의 내용을 입력하세요." required></textarea>
        <button type="submit">문의 등록</button>
    </form>
</c:if>

</body>
</html>
