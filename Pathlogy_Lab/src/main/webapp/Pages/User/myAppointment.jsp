<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>My Appointment</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Outfit:wght@400;500;600;700;800&display=swap"
	rel="stylesheet">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css"
	rel="stylesheet">
<style>
:root {
	--page-bg: radial-gradient(circle at top left, #e0f2fe 0%, #f8fbff 34%, #eef4fb
		100%);
	--card-bg: rgba(255, 255, 255, 0.92);
	--ink: #0f172a;
	--muted: #64748b;
	--line: #dbe5f1;
	--primary: #2563eb;
	--primary-soft: #dbeafe;
	--success: #0f766e;
	--warning: #b45309;
	--danger: #be123c;
	--shadow: 0 20px 40px rgba(15, 23, 42, 0.12);
	--radius: 22px;
}

body {
	margin: 0;
	font-family: 'Outfit', sans-serif;
	background: var(--page-bg);
	color: var(--ink);
}

.page-shell {
	min-height: 100vh;
	padding: 32px 18px;
}

.page-wrap {
	max-width: 1180px;
	margin: 0 auto;
}

.hero {
	display: flex;
	align-items: center;
	justify-content: space-between;
	gap: 18px;
	flex-wrap: wrap;
	margin-bottom: 22px;
}

.hero-copy h1 {
	font-size: clamp(2rem, 3vw, 2.8rem);
	font-weight: 800;
	margin: 0 0 10px;
}

.hero-copy p {
	margin: 0;
	color: var(--muted);
	max-width: 760px;
}

.back-link {
	display: inline-flex;
	align-items: center;
	gap: 8px;
	padding: 10px 16px;
	border-radius: 999px;
	text-decoration: none;
	font-weight: 700;
	color: var(--primary);
	background: #eff6ff;
	border: 1px solid #bfdbfe;
	white-space: nowrap;
}

.back-link:hover {
	background: #dbeafe;
	color: #1d4ed8;
}

.appointment-card {
	background: var(--card-bg);
	border: 1px solid var(--line);
	border-radius: var(--radius);
	box-shadow: var(--shadow);
	overflow: hidden;
}

