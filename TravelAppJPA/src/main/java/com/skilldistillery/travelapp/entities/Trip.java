package com.skilldistillery.travelapp.entities;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;

@Entity
public class Trip {

	// fields

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;

	private String title;

	private int rating;

	@Column(name = "total_cost")
	private Double totalCost;

	@Column(name = "date_start")
	private Date dateStart;

	@Column(name = "date_end")
	private Date dateEnd;

	private String review;

	@Column(name = "img_link")
	private String imgLink;

	@ManyToOne
	@JoinColumn(name = "profile_id")
	private Profile profile;

	@ManyToMany
	@JoinTable(name = "favorites", joinColumns = @JoinColumn(name = "profile_id"),
			inverseJoinColumns = @JoinColumn(name = "trip_id"))
	private List<Profile> profiles;

	@ManyToMany
	@JoinTable(name = "trip_tag", joinColumns = @JoinColumn(name = "trip_id"),
			inverseJoinColumns = @JoinColumn(name = "tag_id"))
	private List<Tag> tags;

	@OneToMany(mappedBy = "trip")
	private List<Recommendation> recommendations;

	@OneToOne(mappedBy = "trip")
	private Posts posts;

	@ManyToOne
	@JoinColumn(name = "destination_id")
	private Destination destination;

	// constructors

	public Trip() {

	}

	public Trip(int id, String title, int rating, Double totalCost, Date dateStart, Date dateEnd, String review,
			String imgLink, Profile profile, List<Profile> profiles, List<Tag> tags,
			List<Recommendation> recommendations, Posts posts, Destination destination) {
		this.id = id;
		this.title = title;
		this.rating = rating;
		this.totalCost = totalCost;
		this.dateStart = dateStart;
		this.dateEnd = dateEnd;
		this.review = review;
		this.imgLink = imgLink;
		this.profile = profile;
		this.profiles = profiles;
		this.tags = tags;
		this.recommendations = recommendations;
		this.posts = posts;
		this.destination = destination;
	}


	// getters & setters

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public List<Tag> getTags() {
		return tags;
	}

	public void setTags(List<Tag> tags) {
		this.tags = tags;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public Destination getDestination() {
		return destination;
	}

	public void setDestination(Destination destination) {
		this.destination = destination;
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

	public List<Recommendation> getRecommendations() {
		return recommendations;
	}

	public void setRecommendations(List<Recommendation> recommendations) {
		this.recommendations = recommendations;
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

	public List<Profile> getProfiles() {
		return profiles;
	}

	public void setProfiles(List<Profile> profiles) {
		this.profiles = profiles;
	}

	public Posts getPosts() {
		return posts;
	}

	public void setPosts(Posts posts) {
		this.posts = posts;
	}

	public Profile getProfile() {
		return profile;
	}

	public void setProfile(Profile profile) {
		this.profile = profile;
	}

	// helpers

	// This is for the many to many relationship between trip and profile, the
	// trips a user has favorited (from people they follow)
	public void addProfile(Profile profile) {
		if (profiles == null) {
			profiles = new ArrayList<>();
		}
		if (!profiles.contains(profile)) {
			profiles.add(profile);
			profile.addFavoriteTrip(this);
		}
	}

	public void removeProfile(Profile profile) {
		if (profiles != null && profiles.contains(profile)) {
			profiles.remove(profile);
			profile.removeFavoriteTrip(this);
		}
	}

	public void addTag(Tag tag) {
		if (tags == null) {
			tags = new ArrayList<>();
		}
		if (!tags.contains(tag)) {
			tags.add(tag);
			tag.addTrip(this);
		}

	}

	public void removeTag(Tag tag) {
		if (tags != null && tags.contains(tag)) {
			tags.remove(tag);
			tag.removeTrip(this);
		}
	}

	public void addRecommendation(Recommendation recommendation) {
		if (recommendations == null)
			recommendations = new ArrayList<>();
		if (!recommendations.contains(recommendation)) {
			recommendations.add(recommendation);
			if (recommendation.getTrip() != null) {
				recommendation.getTrip().getRecommendations().remove(recommendation);
			}
			recommendation.setTrip(this);
		}
	}

	public void removeRecommendation(Recommendation recommendation) {
		recommendation.setTrip(null);
		if (recommendations != null) {
			recommendations.remove(recommendation);
		}
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((dateEnd == null) ? 0 : dateEnd.hashCode());
		result = prime * result + ((dateStart == null) ? 0 : dateStart.hashCode());
		result = prime * result + ((destination == null) ? 0 : destination.hashCode());
		result = prime * result + id;
		result = prime * result + ((imgLink == null) ? 0 : imgLink.hashCode());
		result = prime * result + ((posts == null) ? 0 : posts.hashCode());
		result = prime * result + ((profile == null) ? 0 : profile.hashCode());
		result = prime * result + ((profiles == null) ? 0 : profiles.hashCode());
		result = prime * result + rating;
		result = prime * result + ((recommendations == null) ? 0 : recommendations.hashCode());
		result = prime * result + ((review == null) ? 0 : review.hashCode());
		result = prime * result + ((tags == null) ? 0 : tags.hashCode());
		result = prime * result + ((title == null) ? 0 : title.hashCode());
		result = prime * result + ((totalCost == null) ? 0 : totalCost.hashCode());
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
		if (dateEnd == null) {
			if (other.dateEnd != null)
				return false;
		} else if (!dateEnd.equals(other.dateEnd))
			return false;
		if (dateStart == null) {
			if (other.dateStart != null)
				return false;
		} else if (!dateStart.equals(other.dateStart))
			return false;
		if (destination == null) {
			if (other.destination != null)
				return false;
		} else if (!destination.equals(other.destination))
			return false;
		if (id != other.id)
			return false;
		if (imgLink == null) {
			if (other.imgLink != null)
				return false;
		} else if (!imgLink.equals(other.imgLink))
			return false;
		if (posts == null) {
			if (other.posts != null)
				return false;
		} else if (!posts.equals(other.posts))
			return false;
		if (profile == null) {
			if (other.profile != null)
				return false;
		} else if (!profile.equals(other.profile))
			return false;
		if (profiles == null) {
			if (other.profiles != null)
				return false;
		} else if (!profiles.equals(other.profiles))
			return false;
		if (rating != other.rating)
			return false;
		if (recommendations == null) {
			if (other.recommendations != null)
				return false;
		} else if (!recommendations.equals(other.recommendations))
			return false;
		if (review == null) {
			if (other.review != null)
				return false;
		} else if (!review.equals(other.review))
			return false;
		if (tags == null) {
			if (other.tags != null)
				return false;
		} else if (!tags.equals(other.tags))
			return false;
		if (title == null) {
			if (other.title != null)
				return false;
		} else if (!title.equals(other.title))
			return false;
		if (totalCost == null) {
			if (other.totalCost != null)
				return false;
		} else if (!totalCost.equals(other.totalCost))
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "Trip [id=" + id + ", title=" + title + ", rating=" + rating + ", totalCost=" + totalCost
				+ ", dateStart=" + dateStart + ", dateEnd=" + dateEnd + ", review=" + review + ", imgLink=" + imgLink
				+ ", profile=" + profile + ", profiles=" + profiles + ", tags=" + tags + ", recommendations="
				+ recommendations + ", posts=" + posts + ", destination=" + destination + "]";
	}

}
