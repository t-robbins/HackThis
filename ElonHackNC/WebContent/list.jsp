<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<c:import url="header.jsp">
        <c:param name="title" value="Elon HackNC Homepage" />
</c:import>

<p id="testTis">${sessionScope.hackString}</p>
<input type="text" name="hackStr" value="${sessionScope.hackString}" id="testThis"/>



<%-- <form method="post" id="exploreTest" action="${pageContext.request.contextPath}/Controller?action=bubblerequest&bubble="> --%>
<!-- <button id="explore">Explore Selected Idea</button> -->
<!-- </form> -->

<div id="mygraph"></div>
 

<sql:setDataSource var="ds" dataSource="jdbc/elonhackdb" />

<sql:setDataSource dataSource="${ds}" />

<sql:query var="results" >
    select idea.title from idea join hackathon as h on (idea.hack_id = h.hackathon_id) where h.name =?
    <sql:param value="${param.hackathon}" />
</sql:query>

<c:forEach var="name" items="${results.rows}" varStatus="row">

<p><a href="${pageContext.request.contextPath}/Controller?action=bubblerequest&bubble=${name.title}">${name.title}</a><p>
</c:forEach>

<div id="footer">

<p>Copyright &copy; ElonHackNC </p>

</div>

</body>
</html>