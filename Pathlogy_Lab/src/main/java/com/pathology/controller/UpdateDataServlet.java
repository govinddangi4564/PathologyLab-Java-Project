package com.pathology.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import com.pathology.dao.DBConnection;
import com.pathology.dao.ReportDao;

@WebServlet(urlPatterns = { "/updateReportStatus" })
public class UpdateDataServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String path = request.getServletPath();
		HttpSession session = request.getSession();

		if (path.equals("/updateReportStatus")) {
			int id = Integer.parseInt(request.getParameter("id"));
			ReportDao dao = new ReportDao();

			int i = dao.updateDeliverdStatus(id);

			if (i > 0) {
				session.setAttribute("successMsg", "Report Delivered successfully");
			} else {
				session.setAttribute("errorMsg", "Something Went Wrong.");
			}
			response.sendRedirect(request.getContextPath() + "/viewAllReports");
		}

	}

}
