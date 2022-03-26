<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<html>
<head>
	<title>Home</title>
	<style type="text/css">
		#dtTable th {
			background-color: rgba(0,0,0,.05);
			height: 50px;
			padding: 10px;
		}
		#dtTable td {
			padding: 10px;
		}
	</style>
	<script src="/resources/js/jquery-3.6.0.min.js"></script>	
	
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
	<link href="//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap-glyphicons.css" rel="stylesheet">
	<link rel="stylesheet" href="/resources/css/bootstrap-theme.min.css">
	
	<script src="/resources/js/bootstrap.js"></script>
	
	<script src="/resources/js/main.js"></script>
	<link href="/resources/css/main.css"  rel="stylesheet" type="text/css" /> 
	
	<script type="text/javascript">
	
		var pwdChk = 0;
	
		$(document).ready(function() {
			
	    }); 
		
		function fnPwdAction() {
			
			var userId = $("#userId").val();
			var agoPwd = $("#agoPwd").val();
			var newPwd = $("#newPwd").val();
			
			if(pwdChk > 0){
				
				$.ajax({
		            url:"/user/loginPwdChgAction.do",
		            data:{
		            		userId:userId,
		            		agoPwd:agoPwd,
		            		newPwd:newPwd
		            	},
		            type:"post",
		            success:function(data){
		               	
		            	alert("변경되었습니다.");
		            	
						window.close();
		            	
		            },
		            error:function(jqxhr, textStatus, errorThrown){
		                console.log("ajax 처리 실패");
		                
		                // 에러 로그
		                console.log(jqxhr);
		                console.log(textStatus);
		                console.log(errorThrown);
		            }
		        });
				
			}else{
				alert("기존비밀번호를 재확인하세요");
				return;
			}
		}
			
		function fnPwdChk() {
			
			var userId = $("#userId").val();
			var agoPwd = $("#agoPwd").val();
			
			$.ajax({
	            url:"/user/loginPwdChk.do",
	            data:{
	            		userId:userId,
	            		agoPwd:agoPwd
	            	},
	            type:"post",
	            success:function(data){
	            	console.log(data)
	            	if(data == "sucess"){
	            		$("#pwdChkMunnu").html("기존비밀번호와 일치합니다");
	            		pwdChk = 1;
	            	}else{
	            		$("#pwdChkMunnu").html("기존비밀번호와 일치하지않습니다");
	            		pwdChk = 0;
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
		
		function fnClose() {
			
			window.close();
		}
	</script>
</head>
<body>
<input type="hidden" id="pageType" name="pageType" value="${pageType }">
	<div style="width:100%;margin:0 auto;">
	
		<h2 style="text-align: center;margin-top:20px;margin-bottom:20px;font-size: 30px">비밀번호 변경</h2>
		
		<table id="dtTable" border="1" style="width:80%;margin:0 auto;">
			<colgroup> 
				<col width="30%"/>
				<col width="70%"/>
			</colgroup>
			<tbody>
				<tr>
					<th>사용자ID</th>
					<td><input type="text" id="userId" name="userId" style="height: 30px;font-size:15px" class="form-control mr-sm-2"></td>
				</tr>
				<tr>
					<th>기존비밀번호</th>
					<td>
						<input type="password" id="agoPwd" name="agoPwd" style="width:40%;height: 30px;font-size:15px;display: initial;" class="form-control mr-sm-2" onkeyup="fnPwdChk()">
						<span id="pwdChkMunnu" style="font-size:13px;"></span>
					</td>
				</tr>
				<tr>
					<th>변경비밀번호</th>
					<td><input type="password" id="newPwd" name="newPwd" style="height: 30px;font-size:15px" class="form-control mr-sm-2"></td>
				</tr>
			</tbody>
		</table>
		<div style="width:90%;text-align: right;margin-top:5px;margin-right:15px">
			<button type="button" onclick="fnPwdAction()" class="btn btn-outline-dark" style="font-size:13">변경</button>
			<button type="button" onclick="fnClose()" class="btn btn-outline-dark" style="font-size:13">닫기</button>
		</div>
	</div>

</body>
</html>
