
<%@page import="com.pathology.model.User"%>
<%
HttpSession mySession = request.getSession(false);

if (mySession == null) {
	response.sendRedirect(request.getContextPath() + "/login");
	return;
}
%>

<%
User u = (User) mySession.getAttribute("userObj");

if (u == null) {
	response.sendRedirect(request.getContextPath() + "/login");
	return;
}

mySession.setAttribute("role", u.getRole());
%>

<%
response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
response.setHeader("Pragma", "no-cache");
response.setDateHeader("Expires", 0);
%>
