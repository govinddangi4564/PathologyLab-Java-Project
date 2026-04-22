package com.pathology.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Feedback {
	private int id;
	private String name;
	private String email;
	private String mobile;
	private int rating;
	private String message;

	public Feedback(String name, String email, String mobile, int rating, String message) {
		super();
		this.name = name;
		this.email = email;
		this.mobile = mobile;
		this.rating = rating;
		this.message = message;
	}

	public Feedback(String name, int rating, String message) {
		super();
		this.name = name;
		this.rating = rating;
		this.message = message;
	}
}
