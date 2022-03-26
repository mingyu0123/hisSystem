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
	
		$(document).ready(function() {
			startDate();
			$("#${menuCode}").addClass("menuActive");
	    }); 
	
	
		function fnEdit(boardType){
			
			var pstSeq = $("#pstSeq").val();
			var pstTitle = $("#pstTitle").val();
			var pstDrugname = $("#pstDrugname").val();
			var pstVolume = $("#pstVolume").val();
			var pstNumber = $("#pstNumber").val();
			var pstDays = $("#pstDays").val();
			var pstYongbyeol = $("#pstYongbyeol").val();
			var pstNote = $("#pstNote").val();
			var pstName = $("#pstName").val();
			var pstBirthdate = $("#pstBirthdate").val();
			
			if(pstTitle == ""){
				alert("제목을 입력하세요");
				return;
				
			}
			
			if(pstDrugname == ""){
				alert("약품명칭을 입력하세요");
				return;
				
			}
			
			if(pstVolume == ""){
				alert("1회투여량를 입력하세요");
				return;
				
			}
			
			if(pstNumber == ""){
				alert("1회투여횟수를 입력하세요");
				return;
				
			}
			
			if(pstDays == ""){
				alert("투약일수를 입력하세요");
				return;
				
			}
			
			if(pstYongbyeol == ""){
				alert("용별을 입력하세요");
				return;
				
			}
			
			if(pstName == ""){
				alert("환자명을 입력하세요");
				return;
				
			}
			
			if(pstBirthdate == ""){
				alert("환자생년월일을 입력하세요");
				return;
				
			}
			
			if(boardType == "ins"){
				var yn = confirm("처방전을 등록하시겠습니까?"); 
			}else if(boardType == "upt"){
				var yn = confirm("처방전을 수정하시겠습니까?"); 
			}
			
			if(yn){
				
				var form = $('#pstForm')[0]
			    var data = new FormData(form);
								
				$.ajax({
		            url:"/pst/pstEdit.do",
		            data:data,
		            type:"post",
		            enctype: 'multipart/form-data',
		            processData: false,
		            contentType: false,
		            success:function(data){
		               	
		            	//window.location.href="/board/boardList.do?menuCode=${menuCode}&nowPage=${nowPage}&cntPerPage=${cntPerPage}"
		            	var form = document.dataForm;
		    			
		    			form.action = "/pst/pstList.do";
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
		
		function fnList() {
			//window.location.href= "/board/boardList.do?menuCode=${menuCode}&nowPage=${nowPage}&cntPerPage=${cntPerPage}";
			var form = document.dataForm;
			
			form.action = "/pst/pstList.do";
			form.method = "post"; 
			form.nowPage.value = ${nowPage};
			form.cntPerPage.value = ${cntPerPage};
			form.submit();
		}
		
		function fnNumOnly(){
			
			if((event.keyCode > 48 && event.keyCode < 57 ) 
			      || event.keyCode == 8 //backspace
			      || event.keyCode == 37 || event.keyCode == 39 //방향키 →, ←
			      || event.keyCode == 46 //delete키
			      || event.keyCode == 39){
			   }else{
			   event.returnValue=false;
			   }
			
		}
	</script>
</head>
<body style="font-size:15px">
<form id="dataForm" name="dataForm">
	<input type="hidden" name="pstSeq" value="${detail.pstSeq}">
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
		
		<div id="pstList" style="margin:5% auto;width:60%;height:779px">
			
			<form id="pstForm" name="pstForm" method="post" enctype="multipart/form-data">
	
				<input type="hidden" id="pstSeq" name="pstSeq" value="${detail.pstSeq }">
				<input type="hidden" id="boardType" name="boardType" value="${boardType }">
				<input type="hidden" id="pstWriter" name="pstWriter" value="${userInfo.userSeq }">
				
				<c:if test="${boardType == 'ins' }">
					<h2 style="text-align: center;margin-top:20px;margin-bottom:20px;font-size: 30px">처방전 등록</h2>
				</c:if>	
				<c:if test="${boardType == 'upt' }">
					<h2 style="text-align: center;margin-top:20px;margin-bottom:20px;font-size: 30px">처방전 수정</h2>
				</c:if>	
				
				<table id="dtTable" border="1" style="width:60%;margin:0 auto">
					<colgroup> 
						<col width="25%"/>
						<col width="75%"/>
					</colgroup>
					<tbody>
						<tr>
							<th>처방제목</th>
							<td><input id="pstTitle" name="pstTitle" style="height: 30px;font-size:15px" class="form-control mr-sm-2" value="${detail.pstTitle }"></td>
						</tr>
						<tr>
							<th>처방의약품명칭</th>
							<td><input id="pstDrugname" name="pstDrugname" style="height: 30px;font-size:15px" class="form-control mr-sm-2" value="${detail.pstDrugname }"></td>
						</tr>
						<tr>
							<th>1회투여량</th>
							<td><input id="pstVolume" name="pstVolume" style="height: 30px;font-size:15px" class="form-control mr-sm-2" value="${detail.pstVolume }" onKeyup="this.value=this.value.replace(/[^.0-9]/g,'');"></td>
						</tr>
						<tr>
							<th>1회투여횟수</th>
							<td><input id="pstNumber" name="pstNumber" style="height: 30px;font-size:15px" class="form-control mr-sm-2" value="${detail.pstNumber }" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');"></td>
						</tr>
						<tr>
							<th>투약일수</th>
							<td><input id="pstDays" name="pstDays" style="height: 30px;font-size:15px" class="form-control mr-sm-2" value="${detail.pstDays }" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');"></td>
						</tr>
						<tr>
							<th>용별</th>
							<td><input id="pstYongbyeol" name="pstYongbyeol" style="height: 30px;font-size:15px" class="form-control mr-sm-2" value="${detail.pstYongbyeol }"></td>
						</tr>
						<tr>
							<th>조제시참고사항</th>
							<td><textarea id="pstNote" name="pstNote" style="width:100%;height:100px">${detail.pstNote }</textarea></td>
						</tr>
						<tr>
							<th>환자명</th>
							<td><input id="pstName" name="pstName" style="height: 30px;font-size:15px" class="form-control mr-sm-2" value="${detail.pstName }"></td>
						</tr>
						<tr>
							<th>환자생년월일</th>
							<td><input type="text" id="pstBirthdate" name="pstBirthdate" style="height: 30px;font-size:15px" class="form-control mr-sm-2" value="${detail.pstBirthdate }" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');"></td>
						</tr>
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