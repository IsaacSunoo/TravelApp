package com.skilldistillery.travelapp.entities;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToMany;

@Entity
public class Tag {

	// fields

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;

	private String name;

	@ManyToMany(mappedBy = "tags")
	private List<Trip> trips;

	// constructors

	public Tag() {

	}

	public Tag(int id, String name) {
		this.id = id;
		this.name = name;
	}

	// getters & setters

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public List<Trip> getTrips() {
		return trips;
	}

	public void setTrips(List<Trip> trips) {
		this.trips = trips;
	}

	// helpers

	public void addTrip(Trip trip) {
		if (trips == null)
			trips = new ArrayList<>();
		if (!trips.contains(trip)) {
			trips.add(trip);
			trip.addTag(this);
		}
	}

	public void removeTrip(Trip trip) {
		if (trips != null && trips.contains(trip)) {
			trips.remove(trip);
			trip.removeTag(this);
		}
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + id;
		result = prime * result + ((name == null) ? 0 : name.hashCode());
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
		Tag other = (Tag) obj;
		if (id != other.id)
			return false;
		if (name == null) {
			if (other.name != null)
				return false;
		} else if (!name.equals(other.name))
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
		return "Tag [id=" + id + ", name=" + name + "]";
	}

}
