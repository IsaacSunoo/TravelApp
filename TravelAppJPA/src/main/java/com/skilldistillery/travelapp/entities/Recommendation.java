package com.skilldistillery.travelapp.entities;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

@Entity
public class Recommendation {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	
	@Column(name="trip_id")
	private int tripId;
	
	@Column(name="rec_type_id")
	private int recTypeId;
	
	private String content;
	
	public Recommendation() {

	}

	public Recommendation(int id, int tripId, int recTypeId, String content) {
		this.id = id;
		this.tripId = tripId;
		this.recTypeId = recTypeId;
		this.content = content;
	}

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

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + id;
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
		if (id != other.id)
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "Recommendation [id=" + id + ", tripId=" + tripId + ", recTypeId=" + recTypeId + ", content=" + content
				+ "]";
	}
	
	
	
	
}
