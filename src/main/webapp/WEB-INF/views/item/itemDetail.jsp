<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${item.itemName}</title>
</head>
<body>
	<div id="section1" class="section" onclick="focusSection('section1')">
        <h1>${item.itemName}</h1>
		<input type="button" value="즐겨찾기">
		<p>게시자: ${item.userNo}</p>
		<p>설명: ${item.itemContent}</p>
		<div>
			<c:forEach var="image" items="${images}">
				<!-- 동일한 이미지파일 로드 시 깨짐 문제 있음 -->
				<img src="data:image/png;base64,${image}"/>
				<br>
			</c:forEach>
		</div>
		<div>
			<textarea rows="10" cols="35"></textarea>
			<input type="button" id="btnQ" value="문의">
		</div>
    </div>
    <hr>
    <div id="section2" class="section" onclick="focusSection('section2')">
        <h2>현재 입찰가: <label id="currentPrice">${item.itemPrice}</label></h2>
        <p>
			입찰:
			<input type="text" id="textPrice">
			<input type="submit" id="btnBid" value="입찰">
		</p>
		<p><a href="#">입찰기록으로 이동하기</a></p>
    </div>
</body>
<script>
	const btnBid = document.getElementById("btnBid");
	const textPrice = document.getElementById("textPrice");
	
	btnBid.addEventListener("click", function(e) {
		let price = textPrice.value;

		fetch('/item/detail/' + ${item.itemNo} + '/bid?itemPrice=' + price, {
	        method: "PATCH",
	    })
	    .then(response => {
	        if (!response.ok) {
	            throw new Error("입찰 실패");
	        }
	        return response.json();
	    })
	    .then(data => {
	        console.log("서버 응답:", data);
	    })
	    .catch(error => {
	        console.error("오류 발생:", error);
	    });
	});
	
	//문의 리스트 로드
	//문의하기(아이템 등록자 외 모두) or 답변하기(아이템 등록자인 경우)

    setInterval(() => {
        updateCurrentPrice(${item.itemNo});
    }, 3000);
    
    function focusSection(sectionId) {
        const sections = document.querySelectorAll('.section');
        sections.forEach(section => {
            section.classList.remove('active');
        });

        const selectedSection = document.getElementById(sectionId);
        selectedSection.classList.add('active');
    }

    function updateCurrentPrice(itemNo) {
        fetch('/item/detail/' + itemNo + '/currentPrice')
            .then(response => response.json())
            .then(data => {
                document.getElementById("currentPrice").innerText = data;
            })
    }
</script>
</html>