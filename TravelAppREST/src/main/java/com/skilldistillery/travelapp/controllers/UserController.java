package com.skilldistillery.travelapp.controllers;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.skilldistillery.travelapp.entities.User;
import com.skilldistillery.travelapp.services.UserService;

@RestController
@CrossOrigin({ "*", "http://localhost:4201" })
public class UserController {

	@Autowired
	private UserService userService;

	@RequestMapping(path = "/register", method = RequestMethod.POST)
	public User register(@RequestBody String json, HttpServletResponse res) {
		User u = userService.register(json);
		if (u == null) {
			res.setStatus(400);
		}
		return u;
	}

}
