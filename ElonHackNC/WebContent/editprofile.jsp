<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ page import="beans.*"%>
<c:import url="header.jsp">
	<c:param name="title" value="User Profile" />
</c:import>

<%
	User user = (User) session.getAttribute("user");
	if (request.getParameter("message") == null) {
		request.setAttribute("aboutme", user.getAboutMe());
		request.setAttribute("website", user.getPersonalWeb());
		request.setAttribute("github", user.getGithub());
		request.setAttribute("pictureurl", user.getPictureURL());
		request.setAttribute("password", user.getPassword());
		request.setAttribute("email", user.getEmail());
		request.setAttribute("username", user.getUsername());
	}
%>
<p class="bold">Once your profile has been updated you will be logged out.
 You must log back in with your new credentials to view your updated account</p>
<form method="post"
	action="<%=request.getContextPath()
					+ "/Controller?action=editprofile"%>" id="1">
	<input type="hidden" name="action" value="editaccount" />
	<input type="hidden" name="username" value="<%=request.getAttribute("username") == null ? "" : request
					.getAttribute("username")%>"/>
	<table class="userTable">
		<tr>
			<td class="align-right">Email Address:</td>
			<td><input type="text" name="email"
				value="<%=request.getAttribute("email") == null ? "" : request
					.getAttribute("email")%>" /></td>
		</tr>
		<tr>
			<td class="align-right">Personal Website:</td>
			<td><input type="text" name="website"
				value="<%=request.getAttribute("website") == null ? "" : request
					.getAttribute("website")%>" /></td>
		</tr>
		<tr>
			<td class="align-right">GitHub:</td>
			<td><input type="text" name="github"
				value="<%=request.getAttribute("github") == null ? "" : request
					.getAttribute("github")%>" /></td>
		</tr>
		<tr>
			<td class="align-right">Picture URL:</td>
			<td><input type="text" name="pictureurl"
				value="<%=request.getAttribute("pictureurl") == null ? "" : request
					.getAttribute("pictureurl")%>" /></td>
		</tr>
		<tr>
			<td class="align-right">Password:</td>
			<td><input type="password" name="password"
				value="<%=request.getAttribute("password") == null ? "" : request
					.getAttribute("password")%>" /></td>
		</tr>
		<tr>
			<td class="align-right">Repeat Password:</td>
			<td><input type="password" name="repeat"
				value="<%=request.getAttribute("password") == null ? "" : request
					.getAttribute("password")%>" /></td>
		</tr>
		<tr>
			<td class="align-right">About Me:</td>
			<td><textarea name="aboutme" rows="4" cols="40" form="1"><%=request.getAttribute("aboutme") == null ? "" : request
					.getAttribute("aboutme")%></textarea></td>
		</tr>
		<tr>
			<td class="align-right" colspan="2"><input type="submit"
				value="Create Account" /></td>
		</tr>
	</table>

	<p class="login-error">
		<%=request.getAttribute("message") == null ? "" : request
					.getAttribute("message")%>
	</p>
</form>

</div>
</div>
<br />
<br />
<div id="footer">

	<p>Copyright &copy; ElonHackNC</p>

</div>
</body>
</html>