package com.leaveapp;

import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class EmailUtil {

	// Gmail SMTP configuration
	private static final String SMTP_HOST = "smtp.gmail.com";
	private static final String SMTP_PORT = "587";
	private static final String EMAIL_USERNAME = "sujitsatpute79@gmail.com"; // Replace with your Gmail
	private static final String EMAIL_PASSWORD = "ojokvpenmgtyvkme"; // Replace with your App Password

	/**
	 * Send email notification when leave request status is updated
	 */
	public static void sendLeaveStatusEmail(String toEmail, String employeeName, String leaveType, String status,
			String reason, String fromDate, String toDate) throws Exception {

		Properties props = new Properties();
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.starttls.enable", "true");
		props.put("mail.smtp.host", SMTP_HOST);
		props.put("mail.smtp.port", SMTP_PORT);
		props.put("mail.smtp.ssl.trust", "smtp.gmail.com");

		Session session = Session.getInstance(props, new Authenticator() {
			@Override
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(EMAIL_USERNAME, EMAIL_PASSWORD);
			}
		});

		Message message = new MimeMessage(session);
		message.setFrom(new InternetAddress(EMAIL_USERNAME, "Leave Management System"));
		message.setReplyTo(new InternetAddress[] { new InternetAddress("noreply@yourcompany.com", "No Reply") });
		message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
		message.setHeader("Return-Path", "<>");

		String statusIcon = status.equals("Approved") ? "✅" : "❌";
		String subject = statusIcon + " Leave Request " + status + " - " + leaveType;
		message.setSubject(subject);

		// HTML email content with proper icons
		String htmlContent = "<html><body style='font-family: Arial, sans-serif; line-height: 1.6; color: #333;'>"
				+ "<div style='max-width: 600px; margin: 0 auto; padding: 20px; border: 1px solid #ddd; border-radius: 10px;'>"
				+ "<h2 style='color: " + (status.equals("Approved") ? "#28a745" : "#dc3545") + "; text-align: center;'>"
				+ statusIcon + " Leave Request " + status + "</h2>" +

				"<div style='background: #f8f9fa; padding: 15px; border-radius: 5px; margin: 20px 0;'>"
				+ "<p><strong>📋 Employee:</strong> " + employeeName + "</p>" + "<p><strong>📅 Leave Type:</strong> "
				+ leaveType + "</p>" + "<p><strong>📆 From Date:</strong> " + fromDate + "</p>"
				+ "<p><strong>📆 To Date:</strong> " + toDate + "</p>" + "<p><strong>💬 Reason:</strong> " + reason
				+ "</p>" + "<p><strong>⚡ Status:</strong> <span style='color: "
				+ (status.equals("Approved") ? "#28a745" : "#dc3545") + "; font-weight: bold;'>" + statusIcon + " "
				+ status + "</span></p>" + "</div>" +

				"<div style='text-align: center; margin-top: 30px; padding: 15px; background: #e9ecef; border-radius: 5px;'>"
				+ "<p style='margin: 0; color: #6c757d; font-size: 14px;'>" + "🏢 Leave Management System<br>"
				+ "📧 This is an automated message, please do not reply." + "</p></div>" + "</div></body></html>";

		message.setContent(htmlContent, "text/html; charset=utf-8");
		Transport.send(message);
	}

	/**
	 * Send password reset email
	 */
	public static void sendPasswordResetEmail(String toEmail, String username, String resetLink) throws Exception {

		Properties props = new Properties();
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.starttls.enable", "true");
		props.put("mail.smtp.host", SMTP_HOST);
		props.put("mail.smtp.port", SMTP_PORT);
		props.put("mail.smtp.ssl.trust", "smtp.gmail.com");

		Session session = Session.getInstance(props, new Authenticator() {
			@Override
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(EMAIL_USERNAME, EMAIL_PASSWORD);
			}
		});

		Message message = new MimeMessage(session);
		message.setFrom(new InternetAddress(EMAIL_USERNAME, "Leave Management System"));
		message.setReplyTo(new InternetAddress[] { new InternetAddress("noreply@yourcompany.com", "No Reply") });
		message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
		message.setHeader("Return-Path", "<>");
		message.setSubject("🔐 Password Reset Request - Leave Management System");

		// HTML password reset email content
		String htmlContent = "<html><body style='font-family: Arial, sans-serif; line-height: 1.6; color: #333;'>"
				+ "<div style='max-width: 600px; margin: 0 auto; padding: 20px; border: 1px solid #ddd; border-radius: 10px;'>"
				+ "<h2 style='color: #e74c3c; text-align: center;'>🔐 Password Reset Request</h2>" +

				"<div style='background: #f8f9fa; padding: 15px; border-radius: 5px; margin: 20px 0;'>"
				+ "<p>Dear <strong>" + username + "</strong>,</p>"
				+ "<p>🔑 You have requested to reset your password for your Leave Management System account.</p>"
				+ "<p>Click the button below to reset your password:</p>" +

				"<div style='text-align: center; margin: 25px 0;'>" + "<a href='" + resetLink
				+ "' style='background: linear-gradient(135deg, #e74c3c 0%, #c0392b 100%); "
				+ "color: white; padding: 12px 30px; text-decoration: none; border-radius: 25px; "
				+ "font-weight: bold; display: inline-block; box-shadow: 0 4px 15px rgba(231, 76, 60, 0.3);'>"
				+ "🔑 Reset My Password</a>" + "</div>" +

				"<p style='font-size: 14px; color: #6c757d;'>"
				+ "⏰ <strong>Important:</strong> This link will expire in 1 hour for security reasons.</p>" +

				"<p style='font-size: 14px; color: #6c757d;'>"
				+ "🚫 If you didn't request this password reset, please ignore this email. Your password will remain unchanged.</p>"
				+ "</div>" +

				"<div style='text-align: center; margin-top: 30px; padding: 15px; background: #e9ecef; border-radius: 5px;'>"
				+ "<p style='margin: 0; color: #6c757d; font-size: 14px;'>" + "🏢 Leave Management System<br>"
				+ "📧 This is an automated message, please do not reply." + "</p></div>" + "</div></body></html>";

		message.setContent(htmlContent, "text/html; charset=utf-8");
		Transport.send(message);
	}

	/**
	 * Send welcome email to new registered users
	 */
	public static void sendWelcomeEmail(String toEmail, String username) throws Exception {

		Properties props = new Properties();
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.starttls.enable", "true");
		props.put("mail.smtp.host", SMTP_HOST);
		props.put("mail.smtp.port", SMTP_PORT);
		props.put("mail.smtp.ssl.trust", "smtp.gmail.com");

		Session session = Session.getInstance(props, new Authenticator() {
			@Override
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(EMAIL_USERNAME, EMAIL_PASSWORD);
			}
		});

		Message message = new MimeMessage(session);
		message.setFrom(new InternetAddress(EMAIL_USERNAME, "Leave Management System"));
		message.setReplyTo(new InternetAddress[] { new InternetAddress("noreply@yourcompany.com", "No Reply") });
		message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
		message.setHeader("Return-Path", "<>");
		message.setSubject("🎉 Welcome to Leave Management System");

		// HTML welcome email content
		String htmlContent = "<html><body style='font-family: Arial, sans-serif; line-height: 1.6; color: #333;'>"
				+ "<div style='max-width: 600px; margin: 0 auto; padding: 20px; border: 1px solid #ddd; border-radius: 10px;'>"
				+ "<h2 style='color: #28a745; text-align: center;'>🎉 Welcome to Leave Management System!</h2>" +

				"<div style='background: #f8f9fa; padding: 15px; border-radius: 5px; margin: 20px 0;'>"
				+ "<p>Dear <strong>" + username + "</strong>,</p>"
				+ "<p>🎊 Congratulations! Your account has been successfully created.</p>" + "<p>You can now:</p>"
				+ "<ul>" + "<li>📝 Apply for leave requests</li>" + "<li>📊 Track your leave status</li>"
				+ "<li>📈 View your leave history</li>" + "<li>📧 Receive email notifications</li>" + "</ul>" + "</div>"
				+

				"<div style='text-align: center; margin-top: 30px; padding: 15px; background: #e9ecef; border-radius: 5px;'>"
				+ "<p style='margin: 0; color: #6c757d; font-size: 14px;'>" + "🏢 Leave Management System<br>"
				+ "📧 This is an automated message, please do not reply." + "</p></div>" + "</div></body></html>";

		message.setContent(htmlContent, "text/html; charset=utf-8");
		Transport.send(message);
	}

	/**
	 * Test email functionality
	 */
	public static void sendTestEmail(String toEmail) throws Exception {

		Properties props = new Properties();
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.starttls.enable", "true");
		props.put("mail.smtp.host", SMTP_HOST);
		props.put("mail.smtp.port", SMTP_PORT);
		props.put("mail.smtp.ssl.trust", "smtp.gmail.com");

		Session session = Session.getInstance(props, new Authenticator() {
			@Override
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(EMAIL_USERNAME, EMAIL_PASSWORD);
			}
		});

		Message message = new MimeMessage(session);
		message.setFrom(new InternetAddress(EMAIL_USERNAME, "Leave Management System"));
		message.setReplyTo(new InternetAddress[] { new InternetAddress("noreply@yourcompany.com", "No Reply") });
		message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
		message.setHeader("Return-Path", "<>");
		message.setSubject("🧪 Test Email - Leave Management System");

		// HTML test email content
		String htmlContent = "<html><body style='font-family: Arial, sans-serif; line-height: 1.6; color: #333;'>"
				+ "<div style='max-width: 600px; margin: 0 auto; padding: 20px; border: 1px solid #ddd; border-radius: 10px;'>"
				+ "<h2 style='color: #007bff; text-align: center;'>🧪 Email Test Successful!</h2>" +

				"<div style='background: #f8f9fa; padding: 15px; border-radius: 5px; margin: 20px 0;'>"
				+ "<p>✅ <strong>Email Configuration Working!</strong></p>" + "<p>📧 SMTP Host: " + SMTP_HOST + "</p>"
				+ "<p>🔐 Authentication: Enabled</p>"
				+ "<p>🚀 Your leave management system is ready to send notifications!</p>" + "</div>" +

				"<div style='text-align: center; margin-top: 30px; padding: 15px; background: #e9ecef; border-radius: 5px;'>"
				+ "<p style='margin: 0; color: #6c757d; font-size: 14px;'>" + "🏢 Leave Management System<br>"
				+ "📧 This is an automated test message." + "</p></div>" + "</div></body></html>";

		message.setContent(htmlContent, "text/html; charset=utf-8");
		Transport.send(message);
	}
}

//private static final String EMAIL_USERNAME = "sujitsatpute79@gmail.com";
//private static final String EMAIL_PASSWORD = "ojokvpenmgtyvkme";