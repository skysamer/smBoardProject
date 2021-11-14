<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" contentType="text/html; charset=UTF-8"%>
<html>
<head>
	<title>커뮤니티 게시판</title>
</head>
<body>
<h1>
	커뮤니티 게시판에 오신 것을 환영합니다.
</h1>
<button type="button" onclick="location.href='/board/list' ">게시판 바로가기</button>
<P>  현재시간: ${serverTime}. </P>
</body>
</html>