.card-top {
	padding: 28px;
	background: linear-gradient(135deg, #eff6ff 0%, #f8fbff 48%, #eefdfb 100%);
	border-bottom: 1px solid var(--line);
}

.summary-grid {
	display: grid;
	grid-template-columns: repeat(12, minmax(0, 1fr));
	gap: 16px;
}

.summary-panel {
	grid-column: span 12;
	padding: 24px;
	background: rgba(255, 255, 255, 0.8);
	border: 1px solid rgba(219, 229, 241, 0.95);
	border-radius: 18px;
	backdrop-filter: blur(8px);
}

.status-chip {
	display: inline-flex;
	align-items: center;
	gap: 8px;
	padding: 8px 14px;
	border-radius: 999px;
	font-weight: 700;
	font-size: 0.92rem;
	background: #ecfeff;
	color: var(--success);
}

.status-chip i {
	font-size: 0.95rem;
}

.appointment-id {
	margin-top: 16px;
	font-size: 2.2rem;
	font-weight: 800;
	letter-spacing: 0.2px;
}

.meta-row {
	display: flex;
	flex-wrap: wrap;
	gap: 10px;
	margin-top: 14px;
}

.meta-pill {
	display: inline-flex;
	align-items: center;
	gap: 8px;
	padding: 9px 14px;
	border-radius: 999px;
	background: #ffffff;
	border: 1px solid var(--line);
	color: var(--ink);
	font-weight: 600;
}

.meta-pill i {
	color: var(--primary);
}

.field-section {
	padding: 26px 28px 30px;
}

.section-heading {
	display: flex;
	align-items: center;
	justify-content: space-between;
	gap: 12px;
	margin-bottom: 18px;
	flex-wrap: wrap;
}

.section-heading h2 {
	margin: 0;
	font-size: 1.35rem;
	font-weight: 800;
}

.section-heading p {
	margin: 0;
	color: var(--muted);
}

.field-grid {
	display: grid;
	grid-template-columns: repeat(12, minmax(0, 1fr));
	gap: 16px;
}

.info-box {
	grid-column: span 12;
	padding: 18px 18px 16px;
	background: #ffffff;
	border: 1px solid var(--line);
	border-radius: 16px;
	box-shadow: 0 10px 22px rgba(15, 23, 42, 0.05);
}

.info-label {
	display: flex;
	align-items: center;
	gap: 10px;
	font-size: 0.88rem;
	font-weight: 700;
	text-transform: uppercase;
	letter-spacing: 0.08em;
	color: var(--muted);
	margin-bottom: 10px;
}

.info-label i {
	width: 30px;
	height: 30px;
	border-radius: 10px;
	display: inline-flex;
	align-items: center;
	justify-content: center;
	background: var(--primary-soft);
	color: var(--primary);
}

.info-value {
	font-size: 1.05rem;
	font-weight: 700;
	color: var(--ink);
}

.info-note {
	margin-top: 6px;
	color: var(--muted);
	font-size: 0.93rem;
}

.priority-high {
	color: var(--danger);
}

.priority-medium {
	color: var(--warning);
}

.priority-normal {
	color: var(--success);
}

.footer-note {
	margin-top: 18px;
	padding: 14px 18px;
	border-radius: 14px;
	background: #f8fafc;
	border: 1px dashed #cbd5e1;
	color: var(--muted);
}

@media ( min-width : 768px) {
	.summary-panel {
		grid-column: span 5;
	}
	.field-grid .info-box:nth-child(1), .field-grid .info-box:nth-child(2),
		.field-grid .info-box:nth-child(3), .field-grid .info-box:nth-child(4)
		{
		grid-column: span 6;
	}
	.field-grid .info-box:nth-child(5), .field-grid .info-box:nth-child(6),
		.field-grid .info-box:nth-child(7), .field-grid .info-box:nth-child(8)
		{
		grid-column: span 6;
	}
}

@media ( min-width : 992px) {
	.summary-panel {
		grid-column: span 4;
	}
	.field-grid .info-box:nth-child(1), .field-grid .info-box:nth-child(2),
		.field-grid .info-box:nth-child(3), .field-grid .info-box:nth-child(4)
		{
		grid-column: span 3;
	}
	.field-grid .info-box:nth-child(5), .field-grid .info-box:nth-child(6) {
		grid-column: span 6;
	}
}
</style>
</head>

<body>
	<div class="page-shell">
		<div class="page-wrap">
			<div class="hero">
				<div class="hero-copy">
					<h1>My Appointment</h1>
					<p>This is a static preview of the appointment details using
						mock data, ready to be replaced with live values later.</p>
				</div>
				<a href="#" class="back-link"><i class="bi bi-arrow-left"></i>
					Back to dashboard</a>
			</div>

			<div class="appointment-card">
				<div class="card-top">
					<div class="summary-grid">
						<div class="summary-panel">
							<span class="status-chip"><i
								class="bi bi-check-circle-fill"></i> Confirmed</span>
							<div class="appointment-id">Appointment #1024</div>
							<div class="meta-row">
								<span class="meta-pill"><i class="bi bi-person-badge"></i>
									Patient ID: P-20418</span> <span class="meta-pill"><i
									class="bi bi-calendar-event"></i> 05 May 2026</span> <span
									class="meta-pill"><i class="bi bi-clock"></i> 10:30 AM</span>
							</div>
						</div>

						<div class="summary-panel">
							<div class="info-label">
								<i class="bi bi-capsule-pill"></i> Test
							</div>
							<div class="info-value">Complete Blood Count</div>
							<div class="info-note">Routine diagnostic test for general
								health screening.</div>
						</div>

						<div class="summary-panel">
							<div class="info-label">
								<i class="bi bi-geo-alt"></i> Location
							</div>
							<div class="info-value">Pathology Lab, Block B, City Center</div>
							<div class="info-note">Sample collection desk, first floor.</div>
						</div>
					</div>
				</div>

				<div class="field-section">
					<div class="section-heading">
						<div>
							<h2>Appointment Details</h2>
							<p>Mock values shown below to preview all fields.</p>
						</div>
					</div>

					<div class="field-grid">
						<div class="info-box">
							<div class="info-label">
								<i class="bi bi-hash"></i> ID
							</div>
							<div class="info-value">1024</div>
							<div class="info-note">Database record id1</div>
						</div>

						<div class="info-box">
							<div class="info-label">
								<i class="bi bi-person-vcard"></i> Patient ID
							</div>
							<div class="info-value">P-20418</div>
							<div class="info-note">pId</div>
						</div>

						<div class="info-box">
							<div class="info-label">
								<i class="bi bi-clipboard2-pulse"></i> Test Name
							</div>
							<div class="info-value">Complete Blood Count</div>
							<div class="info-note">test</div>
						</div>

						<div class="info-box">
							<div class="info-label">
								<i class="bi bi-calendar3"></i> Appointment Date
							</div>
							<div class="info-value">05 May 2026</div>
							<div class="info-note">apDate</div>
						</div>

						<div class="info-box">
							<div class="info-label">
								<i class="bi bi-clock-history"></i> Time Slot
							</div>
							<div class="info-value">10:30 AM</div>
							<div class="info-note">apTime / time</div>
						</div>

						<div class="info-box">
							<div class="info-label">
								<i class="bi bi-geo"></i> Lab Location
							</div>
							<div class="info-value">Pathology Lab, Block B, City Center</div>
							<div class="info-note">loc</div>
						</div>

						<div class="info-box">
							<div class="info-label">
								<i class="bi bi-info-circle"></i> Status
							</div>
							<div class="info-value">Confirmed</div>
							<div class="info-note">sts</div>
						</div>

						<div class="info-box">
							<div class="info-label">
								<i class="bi bi-lightning-charge"></i> Priority
							</div>
							<div class="info-value priority-high">High</div>
							<div class="info-note">priority</div>
						</div>

						<div class="info-box">
							<div class="info-label">
								<i class="bi bi-upc-scan"></i> Token No
							</div>
							<div class="info-value">17</div>
							<div class="info-note">token</div>
						</div>

						<div class="info-box">
							<div class="info-label">
								<i class="bi bi-diagram-3"></i> Booking Type
							</div>
							<div class="info-value">Online</div>
							<div class="info-note">mode</div>
						</div>
					</div>

					<div class="footer-note">
						<i class="bi bi-info-circle me-2"></i>This layout is static and
						uses mock data only. You can later replace each value with live
						appointment data.
					</div>
				</div>
			</div>
		</div>
	</div>
</body>

</html>