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

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public LoginServlet() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.getRequestDispatcher("/Pages/login.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String emailOrMobile = request.getParameter("loginId");
		String pass = request.getParameter("password");

		UserDao dao = new UserDao();
		User user = dao.login(emailOrMobile);

		if (user != null && user.getPassword() != null && BCrypt.checkpw(pass, user.getPassword())) {

			HttpSession oldSession = request.getSession(false);
			if (oldSession != null) {
				oldSession.invalidate();
			}

			HttpSession session = request.getSession(true);
			session.setAttribute("userObj", user);

			String role = user.getRole();

			session.setAttribute("successMsg", "Login Successful");

			if ("USER".equalsIgnoreCase(role)) {
				response.sendRedirect(request.getContextPath() + "/Pages/User/user-dashboard.jsp");
			} else if ("ADMIN".equalsIgnoreCase(role)) {
				response.sendRedirect(request.getContextPath() + "/Pages/admin-dashboard.jsp");
			} else if ("STAFF".equalsIgnoreCase(role)) {
				response.sendRedirect(request.getContextPath() + "/Pages/Staff/staff-dashboard.jsp");
			}

		} else {
			HttpSession session = request.getSession();
			session.setAttribute("errorMsg", "Invalid Credentials");

			response.sendRedirect(request.getContextPath() + "/Pages/login.jsp");
		}
	}
}