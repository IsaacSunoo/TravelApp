package com.skilldistillery.travelapp.services;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.travelapp.entities.Trip;
import com.skilldistillery.travelapp.repositories.TripRepository;

@Service
public class TripServiceImpl implements TripService {

	@Autowired
	private TripRepository tripRepo;

	// CREATE ***************************************************************

	@Override
	public Trip create(Trip trip) {
		return tripRepo.saveAndFlush(trip);
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
