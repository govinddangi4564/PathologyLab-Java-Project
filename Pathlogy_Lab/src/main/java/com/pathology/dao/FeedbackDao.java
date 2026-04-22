package com.pathology.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.LinkedList;
import java.util.List;

import com.pathology.model.Feedback;

public class FeedbackDao {

	public int submitFeedback(Feedback u) {
		int i = 0;

		try (Connection con = DBConnection.getConnection();
				PreparedStatement pst = con.prepareStatement(
						"INSERT INTO feedback (name, email, phone, rating, message) VALUES (?, ?, ?, ?, ?)")) {
			pst.setString(1, u.getName());
			pst.setString(2, u.getEmail());
			pst.setString(3, u.getMobile());
			pst.setInt(4, u.getRating());
			pst.setString(5, u.getMessage());

			i = pst.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return i;
	}

	public List<Feedback> viewFeedback() {
		List<Feedback> list = new LinkedList<Feedback>();

		try (Connection con = DBConnection.getConnection();
				PreparedStatement pst = con.prepareStatement(
						"SELECT name,rating,message FROM feedback WHERE rating >= 4 ORDER BY created_at DESC LIMIT 3")) {

			ResultSet rs = pst.executeQuery();

			while (rs.next()) {
				list.add(new Feedback(rs.getString("name"), rs.getInt("rating"), rs.getString("message")));
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}
}
