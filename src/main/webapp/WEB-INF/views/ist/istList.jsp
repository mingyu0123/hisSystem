<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page session="false" %>
<html>
<head>
	<title>Home</title>
	
	<script src="/resources/js/jquery-3.6.0.min.js"></script>
	
	
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
	<link href="//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap-glyphicons.css" rel="stylesheet">
	<link rel="stylesheet" href="/resources/css/bootstrap-theme.min.css">
	
	<script src="/resources/js/bootstrap.js"></script>
	<script src="/resources/js/main.js"></script>
	
	<link href="/resources/css/main.css"  rel="stylesheet" type="text/css" /> 
	
	<script type="text/javascript">
		
	 	$(document).ready(function () { 
	 		
	 		fnList();
	 		
	 		startDate();
	 		$("#${menuCode}").addClass("menuActive");
	    }); 
		
	 	function fnList(){
	 		
	 		$.ajax({
	            url:"/ist/istListPage.do",
	            data:{
		            	nowPage : ${nowPage},
	            		cntPerPage : ${cntPerPage},
	            		istWriter : ${userInfo.userSeq}
	            	},
	            type:"post",
	            success:function(data){
	               	
	            	$("#istList").html(data);
	            	
	                
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
	 	
		function fnPage(nowPage,cntPerPage) {
			
			$.ajax({
	            url:"/ist/istListPage.do",
	            data:{
	            		nowPage : nowPage,
	            		cntPerPage : cntPerPage,
	            		istWriter : ${userInfo.userSeq}
	            	},
	            type:"post",
	            success:function(data){
	               	
	            	$("#istList").html(data);
	            	
	                
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
		
		function fnDetail(istSeq,istTitle,istRecipient,istStatus,istContent,istStatusday,insDateDetail){
			
			var trClass = $("#tr"+istSeq).attr('class');
			var trSize = $("#istTable .trCssColor").length;
			
			if(trSize > 0){
				$("#istTable tr").removeClass("trCssColor");
				$("#istDetail").hide();
				
			}else{
				$("#tr"+istSeq).removeClass("trCssColor");
				$("#istDetail").hide();
			}
			
			if(trClass != "trCssColor"){

				$("#tr"+istSeq).addClass("trCssColor");
				
				$("#istDetail").show();
				
				$("#detailIstTitle").html(istTitle);
				$("#detailIstRecipient").html(istRecipient);
				
				if(istStatus == "Y"){
					$("#detailIstStatus").html("확인");
				} else {
					$("#detailIstStatus").html("미확인");
				}
				
				$("#detailIstContent").html(istContent);
				$("#detailIstStatusday").html(istStatusday);
				$("#detailInsDateDetail").html(insDateDetail);
											
			}
			
			
		}
		
		function fnSearch(){
			
			var searchType = $("#searchType").val();
			var searchValue = $("#searchValue").val();
	
			$.ajax({
	            url:"/ist/istListPage.do",
	            data:{
	            		searchType:searchType,
	            		searchValue:searchValue,
	            		nowPage : ${nowPage},
	            		cntPerPage : ${cntPerPage},
	            		istWriter : ${userInfo.userSeq}
	            	},
	            type:"post",
	            success:function(data){
	               	
	            	$("#istList").html(data);
	            	
	                
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
	 	
	 	function fnUserSearch() {
	 		
	 		var url = "/user/userSearchPage.do?nowPage=1&cntPerPage=10";
			var name = "userSearchPage";
			var popupX = (document.body.offsetWidth / 2) - (750 / 2);
			var popupY= (window.screen.height / 2) - (600 / 2);
			
			var options = 'top='+popupY+', left='+popupX+', width=750, height=600, status=no, menubar=no, toolbar=no, resizable=no';
			
		    window.open(url, name, options);
	 		
	 	}
	 	
	 	function fnSend() {
	 		
			var istTitle = $("#istTitle").val();
			var userName = $("#userName").val();
			var istContent = $("#istContent").val();
			
			if(istTitle == ""){
				alert("제목을 입력하세요");
				return;
				
			}
			
			if(userName == ""){
				alert("받는이를 입력하세요");
				return;
				
			}
			
			if(istContent == ""){
				alert("내용을 입력하세요");
				return;
				
			}
	 		
	 		var yn = confirm("지시내용을 전송 하시겠습니까?"); 
	 		
			if(yn){
				
				var form = $('#istForm')[0]
			    var data = new FormData(form);
								
				$.ajax({
		            url:"/ist/istSend.do",
		            data:data,
		            type:"post",
		            enctype: 'multipart/form-data',
		            processData: false,
		            contentType: false,
		            success:function(data){
		               	
		            	fnClear();
		            	fnList();
		                
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
	 	
	 	function fnClear() {
	 		
	 		$("#istTitle").val("");
	 		$("#istContent").val("");
	 		$("#userSeq").val("");
	 		$("#userName").val("");
	 		
	 	}
	 	
	</script>
	<style type="text/css">
		
		#dtTable tr th{
			padding: 10px;
		}
		
		#dtTable tr td{
			padding: 5px;
		}
		
		.trCssColor{
			background-color: rgba(0,0,0,.075);
		}
	</style>
</head>
<body>

<form id="dataForm" name="dataForm">
	<input type="hidden" id="boardSeq" name="boardSeq" value="">
	<input type="hidden" id="menuCode" name="menuCode" value="">
	<input type="hidden" id="nowPage" name="nowPage" value="">
	<input type="hidden" id="cntPerPage" name="cntPerPage" value="">
	<input type="hidden" id="boardType" name="boardType" value="">
	
</form>

<div style="width:100%;height: 1077px">
	
	<!-- 사이드메뉴 -->
	<jsp:include page="/WEB-INF/views/leftMenu.jsp"></jsp:include>
	
	<div id="rightDv" style="width:88%;height: 1077px;float: left;background-color: ghostwhite;">
	
		<!-- 상단 -->
		<jsp:include page="/WEB-INF/views/top.jsp"></jsp:include>
		
		<div>
			
			<div style="width:50%;height:967px;float:left;">
				<div id="istList" style="margin:0 auto;margin-top:5%;width:80%">
					
				</div>
				<div id="istDetail" style="display: none;">
					<h2 style="text-align: center;margin-top:15px;margin-bottom:20px;font-weight: bold;font-size:25px">지시내용 상세</h2>
				
					<table id="dtTable" border="1" style="width:80%;margin:0 auto;">
						<colgroup> 
							<col width="20%"/>
							<col width="80%"/> 
						</colgroup>
						<tbody>
							<tr>
								<th>제목</th>
								<td id="detailIstTitle"></td>
							</tr>
							<tr>
								<th>수신인</th>
								<td id="detailIstRecipient"></td>
							</tr>
							<tr>
								<th>수신여부</th>
								<td id="detailIstStatus"></td>
							</tr>
							<tr>
								<th>수신일</th>
								<td id="detailIstStatusday"></td>
							</tr>
							<tr>
								<th>내용</th>
								<td colspan="3">
									<textarea id="detailIstContent" style="width:100%;height: 100px" readonly="readonly"></textarea>
								</td>
							</tr>
							<tr>
								<th>발신일</th>
								<td id="detailInsDateDetail"></td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
			<div style="width:50%;height:967px;float:left;">
				<div style="width:90%;margin:5% auto">
					<h2 style="text-align: center;font-weight: bold;font-size:25px">지시내용 입력</h2>
						<form id="istForm" name="istForm" method="post" enctype="multipart/form-data">
							<input type="hidden" id="istWriter" name="istWriter" value="${userInfo.userSeq }">		
							<table id="dtTable" border="1" style="width:90%;margin:30 auto">
								<colgroup> 
									<col width="20%"/>
									<col width="80%"/>
								</colgroup>
								<tbody>
									<tr>
										<th>제목</th>
										<td><input id="istTitle" name="istTitle" style="height: 30px;font-size:15px" class="form-control mr-sm-2" value=""></td>
									</tr>
									<tr>
										<th>받는이</th>
										<td>
											<input id="userName" name="userName" readonly="readonly" style="width:85%;height: 30px;font-size:15px;display: initial;" class="form-control mr-sm-2" value="">
											<input type="hidden" id="userSeq" name="userSeq">
											<button type="button" onclick="fnUserSearch()" class="btn btn-outline-dark" style="font-size:15px">유저찾기</button>
										</td>
									</tr>
									<tr>
										<th>내용</th>
										<td><textarea id="istContent" name="istContent" style="width:100%;height:600px"></textarea></td>
									</tr>
								</tbody>
							</table>
						</form>
						<div style="text-align: center;margin-top:5px;margin-right:15px">
							<button type="button" onclick="fnSend()" class="btn btn-outline-dark" style="font-size:15px">전송</button>
							<button type="button" onclick="fnClear()" class="btn btn-outline-dark" style="font-size:15px">초기화</button>
						</div>
				</div>
			</div>
			
		</div>
		
		<!-- 하단 -->
		<jsp:include page="/WEB-INF/views/footer.jsp"></jsp:include>
		
	</div>
	
</div>

</body>
</html>

