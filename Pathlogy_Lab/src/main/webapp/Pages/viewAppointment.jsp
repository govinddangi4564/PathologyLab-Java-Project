<%@page import="com.pathology.model.Appointment"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>View Appointments | PathLab</title>

<link
	href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700&display=swap"
	rel="stylesheet">
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"
	rel="stylesheet">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/Css/app-theme.css">

<style>
:root {
	--bg-grad: radial-gradient(circle at 12% 18%, #e3f2ff 0%, #f8fbff 36%, #eef5ff 100%
		);
	--panel-bg: rgba(255, 255, 255, 0.95);
	--border: #dbe6f2;
	--text: #0f172a;
	--muted: #64748b;
	--primary: #2563eb;
	--shadow: 0 20px 38px rgba(15, 23, 42, 0.08);
}

body {
	font-family: "Outfit", sans-serif;
	background: var(--bg-grad);
	color: var(--text);
	min-height: 100vh;
}

.dashboard-wrap {
	max-width: 1240px;
	margin: 0 auto;
}

.page-head {
	display: flex;
	justify-content: space-between;
	align-items: flex-end;
	gap: 14px;
	margin-bottom: 18px;
	flex-wrap: wrap;
}

.page-title {
	font-size: 1.9rem;
	font-weight: 700;
	margin: 0;
}

.page-subtitle {
	margin: 4px 0 0;
	color: var(--muted);
}

.summary-grid {
	display: grid;
	grid-template-columns: repeat(auto-fit, minmax(190px, 1fr));
	gap: 12px;
	margin-bottom: 16px;
}

.summary-card {
	background: var(--panel-bg);
	border: 1px solid var(--border);
	border-radius: 14px;
	padding: 14px;
	box-shadow: 0 8px 18px rgba(15, 23, 42, 0.04);
}

.summary-label {
	font-size: 0.82rem;
	color: var(--muted);
	margin-bottom: 2px;
}

.summary-value {
	font-size: 1.4rem;
	font-weight: 700;
	line-height: 1.1;
}

.panel {
	background: var(--panel-bg);
	border: 1px solid var(--border);
	border-radius: 18px;
	box-shadow: var(--shadow);
	padding: 16px;
}

.appointment-grid {
	display: grid;
	grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
	gap: 14px;
}

.appointment-card {
	background: #fff;
	border: 1px solid var(--border);
	border-radius: 18px;
	box-shadow: 0 10px 24px rgba(15, 23, 42, 0.05);
	padding: 16px;
	height: 100%;
	transition: transform 0.2s ease, box-shadow 0.2s ease;
}

.appointment-card:hover {
	transform: translateY(-2px);
	box-shadow: 0 14px 30px rgba(15, 23, 42, 0.09);
}

.appointment-card-head {
	display: flex;
	justify-content: space-between;
	align-items: flex-start;
	gap: 12px;
	margin-bottom: 12px;
}

.appointment-index {
	display: inline-flex;
	align-items: center;
	justify-content: center;
	min-width: 34px;
	height: 34px;
	padding: 0 10px;
	border-radius: 10px;
	background: #eef4ff;
	border: 1px solid #cfe0ff;
	color: #1d4ed8;
	font-size: 0.82rem;
	font-weight: 800;
	flex: 0 0 auto;
}

.appointment-title {
	font-size: 1.02rem;
	font-weight: 700;
	margin: 0;
}

.appointment-subtitle {
	font-size: 0.86rem;
	color: var(--muted);
	margin-top: 2px;
}

.appointment-meta {
	display: grid;
	grid-template-columns: repeat(2, minmax(0, 1fr));
	gap: 10px;
	margin-bottom: 14px;
}

.meta-item {
	background: #f8fbff;
	border: 1px solid #e8eef7;
	border-radius: 12px;
	padding: 10px 12px;
}

.meta-label {
	display: block;
	font-size: 0.73rem;
	font-weight: 700;
	text-transform: uppercase;
	letter-spacing: 0.4px;
	color: var(--muted);
	margin-bottom: 4px;
}

.meta-value {
	font-size: 0.92rem;
	font-weight: 600;
	color: var(--text);
	word-break: break-word;
}

.appointment-actions {
	display: flex;
	flex-wrap: wrap;
	gap: 8px;
	margin-top: 2px;
}

.filter-row .form-control, .filter-row .form-select {
	border-radius: 11px;
	border: 1px solid #d2ddeb;
	min-height: 42px;
}

.table thead th {
	background: #0f172a;
	color: #fff;
	font-weight: 600;
	font-size: 0.88rem;
	border: none;
	white-space: nowrap;
}

.table tbody td {
	vertical-align: middle;
	white-space: nowrap;
}

.table tbody tr:hover {
	background: #f8fbff;
}

.status-pill {
	display: inline-flex;
	align-items: center;
	justify-content: center;
	padding: 5px 10px;
	border-radius: 999px;
	font-size: 0.76rem;
	font-weight: 700;
	border: 1px solid transparent;
}

.status-confirmed {
	background: #dcfce7;
	color: #166534;
	border-color: #bbf7d0;
}

.status-pending {
	background: #fef3c7;
	color: #92400e;
	border-color: #fde68a;
}

.status-cancelled {
	background: #ffe4e6;
	color: #9f1239;
	border-color: #fecdd3;
}

.action-btn {
	height: 32px;
	min-width: 86px;
	font-size: 0.8rem;
	font-weight: 600;
	border-radius: 9px;
}

.section-label {
	font-size: 0.82rem;
	font-weight: 700;
	text-transform: uppercase;
	letter-spacing: 0.6px;
	color: var(--muted);
	margin-bottom: 12px;
}

