package com.skilldistillery.travelapp.entities;

import java.util.ArrayList;
import java.util.List;

// Comment
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.OneToOne;

@Entity
public class User {

	// fields

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;

	private String name;

	private String password;

	private String email;

	private boolean active;

	private String role;

	@OneToOne(mappedBy = "user")
	private Profile profile;

	// Self-join table
	@ManyToMany
	@JoinTable(name = "followers",
			joinColumns = @JoinColumn(name = "follower_id"),
			inverseJoinColumns = @JoinColumn(name = "followed_id"))
	private List<User> followers;

	// constructors

	public User() {

	}

	public User(int id, String name, String password, String email,
			boolean active, String role, Profile profile, List<User> followers) {
		this.id = id;
		this.name = name;
		this.password = password;
		this.email = email;
		this.active = active;
		this.role = role;
		this.profile = profile;
		this.followers = followers;
	}

	public User(int id, String name, String password, String email,
			boolean active, String role, Profile profile) {
		this.id = id;
		this.name = name;
		this.password = password;
		this.email = email;
		this.active = active;
		this.role = role;
		this.profile = profile;
	}

	// getters & setters

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public List<User> getFollowers() {
		return followers;
	}

	public void setFollowers(List<User> followers) {
		this.followers = followers;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Profile getProfile() {
		return profile;
	}

	public void setProfile(Profile profile) {
		this.profile = profile;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public boolean isActive() {
		return active;
	}

	public void setActive(boolean active) {
		this.active = active;
	}

	public String getRole() {
		return role;
	}

	public void setRole(String role) {
		this.role = role;
	}

	// helpers

	public void addFollower(User follower) {
		if (followers == null)
			followers = new ArrayList<>();

		if (!followers.contains(follower)) {
			followers.add(follower);
			follower.getFollowers().add(this);
		}

	}

	public void removeFollower(User follower) {
		if (followers != null && followers.contains(follower)) {
			followers.remove(follower);
			follower.getFollowers().remove(this);
		}
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + (active ? 1231 : 1237);
		result = prime * result + ((email == null) ? 0 : email.hashCode());
		result = prime * result + ((followers == null) ? 0 : followers.hashCode());
		result = prime * result + id;
		result = prime * result + ((name == null) ? 0 : name.hashCode());
		result = prime * result + ((password == null) ? 0 : password.hashCode());
		result = prime * result + ((profile == null) ? 0 : profile.hashCode());
		result = prime * result + ((role == null) ? 0 : role.hashCode());
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
		User other = (User) obj;
		if (active != other.active)
			return false;
		if (email == null) {
			if (other.email != null)
				return false;
		} else if (!email.equals(other.email))
			return false;
		if (followers == null) {
			if (other.followers != null)
				return false;
		} else if (!followers.equals(other.followers))
			return false;
		if (id != other.id)
			return false;
		if (name == null) {
			if (other.name != null)
				return false;
		} else if (!name.equals(other.name))
			return false;
		if (password == null) {
			if (other.password != null)
				return false;
		} else if (!password.equals(other.password))
			return false;
		if (profile == null) {
			if (other.profile != null)
				return false;
		} else if (!profile.equals(other.profile))
			return false;
		if (role == null) {
			if (other.role != null)
				return false;
		} else if (!role.equals(other.role))
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "User [id=" + id + ", name=" + name + ", password=" + password
				+ ", email=" + email + ", active=" + active + ", role=" + role + "]";
	}

}
