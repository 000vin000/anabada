<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>500 error</title>
<style>
	body {
		max-width: 1200px; /* 최대 너비 설정 (원하는 크기로 조정 가능) */
  		margin: 0 auto; /* 좌우 중앙 정렬 */
  		padding: 0 20px; /* 내부 여백 추가 (필요에 따라 조정) */
  		justify-content: center; /* 수평 중앙 정렬 */
  		align-items: center; /* 수직 중앙 정렬 */
  		height: 100vh; /* 전체 화면 높이 */
	}
	#error {
		margin-top: 20px; /* 상단 여백 제거 */
		padding: 20px; /* 내부 여백 추가 */
		border: 4px solid #000000; /* 테두리 추가 */
		text-align: center; /* 텍스트 중앙 정렬 */
	}
	#errorMain {
		font-size: 20px;
		font-weight: 700;
	}
	#toMain {
		margin-top: 100px; /* 위쪽 여백 */
		margin: 0 auto;
		padding: 10px 20px; /* 내부 여백 */
		background-color: #000; /* 검은색 배경 */
		color: #fff; /* 흰색 글씨 */
		text-decoration: none; /* 밑줄 제거 */
		border-radius: 5px; /* 모서리 둥글게 */
		font-size: 16px; /* 글씨 크기 */
	}
</style>
</head>
<body>
	<div id="error">
		<p id="errorMain">요청하신 페이지를 표시할 수 없습니다.</p>
		<p>잘못 검색하셨거나 종료된 화면, 또는 해당 화면에서 에러가 발생해서</p>
		<p>표시할 수가 없습니다.</p>
	</div>
	<a href="/" id="toMain">메인으로 돌아가기</a>
</body>
</html>