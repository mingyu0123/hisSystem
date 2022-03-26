<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
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
	
		var idChk = 0;
	
		$(document).ready(function() {
			startDate();
			$("#${menuCode}").addClass("menuActive");
			
			var boardType = $("#boardType").val();
			
			if(boardType == "upt"){
				
				var userClass = "${detail.userClass}";
				
				if(userClass == "외과"){
					userClass = "surgery";
				} else if(userClass == "내과"){
					userClass = "medicine";
				} else if(userClass == "기타"){
					userClass = "other";
				}
				
				$("#mainDept").val(userClass).prop("selected", true);
				
				fnCodeList(userClass);
				
			}else{
				fnCodeList("surgery");
			}
			
	    }); 
	
	
		function fnEdit(boardType){
			
			var userId = $("#userId").val();
			var userPassword = $("#userPassword").val();
			var userName = $("#userName").val();
			var userDept = $("#middleDept").val();
			var userPosition = $("#userPosition").val();
			var userAuth = $("#userAuth").val();
			
			
			if(userId == ""){
				alert("아이디를 입력하세요");
				return;
				
			}
			
			if(userPassword == ""){
				alert("비밀번호를 입력하세요");
				return;
				
			}
			
			if(userName == ""){
				alert("이름을 입력하세요");
				return;
				
			}
			
			if(userDept == ""){
				alert("부서를 입력하세요");
				return;
				
			}
			
			if(userPosition == ""){
				alert("직책을 입력하세요");
				return;
				
			}
			
			if(userAuth == ""){
				alert("권한을 입력하세요");
				return;
				
			}
			
			if(idChk < 1 && boardType == "ins"){
				alert("아이디를 확인하세요.");
				return;
			}
			
			if(boardType == "ins"){
				var yn = confirm("사용자를 등록하시겠습니까?"); 
			}else if(boardType == "upt"){
				var yn = confirm("사용자를 수정하시겠습니까?"); 
			}
			
			if(yn){
				
				var form = $('#userForm')[0]
			    var data = new FormData(form);
				
				$.ajax({
		            url:"/user/userEdit.do",
		            data:data,
		            type:"post",
		            enctype: 'multipart/form-data',
		            processData: false,
		            contentType: false,
		            success:function(data){
		               	
		            	//window.location.href="/board/boardList.do?menuCode=${menuCode}&nowPage=${nowPage}&cntPerPage=${cntPerPage}"
		            	var form = document.dataForm;
		    					            	
		    			if(userAuth != "사용자"){
		    				
		    				form.action = "/user/userList.do";
		    				form.method = "post"; 
		    				form.nowPage.value = ${nowPage};
		    				form.cntPerPage.value = ${cntPerPage};
		    				form.submit();
		    				
		    			}else{
		    								
		    				form.action = "/user/userView.do";
		    				form.method = "post"; 
		    				form.nowPage.value = ${nowPage};
		    				form.cntPerPage.value = ${cntPerPage};
		    				form.submit();
		    				
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
				
				
			}else{
				return;
			}
			
		}
		
		function fnList() {
			//window.location.href= "/board/boardList.do?menuCode=${menuCode}&nowPage=${nowPage}&cntPerPage=${cntPerPage}";
			var form = document.dataForm;
			var userAuth = $("#userAuth").val();
			
			if(userAuth != "사용자"){
				
				form.action = "/user/userList.do";
				form.method = "post"; 
				form.nowPage.value = ${nowPage};
				form.cntPerPage.value = ${cntPerPage};
				form.submit();
				
			}else{
								
				form.action = "/user/userView.do";
				form.method = "post"; 
				form.nowPage.value = ${nowPage};
				form.cntPerPage.value = ${cntPerPage};
				form.submit();
				
			}
			
			
		}
		
		function fnCodeList(codeUpper) {
			
			$.ajax({
	            url:"/code/codeType.do",
	            data:{
	            		codeType:'dept',
	            		codeUpper:codeUpper,
	            		codeCategory:'middle'
	            	},
	            type:"post",
	            dataType : "JSON",
	            success:function(data){
	               	
	            	//$("#userList").html(data);
	            	callbackCodeList(data.codeList);
	            	
	                
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
		
		function callbackCodeList(codeList) {
			
			$("#middleDept").empty();
			
			$.each(codeList,function(i,v){
				
				if("${detail.userDept}" == v.codeName){
					$("#middleDept").append("<option value='"+v.code+"'selected='selected'>"+v.codeName+"</option>");
				}else{
					$("#middleDept").append("<option value='"+v.code+"'>"+v.codeName+"</option>");
				}
				
				
			});
			
			
		}
		
		function fnIdChk() {
			
			var userId = $("#userId").val();
			
			$.ajax({
	            url:"/user/userIdChk.do",
	            data:{
	            		userId:userId
	            	},
	            type:"post",
	            success:function(data){
	               	
	            	if(data == "sucess"){
	            		
	            		$("#idChkMunnu").html("사용할수 없는 아이디입니다");
	            		idChk = 0;
	            		
	            	}else{
	            		$("#idChkMunnu").html("사용가능한 아이디입니다");
	            		idChk = 1;
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
	</script>
</head>
<body>
<form id="dataForm" name="dataForm">
	<input type="hidden" name="userSeq" value="${detail.userSeq}">
	<input type="hidden" id="menuCode" name="menuCode" value="${menuCode }">
	<input type="hidden" name="nowPage" value="${nowPage}">
	<input type="hidden" name="cntPerPage" value="${cntPerPage}">
	<input type="hidden" name="boardType" value="${boardType}">
	<input type="hidden" name="infoCode" value="y">
</form>
<div style="width:100%;height: 1077px">
	
	<!-- 사이드메뉴 -->
	<jsp:include page="/WEB-INF/views/leftMenu.jsp"></jsp:include>
	
	<div id="rightDv" style="width:88%;height: 1077px;float: left;background-color: ghostwhite;">
	
		<!-- 상단 -->
		<jsp:include page="/WEB-INF/views/top.jsp"></jsp:include>
		
		<div id="userList" style="margin:5% auto;width:60%;height:779px">
			
			<form id="userForm" name="userForm" method="post">
	
				<input type="hidden" id="userSeq" name="userSeq" value="${detail.userSeq }">
				<input type="hidden" id="boardType" name="boardType" value="${boardType }">
				<input type="hidden" id="userWriter" name="userWriter" value="${userInfo.userSeq }">
				<input type="hidden" id="userAuth" value="${userInfo.userAuth }">
				
				<c:if test="${boardType == 'ins' }">
					<h2 style="text-align: center;margin-top:20px;margin-bottom:20px;font-size: 30px">사용자 등록</h2>
				</c:if>	
				<c:if test="${boardType == 'upt' }">
					<h2 style="text-align: center;margin-top:20px;margin-bottom:20px;font-size: 30px">사용자 수정</h2>
				</c:if>	
				
				<table id="dtTable" border="1" style="width:60%;margin:0 auto">
					<colgroup> 
						<col width="25%"/>
						<col width="75%"/>
					</colgroup>
					<tbody>
						<tr>
							<th>아이디</th>
							<td>
								<input id="userId" name="userId" style="width:40%;height: 30px;font-size:15px;display: initial;" class="form-control mr-sm-2" onkeyup="fnIdChk()" value="${detail.userId }" <c:if test="${boardType == 'upt' }">readonly="readonly"</c:if>>
								<span id="idChkMunnu" style="font-size:13px;"></span>
							</td>
						</tr>
						<c:if test="${boardType == 'ins' }">
							<tr>
								<th>비밀번호</th>
								<td><input id="userPassword" name="userPassword" type="password" style="height: 30px;font-size:15px" class="form-control mr-sm-2" value=""></td>
							</tr>
						</c:if>
						<tr>
							<th>이름</th>
							<td><input id="userName" name="userName" style="height: 30px;font-size:15px" class="form-control mr-sm-2" value="${detail.userName }"></td>
						</tr>
						<tr>
							<th>부서</th>
							<td>
								<select id="mainDept" name="mainDept" class="form-control" style="width:40%;font-size: 13px;display:initial;" onchange="fnCodeList(this.value)">
									<option value="surgery">외과</option>
									<option value="medicine">내과</option>
									<option value="other">기타</option>
								</select>
								<select id="middleDept" name="middleDept" class="form-control" style="width:40%;font-size: 13px;display:initial;"></select>
								
							</td>
						</tr>
						<tr>
							<th>직책</th>
							<td>
								<select id="userPosition" name="userPosition" class="form-control" style="width:40%;font-size: 13px">
									<c:forEach items="${postionCodeList }" var="code">
										<option value="${code.code }" <c:if test="${detail.userPosition == code.codeName }">selected="selected"</c:if>>${code.codeName }</option>
										
									</c:forEach>
								</select>
							</td>
						</tr>
						<c:if test="${userInfo.userAuth != '사용자' }">
							<tr>
								<th>권한</th>
								<td>
									<select id="userAuth" name="userAuth" class="form-control" style="width:40%;font-size: 13px">
										<c:forEach items="${authCodeList }" var="code">
											<option value="${code.code }" <c:if test="${detail.userAuth == code.codeName }">selected="selected"</c:if>>${code.codeName }</option>
										</c:forEach>
									</select>
								</td>
							</tr>
						</c:if>
						
					</tbody>
				</table>
			</form>
				<div style="text-align: center;margin-top:5px;margin-right:15px">
					<c:if test="${boardType == 'ins' }">
						<button type="button" onclick="fnEdit('ins')" class="btn btn-outline-dark" style="font-size:15px">등록</button>
					</c:if>	
					<c:if test="${boardType == 'upt' }">
						<button type="button" onclick="fnEdit('upt')" class="btn btn-outline-dark" style="font-size:15px">수정</button>
					</c:if>	
					<button type="button" onclick="fnList()" class="btn btn-outline-dark" style="font-size:15px">취소</button>
				</div>
			
		</div>
		
		<!-- 하단 -->
		<jsp:include page="/WEB-INF/views/footer.jsp"></jsp:include>
		
	</div>
	
</div>
</body>
</html>