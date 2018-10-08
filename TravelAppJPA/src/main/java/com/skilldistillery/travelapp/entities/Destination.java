package com.skilldistillery.travelapp.entities;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;

import com.fasterxml.jackson.annotation.JsonIgnore;

@Entity
public class Destination {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)

	// fields

	private int id;

	private String city;

	private String state;

	private String country;

	private String longitude;

	private String latitude;

	@JsonIgnore
	@OneToMany(mappedBy = "destination")
	private List<Trip> trips;

	// constructors

	public Destination() {

	}

	public Destination(int id, String city, String state, String country,
			String longitude, String latitude, List<Trip> trips) {
		super();
		this.id = id;
		this.city = city;
		this.state = state;
		this.country = country;
		this.longitude = longitude;
		this.latitude = latitude;
		this.trips = trips;
	}

	// getters & setters

	public List<Trip> getTrips() {
		return trips;
	}

	public void setTrips(List<Trip> trips) {
		this.trips = trips;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public String getCountry() {
		return country;
	}

	public void setCountry(String country) {
		this.country = country;
	}

	public String getLongitude() {
		return longitude;
	}

	public void setLongitude(String longitude) {
		this.longitude = longitude;
	}

	public String getLatitude() {
		return latitude;
	}

	public void setLatitude(String latitude) {
		this.latitude = latitude;
	}

	// helpers

	public void addTrip(Trip trip) {
		if (trips == null)
			trips = new ArrayList<>();
		if (!trips.contains(trip)) {
			trips.add(trip);
			if (trip.getDestination() != null) {
				trip.getDestination().getTrips().remove(trip);

			}
			trip.setDestination(this);

		}
	}

	public void removeTrip(Trip trip) {
		trip.setDestination(null);
		if (trips != null) {
			trips.remove(trip);
		}
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((city == null) ? 0 : city.hashCode());
		result = prime * result + ((country == null) ? 0 : country.hashCode());
		result = prime * result + id;
		result = prime * result + ((latitude == null) ? 0 : latitude.hashCode());
		result = prime * result + ((longitude == null) ? 0 : longitude.hashCode());
		result = prime * result + ((state == null) ? 0 : state.hashCode());
		result = prime * result + ((trips == null) ? 0 : trips.hashCode());
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Destination other = (Destination) obj;
		if (city == null) {
			if (other.city != null)
				return false;
		} else if (!city.equals(other.city))
			return false;
		if (country == null) {
			if (other.country != null)
				return false;
		} else if (!country.equals(other.country))
			return false;
		if (id != other.id)
			return false;
		if (latitude == null) {
			if (other.latitude != null)
				return false;
		} else if (!latitude.equals(other.latitude))
			return false;
		if (longitude == null) {
			if (other.longitude != null)
				return false;
		} else if (!longitude.equals(other.longitude))
			return false;
		if (state == null) {
			if (other.state != null)
				return false;
		} else if (!state.equals(other.state))
			return false;
		if (trips == null) {
			if (other.trips != null)
				return false;
		} else if (!trips.equals(other.trips))
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "Destination [id=" + id + ", city=" + city + ", state=" + state
				+ ", country=" + country + ", longitude=" + longitude + ", latitude="
				+ latitude + "]";
	}

}
