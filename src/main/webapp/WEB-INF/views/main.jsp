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
	 		startDate()
	    }); 
		
		function fnDetail(seq,nowPage,cntPerPage,type){
			
			//window.location.href="/board/boardView.do?boardSeq="+boardSeq+"&menuCode=${menuCode}&nowPage="+nowPage+"&cntPerPage="+cntPerPage;
			var form = document.dataForm;
			
			if(type == 'board'){
				
				form.action = "/board/boardView.do";
				form.method = "post"; 
				form.boardSeq.value = seq;
				form.menuCode.value = "board";
				form.nowPage.value = nowPage;
				form.cntPerPage.value = cntPerPage;
				form.submit();
				
			}else if(type == 'pst'){
				
				form.action = "/pst/pstView.do";
				form.method = "post"; 
				form.pstSeq.value = seq;
				form.menuCode.value = "pst";
				form.nowPage.value = nowPage;
				form.cntPerPage.value = cntPerPage;
				form.submit();
				
			}else if(type == 'ist'){
				
				form.action = "/ist/istList.do";
				form.method = "post"; 
				form.istSeq.value = seq;
				form.menuCode.value = "ist";
				form.nowPage.value = nowPage;
				form.cntPerPage.value = cntPerPage;
				form.submit();
				
			}else if(type == 'record'){
				
				form.action = "/record/recordView.do";
				form.method = "post"; 
				form.recordSeq.value = seq;
				form.menuCode.value = "record";
				form.nowPage.value = nowPage;
				form.cntPerPage.value = cntPerPage;
				form.submit();
				
			}
			
		}
	 	
	</script>
	
</head>
<body>

