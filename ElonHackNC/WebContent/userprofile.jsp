<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ page import="beans.*"%>
<c:import url="header.jsp">
	<c:param name="title" value="User Profile" />
</c:import>

<sql:setDataSource var="ds" dataSource="jdbc/elonhackdb" />


<c:set scope="page" var="user" value="${session.user}" />
<sql:query dataSource="${ds}"
	sql="SELECT h.name FROM hackathon_attendees a JOIN hackathon h ON a.hackathon_id = h.hackathon_id join user_table u on a.user_id = u.user_id where u.username = ?"
	var="hacks">
	<sql:param>${user.username}</sql:param>
</sql:query>

<sql:query dataSource="${ds}"
	sql="SELECT i.title FROM user_table u JOIN idea i ON i.user_id = u.user_id where u.username = ?"
	var="ideas">
	<sql:param>${user.username}</sql:param>
</sql:query>

<c:choose>
	<c:when test="${not empty user }">

		<div>
			<table class="userTable">
				<tr>
					<td width="300"><img src="./images/userPicture.png"
						alt="./images/userPicture.png" width="200"></td>

					<td>
						<table class="userTable">
							<tr>
								<td><span class="bold">Username: </span> <c:out
										value="${user.username}" /></td>
							</tr>
							<tr>
								<td><span class="bold">Email: </span> <c:out
										value="${user.email}" /></td>
							</tr>
							<tr>
								<td><span class="bold">GitHub: </span><a href=""> <c:out
											value="${user.github}" />
								</a></td>
							</tr>
							<tr>
								<td><span class="bold">PersonalWebsite: </span> <a href="">
										<c:out value="${user.personalWeb}" />
								</a></td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td colspan="2" class="bold leftPadding">
						<p>About Me:</p>
						<p>
							<c:out value="${user.aboutMe}" />
						</p>
					</td>
				</tr>
				<tr>
					<td width="300">
						<table>
							<tr>
								<td class="bold">Hackathons Attended</td>
								<c:forEach var="item" items="${hacks.rows}">
									<tr>
										<td><c:out value="${item.name}" /></td>
									</tr>
								</c:forEach>
							</tr>
						</table>
					</td>

					<td>
						<table>
							<tr>
								<td class="bold">Ideas Posted</td>
							</tr>
							<c:forEach var="item" items="${ideas.rows}">
									<tr>
										<td><c:out value="${item.title}" /></td>
									</tr>
								</c:forEach>
						</table>
					</td>
				</tr>
			</table>
		</div>

	</c:when>
	<c:otherwise>
		<c:redirect url="/error.jsp" />
	</c:otherwise>
</c:choose>
</div>
</div>
<br />
<div id="footer">

	<p>Copyright &copy; ElonHackNC</p>

</div>
</body>
</html>