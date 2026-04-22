<%@page import="com.pathology.model.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Staff Navigation | PathLab</title>

<link
	href="https://fonts.googleapis.com/css2?family=Sora:wght@300;400;500;600;700&display=swap"
	rel="stylesheet">
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"
	rel="stylesheet">

<style>
:root {
	--staff-primary: #0f766e;
	--staff-primary-soft: #0d9488;
	--staff-sidebar-deep: #102a43;
	--staff-sidebar-mid: #1f3c5a;
	--staff-text: #dce8f7;
	--staff-muted: #9fb7d3;
	--staff-topbar-bg: rgba(248, 250, 252, 0.96);
	--staff-border: #dbe4f0;
	--staff-shadow: 0 12px 30px rgba(15, 23, 42, 0.08);
	--sidebar-width: 265px;
}

* {
	box-sizing: border-box;
}

body {
	margin: 0;
	font-family: "Sora", sans-serif;
}

.sidebar {
	position: fixed;
	top: 0;
	left: 0;
	width: var(--sidebar-width);
	height: 100vh;
	background: linear-gradient(175deg, var(--staff-sidebar-deep) 0%,
		var(--staff-sidebar-mid) 100%);
	color: var(--staff-text);
	padding: 22px 16px;
	box-shadow: 8px 0 26px rgba(2, 6, 23, 0.25);
	z-index: 1001;
	display: flex;
	flex-direction: column;
	transition: transform 0.25s ease;
}

.sidebar-header {
	padding: 0 10px 24px;
	margin-bottom: 18px;
	border-bottom: 1px solid rgba(255, 255, 255, 0.15);
}

.sidebar-header h3 {
	margin: 0;
	font-size: 1.25rem;
	font-weight: 700;
	display: flex;
	align-items: center;
	gap: 10px;
	color: #fff;
}

.sidebar-header i {
	color: #34d399;
}

.nav-label {
	font-size: 0.74rem;
	text-transform: uppercase;
	letter-spacing: 1px;
	color: var(--staff-muted);
	padding: 0 10px;
	margin: 14px 0 8px;
	display: block;
	font-weight: 600;
}

.sidebar a {
	display: flex;
	align-items: center;
	gap: 10px;
	padding: 11px 13px;
	border-radius: 11px;
	text-decoration: none;
	color: var(--staff-text);
	font-size: 0.93rem;
	font-weight: 500;
	transition: background 0.2s ease, transform 0.2s ease;
	margin-bottom: 3px;
}

.sidebar a i {
	width: 18px;
	text-align: center;
	color: #b8cce4;
}

.sidebar a:hover {
	background: rgba(255, 255, 255, 0.11);
	transform: translateX(4px);
	color: #fff;
}

.sidebar a.active {
	background: linear-gradient(135deg, var(--staff-primary) 0%,
		var(--staff-primary-soft) 100%);
	color: #fff;
	box-shadow: 0 8px 18px rgba(15, 118, 110, 0.32);
}

.sidebar a.active i {
	color: #fff;
}

.bottom-nav {
	margin-top: auto;
	padding-top: 16px;
	border-top: 1px solid rgba(255, 255, 255, 0.15);
}

.logout-link {
	color: #fecaca !important;
}

.logout-link i {
	color: #fecaca !important;
}

.topbar {
	margin-left: var(--sidebar-width);
	height: 72px;
	display: flex;
	align-items: center;
	justify-content: space-between;
	padding: 0 26px;
	background: var(--staff-topbar-bg);
	backdrop-filter: blur(8px);
	border-bottom: 1px solid var(--staff-border);
	position: sticky;
	top: 0;
	z-index: 1000;
}

.topbar-title {
	font-size: 0.98rem;
	font-weight: 600;
	color: #334155;
	letter-spacing: 0.3px;
}

.mobile-toggle {
	display: none;
	font-size: 1.35rem;
	cursor: pointer;
	color: #0f172a;
}

.topbar-right {
	display: flex;
	align-items: center;
	gap: 14px;
}

.icon-btn {
	border: none;
	width: 40px;
	height: 40px;
	border-radius: 10px;
	background: #e2e8f0;
	color: #475569;
	position: relative;
	cursor: pointer;
}

