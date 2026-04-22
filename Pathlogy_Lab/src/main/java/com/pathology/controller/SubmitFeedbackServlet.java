package com.pathology.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

import com.pathology.dao.FeedbackDao;
import com.pathology.dao.UserDao;
import com.pathology.model.Feedback;
import com.pathology.model.User;

@WebServlet("/submitFeedback")
public class SubmitFeedbackServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public SubmitFeedbackServlet() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String name = request.getParameter("name");
		String email = request.getParameter("email");
		String phone = request.getParameter("phone");
		int rating = Integer.parseInt(request.getParameter("rating"));
		String msg = request.getParameter("message");

		Feedback f = new Feedback(name, email, phone, rating, msg);
		FeedbackDao dao = new FeedbackDao();

		int i = dao.submitFeedback(f);

		HttpSession session = request.getSession();

		if (i > 0) {
			session.setAttribute("successMsg", "Feedback Submited Successfully");
		} else {
			session.setAttribute("errorMsg", "Something Went Wrong");
		}

		response.sendRedirect(request.getContextPath() + "/index.jsp");
	}

}
