package com.pathology.controller;

import jakarta.mail.Authenticator;
import jakarta.mail.Message;
import jakarta.mail.MessagingException;
import jakarta.mail.Multipart;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeBodyPart;
import jakarta.mail.internet.MimeMessage;
import jakarta.mail.internet.MimeMultipart;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.File;
import java.io.IOException;
import java.util.Properties;
import java.util.ResourceBundle;

import com.pathology.dao.ReportDao;
import com.pathology.model.Report;

@WebServlet("/sendReport")
public class SendReportByEmail extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public SendReportByEmail() {
		super();
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		int id = Integer.parseInt(request.getParameter("id"));

		HttpSession session = request.getSession();
		ReportDao dao = new ReportDao();
		Report r = dao.getReport(id);

		String fileName = r.getReportPath();
		String toEmail = r.getPatientEmail();

		// Load credentials from properties file
		ResourceBundle bundle = ResourceBundle.getBundle("config");
		String fromEmail = bundle.getString("email.from");
		String appPass = bundle.getString("email.password");
		String smtpHost = bundle.getString("email.smtp.host");
		String smtpPort = bundle.getString("email.smtp.port");
		String reportsPath = bundle.getString("reports.path");

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
			MimeMessage ms = new MimeMessage(mailSession);
			ms.setFrom(new InternetAddress(fromEmail));
			ms.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));

			ms.setSubject("Your Medical Report");

			MimeBodyPart textPart = new MimeBodyPart();
			textPart.setText("Dear Patient,\n\nYour report is attached.\n\nThank you.");

			String fullPath = reportsPath + fileName;

			File file = new File(fullPath);

			MimeBodyPart filePart = new MimeBodyPart();
			filePart.attachFile(file);

			Multipart mul = new MimeMultipart();
			mul.addBodyPart(textPart);
			mul.addBodyPart(filePart);

			ms.setContent(mul);

			try {
				Transport.send(ms);

				int i = dao.updateStatus(id);
				int j = dao.markEmailSent(id);

				if (i > 0 && j > 0) {
					session.setAttribute("successMsg", "Report sent successfully!");
				}
			} catch (Exception e) {
				session.setAttribute("errorMsg", "Failed to send email!");
			}

			response.sendRedirect(request.getContextPath() + "/viewAllReports");

		} catch (MessagingException e) {
			e.printStackTrace();
		}
	}

}
