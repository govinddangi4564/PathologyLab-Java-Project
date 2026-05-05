package com.pathology.service;

import java.io.UnsupportedEncodingException;
import java.util.Properties;
import java.util.ResourceBundle;

import jakarta.mail.Authenticator;
import jakarta.mail.Message;
import jakarta.mail.MessagingException;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;

public class EmailService {

	private static final String SENDER_NAME = getSenderName();

	private static String getSenderName() {
		ResourceBundle bundle = null;
		try {
			bundle = ResourceBundle.getBundle("config");
		} catch (Exception e) {
		}

		return bundle != null && bundle.containsKey("email.from.name") ? bundle.getString("email.from.name")
				: "PathologyLab";
	}

	public static void sendEmail(String toEmail, String subject, String body) throws MessagingException {

		ResourceBundle bundle = null;
		try {
			bundle = ResourceBundle.getBundle("config");
		} catch (Exception e) {
		}

		String fromEmail = System.getenv("EMAIL_FROM") != null ? System.getenv("EMAIL_FROM")
				: (bundle != null ? bundle.getString("email.from") : "");
		String replyToEmail = bundle != null && bundle.containsKey("email.reply.to")
				? bundle.getString("email.reply.to")
				: fromEmail;
		String appPass = System.getenv("EMAIL_PASSWORD") != null ? System.getenv("EMAIL_PASSWORD")
				: (bundle != null ? bundle.getString("email.password") : "");
		String smtpHost = bundle != null ? bundle.getString("email.smtp.host") : "smtp.gmail.com";
		String smtpPort = bundle != null ? bundle.getString("email.smtp.port") : "587";

		Properties props = new Properties();
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.starttls.enable", "true");
		props.put("mail.smtp.host", smtpHost);
		props.put("mail.smtp.port", smtpPort);

		Session session = Session.getInstance(props, new Authenticator() {
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(fromEmail, appPass);
			}
		});

		MimeMessage msg = new MimeMessage(session);
		try {
			msg.setFrom(new InternetAddress(fromEmail, SENDER_NAME));
		} catch (UnsupportedEncodingException | MessagingException e) {
			e.printStackTrace();
		}
		msg.setReplyTo(InternetAddress.parse(replyToEmail));
		msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
		msg.setSubject(subject);
		msg.setContent(body, "text/html");

		Transport.send(msg);
	}
}