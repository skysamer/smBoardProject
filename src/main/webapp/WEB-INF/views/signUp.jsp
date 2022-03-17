<%@ page session="false" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>회원가입 페이지</title>
<!-- Bootstrap CSS -->
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
	integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T"
	crossorigin="anonymous">

<style>
body {
	min-height: 100vh;
	background: -webkit-gradient(linear, left bottom, right top, from(#92b5db),
		to(#1d466c));
	background: -webkit-linear-gradient(bottom left, #92b5db 0%, #1d466c 100%);
	background: -moz-linear-gradient(bottom left, #92b5db 0%, #1d466c 100%);
	background: -o-linear-gradient(bottom left, #92b5db 0%, #1d466c 100%);
	background: linear-gradient(to top right, #92b5db 0%, #1d466c 100%);
}

.input-form {
	max-width: 680px;
	margin-top: 80px;
	padding: 32px;
	background: #fff;
	-webkit-border-radius: 10px;
	-moz-border-radius: 10px;
	border-radius: 10px;
	-webkit-box-shadow: 0 8px 20px 0 rgba(0, 0, 0, 0.15);
	-moz-box-shadow: 0 8px 20px 0 rgba(0, 0, 0, 0.15);
	box-shadow: 0 8px 20px 0 rgba(0, 0, 0, 0.15)
}
</style>

</head>

<body>
	<div class="container">
		<div class="input-form-backgroud row">
			<div class="input-form col-md-12 mx-auto">
				<h4 class="mb-3">회원가입</h4>
				<form class="validation-form" name="signForm" id="signForm" novalidate>
					<div class="row">
						<div class="col-md-6 mb-3">

							<label for="userid">아이디</label> <input type="text"
								class="form-control" id="userid" name="userid" placeholder="" value="" required autofocus>
							<div class="invalid-feedback">아이디를 입력해주세요.</div>
							<div id="idCheck"></div>
						</div>
						<div class="col-md-6 mb-3">

							<label for="name">이름</label> <input type="text"
								class="form-control" id="username"  name="username" placeholder="" value=""
								required>
							<div class="invalid-feedback">이름을 입력해주세요.</div>
						</div>
					</div>
					
					<div class="mb-3">
						<label for="password">비밀번호</label> <input type="password"
							class="form-control" id="userpw" name="userpw" placeholder="영문+숫자+특수문자 8자리 이상"
							required>
						<div class="invalid-feedback">비밀번호를 입력해주세요.</div>
						<div id="pwCheck"></div>
					</div>
					
					<div class="mb-3">
						<label for="password">비밀번호 확인</label> <input type="password"
							class="form-control" id="userpwConfirm" placeholder="영문+숫자 8자리 이상"
							required>
						<div class="invalid-feedback">비밀번호를 입력해주세요.</div>
						<div id="pwCheckConfirm"></div>
					</div>

					<div class="mb-3">
						<label for="email">이메일</label> <input type="email"
							class="form-control" id="email" name="email" placeholder="you@example.com"
							required>
						<div class="invalid-feedback">이메일을 입력해주세요.</div>
						<div id="emailCheck"></div>
					</div>

					<div class="mb-3">
						<label for="address">주소</label> <input type="text"
							class="form-control" id="address" name="address" placeholder="서울특별시 강남구"
							required>
						<div class="invalid-feedback">주소를 입력해주세요.</div>
					</div>
					<div class="mb-3">
						<label for="address2">상세주소<span class="text-muted">&nbsp;(필수
								아님)</span></label> <input type="text" class="form-control" id="address2" name="address2"
							placeholder="상세주소를 입력해주세요.">
					</div>
					<div class="row">
						<div class="col-md-8 mb-3">

							<label for="root">성별</label> <select
								class="custom-select d-block w-100" id="root" name="sex">
								<option>남자</option>
								<option>여자</option>
							</select>

							<div class="invalid-feedback">성별을 선택해주세요.</div>
						</div>

						<div class="col-md-4 mb-3">
							<label for="code">휴대폰 번호</label> <input type="text"
								class="form-control" id="phone" name="phone" placeholder="010-1234-5678" required>
							<div class="invalid-feedback">핸드폰 번호를 입력해주세요.</div>
							<div id="phoneCheck"></div>
						</div>
					</div>

					<hr class="mb-4">
					<div class="custom-control custom-checkbox">
						<input type="checkbox" class="custom-control-input" id="aggrement"
							required> <label class="custom-control-label"
							for="aggrement">개인정보 수집 및 이용에 동의합니다.</label>
					</div>

					<div class="mb-4"></div>
					<button class="btn btn-primary btn-lg btn-block" id="submit" type="button">가입
						완료</button>
				</form>
			</div>
		</div>

		<footer class="my-3 text-center text-small">
			<p class="mb-1">&copy; 커뮤니티 사이트</p>
		</footer>
	</div>

<script src="/resources/vendor/jquery/jquery.min.js"></script>

<script> 
window.addEventListener('load', () => { 
	const forms = document.getElementsByClassName('validation-form'); 
	Array.prototype.filter.call(forms, (form) => { 
		form.addEventListener('submit', function (event) { 
			if (form.checkValidity() === false) { 
				event.preventDefault(); event.stopPropagation(); 
			} 
			form.classList.add('was-validated'); 
			}, false); 
		}); 
}, false);

//아이디 유효성 검사(1 = 중복 / 0 != 중복)
$("#userid").blur(function() {
	// id = "id_reg" / name = "userId"
	var userid = $('#userid').val();
	
	var csrfHeaderName="${_csrf.headerName}";
	var csrfTokenValue="${_csrf.token}";

	// ajax security header
	$(document).ajaxSend(function(e, xhr, options){
		xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
	});
	
	// 아이디 중복 체크
	$.ajax({
		url : 'idCheck',
		type : 'post',
		dataType: "json",
		data : {"userid" : userid},
		success : function(idCheck) {
			console.log("1 = 중복o / 0 = 중복x : "+ idCheck);							
			
			if (idCheck == 1) {
				// 1 : 아이디가 중복되는 문구
				$("#idCheck").text("사용중인 아이디 혹은 아이디 오류입니다.");
				$("#idCheck").css("color", "red");
				$("#submit").attr("disabled", true);
			} 
			else if(idCheck == 0){
				$("#idCheck").text("사용 가능한 아이디입니다.");
				$("#idCheck").css("color", "green");	
				$("#submit").attr("disabled", false);
			}
		}, error : function(request, status, error) {
			console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			console.log("실패");
		}
	});
	
	
});

//비밀번호 정규식 체크
$("#userpw").blur(function() {
	var userpw = $('#userpw').val();
	
	var csrfHeaderName="${_csrf.headerName}";
	var csrfTokenValue="${_csrf.token}";

	// ajax security header
	$(document).ajaxSend(function(e, xhr, options){
		xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
	});
	
	// 비밀번호 정규식 체크
	$.ajax({
		url : 'pwCheck',
		type : 'post',
		dataType: "json",
		data : {"userpw" : userpw},
		success : function(pwCheck) {
			console.log("1 = 형식불일치 / 0 = 통과 : "+ pwCheck);							
			
			if (pwCheck == 1) {
				$("#pwCheck").text("비밀번호는 숫자, 문자, 특수문자 포함 8~15자리 이내이어야 합니다.");
				$("#pwCheck").css("color", "red");
				$("#submit").attr("disabled", true);
			} 
			else if(pwCheck == 0){
				$("#pwCheck").text("사용 가능한 비밀번호입니다.");
				$("#pwCheck").css("color", "green");	
				$("#submit").attr("disabled", false);
			}
		}, error : function(request, status, error) {
			console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			console.log("실패");
		}
	});
});

//비밀번호 확인
$("#userpwConfirm").blur(function() {
	var userpwConfirm = $('#userpwConfirm').val();
	var userpw = $('#userpw').val();
	
	var csrfHeaderName="${_csrf.headerName}";
	var csrfTokenValue="${_csrf.token}";

	// ajax security header
	$(document).ajaxSend(function(e, xhr, options){
		xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
	});
	
	// 비밀번호 확인
	$.ajax({
		url : 'pwConfirm',
		type : 'post',
		dataType: "json",
		data : {"userpwConfirm" : userpwConfirm, 
				"userpw" : userpw},
		success : function(pwConfirm) {
			console.log("1 = 비밀번호 불일치/ 0 = 일치 : "+ pwConfirm);							
			
			if (pwConfirm == 1) {
				$("#pwCheckConfirm").text("비밀번호 불일치 혹은 오류입니다.");
				$("#pwCheckConfirm").css("color", "red");
				$("#submit").attr("disabled", true);
			} 
			else if(pwConfirm == 0){
				$("#pwCheckConfirm").text("비밀번호가 일치합니다.");
				$("#pwCheckConfirm").css("color", "green");	
				$("#submit").attr("disabled", false);
			}
		}, error : function(request, status, error) {
			console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			console.log("실패");
		}
	});
});

// 이메일 정규식 체크
$("#email").blur(function() {
	var email = $('#email').val();
	
	var csrfHeaderName="${_csrf.headerName}";
	var csrfTokenValue="${_csrf.token}";

	// ajax security header
	$(document).ajaxSend(function(e, xhr, options){
		xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
	});
	
	// 이메일 정규식 체크
	$.ajax({
		url : 'emailCheck',
		type : 'post',
		dataType: "json",
		data : {"email" : email},
		success : function(emailCheck) {
			console.log("1 = 형식 불일치/ 0 = 일치 : "+ emailCheck);							
			
			if (emailCheck == 1) {
				$("#emailCheck").text("이메일 형식 오류입니다.");
				$("#emailCheck").css("color", "red");
				$("#submit").attr("disabled", true);
			} 
			else if(emailCheck == 0){
				$("#emailCheck").text("이메일 형식에 일치합니다.");
				$("#emailCheck").css("color", "green");	
				$("#submit").attr("disabled", false);
			}
		}, error : function(request, status, error) {
			console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			console.log("실패");
		}
	});
});

// 핸드폰 번호 정규식 체크
$("#phone").blur(function() {
	var phone = $('#phone').val();
	
	var csrfHeaderName="${_csrf.headerName}";
	var csrfTokenValue="${_csrf.token}";

	// ajax security header
	$(document).ajaxSend(function(e, xhr, options){
		xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
	});
	
	// 핸드폰 번호 정규식 체크
	$.ajax({
		url : 'phoneCheck',
		type : 'post',
		dataType: "json",
		data : {"phone" : phone},
		success : function(phoneCheck) {
			console.log("1 = 형식 불일치/ 0 = 일치 : "+ phoneCheck);							
			
			if (phoneCheck == 1) {
				$("#phoneCheck").text("핸드폰 번호 형식 오류입니다.");
				$("#phoneCheck").css("color", "red");
				$("#submit").attr("disabled", true);
			} 
			else if(phoneCheck == 0){
				$("#phoneCheck").text("핸드폰 번호 형식에 일치합니다.");
				$("#phoneCheck").css("color", "green");	
				$("#submit").attr("disabled", false);
			}
		}, error : function(request, status, error) {
			console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			console.log("실패");
		}
	});
});

jQuery.fn.serializeObject = function() {
    var obj = null;
    try {
        if (this[0].tagName && this[0].tagName.toUpperCase() == "FORM") {
            var arr = this.serializeArray();
            if (arr) {
                obj = {};
                jQuery.each(arr, function() {
                    obj[this.name] = this.value;
                });
            }//if ( arr ) {
        }
    } catch (e) {
        alert(e.message);
    } finally {
    }
 
    return obj;
};

// 회원가입 데이터 전송
$(function(e){
    $('#submit').on("click",function (e) {
    	e.preventDefault();
    	
    	var vo = JSON.stringify($("#signForm").serializeObject());
        console.log(JSON.parse(vo));
        
        var csrfHeaderName="${_csrf.headerName}";
    	var csrfTokenValue="${_csrf.token}";

    	// ajax security header
    	 $(document).ajaxSend(function(e, xhr, options){
    		xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
    	}); 
        
         $.ajax({
            type : "post",
            url : "/signUpForm",
            data : vo,
            dataType : 'json',
            contentType: "application/json",
            success : function (data) {
                alert("success");
                location.href='/board/list';
            },
            error: function (request, status, error) {
                console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);

            }
        }); 
    });
});
</script>
</body>
</html>

