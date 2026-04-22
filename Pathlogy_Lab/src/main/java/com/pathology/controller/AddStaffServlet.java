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

@WebServlet("/addStaff")
public class AddStaffServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public AddStaffServlet() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String name = request.getParameter("fullName");
		String email = request.getParameter("email");
		String mobile = request.getParameter("mobile");
		String password = request.getParameter("password");
		String role = request.getParameter("role");

		String hashPass = BCrypt.hashpw(password, BCrypt.gensalt());

		User u = new User(name, email, mobile, hashPass, role);

		UserDao dao = new UserDao();

		int i = dao.addStaff(u);

		HttpSession session = request.getSession();

		if (i > 0) {
			session.setAttribute("successMsg", "Staff Addedd Successfully");
			response.sendRedirect(request.getContextPath() + "/Pages/admin-dashboard.jsp");
		} else {
			session.setAttribute("errorMsg", "Something went wrong. Try again.");
			response.sendRedirect(request.getContextPath() + "/Pages/addStaff.jsp");
		}

	}

}
