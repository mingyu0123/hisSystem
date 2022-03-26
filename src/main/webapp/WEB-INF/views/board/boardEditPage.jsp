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
			
			var boardSeq = $("#boardSeq").val();
			var boardTitle = $("#boardTitle").val();
			var boardContent = $("#boardContent").val();
			var boardWriter = $("#boardWriter").val();
			
			if(boardTitle == ""){
				alert("제목을 입력하세요");
				return;
				
			}
			
			if(boardContent == ""){
				alert("내용을 입력하세요");
				return;
				
			}
			
			if(boardType == "ins"){
				var yn = confirm("게시글을 등록하시겠습니까?"); 
			}else if(boardType == "upt"){
				var yn = confirm("게시글을 수정하시겠습니까?"); 
			}
			
			if(yn){
				
				var form = $('#boardForm')[0]
			    var data = new FormData(form);
				
				$.ajax({
		            url:"/board/boardEdit.do",
		            data:data,
		            type:"post",
		            enctype: 'multipart/form-data',
		            processData: false,
		            contentType: false,
		            success:function(data){
		               	
		            	//window.location.href="/board/boardList.do?menuCode=${menuCode}&nowPage=${nowPage}&cntPerPage=${cntPerPage}"
		            	var form = document.dataForm;
		    			
		    			form.action = "/board/boardList.do";
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
			
			form.action = "/board/boardList.do";
			form.method = "post"; 
			form.nowPage.value = ${nowPage};
			form.cntPerPage.value = ${cntPerPage};
			form.submit();
		}
	</script>
</head>
<body style="font-size:15px">
<form id="dataForm" name="dataForm">
	<input type="hidden" name="boardSeq" value="${detail.boardSeq}">
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
			
			<form id="boardForm" name="boardForm" method="post" enctype="multipart/form-data">
	
				<input type="hidden" id="boardSeq" name="boardSeq" value="${detail.boardSeq }">
				<input type="hidden" id="boardType" name="boardType" value="${boardType }">
				
				<c:if test="${boardType == 'ins' }">
					<h2 style="text-align: center;margin-top:20px;margin-bottom:20px;font-size: 30px">공지사항 등록</h2>
				</c:if>	
				<c:if test="${boardType == 'upt' }">
					<h2 style="text-align: center;margin-top:20px;margin-bottom:20px;font-size: 30px">공지사항 수정</h2>
				</c:if>	
				
				<table id="dtTable" border="1" style="width:60%;margin:0 auto">
					<colgroup> 
						<col width="15%"/>
						<col width="85%"/>
					</colgroup>
					<tbody>
						<tr>
							<th>제목</th>
							<td><input id="boardTitle" name="boardTitle" style="height: 30px;font-size:15px" class="form-control mr-sm-2" value="${detail.boardTitle }"></td>
						</tr>
						<tr>
							<th>내용</th>
							<td><textarea id="boardContent" name="boardContent" style="width:100%;height: 400px;font-size:15px" class="form-control">${detail.boardContent }</textarea></td>
						</tr>
						<tr>
							<th>작성자</th>
							<td><input id="boardWriter" name="boardWriter" readonly="readonly" style="height: 30px;font-size:15px" class="form-control mr-sm-2" <c:if test="${boardType == 'ins' }">value="${userInfo.userId }"</c:if> <c:if test="${boardType == 'upt' }">value="${detail.boardWriter }"</c:if> ></td>
						</tr>
						<tr>
							<th>파일</th>
							<td>
								<input type="file" name="uploadFile">
							</td>
						</tr>
					</tbody>
				</table>
			</form>
				<div style="text-align: center;margin-top:5px;margin-right:15px">
					<c:if test="${boardType == 'ins' }">
						<button type="button" onclick="fnEdit('ins')" class="btn btn-outline-dark" style="font-size:15px">작성</button>
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