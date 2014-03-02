<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>

<script src="//code.jquery.com/jquery-1.9.1.js"></script>
<script src="//code.jquery.com/ui/1.10.4/jquery-ui.js"></script>
<script src="./scripts/home.js"></script>

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
		<a href="<c:url value="/Controller?hackathon=HackVTf13"/>">HackVT
			Fall 2013</a> <br>
		<a href="<c:url value="/Controller?hackathon=HackDukef13"/>">HackDuke
			Fall 2013</a>

	</div>
	<h3>
		<a href="#"> Upcoming Hackathons</a>
	</h3>
	<div>

		<br>
		<a href="<c:url value="/Controller?hackathon=HackNCs14"/>">HackNC
			Spring 2014 </a> &lt;&lt;This link works<br>
		<a href="<c:url value="/Controller?hackathon=HackElons14"/>">HackElon
			Spring 2014</a>

	</div>
	<h3>
		<a href="#"> Future Hackathons</a>
	</h3>
	<div>

		<br>
		<a href="<c:url value="/Controller?hackathon=HackThats14"/>">HackThat
			Spring 2014</a> <br>
		<a href="<c:url value="/Controller?hackathon=HackWhats14"/>">HackWhat
			Spring 2014</a> <br>
		<a href="<c:url value="/Controller?hackathon=HackOtherf14"/>">HackOther
			Fall 2014</a> <br>
		<a href="<c:url value="/Controller?hackathon=HackWhichf14"/>">HackWhich
			Fall 2014</a>

	</div>
</div>

<br>


<div id="footer">

	<p>Copyright &copy; ElonHackNC</p>

</div>

</body>
</html>
