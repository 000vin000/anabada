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
	<section id="detailSection">
        <h1>${item.itemName}</h1>
		<input type="button" value="즐겨찾기">
		<label id="currentState">상태</label>
		<label>| ${item.itemStart} ~ ${item.itemEnd}</label>
		<h3><label id="remainTime">남은 시간</label></h3>
		<p>게시자: ${userNick}</p>
		<p>설명: ${item.itemContent}</p>
		<div>
			<c:forEach var="image" items="${images}">
				<!-- 동일한 이미지파일 로드 시 깨짐 문제 있음 -->
				<img src="data:image/png;base64,${image}"/>
				<br>
			</c:forEach>
		</div>
    </section>
    <section id="qnaSection">
    	<a href="#" onclick="openQuestionsWindow('${item.itemNo}')">문의하기</a>
    </section>
    <hr>
    <section id="bidSection">
        <h2 id="priceHeading">현재 입찰가: <label id="currentPrice">${item.itemPrice}</label></h2>
        <p>
			입찰:
			<input type="text" id="textPrice" disabled="disabled">
			<input type="submit" id="btnBid" value="입찰" disabled="disabled">
		</p>
		<p><a href="#">입찰기록으로 이동하기</a></p>
    </section>
</body>
<script>
	let intervals = [];
	const btnBid = document.getElementById("btnBid");
	const textPrice = document.getElementById("textPrice");

	document.addEventListener('DOMContentLoaded', function() {
		//init
		updateCurrentState(${item.itemNo});
		updateRemainingTime();
	});

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
	
    function openQuestionsWindow(itemNo) {
        window.open(
            '/item/detail/' + itemNo + '/questions', 
            'QuestionsWindow', 
            'width=1000,height=800,scrollbars=yes'
        );
    }

    function updateCurrentPrice(itemNo) {
        fetch('/item/detail/' + itemNo + '/currentPrice')
            .then(response => response.text())
            .then(data => {
                document.getElementById("currentPrice").innerText = data;
            })
    }

    let itvPrice = setInterval(() => {
        updateCurrentPrice(${item.itemNo});
    }, 1000);
    intervals.push(itvPrice);

    function updateCurrentState(itemNo) {
        fetch('/item/detail/' + itemNo + '/currentState')
            .then(response => response.text())
            .then(data => {
            	if (data === "입찰 가능") {
            		textPrice.disabled = false;
        			btnBid.disabled = false;
        		} else {
        			textPrice.disabled = true;
        			btnBid.disabled = true;
        		}
            	
                document.getElementById("currentState").innerText = data;
                
                if (data === "낙찰" || data === "종료") {
                    stopAllIntervals();
                    
                    if (data === "낙찰") {
                    	const priceHeading = document.getElementById("priceHeading");
                    	priceHeading.childNodes[0].textContent = "낙찰가: ";
                    }
                }
            })
    }
    
    function stopAllIntervals() {
        intervals.forEach(id => clearInterval(id));
        intervals = [];
    }

    let itvState = setInterval(() => {
        updateCurrentState(${item.itemNo});
    }, 1000);
    intervals.push(itvState);
    
    let remainTime = ${remainTime};
    function updateRemainingTime() {
        if (remainTime <= 0) {
            document.getElementById("remainTime").innerText = "";
        } else {
            let hours = Math.floor(remainTime / 3600);
            let minutes = Math.floor((remainTime % 3600) / 60);
            let seconds = remainTime % 60;
            
            document.getElementById("remainTime").innerText = "남은 시간: " + hours + "시간 " + minutes + "분 " + seconds + "초";
        }
    }

    let itvRemainTime = setInterval(function() {
        remainTime--;
        updateRemainingTime();
    }, 1000);
    intervals.push(itvRemainTime);
</script>
</html>