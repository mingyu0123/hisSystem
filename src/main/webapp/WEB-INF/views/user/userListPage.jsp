<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

				<h2 style="text-align: center;font-weight: bold;font-size:25px">사용자관리</h2>
				<div style="text-align: right;">
					<select id="searchType" class="form-control" style="width: 100px;display: initial;font-size: 15" onchange="fnSearchType(this.value)">
						<option value="userId" <c:if test="${searchType == 'userId' }">selected="selected"</c:if>>아이디</option> 
						<option value="userName" <c:if test="${searchType == 'userName' }">selected="selected"</c:if>>이름</option>
						<option value="userClass" <c:if test="${searchType == 'userClass' }">selected="selected"</c:if>>과</option>
						<option value="userDept" <c:if test="${searchType == 'userDept' }">selected="selected"</c:if>>부서</option>
						<option value="userPosition" <c:if test="${searchType == 'userPosition' }">selected="selected"</c:if>>직책</option>
					</select>
					<select id="mainDept" name="mainDept" class="form-control" 
						<c:if test="${searchType == 'userClass' || searchType == 'userDept' }">style="width:100px;font-size: 15px;display:initial;"</c:if>
						<c:if test="${searchType != 'userClass' }">style="width:100px;font-size: 15px;display:none;"</c:if> onchange="fnCodeList(this.value)">
						<c:forEach items="${deptCodeList }" var="code">
							<c:if test="${classVal != null }">
								<option value="${code.code }" <c:if test="${classVal == code.code }">selected="selected"</c:if>>${code.codeName }</option>
							</c:if>
							<c:if test="${classVal == null }">
								<option value="${code.code }" <c:if test="${searchValue == code.code }">selected="selected"</c:if>>${code.codeName }</option>
							</c:if>
						</c:forEach>
					</select>
					<select id="middleDept" name="middleDept" class="form-control" 
						<c:if test="${searchType == 'userDept' }">style="width:130px;font-size: 15px;display:initial;"</c:if>
						<c:if test="${searchType != 'userDept' }">style="width:130px;font-size: 15px;display:none;"</c:if>>
						<c:forEach items="${midDeptCodeList }" var="code">
							<option value="${code.code }" <c:if test="${searchValue == code.code }">selected="selected"</c:if>>${code.codeName }</option>
						</c:forEach>
					</select>
					<select id="userPosition" name="userPosition" class="form-control" 
						<c:if test="${searchType == 'userPosition' }">style="width:130px;font-size: 15px;display:initial;"</c:if>
						<c:if test="${searchType != 'userPosition' }">style="width:130px;font-size: 15px;display:none;"</c:if>>
						<c:forEach items="${postionCodeList }" var="code">
							<option value="${code.code }" <c:if test="${searchValue == code.code }">selected="selected"</c:if>>${code.codeName }</option>
						</c:forEach>
					</select>
					<input type="text" class="form-control" id="searchValue" 
					<c:if test="${searchType == 'userId' || searchType == 'userName' || searchType == null }">style="width:130px;display: initial;font-size: 15" value="${searchValue }"</c:if>
					<c:if test="${searchType != 'userId' || searchType != 'userName' }">style="width:130px;display: none;font-size: 15"</c:if>
					  onKeypress="javascript:if(event.keyCode==13) {fnSearch()}">
					<button type="button" class="btn btn-primary" onclick="fnSearch()" style="font-size:15">검색</button>
				</div>
				<table class="table table-hover" style="margin-top:30px;">
				  <colgroup> 
					<col width="10%"/>
					<col width="15%"/>
					<col width="15%"/>
					<col width="15%"/>
					<col width="15%"/>
					<col width="15%"/>
					<col width="20%"/>
				</colgroup>
				  <thead class="thead-dark">
				    <tr>
				      <th scope="col">번호</th>
				      <th scope="col">아이디</th>
				      <th scope="col">이름</th>
				      <th scope="col">과</th>
				      <th scope="col">부서</th>
				      <th scope="col">직책</th>
				      <th scope="col">생성일</th>
				    </tr>
				  </thead>
				  <tbody>
				  	<c:forEach items="${list}" var="usr" varStatus="sta">
						<tr onclick="fnDetail(${usr.userSeq},${paging.nowPage },${paging.cntPerPage })">
							<td>${totalCnt+(-(10*(paging.nowPage-1))-(sta.index))}</td>
							<td>${usr.userId }</td>
							<td>${usr.userName }</td>
							<td>${usr.userClass }</td>
							<td>${usr.userDept }</td>
							<td>${usr.userPosition }</td>
							<td>${usr.insDate }</td>
						</tr>
					</c:forEach>
				  </tbody>
				</table>
				<div style="text-align: right;margin-top:5px;">
					<button type="button" onclick="fnEditPage('ins')" class="btn btn-outline-dark" style="font-size:13">등록</button>
				</div>
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