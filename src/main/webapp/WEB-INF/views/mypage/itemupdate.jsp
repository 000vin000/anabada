<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>상품 수정</title>
  <script>
    // 페이지 로드 시 오늘 날짜를 yyyy-MM-dd 형식으로 설정
    window.onload = function() {
      var today = new Date();
      var yyyy = today.getFullYear();
      var mm = (today.getMonth() + 1).toString().padStart(2, '0');  // 월은 0부터 시작하므로 +1
      var dd = today.getDate().toString().padStart(2, '0');  // 일(day)을 2자리로 만들기 위해 padding

      var todayFormatted = yyyy + '-' + mm + '-' + dd;

      // itemStart와 itemEnd의 min 속성에 오늘 날짜를 설정
      document.getElementById('itemStart').setAttribute('min', todayFormatted + "T00:00");
      document.getElementById('itemEnd').setAttribute('min', todayFormatted + "T00:00");
    }

    // itemStart의 시간값이 변경될 때마다 updateEndTime 함수 호출
    document.getElementById('itemStart').addEventListener('input', updateEndTime);

    // itemEnd의 시간값이 변경될 때에도 updateEndTime 함수 호출
    document.getElementById('itemEnd').addEventListener('input', updateEndTime);

    function validateForm(event) {
      var itemStart = document.getElementById('itemStart').value;
      var itemEnd = document.getElementById('itemEnd').value;

      // 경매 마감시간이 경매 시작시간보다 앞설 경우
      if (new Date(itemEnd) < new Date(itemStart)) {
        alert("경매 마감시간은 경매 시작시간보다 이전일 수 없습니다. 마감시간을 다시 설정해주세요.");
        event.preventDefault();
        return false;
      }

      return true;
    }
  </script>
</head>
<body>
<h1>상품 수정</h1>
<form action="/mypage/itemupdate/${item.itemNo}" method="post" enctype="multipart/form-data" onsubmit="return validateForm(event);">
  <input type="hidden" name="itemNo" value="${item.itemNo}">

  <label for="itemName">제목:</label>
  <input type="text" id="itemName" name="itemName" value="${item.itemName}" required><br><br>

  <label for="imageFile">이미지:</label>
  <input type="file" id="imageFile" name="imageFiles[]" accept="image/*" multiple required><br><br>

  <label for="itemStart">경매 시작시간:</label>
  <input type="datetime-local" id="itemStart" name="itemStart" value="${item.itemStart}" required><br><br>

  <label for="itemEnd">경매 마감시간:</label>
  <input type="datetime-local" id="itemEnd" name="itemEnd" value="${item.itemEnd}" required><br><br>

  <label>카테고리</label><br><br>
  <label>성별:</label><br>
  <input type="radio" id="itemGender0" name="itemGender" value="m" ${item.itemGender == 'm' ? 'checked' : ''} required>
  <label for="itemGender0">남성</label><br>
  <input type="radio" id="itemGender1" name="itemGender" value="w" ${item.itemGender == 'w' ? 'checked' : ''} required>
  <label for="itemGender1">여성</label><br><br>

  <label>의류 종류:</label><br>
  <input type="radio" id="top" name="itemCate" value="top" ${item.itemCate == 'top' ? 'checked' : ''} required>
  <label for="top">상의</label><br>
  <input type="radio" id="bottom" name="itemCate" value="bottom" ${item.itemCate == 'bottom' ? 'checked' : ''} required>
  <label for="bottom">하의</label><br>
  <input type="radio" id="outer" name="itemCate" value="outer" ${item.itemCate == 'outer' ? 'checked' : ''} required>
  <label for="outer">아우터</label><br>
  <input type="radio" id="dress" name="itemCate" value="dress" ${item.itemCate == 'dress' ? 'checked' : ''} required>
  <label for="dress">원피스</label><br>
  <input type="radio" id="etc" name="itemCate" value="etc" ${item.itemCate == 'etc' ? 'checked' : ''} required>
  <label for="etc">기타</label><br>
  <input type="radio" id="set" name="itemCate" value="set" ${item.itemCate == 'set' ? 'checked' : ''} required>
  <label for="set">셋업</label><br><br>

  <label for="itemPrice">가격:</label>
  <input type="number" id="itemPrice" name="itemPrice" value="${item.itemPrice}" required><br><br>

  <label for="itemContent">내용:</label><br>
  <textarea id="description" name="itemContent" rows="4" cols="50" required>${item.itemContent}</textarea><br><br>

  <label for="itemStatus">상품상태:</label><br>
  <input type="radio" id="itemStatus0" name="itemStatus" value="high" ${item.itemStatus == 'high' ? 'checked' : ''} required>
  <label for="itemStatus0">상</label>
  <input type="radio" id="itemStatus1" name="itemStatus" value="mid" ${item.itemStatus == 'mid' ? 'checked' : ''} required>
  <label for="itemStatus1">중</label>
  <input type="radio" id="itemStatus2" name="itemStatus" value="low" ${item.itemStatus == 'low' ? 'checked' : ''} required>
  <label for="itemStatus2">하</label><br><br>

  <input type="submit" value="수정"><br>

</form>

<a href="/mypage">마이페이지로 돌아가기</a>
</body>
</html>
