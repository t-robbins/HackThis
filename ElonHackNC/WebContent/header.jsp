<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<!DOCTYPE html>
<!--
* Copyright (c) Thomas Robbins, Schuyler Goodwin, Miles Camp, Evan Walmer March 1, 2014
-->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>${param.title}</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/style/style.css">
<link rel="shortcut icon" href="./images/hackthis.ico">
<link href="http://visjs.org/dist/vis.css" rel="stylesheet" type="text/css" />

<script src="http://visjs.org/dist/vis.js"></script>
<script src="//code.jquery.com/jquery-1.9.1.js"></script>
<script src="//code.jquery.com/ui/1.10.4/jquery-ui.js"></script>

<script src="./scripts/home.js"></script>
<script src="./scripts/ideamap.js"></script>
	
</head>
<body>

	<c:set var="currentPage" value="${ pageContext.request.requestURI }"
		scope="session" />

	
	<div class="header">
		<a href="${pageContext.request.contextPath}/index.jsp"><img
			src="${pageContext.request.contextPath}/images/hackthis_logo.png"
			height="35px" /></a>
		<div class="headerRight">
			<c:choose>
				<c:when test="${ sessionScope.user.username == null}">
					<a
						href="${pageContext.request.contextPath}/Controller?action=login&from=${pageContext.request.requestURI}?${pageContext.request.queryString}">
						Login</a> | <a
						href="${pageContext.request.contextPath}/Controller?action=createaccount">
						Create Account</a>
						
				</c:when>
				<c:otherwise>
			
				Welcome <a
						href="${pageContext.request.contextPath}/Controller?action=userprofile">
						${ sessionScope.user.username }</a>!
				
				| <a href="${pageContext.request.contextPath}/logout.jsp">
						Logout</a>
				</c:otherwise>

			</c:choose>
		</div>
	</div>

	<div class="content">