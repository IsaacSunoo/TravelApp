package com.skilldistillery.travelapp.controllers;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.skilldistillery.travelapp.entities.Trip;
import com.skilldistillery.travelapp.repositories.TripRepository;
import com.skilldistillery.travelapp.services.ProfileService;
import com.skilldistillery.travelapp.services.TripService;
import com.skilldistillery.travelapp.services.UserService;

@RestController
@RequestMapping("api")
@CrossOrigin({ "*", "http://localhost:4201" })
public class TripController {
	
	@Autowired
	private ProfileService profileService;

	@Autowired
	private UserService userService;
	
	@Autowired
	private TripService tripService;
	
	@Autowired
	private TripRepository tripRepo;
	
	
	@RequestMapping(path="trips/{pid}", method=RequestMethod.GET)
	public List<Trip> index(HttpServletRequest req, HttpServletResponse res,
			@PathVariable(name="pid")int pid) {
		return tripRepo.queryForTripsByProfileId(pid);
	}

}
