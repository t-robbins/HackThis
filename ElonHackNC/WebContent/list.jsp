<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<c:import url="header.jsp">
        <c:param name="title" value="Elon HackNC Homepage" />
</c:import>

<sql:setDataSource var="ds" dataSource="jdbc/elonhackdb" />

<sql:query dataSource="${ds}" sql="select * from idea" var="results" />

<c:forEach var="name" items="${results.rows}" varStatus="row">

<p><a href="${pageContext.request.contextPath}/Controller?action=bubblerequest">${name.title}</a><p>
</c:forEach>



<div id="footer">

<p>Copyright &copy; ElonHackNC </p>

</div>

</body>
</html>