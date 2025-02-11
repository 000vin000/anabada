<%@ page contentType="text/html; charset=UTF-8" %>
<div class="sidebar">
    <h3>최근 본 상품</h3>
    <div id="recently-viewed"></div>
</div>

<script>
	document.addEventListener("DOMContentLoaded", function() {
	    fetch("/sidebar.jsp") // JSP 파일을 동적으로 불러오기
	        .then(response => response.text())
	        .then(data => {
	            document.getElementById("sidebar-container").innerHTML = data;
	            displayViewedProducts(); // 최근 본 상품 데이터 로드
	        })
	        .catch(error => console.error("사이드바 로드 오류:", error));
	});
</script>