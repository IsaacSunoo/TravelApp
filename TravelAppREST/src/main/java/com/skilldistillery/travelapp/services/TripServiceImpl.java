package com.skilldistillery.travelapp.services;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.skilldistillery.travelapp.entities.Destination;
import com.skilldistillery.travelapp.entities.NewTripDTO;
import com.skilldistillery.travelapp.entities.Trip;
import com.skilldistillery.travelapp.repositories.TripRepository;

import ch.qos.logback.core.net.SyslogOutputStream;

@Service
public class TripServiceImpl implements TripService {

	@Autowired
	private TripRepository tripRepo;

	// CREATE ***************************************************************

	@Override
	public Trip create(Trip trip) {
		return tripRepo.saveAndFlush(trip);
	}

	@Override
	public Trip newTrip(String json) {
		ObjectMapper om = new ObjectMapper();
		NewTripDTO newTripDTO = null;
		Trip trip = new Trip();

		try {
			newTripDTO = om.readValue(json, NewTripDTO.class);
			if (newTripDTO == null) {
				return null;
			}
			trip.setTitle(newTripDTO.getTitle());
			trip.setRating(newTripDTO.getRating());
			trip.setTotalCost(newTripDTO.getTotalCost());
			trip.setDateStart(newTripDTO.getDateStart());
			trip.setDateEnd(newTripDTO.getDateEnd());
			trip.setReview(newTripDTO.getReview());
			trip.setImgLink(newTripDTO.getImgLink());

			Destination dest = new Destination();
			dest.setCity(newTripDTO.getCity());
			dest.setState(newTripDTO.getState());
			dest.setCountry(newTripDTO.getCountry());
			dest.setLatitude(newTripDTO.getLatitude());
			dest.setLongitude(newTripDTO.getLongitude());

			trip.setDestination(dest);

			tripRepo.saveAndFlush(trip);

		} catch (Exception e) {
			System.out.println(e);
		}
		return trip;
	}

	// READ *****************************************************************

	@Override
	public List<Trip> index() {
		return tripRepo.findAll();
	}

	@Override
	public Trip show(Integer id) {
		Optional<Trip> opTrip = tripRepo.findById(id);

		if (opTrip.isPresent()) {
			return opTrip.get();
		}

		return null;
	}

	@Override
	public List<Trip> queryForTripsByProfileId(Integer pid) {
		return tripRepo.queryForTripsByProfileId(pid);
	}

	// UPDATE ***************************************************************

	@Override
	public Trip update(Integer id, Trip trip) {
		Optional<Trip> opTrip = tripRepo.findById(id);

		if (opTrip.isPresent()) {
			Trip managedTrip = opTrip.get();

			if (trip.getTitle() != null && !trip.getTitle().equals("")) {
				managedTrip.setTitle(trip.getTitle());
			}

			if (!(trip.getRating() < 0)) {
				managedTrip.setRating(trip.getRating());
			}

			if (!(trip.getTotalCost() < 0)) {
				managedTrip.setTotalCost(trip.getTotalCost());
			}

			if (trip.getDateStart() != null) {
				managedTrip.setDateStart(trip.getDateStart());
			}

			if (trip.getDateEnd() != null) {
				managedTrip.setDateEnd(trip.getDateEnd());
			}

			if (trip.getReview() != null && !trip.getReview().equals("")) {
				managedTrip.setReview(trip.getReview());
			}

			if (trip.getImgLink() != null && !trip.getImgLink().equals("")) {
				managedTrip.setImgLink(trip.getImgLink());
			}

			return tripRepo.saveAndFlush(managedTrip);
		}

		return null;
	}

	// DELETE ***************************************************************

	@Override
	public Boolean delete(Integer id) {

		try {
			tripRepo.deleteById(id);
			return true;
		} catch (Exception e) {
			e.printStackTrace();
		}

		return false;
	}

}
