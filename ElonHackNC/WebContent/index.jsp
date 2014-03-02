<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>

<script src="./scripts/slideshow.js"></script>


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
	inspire others!</h4>

<div id="scroll">

	<img src="./images/image1.jpg" name="slide" border=0 width=600
		height=400>
	<script language="JavaScript1.1">
	<!--
		
//configure the paths of the images, plus corresponding target links
slideshowimages("./images/image1.jpg","./images/image2.jpg", "./images/hackthis_logo.png")


//configure the speed of the slideshow, in miliseconds
var slideshowspeed=2500

var whichlink=0
var whichimage=0
function slideit(){
if (!document.images)
return
document.images.slide.src=slideimages[whichimage].src
whichlink=whichimage
if (whichimage<slideimages.length-1)
whichimage++
else
whichimage=0
setTimeout("slideit()",slideshowspeed)
}
slideit()


	//-->
	</script>

</div>

<br>
<h4>Select a Hackathon event below to get started</h4>

<br>

<div id="accordion">
	<h3>
		<a href="#"> Upcoming Hackathons</a>
	</h3>
	<div>
		<br> <a
			href="<c:url value="/Controller?action=list&hackathon=HackNC"/>">HackNC
			Spring 2014 </a> &lt;&lt;This link works<br> <a
			href="<c:url value="/Controller?action=list&hackathon=HackElon"/>">HackElon
			Spring 2014</a>



	</div>
	<h3>
		<a href="#"> Past Hackathons</a>
	</h3>
	<div>
		<br> <a
			href="<c:url value="/Controller?action=list&hackathon=HackVT"/>">HackVT
			Fall 2013</a> <br> <a
			href="<c:url value="/Controller?action=list&hackathon=HackDuke"/>">HackDuke
			Fall 2013</a>

	</div>
	<h3>
		<a href="#"> Future Hackathons</a>
	</h3>
	<div>

		<br> <a
			href="<c:url value="/Controller?action=list&hackathon=HackThat"/>">HackThat
			Spring 2014</a> <br> <a
			href="<c:url value="/Controller?action=list&hackathon=HackWhat"/>">HackWhat
			Spring 2014</a> <br> <a
			href="<c:url value="/Controller?action=list&hackathon=HackOther"/>">HackOther
			Fall 2014</a> <br> <a
			href="<c:url value="/Controller?action=list&hackathon=HackWhich"/>">HackWhich
			Fall 2014</a>

	</div>
</div>

<br>


<div id="footer">

	<p>Copyright &copy; ElonHackNC</p>

</div>

</body>
</html>
