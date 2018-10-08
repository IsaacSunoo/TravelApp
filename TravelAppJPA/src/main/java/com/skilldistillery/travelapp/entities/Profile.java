package com.skilldistillery.travelapp.entities;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;

import com.fasterxml.jackson.annotation.JsonIgnore;

@Entity
public class Profile {

	// fields

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;

	@Column(name = "first_name")
	private String firstName;

	@Column(name = "last_name")
	private String lastName;

	@Column(name = "img_link")
	private String imgLink;

	private String bio;

	@JsonIgnore
	@OneToMany(mappedBy = "profile")
	private List<Posts> posts;

	// Have to do this because can't update a nested object without getting the
	// managed version of it
	@ManyToOne(cascade = CascadeType.ALL)
	@JoinColumn(name = "location_id")
	private ProfileLocation location;

	@JsonIgnore
	// Trips this user has created
	@OneToMany(mappedBy = "profile")
	private List<Trip> trips;

	@JsonIgnore
	// Trips this user has favorited
	@ManyToMany(mappedBy = "profiles")
	private List<Trip> favoriteTrips;

	@OneToOne
	@JoinColumn(name = "user_id")
	private User user;

	// constructors

	public Profile() {

	}

	// getters & setters

	public Profile(int id, String firstName, String lastName, String imgLink,
			String bio, List<Posts> posts, ProfileLocation location, List<Trip> trips,
			List<Trip> favoriteTrips, User user) {
		this.id = id;
		this.firstName = firstName;
		this.lastName = lastName;
		this.imgLink = imgLink;
		this.bio = bio;
		this.posts = posts;
		this.location = location;
		this.trips = trips;
		this.favoriteTrips = favoriteTrips;
		this.user = user;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getFirstName() {
		return firstName;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	public String getLastName() {
		return lastName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	public List<Trip> getFavoriteTrips() {
		return favoriteTrips;
	}

	public void setFavoriteTrips(List<Trip> favoriteTrips) {
		this.favoriteTrips = favoriteTrips;
	}

	public String getImgLink() {
		return imgLink;
	}

	public void setImgLink(String imgLink) {
		this.imgLink = imgLink;
	}

	public String getBio() {
		return bio;
	}

	public void setBio(String bio) {
		this.bio = bio;
	}

	public ProfileLocation getLocation() {
		return location;
	}

	public void setLocation(ProfileLocation location) {
		this.location = location;
	}

	public List<Posts> getPosts() {
		return posts;
	}

	public void setPosts(List<Posts> posts) {
		this.posts = posts;
	}

	public List<Trip> getTrips() {
		return trips;
	}

	public void setTrips(List<Trip> trips) {
		this.trips = trips;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	// helpers

	public void addFavoriteTrip(Trip favoriteTrip) {
		if (favoriteTrips == null) {
			favoriteTrips = new ArrayList<>();
		}
		if (!favoriteTrips.contains(favoriteTrip)) {
			favoriteTrips.add(favoriteTrip);
			favoriteTrip.addProfile(this);
		}
	}

	public void removeFavoriteTrip(Trip favoriteTrip) {
		if (favoriteTrips != null && favoriteTrips.contains(favoriteTrip)) {
			favoriteTrips.remove(favoriteTrip);
			favoriteTrip.removeProfile(this);
		}
	}

	public void addPost(Posts post) {
		if (posts == null)
			posts = new ArrayList();

		if (!posts.contains(post)) {
			posts.add(post);
			if (post.getProfile() != null) {
				post.getProfile().getPosts().remove(post);
			}
			post.setProfile(this);
		}
	}

	public void removePost(Posts post) {
		post.setProfile(null);
		if (posts != null) {
			posts.remove(post);
		}
	}

	public void addTrip(Trip trip) {
		if (trips == null)
			trips = new ArrayList();

		if (!trips.contains(trip)) {
			trips.add(trip);
			if (trip.getProfile() != null) {
				trip.getProfile().getTrips().remove(trip);
			}
			trip.setProfile(this);
		}
	}

	public void removeTrip(Trip trip) {
		trip.setProfile(null);
		if (trips != null) {
			trips.remove(trip);
		}
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((bio == null) ? 0 : bio.hashCode());
		result = prime * result
				+ ((favoriteTrips == null) ? 0 : favoriteTrips.hashCode());
		result = prime * result + ((firstName == null) ? 0 : firstName.hashCode());
		result = prime * result + id;
		result = prime * result + ((imgLink == null) ? 0 : imgLink.hashCode());
		result = prime * result + ((lastName == null) ? 0 : lastName.hashCode());
		result = prime * result + ((location == null) ? 0 : location.hashCode());
		result = prime * result + ((posts == null) ? 0 : posts.hashCode());
		result = prime * result + ((trips == null) ? 0 : trips.hashCode());
		result = prime * result + ((user == null) ? 0 : user.hashCode());
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
		Profile other = (Profile) obj;
		if (bio == null) {
			if (other.bio != null)
				return false;
		} else if (!bio.equals(other.bio))
			return false;
		if (favoriteTrips == null) {
			if (other.favoriteTrips != null)
				return false;
		} else if (!favoriteTrips.equals(other.favoriteTrips))
			return false;
		if (firstName == null) {
			if (other.firstName != null)
				return false;
		} else if (!firstName.equals(other.firstName))
			return false;
		if (id != other.id)
			return false;
		if (imgLink == null) {
			if (other.imgLink != null)
				return false;
		} else if (!imgLink.equals(other.imgLink))
			return false;
		if (lastName == null) {
			if (other.lastName != null)
				return false;
		} else if (!lastName.equals(other.lastName))
			return false;
		if (location == null) {
			if (other.location != null)
				return false;
		} else if (!location.equals(other.location))
			return false;
		if (posts == null) {
			if (other.posts != null)
				return false;
		} else if (!posts.equals(other.posts))
			return false;
		if (trips == null) {
			if (other.trips != null)
				return false;
		} else if (!trips.equals(other.trips))
			return false;
		if (user == null) {
			if (other.user != null)
				return false;
		} else if (!user.equals(other.user))
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "Profile [id=" + id + ", firstName=" + firstName + ", lastName="
				+ lastName + ", imgLink=" + imgLink + ", bio=" + bio + ", posts="
				+ posts + ", location=" + location + ", trips=" + trips
				+ ", favoriteTrips=" + favoriteTrips + ", user=" + user + "]";
	}

}