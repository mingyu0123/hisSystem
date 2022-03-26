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
				
		function fnEditPage(boardType,rcdSeq){
			
			if(boardType == "upt"){
				
				//window.location.href="/board/boardEditPage.do?boardSeq="+boardSeq+"&boardType="+boardType+"&menuCode=${menuCode}&nowPage=${nowPage}&cntPerPage=${cntPerPage}";
				var form = document.recordForm;
				
				form.action = "/record/recordEditPage.do";
				form.method = "post"; 
				form.rcdSeq.value = rcdSeq;
				form.boardType.value = boardType;
				form.nowPage.value = ${nowPage};
				form.cntPerPage.value = ${cntPerPage};
				form.submit();
				
			}else{
			
				var yn = confirm("진료기록을 삭제하시겠습니까?"); 
				if(yn){
					
					$.ajax({
			            url:"/record/recordEdit.do",
			            data:{
			            		rcdSeq:rcdSeq,
			            		boardType:boardType
			            	},
			            type:"post",
			            success:function(data){
			               	
			            	alert("진료기록이 삭제되었습니다");
			            	
			            	//window.location.href="/board/boardList.do?menuCode=${menuCode}&nowPage=${nowPage}&cntPerPage=${cntPerPage}";
			            	var form = document.recordForm;
			    			
			    			form.action = "/record/recordList.do";
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
			var form = document.recordForm;
			
			form.action = "/record/recordList.do";
			form.method = "post"; 
			form.nowPage.value = ${nowPage};
			form.cntPerPage.value = ${cntPerPage};
			form.submit();
		}
		
	</script>
</head>
<body>
<form id="recordForm" name="recordForm">
	<input type="hidden" id="rcdSeq" name="rcdSeq" value="${detail.rcdSeq}">
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
			
			<div style="width:80%;margin:0 auto;">
				
				<h2 style="text-align: center;margin-top:20px;margin-bottom:20px;font-size: 30px">진료기록 상세화면</h2>
				
				<table id="dtTable" border="1" style="width:80%;margin:0 auto;">
					<colgroup> 
						<col width="25%"/>
						<col width="75%"/>
					</colgroup>
					<tbody>
						<tr>
							<th>회진</th>
							<td>${detail.rcdRounds }</td>
						</tr>
						<tr>
							<th>의뢰일</th>
							<td>${detail.rcdReqdate }</td>
						</tr>
						<tr>
							<th>구분</th>
							<td>${detail.rcdDivision }</td>
						</tr>
						<tr>
							<th>등록번호</th>
							<td>${detail.rcdNumber }</td>
						</tr>
						<tr>
							<th>환자명</th>
							<td>${detail.rcdPtename }</td>
						</tr>
						<tr>
							<th>S/A</th>
							<td>${detail.rcdGender }/${detail.rcdAge }</td>
						</tr>
						<tr>
							<th>주치의</th>
							<td>${detail.rcdMaindoctor }</td>
						</tr>
						<tr>
							<th>희망과</th>
							<td>${detail.rcdHopeclass }</td>
						</tr>
						<tr>
							<th>희망의</th>
							<td>${detail.rcdHopedoctor }</td>
						</tr>
						<tr>
							<th>실시</th>
							<td>${detail.rcdPractice }</td>
						</tr>
						<tr>
							<th>의뢰과</th>
							<td>${detail.rcdReqclass }</td>
						</tr>
						<tr>
							<th>의뢰의</th>
							<td>${detail.rcdReqdoctor }</td>
						</tr>
					</tbody>
				</table>
				
				<div style="width:90%;text-align: right;margin-top:5px;margin-right:15px">
					<c:if test="${userInfo.userAuth != '사용자' }">
						<button type="button" onclick="fnEditPage('upt',${detail.rcdSeq})" class="btn btn-outline-dark" style="font-size:13">수정</button>
						<button type="button" onclick="fnEditPage('del',${detail.rcdSeq})" class="btn btn-outline-dark" style="font-size:13">삭제</button>
					</c:if>
					<button type="button" onclick="fnList()" class="btn btn-outline-dark" style="font-size:13">목록</button>
				</div>
			</div>
			
		</div>
		
		<!-- 하단 -->
		<jsp:include page="/WEB-INF/views/footer.jsp"></jsp:include>
		
	</div>
	
</div>

</body>
</html>
