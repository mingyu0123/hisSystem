<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
	
	<style type="text/css">
		
	</style>
	<script type="text/javascript">
		$(document).ready(function () { 
	        
			$.ajax({
	            url:"/user/userListPage.do",
	            data:{
		            	nowPage : ${nowPage},
	            		cntPerPage : ${cntPerPage}
	            	},
	            type:"post",
	            success:function(data){
	               	
	            	$("#userList").html(data);
	            	
	                
	            },
	            error:function(jqxhr, textStatus, errorThrown){
	                console.log("ajax 처리 실패");
	                
	                // 에러 로그
	                console.log(jqxhr);
	                console.log(textStatus);
	                console.log(errorThrown);
	            }
	        });
			
			startDate();
			
			$("#${menuCode}").addClass("menuActive");
			
			var searchType = $("#searchType").val();
			
			fnSearchType(searchType);
			
	    }); 

		function fnEditPage(boardType,boardSeq) {
			
			//window.location.href="/board/boardEditPage.do?boardSeq="+boardSeq+"&boardType="+boardType+"&menuCode=${menuCode}";
			var form = document.dataForm;
			
			form.action = "/user/userEditPage.do";
			form.method = "post"; 
			form.userSeq.value = userSeq;
			form.boardType.value = boardType;
			form.nowPage.value = ${nowPage};
			form.cntPerPage.value = ${cntPerPage};
			form.submit();			
		}
		
		function fnPage(nowPage,cntPerPage) {
			
			$.ajax({
	            url:"/user/userListPage.do",
	            data:{
	            		nowPage : nowPage,
	            		cntPerPage : cntPerPage
	            	},
	            type:"post",
	            success:function(data){
	               	
	            	$("#userList").html(data);
	            	
	                
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
		
		function fnDetail(userSeq,nowPage,cntPerPage){
			
			//window.location.href="/board/boardView.do?boardSeq="+boardSeq+"&menuCode=${menuCode}&nowPage="+nowPage+"&cntPerPage="+cntPerPage;
			var form = document.dataForm;
			
			form.action = "/user/userView.do";
			form.method = "post"; 
			form.userSeq.value = userSeq;
			form.nowPage.value = nowPage;
			form.cntPerPage.value = cntPerPage;
			form.submit();
		}
		
		function fnSearch(){
			
			var searchType = $("#searchType").val();
			var searchValue = "";
			var classVal = "";
			
			if(searchType == "userClass"){
				
				searchValue = $("#mainDept").val();
				
			}else if(searchType == "userDept"){
				
				searchValue = $("#middleDept").val();
				classVal = $("#mainDept").val();
				
			}else if(searchType == "userPosition"){
				
				searchValue = $("#userPosition").val();
				
			}else{
				
				searchValue = $("#searchValue").val();
			}
				
			$.ajax({
	            url:"/user/userListPage.do",
	            data:{
	            		searchType:searchType,
	            		searchValue:searchValue,
	            		classVal:classVal
	            	},
	            type:"get",
	            success:function(data){
	               	
	            	$("#userList").html(data);
	            	
	                
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
		
		function fnSearchType(searchVal){
			
			if(searchVal == "userClass"){
				
				$("#searchValue").hide();
				$("#mainDept").show();
				$("#middleDept").hide();
				$("#userPosition").hide();
				
				$("#mainDept").attr("style","width:100px;font-size: 15px;display:initial");
				
			}else if(searchVal == "userDept"){
				
				$("#searchValue").hide();
				$("#mainDept").show();
				$("#middleDept").show();
				$("#userPosition").hide();
				
				$("#mainDept").attr("style","width:100px;font-size: 15px;display:initial");
				$("#middleDept").attr("style","width:130px;font-size: 15px;display:initial");
				
				//fnCodeList("surgery");
				
			}else if(searchVal == "userPosition"){
				
				$("#searchValue").hide();
				$("#mainDept").hide();
				$("#middleDept").hide();
				$("#userPosition").show();
				
				$("#userPosition").attr("style","width:130px;font-size: 15px;display:initial");
				
			}else{
				
				$("#searchValue").show();
				$("#mainDept").hide();
				$("#middleDept").hide();
				$("#userPosition").hide();
				
				$("#searchValue").attr("style","width:130px;display: initial;font-size: 15");
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
	</script>
</head>
<body>

<form id="dataForm" name="dataForm">
	<input type="hidden" id="userSeq" name="userSeq" value="">
	<input type="hidden" id="menuCode" name="menuCode" value="${menuCode }">
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
		
		<div id="userList" style="margin:5% auto;width:60%;height:779px">
			
		</div>
		
		<!-- 하단 -->
		<jsp:include page="/WEB-INF/views/footer.jsp"></jsp:include>
		
	</div>
	
</div>


</body>
</html>