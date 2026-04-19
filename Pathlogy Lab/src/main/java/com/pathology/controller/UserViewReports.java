package com.pathology.controller;

import java.io.IOException;
import java.util.List;

import com.pathology.dao.ReportDao;
import com.pathology.model.Report;
import com.pathology.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/userViewReports")
public class UserViewReports extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		HttpSession session = request.getSession(false);

		// check session
		if (session == null || session.getAttribute("userObj") == null) {
			response.sendRedirect("./Pages/login.jsp"); // redirect if not logged in
			return;
		}

		User u = (User) session.getAttribute("userObj");
		String email = u.getEmail();

		ReportDao dao = new ReportDao();
		List<Report> list = dao.reportList(email);

		request.setAttribute("reportList", list);
		request.getRequestDispatcher("./Pages/User/viewReports.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
	}

}
