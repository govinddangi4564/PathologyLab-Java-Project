package com.pathology.controller;

import java.io.IOException;
import java.sql.Date;
import java.time.LocalTime;
import java.util.Properties;
import java.util.ResourceBundle;

import com.pathology.dao.AppointmentDao;
import com.pathology.model.Appointment;

import jakarta.mail.Authenticator;
import jakarta.mail.Message;
import jakarta.mail.MessagingException;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/appointmentConfirmation")
public class SendAppointmentConfirmation extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public SendAppointmentConfirmation() {
		super();
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		int id = Integer.parseInt(request.getParameter("id"));

		AppointmentDao dao = new AppointmentDao();
		Appointment ap = dao.getAppointmentById(id);

		String toEmail = ap.getPatientEmail();
		String patientName = ap.getPatientName();
		Date appointmentDate = ap.getAppointmentDate();
		LocalTime appointmentTime = ap.getAppointmentTime();
		String testName = ap.getTestName();

		HttpSession session = request.getSession();

		ResourceBundle bundle = ResourceBundle.getBundle("config");
		String fromEmail = bundle.getString("email.from");
		String appPass = bundle.getString("email.password");
		String smtpHost = bundle.getString("email.smtp.host");
		String smtpPort = bundle.getString("email.smtp.port");

		Properties props = new Properties();
		props.setProperty("mail.smtp.auth", "true");
		props.setProperty("mail.smtp.starttls.enable", "true");
		props.setProperty("mail.smtp.host", smtpHost);
		props.setProperty("mail.smtp.port", smtpPort);

		Session mailSession = Session.getInstance(props, new Authenticator() {
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(fromEmail, appPass);
			}
		});

		try {
			MimeMessage msg = new MimeMessage(mailSession);
			msg.setFrom(new InternetAddress(fromEmail));
			msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
			msg.setSubject("Appointment Confirmation");

			String message = "<html>"
					+ "<body style='font-family:Arial, sans-serif; background:#f4f6f8; padding:20px;'>"

					+ "<div style='max-width:500px; margin:auto; background:#ffffff; padding:25px; border-radius:10px; box-shadow:0 5px 15px rgba(0,0,0,0.1);'>"

					+ "<h2 style='color:#0b7a75; text-align:center;'>Pathology Lab</h2>"
					+ "<hr style='border:none; border-top:1px solid #eee;'>"

					+ "<p style='font-size:15px;'>Dear " + patientName + ",</p>"

					+ "<p style='font-size:15px;'>Your appointment has been <b style='color:#0b7a75;'>confirmed</b>.</p>"

					+ "<div style='background:#f9fbfc; padding:15px; border-radius:8px; margin:20px 0;'>"
					+ "<p><b>Date:</b> " + appointmentDate + "</p>" + "<p><b>Time:</b> " + appointmentTime + "</p>"
					+ "<p><b>Test:</b> " + testName + "</p>" + "</div>"

					+ "<p style='font-size:14px; color:#555;'>Please arrive 10 minutes early.</p>"

					+ "<hr style='border:none; border-top:1px solid #eee;'>"
					+ "<p style='font-size:13px; color:#888; text-align:center;'>© 2026 Pathology Lab</p>"

					+ "</div></body></html>";

			msg.setContent(message, "text/html");

			Transport.send(msg);

			session.setAttribute("successMsg", "Appointment email sent successfully");

		} catch (MessagingException e) {
			e.printStackTrace();
			session.setAttribute("errorMsg", "Email sending failed");
		}

		response.sendRedirect(request.getContextPath() + "/Pages/viewAppointment.jsp");
	}

}
