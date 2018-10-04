package com.skilldistillery.travelapp.entities;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;

@Entity
public class Recommendation {

	// fields

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;

	@Column(name = "trip_id")
	private int tripId;

	@Column(name = "rec_type_id")
	private int recTypeId;

	private String content;

	@ManyToOne
	@JoinColumn(name = "rec_type_id")
	private RecType recType;

	@ManyToOne
	@JoinColumn(name = "trip_id")
	private Trip trip;

	// constructors

	public Recommendation() {

	}

	public Recommendation(int id, int tripId, int recTypeId, String content,
			RecType recType, Trip trip) {
		super();
		this.id = id;
		this.tripId = tripId;
		this.recTypeId = recTypeId;
		this.content = content;
		this.recType = recType;
		this.trip = trip;
	}

	// getters & setters

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getTripId() {
		return tripId;
	}

	public void setTripId(int tripId) {
		this.tripId = tripId;
	}

	public int getRecTypeId() {
		return recTypeId;
	}

	public void setRecTypeId(int recTypeId) {
		this.recTypeId = recTypeId;
	}

	public RecType getRecType() {
		return recType;
	}

	public void setRecType(RecType recType) {
		this.recType = recType;
	}

	public Trip getTrip() {
		return trip;
	}

	public void setTrip(Trip trip) {
		this.trip = trip;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	// helpers

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((content == null) ? 0 : content.hashCode());
		result = prime * result + id;
		result = prime * result + ((recType == null) ? 0 : recType.hashCode());
		result = prime * result + recTypeId;
		result = prime * result + ((trip == null) ? 0 : trip.hashCode());
		result = prime * result + tripId;
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
		Recommendation other = (Recommendation) obj;
		if (content == null) {
			if (other.content != null)
				return false;
		} else if (!content.equals(other.content))
			return false;
		if (id != other.id)
			return false;
		if (recType == null) {
			if (other.recType != null)
				return false;
		} else if (!recType.equals(other.recType))
			return false;
		if (recTypeId != other.recTypeId)
			return false;
		if (trip == null) {
			if (other.trip != null)
				return false;
		} else if (!trip.equals(other.trip))
			return false;
		if (tripId != other.tripId)
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "Recommendation [id=" + id + ", tripId=" + tripId + ", recTypeId="
				+ recTypeId + ", content=" + content + "]";
	}

}
