package com.skilldistillery.travelapp.services;

import java.util.List;

import com.skilldistillery.travelapp.entities.Trip;

public interface TripService {

	public List<Trip> index();

	public Trip show(Integer id);

	public Trip create(Trip trip);

	public Trip update(Integer id, Trip trip);

	public Boolean delete(Integer id);

	public Trip newTrip(String json);

}
