package com.skilldistillery.travelapp.entities;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;

@Entity
public class Profile {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	
	@Column(name="user_id")
	private int userId;
	
	@Column(name="first_name")
	private String firstName;
	
	@Column(name="last_name")
	private String lastName;
	
	@Column(name="img_link")
	private String imgLink;
	
	@Column(name="location_id")
	private int locationId;
	
	private String bio;
	
	@OneToMany(mappedBy="profile")
	private List<Posts> posts;
	
	@ManyToOne
	@JoinColumn(name="location_id")
	private ProfileLocation location;
	
	
	public Profile() {

	}

	public Profile(int userId, String firstName, String lastName, String imgLink, int locationId, String bio) {
		this.userId = userId;
		this.firstName = firstName;
		this.lastName = lastName;
		this.imgLink = imgLink;
		this.locationId = locationId;
		this.bio = bio;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
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

	public String getImgLink() {
		return imgLink;
	}

	public void setImgLink(String imgLink) {
		this.imgLink = imgLink;
	}

	public int getLocationId() {
		return locationId;
	}

	public void setLocationId(int locationId) {
		this.locationId = locationId;
	}

	public String getBio() {
		return bio;
	}

	public void setBio(String bio) {
		this.bio = bio;
	}
	
	public List<Posts> getPosts() {
		return posts;
	}

	public void setPosts(List<Posts> posts) {
		this.posts = posts;
	}

	public ProfileLocation getLocation() {
		return location;
	}

	public void setLocation(ProfileLocation location) {
		this.location = location;
	}

	public void addPost(Posts post) {
		if (posts == null) posts = new ArrayList();
		
		if (!posts.contains(post)) {
			posts.add(post);
			if(post.getProfile() != null) {
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
	
	
	
	
}

