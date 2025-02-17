<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>내가 받은 문의 리스트</title>
    <style>
        /* 수정 폼 숨김 처리 */
        .edit-form {
            display: none;
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
<body>
<h1>내가 받은 문의 리스트</h1>

<div class="container">
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
                    <th></th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="item" items="${ list }">
                    <tr>
                        <td><a href="/item/detail/${item.itemNo}">${item.itemName}</a></td>
                        <td>${ item.getUserNick() }</td>
                        <td>${ item.getQTitle() }</td>   
                        <td>${ item.getQDate() }</td>
                        <td>${ item.getQContent() }</td>  	
                        <td>${ item.getADate() }</td>				             
                        <td>${ item.getAContent() }</td>
                        <td>
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
</body>
</html>
