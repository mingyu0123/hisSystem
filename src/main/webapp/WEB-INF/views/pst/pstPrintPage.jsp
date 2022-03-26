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
			fnPrint();
	    }); 
				
				
		function fnClose() {
			window.close();
		}
		
		function fnPrint() {
			
			var inbody = document.body.innerHTML;
			window.onbeforeprint = function(){
				document.body.innerHTML = document.getElementById('printDv').innerHTML;
			}
			window.onagterprint = function(){
				document.body.innerHTML = inbody;
			}
			window.print();
			
			setTimeout("window.close();", 500);
			
		}
	</script>
</head>
<body>
<form id="boardForm" name="boardForm">
	<input type="hidden" name="pstSeq" value="${detail.pstSeq}">
</form>

	<div id="pstList" style="margin:5% auto;width:100%">
			
			<div style="width:80%;margin:0 auto;">
				<div id="printDv">
					<h2 style="text-align: center;margin-top:20px;margin-bottom:20px;font-size: 30px">처방전</h2>
					
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
								<td>${detail.pstNote }</td>
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
					<button type="button" onclick="fnPrint()" class="btn btn-outline-dark" style="font-size:13">프린트</button>
					<button type="button" onclick="fnClose()" class="btn btn-outline-dark" style="font-size:13">닫기</button>
				</div>
			</div>
			
		</div>

</body>
</html>
