<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="../header.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>아이템 목록</title>
    <link rel="stylesheet" type="text/css" href="/css/styleTemp.css"> <%-- 사이드바 css --%>
    <link rel="stylesheet" type="text/css" href="/css/styleMainPage.css"> <%-- 메인페이지 css --%>
</head>
<body>
    <jsp:include page="item.jsp" />
    <jsp:include page="../sidebar.jsp" />
    <jsp:include page="../footer.jsp" /> 
</body>
<script src="/js/common.js"></script>
<script src="/js/todaypick.js"></script>
<script>
        function sortItems() {  
            let sortOrder = document.getElementById("sortOrder");
            let selectedValue = sortOrder.value;
          	
            sessionStorage.setItem("sortOrder", selectedValue);
            
			window.location.href = `?sortOrder=` + selectedValue;
        }     
</script>
</html>
