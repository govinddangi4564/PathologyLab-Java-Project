package com.pathology.template;

public class ReportTemplate {

	public static String getTemplate() {

		return "<html>" + "<body style='font-family:Segoe UI, Arial, sans-serif; background:#f4f6f8; padding:20px;'>"

				+ "<div style='max-width:600px; margin:auto; background:#ffffff; padding:30px; border-radius:12px; box-shadow:0 8px 20px rgba(0,0,0,0.08);'>"

				// Header
				+ "<h2 style='color:#0b7a75; text-align:center; margin-bottom:5px;'>Pathology Lab</h2>"
				+ "<p style='text-align:center; color:#888; font-size:13px;'>Accurate Reports. Trusted Care.</p>"
				+ "<hr style='border:none; border-top:1px solid #eee; margin:20px 0;'>"

				// Greeting
				+ "<p style='font-size:15px; color:#333;'>Dear Patient,</p>"

				// Message
				+ "<p style='font-size:15px; color:#333;'>"
				+ "We are pleased to inform you that your <b>medical test report</b> has been successfully generated and is now ready for your review."
				+ "</p>"

				// Highlight box
				+ "<div style='background:#f1f9f9; padding:15px; border-left:4px solid #0b7a75; border-radius:6px; margin:20px 0;'>"
				+ "<p style='margin:0; font-size:14px; color:#333;'>"
				+ "📄 Your report is attached with this email. Please download and review it carefully." + "</p>"
				+ "</div>"

				// Extra info
				+ "<p style='font-size:14px; color:#555;'>"
				+ "If you have any questions or need assistance understanding your report, "
				+ "our medical team is here to help you." + "</p>"

				// Closing
				+ "<p style='font-size:14px; color:#333;'>" + "Wishing you good health,<br>"
				+ "<b>Pathology Lab Team</b>" + "</p>"

				// Footer
				+ "<hr style='border:none; border-top:1px solid #eee; margin:25px 0;'>"
				+ "<p style='font-size:12px; color:#999; text-align:center;'>"
				+ "This is an automated email. Please do not reply directly.<br>"
				+ "© 2026 Pathology Lab. All rights reserved." + "</p>"

				+ "</div>" + "</body>" + "</html>";
	}
}