.notification-count {
	position: absolute;
	top: -4px;
	right: -4px;
	width: 17px;
	height: 17px;
	border-radius: 50%;
	background: #dc2626;
	color: #fff;
	display: flex;
	align-items: center;
	justify-content: center;
	font-size: 0.62rem;
	font-weight: 700;
	border: 2px solid #fff;
}

.profile {
	display: flex;
	align-items: center;
	gap: 10px;
	padding-left: 14px;
	border-left: 1px solid #dbe4f0;
}

.profile-name {
	font-size: 0.86rem;
	font-weight: 600;
	color: #0f172a;
	line-height: 1.2;
}

.profile-role {
	font-size: 0.72rem;
	color: #64748b;
	line-height: 1.2;
	text-transform: uppercase;
	letter-spacing: 0.5px;
}

.profile-avatar {
	width: 38px;
	height: 38px;
	border-radius: 10px;
	background: linear-gradient(135deg, #99f6e4 0%, #5eead4 100%);
	color: #0f766e;
	display: flex;
	align-items: center;
	justify-content: center;
	font-size: 1rem;
}

@media ( max-width : 992px) {
	.sidebar {
		transform: translateX(-100%);
	}
	.sidebar.active {
		transform: translateX(0);
	}
	.topbar {
		margin-left: 0;
	}
	.mobile-toggle {
		display: inline-flex;
	}
}
</style>
</head>

<body>

	<%
	HttpSession newSession = request.getSession(false);

	if (newSession == null || newSession.getAttribute("userObj") == null) {
		response.sendRedirect(request.getContextPath() + "/login");
		return;
	}

	User u = (User) newSession.getAttribute("userObj");

	String name = u.getName();
	String role = u.getRole();
	%>

	<div class="sidebar" id="staffSidebar">
		<div class="sidebar-header">
			<h3>
				<i class="fa-solid fa-flask-vial"></i> PathLab Staff
			</h3>
		</div>

		<span class="nav-label">Overview</span> <a
			href="<%=request.getContextPath()%>/Pages/Staff/staff-dashboard.jsp"
			data-staff-link="dashboard"> <i class="fa-solid fa-gauge-high"></i>
			Dashboard
		</a> <a href="<%=request.getContextPath()%>/Pages/uploadReport.jsp"
			data-staff-link="upload"> <i class="fa-solid fa-cloud-arrow-up"></i>
			Upload Report
		</a> <a href="<%=request.getContextPath()%>/viewAllReports"
			data-staff-link="reports"> <i class="fa-solid fa-file-medical"></i>
			View Reports
		</a> <span class="nav-label">Management</span> <a
			href="<%=request.getContextPath()%>/viewPatients"
			data-staff-link="patients"> <i class="fa-solid fa-users"></i>
			Patients
		</a> <a href="<%=request.getContextPath()%>/Pages/changePassword.jsp"
			data-staff-link="password"> <i class="fa-solid fa-key"></i>
			Change Password
		</a>

		<div class="bottom-nav">
			<a href="<%=request.getContextPath()%>/logout" class="logout-link"
				onclick="return confirm('Are you sure you want to logout?');"> <i
				class="fa-solid fa-right-from-bracket"></i> Logout
			</a>
		</div>
	</div>

	<div class="topbar">
		<div class="mobile-toggle" onclick="toggleSidebar()">
			<i class="fa-solid fa-bars"></i>
		</div>

		<div class="topbar-title">Staff Operations Console</div>

		<div class="topbar-right">
			<button class="icon-btn" type="button" title="Notifications">
				<i class="fa-solid fa-bell"></i> <span class="notification-count">2</span>
			</button>

			<div class="profile">
				<div>
					<div class="profile-name"><%=name%></div>
					<div class="profile-role"><%=role%></div>
				</div>
				<div class="profile-avatar">
					<i class="fa-solid fa-user-doctor"></i>
				</div>
			</div>
		</div>
	</div>

	<script>
		function toggleSidebar() {
			document.getElementById("staffSidebar").classList.toggle("active");
		}

		(function() {
			const pageAttr = document.body.getAttribute("data-staff-page");
			const currentPath = window.location.pathname.toLowerCase();

			document.querySelectorAll("[data-staff-link]").forEach(
					function(link) {
						const key = link.getAttribute("data-staff-link");
						const href = (link.getAttribute("href") || "")
								.toLowerCase();

						if (pageAttr === key
								|| (href && currentPath.includes(href))) {
							link.classList.add("active");
						}
					});
		})();
	</script>

</body>

</html>