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
		
		var tdArr = new Array();
		var tdArr2 = new Array();
	
		$(document).ready(function () { 
	        
			$.ajax({
	            url:"/user/userSearchListPage.do",
	            data:{
		            	nowPage : ${nowPage},
	            		cntPerPage : ${cntPerPage},
	            		type : $("#type").val()
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
						
			var searchType = $("#searchType").val();
			
			fnSearchType(searchType);
			
	    }); 

		function fnTrUserSeq(userSeq,userName){
				
			var trClass = $("#tr"+userSeq).attr('class');
			var arrCnt = tdArr.length;
			var arrCnt2 = tdArr2.length;
			
			if(trClass == "trCssColor"){
				
				$("#tr"+userSeq).removeClass("trCssColor");
				
				for(var i=0;i<arrCnt;i++){
					if(tdArr[i] == userSeq){
						tdArr.splice(i,1);
						i--;
					}
				}
				
				for(var i=0;i<arrCnt2;i++){
					if(tdArr2[i] == userName){
						tdArr2.splice(i,1);
						i--;
					}
				}
				
			}else{
				
				$("#tr"+userSeq).addClass("trCssColor");
				tdArr.push(userSeq);
				tdArr2.push(userName);
			}
			
			 
		}
		
		function fnSelect(){
			
			var type = $("#type").val();
			
			if(type == 'main'){
				opener.document.getElementById("rcdMaindoctor").value = tdArr.toString();
				opener.document.getElementById("rcdMaindoctorNm").value = tdArr2.toString();
			}else if(type == 'hope'){
				opener.document.getElementById("rcdHopedoctor").value = tdArr.toString();
				opener.document.getElementById("rcdHopedoctorNm").value = tdArr2.toString();
			}else if(type == 'req'){
				opener.document.getElementById("rcdReqdoctor").value = tdArr.toString();
				opener.document.getElementById("rcdReqdoctorNm").value = tdArr2.toString();
			}else{
				opener.document.getElementById("userSeq").value = tdArr.toString();
				opener.document.getElementById("userName").value = tdArr2.toString();
			}
			
			
			
			window.close();
			
		}
		
		function fnPage(nowPage,cntPerPage) {
			
			$.ajax({
	            url:"/user/userSearchListPage.do",
	            data:{
	            		nowPage : nowPage,
	            		cntPerPage : cntPerPage,
	            		type : $("#type").val()
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
	            url:"/user/userSearchListPage.do",
	            data:{
	            		searchType:searchType,
	            		searchValue:searchValue,
	            		classVal:classVal,
	            		type : $("#type").val()
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
		
		function fnClose(){
			window.close();
		}
		
		
		
	</script>
</head>
<body style="background-color: ghostwhite;">
<input type="hidden" id="type" name="type" value="${type }">
<div>
	
	<div id="userList" style="margin:5% auto;width:98%;">
			
	</div>
	
</div>


</body>
</html>