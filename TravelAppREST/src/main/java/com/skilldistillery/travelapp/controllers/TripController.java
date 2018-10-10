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

import com.skilldistillery.travelapp.entities.Trip;
import com.skilldistillery.travelapp.repositories.TripRepository;
import com.skilldistillery.travelapp.services.ProfileService;
import com.skilldistillery.travelapp.services.TripService;
import com.skilldistillery.travelapp.services.UserService;

@RestController
@RequestMapping("api")
@CrossOrigin({ "*", "http://localhost:4201" })
public class TripController {

	// Fields

	@Autowired
	private ProfileService profileService;

	@Autowired
	private UserService userService;

	@Autowired
	private TripService tripService;

	@Autowired
	private TripRepository tripRepo;

	// Methods

	// CREATE

	// Richard: We don't seem to be using this route -- creating a trip from the
	// feed page actually uses api/profile/id/posts. Also tripRepo should be
	// called only in service classes
	@RequestMapping(path = "trips", method = RequestMethod.POST)
	public Trip createTrip(HttpServletRequest req, HttpServletResponse res,
			@RequestBody Trip trip) {
		return tripRepo.saveAndFlush(trip);
	}

	// READ

	// Richard: Note -- This method seems to be pulling trips for a particular
	// profile? Also tripRepo should be called only in service classes. If we were
	// to use this route, change it to /profile/{pid}/trips.
//	@RequestMapping(path = "trips/{pid}", method = RequestMethod.GET)
//	public List<Trip> index(HttpServletRequest req, HttpServletResponse res,
//			@PathVariable(name = "pid") int pid) {
//		return tripRepo.queryForTripsByProfileId(pid);
//	}

	// Get the trip by its trip id, *tid* here would be the trip id
	@RequestMapping(path = "/trips/{tid}", method = RequestMethod.GET)
	public Trip show(@PathVariable(name = "tid") Integer tid,
			HttpServletResponse res) {

		Trip returnedTrip = tripService.show(tid);

		if (returnedTrip == null) {
			res.setStatus(500);
		}

		return returnedTrip;
	}

	// UPDATE

	// DELETE

}
