<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<nav class="navbar navbar-dark bg-dark" style="background-color:#343a40!important;height: 70px" >
  <a href="javascript:fnMenu('/main.do','main')" style="font-size:21px;cursor: pointer;" class="navbar-brand">종합의료정보시스템</a>
  <a href="javascript:fnInfo()" class="aCss" style="margin-right:30px"><i style="font-size:25px;color:white;" class="glyphicon glyphicon-user"></i></a>
  <div class="infoDv">
  	<p></p>
  	<p style="padding:0 10 0 25">
  		<a href="javascript:fnLogout()" style="font-size:16px;cursor: pointer;text-decoration: none;color:black"><i class="glyphicon glyphicon-info-sign" style="margin-right:5px"></i>Logout</a>
  	</p>
  	<p style="padding:0 10 0 25">
  		<a href="javascript:fnInfoPage(${userInfo.userSeq })" style="font-size:16px;cursor: pointer;text-decoration: none;color:black"><i class="glyphicon glyphicon-edit" style="margin-right:5px"></i>MyInfo</a>
  	</p>
  </div>
</nav>