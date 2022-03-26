<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div id="footerDv">
	<div class="footerInfo">
		<span>사용자 :</span><span> ${userInfo.userName } </span>
		<span style="margin-left:15px"> 부서 :</span><span> ${userInfo.userDept }</span>
		<span style="margin-left:15px"> 직책 :</span><span> ${userInfo.userPosition }</span>
	</div>
	<div class="footerSubDv">
		<span>접속시간 :</span><span> ${accessTime }</span>
	</div>
	<div class="footerSubDv">
		<span>현재시간 :</span><span id="date"></span>
	</div>
	<div class="footerSubDv">
		<c:if test="${recipientCnt > 0 }">
			<span>지시내용 :</span><span><a href="javascript:fnIstPop(${userInfo.userSeq })" class="aCss" style="text-decoration: underline;"> ${recipientCnt }건</a></span>
		</c:if>
		<c:if test="${recipientCnt < 1 }">
			<span>지시내용 :</span><span><a class="aCss"> 0건</a></span>
		</c:if>
		
	</div>
</div>