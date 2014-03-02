<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>



<c:import url="header.jsp">
	<c:param name="title" value="Elon HackNC Homepage" />
</c:import>


<sql:setDataSource var="ds" dataSource="jdbc/elonhackdb" />

<sql:query dataSource="${ds}" sql="select * from hackathon"
	var="results" />


<h2>
	<img src="./images/hackthis_logo.png" />
</h2>

<h4>A collaborative environment to help hackers share ideas and
	inspire others.!</h4>

<div class="screenshot"></div>

<br>
<h4>Select a Hackathon event below to get started</h4>

<br>

<div id="accordion">
	<h3>
		<a href="#"> Past Hackathons</a>
	</h3>
	<div>

		<br>
		<a href="<c:url value="/list.jsp?hackathon=HackVT"/>">HackVT
			Fall 2013</a> <br>
		<a href="<c:url value="/list.jsp?hackathon=HackDuke"/>">HackDuke
			Fall 2013</a>

	</div>
	<h3>
		<a href="#"> Upcoming Hackathons</a>
	</h3>
	<div>

		<br>
		<a href="<c:url value="/list.jsp?hackathon=HackNC"/>">HackNC
			Spring 2014 </a> &lt;&lt;This link works<br>
		<a href="<c:url value="/list.jsp?hackathon=HackElon"/>">HackElon
			Spring 2014</a>

	</div>
	<h3>
		<a href="#"> Future Hackathons</a>
	</h3>
	<div>

		<br>
		<a href="<c:url value="/list.jsp?hackathon=HackThat"/>">HackThat
			Spring 2014</a> <br>
		<a href="<c:url value="/list.jsp?hackathon=HackWhat"/>">HackWhat
			Spring 2014</a> <br>
		<a href="<c:url value="/list.jsp?hackathon=HackOther"/>">HackOther
			Fall 2014</a> <br>
		<a href="<c:url value="/list.jsp?hackathon=HackWhich"/>">HackWhich
			Fall 2014</a>

	</div>
</div>

<br>


<div id="footer">

	<p>Copyright &copy; ElonHackNC</p>

</div>

</body>
</html>
