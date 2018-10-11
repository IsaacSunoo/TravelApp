package com.skilldistillery.travelapp.controllers;

import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.skilldistillery.travelapp.entities.Profile;
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

	// Temporary login method, find the user by their username, return the profile
	// object, store profile ID in local storage via angular side
	@RequestMapping(path = "/login", method = RequestMethod.POST)
	public Profile retrieveProfile(@RequestBody User user, HttpServletResponse res) {

		String username = user.getName();
		User managedUser = userService.getOneUser(username);

		if (managedUser != null) {
			Profile profile = managedUser.getProfile();
			return profile;
		}

		return null;
	}

	@RequestMapping(path = "/addfollower/{uid}/{fid}", method = RequestMethod.POST)
	public User addFollower(@PathVariable(name = "uid") int uid, @PathVariable(name = "fid") int fid) {
		
		User newList = userService.followUser(uid, fid);
		return newList;

	}
	
	@RequestMapping(path = "/findfollowers/{uid}", method = RequestMethod.GET)
	public List<User> findFollowers(@PathVariable(name = "uid") int uid) {
		List<User> followers = userService.findFollowers(uid);
		return followers;

	}
	
	@RequestMapping(path= "/removefollower/{uid}/{fid}", method = RequestMethod.DELETE)
	public boolean unFollow(@PathVariable(name = "uid") int uid, @PathVariable(name = "fid") int fid) {
		boolean result = userService.unfollowUser(uid, fid);
		return result;
	}

}
