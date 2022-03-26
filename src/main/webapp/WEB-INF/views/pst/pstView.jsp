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
				
		function fnEditPage(boardType,pstSeq){
			
			if(boardType == "upt"){
				
				//window.location.href="/board/boardEditPage.do?boardSeq="+boardSeq+"&boardType="+boardType+"&menuCode=${menuCode}&nowPage=${nowPage}&cntPerPage=${cntPerPage}";
				var form = document.boardForm;
				
				form.action = "/pst/pstEditPage.do";
				form.method = "post"; 
				form.pstSeq.value = pstSeq;
				form.boardType.value = boardType;
				form.nowPage.value = ${nowPage};
				form.cntPerPage.value = ${cntPerPage};
				form.submit();
				
			}else{
			
				var yn = confirm("처방전을 삭제하시겠습니까?"); 
				if(yn){
					
					$.ajax({
			            url:"/pst/pstEdit.do",
			            data:{
			            		pstSeq:pstSeq,
			            		boardType:boardType
			            	},
			            type:"post",
			            success:function(data){
			               	
			            	alert("처방전이 삭제되었습니다");
			            	
			            	//window.location.href="/board/boardList.do?menuCode=${menuCode}&nowPage=${nowPage}&cntPerPage=${cntPerPage}";
			            	var form = document.boardForm;
			    			
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
		}
				
		function fnList() {
			//window.location.href= "/board/boardList.do?menuCode=${menuCode}&nowPage=${nowPage}&cntPerPage=${cntPerPage}";
			var form = document.boardForm;
			
			form.action = "/pst/pstList.do";
			form.method = "post"; 
			form.nowPage.value = ${nowPage};
			form.cntPerPage.value = ${cntPerPage};
			form.submit();
		}
		
		function fnPrint() {
			
			var pstSeq = $("#pstSeq").val();
			var url = "/pst/pstPrintPage.do?pstSeq="+pstSeq;
			var name = "pstPrintPage";
			var popupX = (document.body.offsetWidth / 2) - (900 / 2);
			var popupY= (window.screen.height / 2) - (750 / 2);
			
			var options = 'top='+popupY+', left='+popupX+', width=900, height=750, status=no, menubar=no, toolbar=no, resizable=no';
			
		    window.open(url, name, options);
			
		}
	</script>
</head>
<body>
<form id="boardForm" name="boardForm">
	<input type="hidden" id="pstSeq" name="pstSeq" value="${detail.pstSeq}">
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
				<div id="printDv">
				<h2 style="text-align: center;margin-top:20px;margin-bottom:20px;font-size: 30px">처방전 상세화면</h2>
				
				<table id="dtTable" border="1" style="width:80%;margin:0 auto;">
					<colgroup> 
						<col width="25%"/>
						<col width="75%"/>
					</colgroup>
					<tbody>
						<tr>
							<th>처방제목</th>
							<td>${detail.pstTitle }</td>
						</tr>
						<tr>
							<th>처방의약품명칭</th>
							<td>${detail.pstDrugname }</td>
						</tr>
						<tr>
							<th>1회투여량</th>
							<td>${detail.pstVolume }</td>
						</tr>
						<tr>
							<th>1회투여횟수</th>
							<td>${detail.pstNumber }</td>
						</tr>
						<tr>
							<th>투약일수</th>
							<td>${detail.pstDays }</td>
						</tr>
						<tr>
							<th>용별</th>
							<td>${detail.pstYongbyeol }</td>
						</tr>
						<tr>
							<th>조제시참고사항</th>
							<td><textarea id="pstNote" name="pstNote" style="width:100%;height:100px" readonly="readonly">${detail.pstNote }</textarea></td>
						</tr>
						<tr>
							<th>환자명</th>
							<td>${detail.pstName }</td>
						</tr>
						<tr>
							<th>환자생년월일</th>
							<td>${detail.pstBirthdate }</td>
						</tr>
						<tr>
							<th>처방일</th>
							<td>${detail.insDate }</td>
						</tr>
						<tr>
							<th>처방의사</th>
							<td>${detail.pstWriter }</td>
						</tr>
					</tbody>
				</table>
				</div>
				<div style="width:90%;text-align: right;margin-top:5px;margin-right:15px">
					<c:if test="${userInfo.userAuth != '사용자' && userInfo.userName == detail.pstWriter }">
						<button type="button" onclick="fnEditPage('upt',${detail.pstSeq})" class="btn btn-outline-dark" style="font-size:13">수정</button>
						<button type="button" onclick="fnEditPage('del',${detail.pstSeq})" class="btn btn-outline-dark" style="font-size:13">삭제</button>
					</c:if>
					<button type="button" onclick="fnPrint()" class="btn btn-outline-dark" style="font-size:13">프린트</button>
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
