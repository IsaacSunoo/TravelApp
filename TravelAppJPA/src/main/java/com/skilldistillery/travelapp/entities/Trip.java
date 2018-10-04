package com.skilldistillery.travelapp.entities;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

@Entity
public class Trip {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	
	private String title;
	
	private int rating;
	
	@Column(name="total_cost")
	private Double totalCost;
	
	@Column(name="date_start")
	private Date dateStart;
	
	@Column(name="date_end")
	private Date dateEnd;
	
	@Column(name="destination_id")
	private int destinationId;
	
	private String review;
	
	@Column(name="img_link")
	private String imgLink;
	
	@Column(name="profile_id")
	private int profileId;
	
	public Trip() {

	}

	public Trip(int id, String title, int rating, Double totalCost, Date dateStart, Date dateEnd, int destinationId,
			String review, String imgLink, int profileId) {
		this.id = id;
		this.title = title;
		this.rating = rating;
		this.totalCost = totalCost;
		this.dateStart = dateStart;
		this.dateEnd = dateEnd;
		this.destinationId = destinationId;
		this.review = review;
		this.imgLink = imgLink;
		this.profileId = profileId;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public int getRating() {
		return rating;
	}

	public void setRating(int rating) {
		this.rating = rating;
	}

	public Double getTotalCost() {
		return totalCost;
	}

	public void setTotalCost(Double totalCost) {
		this.totalCost = totalCost;
	}

	public Date getDateStart() {
		return dateStart;
	}

	public void setDateStart(Date dateStart) {
		this.dateStart = dateStart;
	}

	public Date getDateEnd() {
		return dateEnd;
	}

	public void setDateEnd(Date dateEnd) {
		this.dateEnd = dateEnd;
	}

	public int getDestinationId() {
		return destinationId;
	}

	public void setDestinationId(int destinationId) {
		this.destinationId = destinationId;
	}

	public String getReview() {
		return review;
	}

	public void setReview(String review) {
		this.review = review;
	}

	public String getImgLink() {
		return imgLink;
	}

	public void setImgLink(String imgLink) {
		this.imgLink = imgLink;
	}

	public int getProfileId() {
		return profileId;
	}

	public void setProfileId(int profileId) {
		this.profileId = profileId;
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
		Trip other = (Trip) obj;
		if (id != other.id)
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "Trip [id=" + id + ", title=" + title + ", rating=" + rating + ", totalCost=" + totalCost
				+ ", dateStart=" + dateStart + ", dateEnd=" + dateEnd + ", destinationId=" + destinationId + ", review="
				+ review + ", imgLink=" + imgLink + ", profileId=" + profileId + "]";
	}
}
