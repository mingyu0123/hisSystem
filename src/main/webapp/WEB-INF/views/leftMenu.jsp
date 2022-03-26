<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div id="leftDv" style="width:12%;height: 1077px;float:left;background-color: #343a40;">
		
	<div style="width:90%;float: left">
		<ul style="list-style: none;padding: 15px">
			<li class="leftLicon"><a href="javascript:fnSideMenu()" class="aCss"><i style="font-size:30px" class="glyphicon glyphicon-align-justify"></i></a></li>
			<li class="leftLicon2">All Categories</li>
			<li id="pst" class="leftLi"><a href="javascript:fnMenu('/pst/pstList.do','pst&nowPage=1&cntPerPage=10')">처방전</a></li>
			<li id="ist" class="leftLi"><a href="javascript:fnMenu('/ist/istList.do','ist&nowPage=1&cntPerPage=8')">지시내용</a></li>
			<li id="record" class="leftLi"><a href="javascript:fnMenu('/record/recordList.do','record&nowPage=1&cntPerPage=10')">진료기록</a></li>
			<li id="board" class="leftLi"><a href="javascript:fnMenu('/board/boardList.do','board&nowPage=1&cntPerPage=10')">공지사항</a></li>
			<c:if test="${userInfo.userAuth != '사용자' }">
				<li id="user" class="leftLi"><a href="javascript:fnMenu('/user/userList.do','user&nowPage=1&cntPerPage=10')">사용자관리</a></li>
			</c:if>
		</ul>
	</div>
	<div id="sideNv" style="width:10%;float:left;position: relative;top:50%;font-size:20px">
		<a href="javascript:fnSideMenu()" class="aCss"><i class="glyphicon glyphicon-step-backward" style="color:white;"></i></a>
	</div>

</div>