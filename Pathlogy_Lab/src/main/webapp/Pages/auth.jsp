
<%
HttpSession mySession = request.getSession(false);

if (mySession == null || mySession.getAttribute("userObj") == null) {
	response.sendRedirect(request.getContextPath() + "/login");
	return;
}

response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
response.setHeader("Pragma", "no-cache");
response.setDateHeader("Expires", 0);
%>