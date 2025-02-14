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
        <h1 class="item-name">${item.itemName}</h1>
		<button id="favor-btn" data-item-id="${item.itemNo}">☆</button>
		<p>게시자: ${item.userNo}</p>
		<p>설명: ${item.itemContent}</p>
		<div>
			<c:forEach var="image" items="${images}">
				<!-- 동일한 이미지파일 로드 시 깨짐 문제 있음 -->
				<img class="item-image" src="data:image/png;base64,${image}"/>
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
		<p><a href="/item/bidList">입찰기록으로 이동하기</a></p>
    </div>
    <jsp:include page="../sidebar.jsp" />
	
</body>
<script src="/js/todaypick.js"></script>
<script>
	document.addEventListener("DOMContentLoaded", () => {
		const itemNo = window.location.pathname.split('/').pop(); // 상품상세페이지로 갔을때 넘버 가져오기
		// /로 배열을 나누고 마지막 요소를 itemNo에 저장함
		const itemName = document.querySelector(".item-name").innerText;
		// 이름을 가져오려고 이너텍스트를 훔쳐오는 부분
		const itemImage = document.querySelector(".item-image")?.src || "";
		// 페이지에서 이미지 클래스를 찾아서 첫번째 이미지를 가져와서 저장함 실패하면 비어있도록 수정
		
		if (itemNo) {
			addRecentView(itemNo, itemName, itemImage);
		}
	}); // jhu
</script>
<script>
	document.addEventListener("DOMContentLoaded", function () {
	    const favBtn = document.getElementById("favor-btn");
	    const itemNo = favBtn.dataset.itemNo;
		
    	fetch(`/api/favor/${itemNo}`)
    		.then(res => res.json())
       		.then(data => {
       			favBtn.textContent = data.isFavorite ? "★" : "☆";
       	})
	    
	    async function toggleFavorite() {
	        const response = await fetch(`/api/favor/${itemNo}`, { method: "POST" });
	        if (response.status === 401) {
	            alert("로그인이 필요합니다.");
	        } else {
		        const isFavorited = await response.json();
		        favBtn.textContent = isFavorited ? "★" : "☆";
	        }
	    }
	
	    favBtn.addEventListener("click", toggleFavorite);
	});
</script>
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