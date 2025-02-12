<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품등록</title>
</head>
<body>
<h1>상품등록</h1>
<form  method="POST" enctype="multipart/form-data">
  <label for="itemName">제목:</label>
  <input type="text" id="itemName" name="itemName" required><br><br>

  <label for="imageFile">이미지:</label>
  <input type="file" id="imageFile" name="imageFile" accept="image/*" required multiple><br><br>

  <label for="itemEnd">경매 시작시간:</label>
  <input type="datetime-local" id="itemStart" name="itemStart" required><br><br>

  <label for="itemEnd">경매 마감시간:</label>
  <input type="datetime-local" id="itemEnd" name="itemEnd" required><br><br>

  <label>카테고리</label><br><br>
  <label>성별:</label><br>
  <input type="radio" id="female" name="gender" value="w">
  <label for="female">여성</label><br>
  <input type="radio" id="male" name="gender" value="m">
  <label for="male">남성</label><br><br>
  
  <label>의류 종류:</label><br>
  <input type="radio" id="top" name="category" value="top" required>
  <label for="top">상의</label><br>
  <input type="radio" id="bottom" name="category" value="bottom" required>
  <label for="bottom">하의</label><br>
  <input type="radio" id="outer" name="category" value="outer" required>
  <label for="outer">아우터</label><br>
  <input type="radio" id="dress" name="category" value="dress" required>
  <label for="dress">원피스</label><br>
  <input type="radio" id="etc" name="category" value="etc" required>
  <label for="etc">기타</label><br>
  <input type="radio" id="set" name="category" value="set" required>
  <label for="set">셋업</label><br><br>

  <label for="itemPrice">가격:</label>
  <input type="number" id="itemPrice" name="itemPrice" required><br><br>

  <label for="itemContent">내용:</label><br>
  <textarea id="description" name="itemContent" rows="4" cols="50" required></textarea><br><br>
  
  <label for="itemStatus">상품상태:</label><br>
  <input type="radio" id="itemStatus0" name="itemStatus" value="high">
  <label for="itemStatus0">상</label>
  <input type="radio" id="itemStatus1" name="itemStatus" value="mid">
  <label for="itemStatus1">중</label>
  <input type="radio" id="itemStatus2" name="itemStatus" value="low">
  <label for="itemStatus2">하</label><br><br>
  
  <input type="submit" value="등록"><br>
  
</form>

<a href="/mypage">마이페이지로 돌아가기</a>
</body>
</html>