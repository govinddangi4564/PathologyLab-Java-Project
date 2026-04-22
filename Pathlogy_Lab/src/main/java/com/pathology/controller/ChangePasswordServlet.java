package com.pathology.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

import org.mindrot.jbcrypt.BCrypt;

import com.pathology.dao.UserDao;
import com.pathology.model.User;

@WebServlet("/changePassword")
public class ChangePasswordServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public ChangePasswordServlet() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		HttpSession session = request.getSession(false);

		if (session == null || session.getAttribute("userObj") == null) {
			response.sendRedirect(request.getContextPath() + "/Pages/login.jsp");
			return;
		}

		User u = (User) session.getAttribute("userObj");
		String email = u.getEmail();

		String currentPassword = request.getParameter("currentPassword");
		String newPassword = request.getParameter("newPassword");
		String confirmPassword = request.getParameter("confirmPassword");

		if (currentPassword == null || newPassword == null || confirmPassword == null
				|| !newPassword.equals(confirmPassword)) {

			session.setAttribute("errorMsg", "Passwords do not match");
			response.sendRedirect(request.getContextPath() + "/Pages/User/user-dashboard.jsp");
			return;
		}

		UserDao dao = new UserDao();
		User user = dao.getPassword(email);

		if (user == null || user.getPassword() == null || !BCrypt.checkpw(currentPassword, user.getPassword())) {

			session.setAttribute("errorMsg", "Current password is incorrect");
			response.sendRedirect(request.getContextPath() + "/Pages/User/user-dashboard.jsp");
			return;
		}

		String hashPass = BCrypt.hashpw(newPassword, BCrypt.gensalt());

		int i = dao.updatePassword(email, hashPass);

		if (i > 0) {
			session.setAttribute("successMsg", "Password updated successfully");

			//  logout
			// session.invalidate();

		} else {
			session.setAttribute("errorMsg", "Failed to update password");
		}

		response.sendRedirect(request.getContextPath() + "/Pages/User/user-dashboard.jsp");
	}
}