<form id="dataForm" name="dataForm">
	<input type="hidden" id="boardSeq" name="boardSeq" value="">
	<input type="hidden" id="pstSeq" name="pstSeq" value="">
	<input type="hidden" id="istSeq" name="istSeq" value="">
	<input type="hidden" id="recordSeq" name="recordSeq" value="">
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
		
		<div id="menuList">
			
			<div style="width:50%;height:967px;float:left;">
				<div style="margin:5% auto;width:80%">
					<h2 style="text-align: center;font-weight: bold;font-size:25px">공지사항<a href="javascript:fnMenu('/board/boardList.do','board&nowPage=1&cntPerPage=10')" style="cursor: pointer;font-size:15px;position:absolute;right: 58.5%;top:11.5%;color:black">More +</a></h2>
					<table class="table table-hover" style="margin-top:30px;">
					  <thead class="thead-dark">
					    <tr>
					      <th scope="col">번호</th>
					      <th scope="col">제목</th>
					      <th scope="col">작성자</th>
					      <th scope="col">조회수</th>
					      <th scope="col">작성일</th>
					    </tr>
					  </thead>
					  <tbody>
					  	<c:forEach items="${mainBoardList}" var="bd" varStatus="sta">
							<tr onclick="fnDetail(${bd.boardSeq},1,10,'board')" style="height: 38px">
								<td>${mainBoardCnt-sta.index}</td>
								<td>${bd.boardTitle }</td>
								<td>${bd.boardWriter }</td>
								<td>${bd.boardHits }</td>
								<td>${bd.insDate }</td>
							</tr>
						</c:forEach>
						<c:if test="${empty mainBoardList }">
					  		<tr>
					  			<td colspan="5" style="text-align: center;">작성된 공지사항이 없습니다.</td>
					  		</tr>
					  	</c:if>
					  </tbody>
					</table>
				</div>
				<div style="margin:5% auto;width:80%">
					<h2 style="text-align: center;font-weight: bold;font-size:25px">처방전<a href="javascript:fnMenu('/pst/pstList.do','pst&nowPage=1&cntPerPage=10')" style="cursor: pointer;font-size:15px;position:absolute;right: 58.5%;top:53%;color:black">More +</a></h2>
					<table class="table table-hover" style="margin-top:30px;">
					  <colgroup> 
						<col width="10%"/>
						<col width="*"/>
						<col width="15%"/>
						<col width="15%"/>
						<col width="25%"/>
					</colgroup>
					  <thead class="thead-dark">
					    <tr>
					      <th scope="col">번호</th>
					      <th scope="col">처방제목</th>
					      <th scope="col">환자명</th>
					      <th scope="col">처방의사</th>
					      <th scope="col">처방일</th>
					    </tr>
					  </thead>
					  <tbody>
				  		<c:forEach items="${mainPstList}" var="pst" varStatus="sta">
							<tr onclick="fnDetail(${pst.pstSeq},1,10,'pst')" >
								<td>${mainPstCnt-sta.index}</td>
								<td>${pst.pstTitle }</td>
								<td>${pst.pstName }</td>
								<td>${pst.pstWriter }</td>
								<td>${pst.insDate }</td>
							</tr>
						</c:forEach>
					  	<c:if test="${empty mainPstList }">
					  		<tr>
					  			<td colspan="5" style="text-align: center;">작성된 처방전이 없습니다.</td>
					  		</tr>
					  	</c:if>
					  	
					  </tbody>
					</table>
				</div>
			</div>
			<div style="width:50%;height:967px;float:left;">
				<div style="width:90%;height:400px;margin:5% auto">
					<h2 style="text-align: center;font-weight: bold;font-size:25px">진료기록<a href="javascript:fnMenu('/record/recordList.do','record&nowPage=1&cntPerPage=10')"  style="cursor: pointer;font-size:15px;position:absolute;right: 12.5%;top:11.5%;color:black">More +</a></h2>
					<table class="table table-hover" style="margin-top:30px;">
					  <thead class="thead-dark">
					    <tr>
					      <th scope="col">회진</th>
					      <th scope="col">의뢰인</th>
					      <th scope="col">구분</th>
					      <th scope="col">환자명</th>
					      <th scope="col">등록번호</th>
					      <th scope="col">S/A</th>
					      <th scope="col">의뢰과</th>
					      <th scope="col">주치의</th>
					      <th scope="col">희망과</th>
					      <th scope="col">희망의</th>
					      <th scope="col">실시</th>
					      <th scope="col">의뢰의</th>
					    </tr>
					  </thead>
					  <tbody>
					  	<c:forEach items="${mainRecordList}" var="rcd" varStatus="sta">
					  		<tr onclick="fnDetail(${rcd.rcdSeq},${paging.nowPage },${paging.cntPerPage },'record')">
								<td>
									<c:if test="${rcd.rcdRounds == 'N' }"></c:if>
									<c:if test="${rcd.rcdRounds != 'N' }">${rcd.rcdRounds }</c:if>
								</td>
								<td>${rcd.rcdReqdate }</td>
								<td>${rcd.rcdDivision }</td>
								<td>${rcd.rcdPtename }</td>
								<td>${rcd.rcdNumber }</td>
								<td>${rcd.rcdGender }/${rcd.rcdAge }</td>
								<td>${rcd.rcdReqclass }</td>
								<td>${rcd.rcdMaindoctor }</td>
								<td>${rcd.rcdHopeclass }</td>
								<td>${rcd.rcdHopedoctor }</td>
								<td>${rcd.rcdPractice }</td>
								<td>${rcd.rcdReqdoctor }</td>
							</tr>
					  	</c:forEach>
					  	<c:if test="${empty mainRecordList }">
					  		<tr>
					  			<td colspan="12" style="text-align: center;">작성된 진료기록이 없습니다.</td>
					  		</tr>
					  	</c:if>
					  </tbody>
					</table> 
				</div>
				<div style="width:90%;height:400px;margin:0 auto">
					<h2 style="text-align: center;font-weight: bold;font-size:25px">지시내용<a href="javascript:fnMenu('/ist/istList.do','ist&nowPage=1&cntPerPage=8')" style="cursor: pointer;font-size:15px;position:absolute;right: 12.5%;top:53%;color:black">More +</a></h2>
					<table class="table table-hover" style="margin-top:30px;">
					  <colgroup> 
						<col width="10%"/>
						<col width="*"/>
						<col width="15%"/>
						<col width="15%"/>
						<col width="25%"/>
					  </colgroup>
					  <thead class="thead-dark">
					    <tr>
					      <th scope="col">번호</th>
					      <th scope="col">제목</th>
					      <th scope="col">수신인</th>
					      <th scope="col">수신확인</th>
					      <th scope="col">발신일</th>
					    </tr>
					  </thead>
					  <tbody>
					  	<c:forEach items="${mainIstList}" var="ist" varStatus="sta">
							<tr onclick="fnDetail(${ist.istSeq},1,8,'ist')" >
								<td>${mainIstCnt-sta.index}</td>
								<td>${ist.istTitle }</td>
								<td>${ist.istRecipient }</td>
								<td>
									<c:if test="${ist.istStatus == 'Y' }">확인</c:if>
									<c:if test="${ist.istStatus == 'N' }">미확인</c:if>
								</td>
								<td>${ist.insDateDetail }</td>
							</tr>
						</c:forEach>
						<c:if test="${empty mainIstList }">
					  		<tr>
					  			<td colspan="5" style="text-align: center;">작성된 지시내용이 없습니다.</td>
					  		</tr>
					  	</c:if>
					  </tbody>
					</table> 
				</div>
			</div>
			
		</div>
		
		<!-- 하단 -->
		<jsp:include page="/WEB-INF/views/footer.jsp"></jsp:include>
		
	</div>
	
</div>

</body>
</html>

