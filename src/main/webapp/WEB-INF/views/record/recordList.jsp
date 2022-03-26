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
	            url:"/record/recordListPage.do",
	            data:{
		            	nowPage : ${nowPage},
	            		cntPerPage : ${cntPerPage}
	            	},
	            type:"post",
	            success:function(data){
	               	
	            	$("#recordList").html(data);
	            	
	                
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
			
	    }); 

		function fnEditPage(boardType,rcdSeq) {
			
			//window.location.href="/board/boardEditPage.do?boardSeq="+boardSeq+"&boardType="+boardType+"&menuCode=${menuCode}";
			var form = document.dataForm;
			
			form.action = "/record/recordEditPage.do";
			form.method = "post"; 
			form.rcdSeq.value = rcdSeq;
			form.boardType.value = boardType;
			form.nowPage.value = ${nowPage};
			form.cntPerPage.value = ${cntPerPage};
			form.submit();			
		}
		
		function fnPage(nowPage,cntPerPage) {
			
			$.ajax({
	            url:"/record/recordListPage.do",
	            data:{
	            		nowPage : nowPage,
	            		cntPerPage : cntPerPage
	            	},
	            type:"post",
	            success:function(data){
	               	
	            	$("#recordList").html(data);
	            	
	                
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
		
		function fnDetail(rcdSeq,nowPage,cntPerPage){
			
			//window.location.href="/board/boardView.do?boardSeq="+boardSeq+"&menuCode=${menuCode}&nowPage="+nowPage+"&cntPerPage="+cntPerPage;
			var form = document.dataForm;
			
			form.action = "/record/recordView.do";
			form.method = "post"; 
			form.rcdSeq.value = rcdSeq;
			form.nowPage.value = nowPage;
			form.cntPerPage.value = cntPerPage;
			form.submit();
		}
		
		function fnSearch(){
			
			var searchType = $("#searchType").val();
			var searchValue = $("#searchValue").val();
	
			$.ajax({
	            url:"/record/recordListPage.do",
	            data:{
	            		searchType:searchType,
	            		searchValue:searchValue
	            	},
	            type:"post",
	            success:function(data){
	               	
	            	$("#recordList").html(data);
	            	
	                
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
	<input type="hidden" id="rcdSeq" name="rcdSeq" value="">
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
		
		<div id="recordList" style="margin:5% auto;width:60%;height:779px">
			
		</div>
		
		<!-- 하단 -->
		<jsp:include page="/WEB-INF/views/footer.jsp"></jsp:include>
		
	</div>
	
</div>


</body>
</html>