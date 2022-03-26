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
		.trCssColor{
			background-color: rgba(0,0,0,.075);
		}
	</style>
	<script type="text/javascript">
			
		$(document).ready(function () { 
	        
			$.ajax({
	            url:"/ist/istListPopPage.do",
	            data:{
		            	nowPage : ${nowPage},
	            		cntPerPage : ${cntPerPage},
	            		userSeq : ${userSeq}
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
						
	    }); 
		
		function fnDetail(istSeq,istTitle,istRecipient,istStatus,istContent,insDateDetail){
			
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
				$("#detailInsDateDetail").html(insDateDetail);
				$("#detailIstContent").html(istContent);
											
			}
			
			$.ajax({
	            url:"/ist/selectStatus.do",
	            data:{
	            	istSeq:istSeq
	            	},
	            type:"post",
	            dataType : "JSON",
	            success:function(data){
	               	   
	            	if(data.result == "N"){
	            		updateStatus(istSeq);
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
		
		function updateStatus(istSeq) {
			$.ajax({
	            url:"/ist/updateStatus.do",
	            data:{
	            	istSeq:istSeq
	            	},
	            type:"post",
	            dataType : "JSON",
	            success:function(data){
	               		                
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
	            url:"/ist/istListPopPage.do",
	            data:{
	            		nowPage : nowPage,
	            		cntPerPage : cntPerPage,
	            		userSeq : ${userSeq}
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
		
		function fnSearch(){
			
			var searchType = $("#searchType").val();
			var searchValue = $("#searchValue").val();
				
			$.ajax({
	            url:"/ist/istListPopPage.do",
	            data:{
	            		searchType:searchType,
	            		searchValue:searchValue,
	            		userSeq : ${userSeq}
	            	},
	            type:"get",
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
		
		
		function fnClose(){
			window.close();
		}
		
		
		
	</script>
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
</head>
<body style="background-color: ghostwhite;">

<div>
	
	<div id="istList" style="margin-top:2%;width:50%;float: left;padding:20px">
			
	</div>
	<div id="istListDetail" style="margin-top:2%;width:50%;float: left;padding:20px">
		<h2 style="text-align: center;margin-bottom:20px;font-weight: bold;font-size:25px">지시내용 상세</h2>
				
		<table id="dtTable" border="1" style="width:95%;margin:30 auto;">
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
					<th>발신인</th>
					<td id="detailIstRecipient"></td>
				</tr>
				<tr>
					<th>발신일</th>
					<td id="detailInsDateDetail"></td>
				</tr>
				<tr>
					<th>내용</th>
					<td colspan="3">
						<textarea id="detailIstContent" style="width:100%;height: 250px" readonly="readonly"></textarea>
					</td>
				</tr>
			</tbody>
		</table>
	</div>
	<div style="width:100%;text-align: center;float: left">
		<button type="button" class="btn btn-outline-dark" onclick="fnClose()" style="font-size:13">닫기</button>
	</div>
</div>


</body>
</html>