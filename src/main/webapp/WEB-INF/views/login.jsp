<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
	
	<script src="/resources/js/main.js"></script>
	<script src="http://code.jquery.com/jquery-3.6.0.min.js"></script>
	<link href="//netdna.bootstrapcdn.com/bootstrap/3.0.3/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.6.1/css/font-awesome.min.css">
	
	<!-- Fonts -->
	<link href='http://fonts.googleapis.com/css?family=Passion+One' rel='stylesheet' type='text/css'>
	<link href='http://fonts.googleapis.com/css?family=Oxygen' rel='stylesheet' type='text/css'>

	<script src="/resources/js/bootstrap.js" type="text/javascript"></script>
	
	<style type="text/css">
		body, html{
		     height: 100%;
		 	background-repeat: no-repeat;
		 	background-color: #d3d3d3;
		 	font-family: 'Oxygen', sans-serif;
		}
		
		.main{
		 	margin-top: 70px;
		}
		
		h1.title { 
			font-size: 50px;
			font-family: 'Passion One', cursive; 
			font-weight: 400; 
		}
		
		hr{
			width: 10%;
			color: #fff;
		}
		
		.form-group{
			margin-bottom: 15px;
		}
		
		label{
			margin-bottom: 15px;
		}
		
		input,
		input::-webkit-input-placeholder {
		    font-size: 11px;
		    padding-top: 3px;
		}
		
		.main-login{
		 	background-color: #fff;
		    /* shadows and rounded borders */
		    -moz-border-radius: 2px;
		    -webkit-border-radius: 2px;
		    border-radius: 2px;
		    -moz-box-shadow: 0px 2px 2px rgba(0, 0, 0, 0.3);
		    -webkit-box-shadow: 0px 2px 2px rgba(0, 0, 0, 0.3);
		    box-shadow: 0px 2px 2px rgba(0, 0, 0, 0.3);
		
		}
		
		.main-center{
		 	margin-top: 30px;
		 	margin: 0 auto;
		 	max-width: 330px;
		    padding: 40px 40px;
		
		}
		
		.login-button{
			margin-top: 5px;
		}
		
		.login-register{
			font-size: 11px;
			text-align: center;
		}
	</style>
		
	<script type="text/javascript">
		function fnLoginAction(){
			
			var userId = $("#userId").val();
			var userPwd = $("#userPwd").val();
			
			$.ajax({
	            url:"/login/loginAction.do",
	            data:{
	            		userId:userId,
	            		userPwd:userPwd
	            	},
	            type:"post",
	            success:function(data){
	               	
	            	if(data == "sucess"){
	            		
	            		window.location.href="/main.do";
	            	}else{
	            		alert("아이디 또는 비밀번호를 확인하세요.");
	            		return;
	            	}
	            	
	                
	            },
	            error:function(jqxhr, textStatus, errorThrown){
	                console.log("ajax 처리 실패");
	                
	                // 에러 로그
	                console.log(jqxhr);
	                console.log(textStatus);
	                console.log(errorThrown);
	            }
	        });
			
		}
		
		function fnUserPwd(){
			
			var url = "/user/loginPwdChgPage.do";
			var name = "loginPwdChgPage";
			var popupX = (document.body.offsetWidth / 2) - (600 / 2);
			var popupY= (window.screen.height / 2) - (300 / 2);
			
			var options = 'top='+popupY+', left='+popupX+', width=600, height=300, status=no, menubar=no, toolbar=no, resizable=no';
			
		    window.open(url, name, options);
			
		}
	</script>
</head>
<body>
		<div class="container">
			<div class="row main" style="margin-top:15%">
				<div class="panel-heading">
	               <div class="panel-title text-center">
	               		<h1 class="title">종합의료정보시스템</h1>
	               		<hr />
	               	</div>
	            </div> 
				<div class="main-login main-center">
					<form class="form-horizontal" method="post" action="#">
						<div class="form-group">
							<label for="username" class="cols-sm-2 control-label">UserId</label>
							<div class="cols-sm-10">
								<div class="input-group">
									<span class="input-group-addon"><i class="fa fa-user fa" aria-hidden="true"></i></span>
									<input type="text" class="form-control" name="userId" id="userId"  placeholder="Enter your UserId"/>
								</div>
							</div>
						</div>

						<div class="form-group">
							<label for="password" class="cols-sm-2 control-label">Password</label>
							<div class="cols-sm-10">
								<div class="input-group">
									<span class="input-group-addon"><i class="fa fa-lock fa-lg" aria-hidden="true"></i></span>
									<input type="password" class="form-control" name="userPwd" id="userPwd"  placeholder="Enter your Password" onKeypress="javascript:if(event.keyCode==13) {fnLoginAction()}"/>
								</div>
							</div>
						</div>

						<div class="form-group ">
							<button type="button" class="btn btn-primary btn-lg btn-block login-button" onclick="fnLoginAction()">Login</button>
						</div>
						<div class="login-register">
				            <a href="javascript:fnUserPwd()">reset password</a>
				         </div>
					</form>
				</div>
			</div>
		</div>
</body>
</html>