<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!-- <script src="http://visjs.org/dist/vis.js"></script> -->
<!-- <script src="//code.jquery.com/jquery-1.9.1.js"></script> -->
<!-- <link href="http://visjs.org/dist/vis.css" rel="stylesheet" type="text/css" /> -->
<!-- <script src="./scripts/ideamap.js"></script> -->

<c:import url="header.jsp">
        <c:param name="title" value="IDEAS" />
</c:import>

<button id="explore" >Explore Selected Idea</button>

<div id="mygraph"></div>

<p id="bubbles">1, 0, HackThis;2, 1, DuckBill;3, 0, seperate;4, 1, RedBull;</p>

<input id="in" value="TEST">
<button id="test">will it blend?</button>

<c:import url="footer.jsp" />
