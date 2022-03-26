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
	
		$(document).ready(function() {
			startDate();
			$("#${menuCode}").addClass("menuActive");
	    }); 
				
		function fnEditPage(boardType,userSeq){
			
			if(boardType == "upt"){
				
				//window.location.href="/board/boardEditPage.do?boardSeq="+boardSeq+"&boardType="+boardType+"&menuCode=${menuCode}&nowPage=${nowPage}&cntPerPage=${cntPerPage}";
				var form = document.userForm;
				
				form.action = "/user/userEditPage.do";
				form.method = "post"; 
				form.userSeq.value = userSeq;
				form.boardType.value = boardType;
				form.nowPage.value = ${nowPage};
				form.cntPerPage.value = ${cntPerPage};
				form.submit();
				
			}else{
			
				var yn = confirm("사용자를 삭제하시겠습니까?"); 
				if(yn){
					
					$.ajax({
			            url:"/user/deleteUser.do",
			            data:{
			            		userSeq:userSeq
			            	},
			            type:"post",
			            success:function(data){
			               	
			            	//window.location.href="/board/boardList.do?menuCode=${menuCode}&nowPage=${nowPage}&cntPerPage=${cntPerPage}";
			            	var form = document.userForm;
			    			
			    			form.action = "/user/userList.do";
			    			form.method = "post"; 
			    			form.nowPage.value = ${nowPage};
			    			form.cntPerPage.value = ${cntPerPage};
			    			form.submit();
			            	
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
					return;
				}
			}
		}
		
		function fnList() {
			//window.location.href= "/board/boardList.do?menuCode=${menuCode}&nowPage=${nowPage}&cntPerPage=${cntPerPage}";
			var form = document.userForm;
			
			form.action = "/user/userList.do";
			form.method = "post"; 
			form.nowPage.value = ${nowPage};
			form.cntPerPage.value = ${cntPerPage};
			form.submit();
		}
		
		function fnPwdChg(userSeq) {
			
			var url = "/user/userPwdChgPage.do?userSeq="+userSeq+"&menuCode=${menuCode}&nowPage=${nowPage}&cntPerPage=${cntPerPage}";
			var name = "pwdChgPage";
			var popupX = (document.body.offsetWidth / 2) - (600 / 2);
			var popupY= (window.screen.height / 2) - (300 / 2);
			
			var options = 'top='+popupY+', left='+popupX+', width=600, height=300, status=no, menubar=no, toolbar=no, resizable=no';
			
		    window.open(url, name, options);
			
		}
	</script>
</head>
<body>
<form id="userForm" name="userForm">
	<input type="hidden" name="userSeq" value="${detail.userSeq}">
	<input type="hidden" id="menuCode" name="menuCode" value="${menuCode }">
	<input type="hidden" name="nowPage" value="${nowPage}">
	<input type="hidden" name="cntPerPage" value="${cntPerPage}">
	<input type="hidden" name="boardType" value="${boardType}">
</form>

<div style="width:100%;height: 1077px">
	
	<!-- 사이드메뉴 -->
	<jsp:include page="/WEB-INF/views/leftMenu.jsp"></jsp:include>
	
	<div id="rightDv" style="width:88%;height: 1077px;float: left;background-color: ghostwhite;">
	
		<!-- 상단 -->
		<jsp:include page="/WEB-INF/views/top.jsp"></jsp:include>
		
		<div id="boardList" style="margin:5% auto;width:60%;height:779px">
			
			<div style="width:80%;margin:0 auto;">
	
				<h2 style="text-align: center;margin-top:20px;margin-bottom:20px;font-size: 30px">사용자 상세화면</h2>
				
				<table id="dtTable" border="1" style="width:80%;margin:0 auto;">
					<colgroup> 
						<col width="30%"/>
						<col width="70%"/>
					</colgroup>
					<tbody>
						<tr>
							<th>사용자ID</th>
							<td>${detail.userId }</td>
						</tr>
						<tr>
							<th>사용자명</th>
							<td>${detail.userName }</td>
						</tr>
						<tr>
							<th>과</th>
							<td>${detail.userClass }</td>
						</tr>
						<tr>
							<th>부서</th>
							<td>${detail.userDept }</td>
						</tr>
						<tr>
							<th>직책</th>
							<td>${detail.userPosition }</td>
						</tr>
						<tr>
							<th>사용자권한</th>
							<td>${detail.userAuth }</td>
						</tr>
						<tr>
							<th>생성자</th>
							<td>${detail.userWriter }</td>
						</tr>
						<tr>
							<th>생성일</th>
							<td>${detail.insDate }</td>
						</tr>
					</tbody>
				</table>
				<div style="width:90%;text-align: right;margin-top:5px;margin-right:15px">
					<c:if test="${infoCode == 'y' }">
						<button type="button" onclick="fnPwdChg(${detail.userSeq})" class="btn btn-outline-dark" style="font-size:13">비밀번호 변경</button>
					</c:if>
					<button type="button" onclick="fnEditPage('upt',${detail.userSeq})" class="btn btn-outline-dark" style="font-size:13">수정</button>
					<c:if test="${userInfo.userAuth != '사용자' }">
						<button type="button" onclick="fnEditPage('del',${detail.userSeq})" class="btn btn-outline-dark" style="font-size:13">삭제</button>
						<button type="button" onclick="fnList()" class="btn btn-outline-dark" style="font-size:13">목록</button>
					</c:if>
					
				</div>
			</div>
			
		</div>
		
		<!-- 하단 -->
		<jsp:include page="/WEB-INF/views/footer.jsp"></jsp:include>
		
	</div>
	
</div>

</body>
</html>
