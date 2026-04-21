<%@ page language="java" contentType="text/html; charset=UTF-8"%>

<%
String success = (String) session.getAttribute("successMsg");
String error = (String) session.getAttribute("errorMsg");
%>

<%
if (success != null) {
%>
<div class="alert alert-success alert-dismissible fade show alertMsg"
	role="alert">
	<%=success%>
	<button type="button" class="btn-close" data-bs-dismiss="alert"></button>
</div>
<%
session.removeAttribute("successMsg");
}
%>

<%
if (error != null) {
%>
<div class="alert alert-danger alert-dismissible fade show alertMsg"
	role="alert">
	<%=error%>
	<button type="button" class="btn-close" data-bs-dismiss="alert"></button>
</div>
<%
session.removeAttribute("errorMsg");
}
%>

<script>
	setTimeout(function() {
		let alerts = document.querySelectorAll(".alertMsg");

		alerts.forEach(function(alert) {
			alert.classList.remove("show");
			alert.classList.add("fade");

			setTimeout(function() {
				alert.remove();
			}, 500);
		});

	}, 3000);
</script>