<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>로그아웃 페이지</title>

    <link href="/resources/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
	
	<link href="/resources/vendor/metisMenu/css/metisMenu.min.css" rel="stylesheet">
	
	<link href="/resources/dist/css/sb-admin-2.css" rel="stylesheet">
	
	<link href="/resources/vendor/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">

</head>

<body>

    <div class="container">
        <div class="row">
            <div class="col-md-4 col-md-offset-4">
                <div class="login-panel panel panel-default">
                    <div class="panel-heading">
                        <h3 class="panel-title">로그아웃 페이지</h3>
                    </div>
                    <div class="panel-body">
                        <form role="form" method="post" action="/customLogout">
                            <fieldset>
                            
                                
                                <a href="/customLogin" class="btn btn-lg btn-success btn-block">로그아웃</a>
                            </fieldset>
                            
                            <input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }"/>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="/resources/vendor/jquery/jquery.min.js"></script>
	
	<script src="/resources/vendor/bootstrap/js/bootstrap.min.js"></script>
	
	<script src="/resources/vendor/metisMenu/metisMenu.min.js"></script>
	
	<script src="/resources/dist/js/sb-admin-2.js"></script>

</body>

</html>

<script>
$(".btn-success").on("click", function(e){
	e.preventDefault();
	$("form").submit();
});
</script>

<c:if test="${param.logout !=null }">
	<script>
	$(document).ready(function(){
		alert("로그아웃 되었습니다.");
	});
	</script>
</c:if>
