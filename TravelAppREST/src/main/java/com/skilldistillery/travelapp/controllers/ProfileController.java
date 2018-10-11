package com.skilldistillery.travelapp.controllers;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.skilldistillery.travelapp.entities.Profile;
import com.skilldistillery.travelapp.entities.SettingsDTO;
import com.skilldistillery.travelapp.entities.Trip;
import com.skilldistillery.travelapp.entities.User;
import com.skilldistillery.travelapp.services.ProfileService;
import com.skilldistillery.travelapp.services.UserService;

@RestController
@RequestMapping("api")
@CrossOrigin({ "*", "http://localhost:4201" })
public class ProfileController {

	@Autowired
	private ProfileService profileService;

	@Autowired
	private UserService userService;

	// CREATE

	// READ

	@RequestMapping(path = "profiles/{pid}", method = RequestMethod.GET)
	public Profile getOneById(@PathVariable(name = "pid") int pid) {
		return profileService.show(pid);
	}

	// This method is for retrieving a user/profile's list of favorite trips (i.e.
	// bookmarked trips)
	@RequestMapping(path = "/profile/{pid}/favoriteTrips",
			method = RequestMethod.GET)
	public List<Trip> favoriteTripsIndexByProfileId(
			@PathVariable(name = "pid") Integer pid, HttpServletResponse res) {

		return profileService.queryForFavoriteTripsByProfileId(pid);
	}

	// UPDATE

	@RequestMapping(path = "profiles/{pid}", method = RequestMethod.PATCH)
	public Profile patch(HttpServletRequest req, HttpServletResponse res,
			@PathVariable(name = "pid") int pid,
			@RequestBody SettingsDTO settingsDTO) {

		Profile updatedProfile = profileService.updateSettings(pid, settingsDTO);
		User updatedUser = userService.updateSettings(pid, settingsDTO);

		if (updatedProfile == null || updatedUser == null) {
			res.setStatus(500);
		}

		return updatedProfile;
	}

	// DELETE

}
