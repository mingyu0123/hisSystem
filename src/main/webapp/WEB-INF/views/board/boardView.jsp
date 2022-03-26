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
				
		function fnEditPage(boardType,boardSeq){
			
			if(boardType == "upt"){
				
				//window.location.href="/board/boardEditPage.do?boardSeq="+boardSeq+"&boardType="+boardType+"&menuCode=${menuCode}&nowPage=${nowPage}&cntPerPage=${cntPerPage}";
				var form = document.boardForm;
				
				form.action = "/board/boardEditPage.do";
				form.method = "post"; 
				form.boardSeq.value = boardSeq;
				form.boardType.value = boardType;
				form.nowPage.value = ${nowPage};
				form.cntPerPage.value = ${cntPerPage};
				form.submit();
				
			}else{
			
				var yn = confirm("게시글을 삭제하시겠습니까?"); 
				if(yn){
					
					$.ajax({
			            url:"/board/deleteBoard.do",
			            data:{
			            		boardSeq:boardSeq,
			            		boardType:boardType
			            	},
			            type:"post",
			            success:function(data){
			               	
			            	//window.location.href="/board/boardList.do?menuCode=${menuCode}&nowPage=${nowPage}&cntPerPage=${cntPerPage}";
			            	var form = document.boardForm;
			    			
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
		}
				
		function fileDown() {
			
			window.location.href= "/fileDown?filePath=${detail.filePath}";
			
		}
		
		function fnList() {
			//window.location.href= "/board/boardList.do?menuCode=${menuCode}&nowPage=${nowPage}&cntPerPage=${cntPerPage}";
			var form = document.boardForm;
			
			form.action = "/board/boardList.do";
			form.method = "post"; 
			form.nowPage.value = ${nowPage};
			form.cntPerPage.value = ${cntPerPage};
			form.submit();
		}
	</script>
</head>
<body>
<form id="boardForm" name="boardForm">
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
			
			<div style="width:80%;margin:0 auto;">
	
				<h2 style="text-align: center;margin-top:20px;margin-bottom:20px;font-size: 30px">게시판 상세화면</h2>
				
				<table id="dtTable" border="1" style="width:80%;margin:0 auto;">
					<colgroup> 
						<col width="15%"/>
						<col width="35%"/>
						<col width="15%"/>
						<col width="35%"/> 
					</colgroup>
					<tbody>
						<tr>
							<th>글번호</th>
							<td>${detail.boardSeq }</td>
							<th>조회수</th>
							<td>${detail.boardHits }</td>
						</tr>
						<tr>
							<th>작성자</th>
							<td>${detail.boardWriter }</td>
							<th>작성일</th>
							<td>${detail.insDate }</td>
						</tr>
						<tr>
							<th>제목</th>
							<td colspan="3">${detail.boardTitle }</td>
						</tr>
						<tr>
							<th>파일</th>
							<td colspan="3">
								<c:if test="${detail.filePath  != null }">
									<a href="javascript:fileDown();" style="text-decoration: none;"><span class="glyphicon glyphicon-save" aria-hidden="true"></span> ${detail.filePath }</a>
								</c:if>
							</td>
						</tr>
						<tr>
							<th>내용</th>
							<td colspan="3">
								<textarea style="width:100%;height: 400px" readonly="readonly">${detail.boardContent }</textarea>
							</td>
						</tr>
					</tbody>
				</table>
				<div style="width:90%;text-align: right;margin-top:5px;margin-right:15px">
					<c:if test="${userInfo.userAuth != '사용자' }">
						<button type="button" onclick="fnEditPage('upt',${detail.boardSeq})" class="btn btn-outline-dark" style="font-size:13">수정</button>
						<button type="button" onclick="fnEditPage('del',${detail.boardSeq})" class="btn btn-outline-dark" style="font-size:13">삭제</button>
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