@media ( max-width : 768px) {
	.page-title {
		font-size: 1.45rem;
	}
	.appointment-meta {
		grid-template-columns: 1fr;
	}
}
</style>
</head>

<body data-admin-page="appointments">
	<%@ include file="Components/auth.jsp"%>

	<%
	String role = (String) mySession.getAttribute("role");
	if ("ADMIN".equalsIgnoreCase(role) || "STAFF".equalsIgnoreCase(role)) {
	%>

	<%
	if ("STAFF".equals(role)) {
	%>
	<jsp:include page="Staff/staffSidebar.jsp" />
	<%
	} else if ("ADMIN".equals(role)) {
	%>
	<jsp:include page="adminSidebar.jsp" />
	<%
	}
	%>

	<%
	List<Appointment> list = (List<Appointment>) request.getAttribute("appointmentList");
	%>

	<div class="main-content">

		<%@include file="Components/message.jsp"%>

		<div class="dashboard-wrap">
			<div class="page-head">
				<div>
					<h1 class="page-title">Appointments Overview</h1>
					<p class="page-subtitle">View, search, and manage appointment
						bookings from one place.</p>
				</div>
				<button class="btn btn-primary" type="button">
					<i class="fa-solid fa-plus me-2"></i>New Appointment
				</button>
			</div>

			<div class="summary-grid">
				<div class="summary-card">
					<div class="summary-label">Total Appointments</div>
					<div class="summary-value">128</div>
				</div>
				<div class="summary-card">
					<div class="summary-label">Confirmed</div>
					<div class="summary-value">84</div>
				</div>
				<div class="summary-card">
					<div class="summary-label">Pending</div>
					<div class="summary-value">31</div>
				</div>
				<div class="summary-card">
					<div class="summary-label">Cancelled</div>
					<div class="summary-value">13</div>
				</div>
			</div>

			<div class="panel">
				<div class="row g-2 filter-row mb-3">
					<div class="col-12 col-md-4">
						<input type="text" class="form-control"
							placeholder="Search by patient, email, or mobile">
					</div>
					<div class="col-6 col-md-2">
						<select class="form-select">
							<option selected>All Tests</option>
							<option>Blood Test</option>
							<option>X-Ray</option>
							<option>MRI</option>
							<option>CT Scan</option>
							<option>ECG</option>
						</select>
					</div>
					<div class="col-6 col-md-2">
						<select class="form-select">
							<option selected>All Status</option>
							<option>Confirmed</option>
							<option>Pending</option>
							<option>Cancelled</option>
						</select>
					</div>
					<div class="col-6 col-md-2">
						<input type="date" class="form-control">
					</div>
					<div class="col-6 col-md-2 d-grid">
						<button class="btn btn-outline-secondary" type="button">Apply
							Filter</button>
					</div>
				</div>

				<div class="section-label">Appointments</div>
				<div class="appointment-grid">
					<%
					int count = 1;
					if (list != null) {
						for (Appointment ap : list) {
							String status = ap.getStatus();
							String statusClass = "status-pending";
							if ("Confirmed".equalsIgnoreCase(status)) {
						statusClass = "status-confirmed";
							} else if ("Cancelled".equalsIgnoreCase(status)) {
						statusClass = "status-cancelled";
							}
					%>
					<div class="appointment-card">
						<div class="appointment-card-head">
							<div class="appointment-index">
								<%=count++%>
							</div>
							<div class="flex-grow-1">
								<h3 class="appointment-title">
									<%=ap.getPatientName()%>
								</h3>
								<div class="appointment-subtitle">
									Patient ID:
									<%=ap.getPatientId()%>
								</div>
							</div>
							<span class="status-pill <%=statusClass%>"> <%=status%>
							</span>
						</div>

						<div class="appointment-meta">
							<div class="meta-item">
								<span class="meta-label">Email</span>
								<div class="meta-value">
									<%=ap.getPatientEmail()%>
								</div>
							</div>
							<div class="meta-item">
								<span class="meta-label">Mobile</span>
								<div class="meta-value">
									<%=ap.getPatientMobile()%>
								</div>
							</div>
							<div class="meta-item">
								<span class="meta-label">Test</span>
								<div class="meta-value">
									<%=ap.getTestName()%>
								</div>
							</div>
							<div class="meta-item">
								<span class="meta-label">Date</span>
								<div class="meta-value">
									<%=ap.getAppointmentDate()%>
								</div>
							</div>
							<div class="meta-item">
								<span class="meta-label">Time</span>
								<div class="meta-value">
									<%=ap.getAppointmentTime()%>
								</div>
							</div>
							<div class="meta-item">
								<span class="meta-label">Location</span>
								<div class="meta-value">
									<%=ap.getLabLocation()%>
								</div>
							</div>
							<div class="meta-item">
								<span class="meta-label">Priority</span>
								<div class="meta-value">
									<%=ap.getPriority()%>
								</div>
							</div>
						</div>

						<form
							action="<%=request.getContextPath()%>/appointmentConfirmation"
							method="post">
							<div class="appointment-actions">
								<input type="hidden" name="id" value="<%=ap.getId()%>">

								<button type="submit" name="action" value="confirm"
									class="btn btn-success btn-sm action-btn">Confirm</button>

								<button type="submit" name="action" value="cancel"
									formaction="cancelAppointment"
									class="btn btn-warning btn-sm action-btn">Cancel</button>
							</div>
						</form>
					</div>
					<%
					}
					}
					%>
				</div>
			</div>
		</div>
	</div>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>

	<%
	} else {
	response.sendRedirect(request.getContextPath() + "/Pages/unauthorizedUser.jsp");
	return;
	}
	%>
</body>

</html>