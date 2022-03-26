<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

				<h2 style="text-align: center;font-weight: bold;font-size:25px">지시내용</h2>
				<div style="text-align: right;">
					<select id="searchType" class="form-control" style="width: 100px;display: initial;font-size: 15">
						<option value="title" <c:if test="${searchType == 'title' }">selected="selected"</c:if>>제목</option> 
					</select>
					<input type="text" class="form-control" id="searchValue" style="width:200px;display: initial;font-size: 15" value="${searchValue }" onKeypress="javascript:if(event.keyCode==13) {fnSearch()}">
					<button type="button" class="btn btn-primary" onclick="fnSearch()" style="font-size:15">검색</button>
				</div>
				<table id="istTable" class="table table-hover" style="margin-top:30px;">
				  <colgroup> 
					<col width="10%"/>
					<col width="*"/>
					<col width="15%"/>
					<col width="35%"/>
				  </colgroup>
				  <thead class="thead-dark">
				    <tr>
				      <th scope="col">번호</th>
				      <th scope="col">제목</th>
				      <th scope="col">발신인</th>
				      <th scope="col">발신일</th>
				    </tr>
				  </thead>
				  <tbody>
				  	<c:forEach items="${list}" var="ist" varStatus="sta">
						<tr id="tr${ist.istSeq }" onclick="fnDetail(${ist.istSeq },'${ist.istTitle}','${ist.istRecipient}','${ist.istStatus}','${ist.istContent}','${ist.insDateDetail}')">
							<td>${totalCnt+(-(10*(paging.nowPage-1))-(sta.index))}</td>
							<td>${ist.istTitle }</td>
							<td>${ist.istRecipient }</td>
							<td>${ist.insDateDetail }</td>
						</tr>
					</c:forEach>
					<c:if test="${empty list }">
				  		<tr>
				  			<td colspan="4" style="text-align: center;">작성된 지시내용이 없습니다.</td>
				  		</tr>
				  	</c:if>
				  </tbody>
				</table>
				<div style="width:300px; margin:0 auto">
					<nav aria-label="Page navigation example" >
					  <ul class="pagination">
					  	<c:if test="${paging.nowPage != 1 }">
					    	<li class="page-item"><a class="page-link" href="javascript:fnPage(${paging.nowPage - 1 },${paging.cntPerPage})">Previous</a></li>
					    </c:if>
					    <c:forEach begin="${paging.startPage }" end="${paging.endPage }" var="p">
							<c:choose>
								<c:when test="${p == paging.nowPage }">
									<li class="page-item active"><a class="page-link" href="#">${p }</a></li>
								</c:when>
								<c:when test="${p != paging.nowPage }">
									<li class="page-item"><a class="page-link" href="javascript:fnPage(${p },${paging.cntPerPage})">${p }</a></li>
								</c:when>
							</c:choose>
					    </c:forEach>
					    <c:if test="${paging.nowPage != paging.lastPage}">
					    	<li class="page-item"><a class="page-link" href="javascript:fnPage(${paging.nowPage+1 },${paging.cntPerPage})">Next</a></li>
					    </c:if>
					  </ul>
					</nav>
				</div>