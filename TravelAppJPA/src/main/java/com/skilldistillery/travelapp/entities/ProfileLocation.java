package com.skilldistillery.travelapp.entities;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIgnore;

@Entity
@Table(name="profile_loc")
public class ProfileLocation {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	
	private String city;
	
	private String state;
	
	private String country;
	
	@JsonIgnore
	@OneToMany(mappedBy="location")
	private List<Profile> profiles;
	
	public ProfileLocation() {

	}

	public ProfileLocation(int id, String city, String state, String country, List<Profile> profiles) {
		this.id = id;
		this.city = city;
		this.state = state;
		this.country = country;
		this.profiles = profiles;
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
	
	public List<Profile> getProfiles() {
		return profiles;
	}

	public void setProfiles(List<Profile> profiles) {
		this.profiles = profiles;
	}

	public void addProfile(Profile profile) {
		if (profiles == null) profiles = new ArrayList();
		
		if (!profiles.contains(profile)) {
			profiles.add(profile);
			if(profile.getLocation() != null) {
				profile.getLocation().getProfiles().remove(profile);
			}
			profile.setLocation(this);
		}
	}
	
	public void removeProfile(Profile profile) {
		profile.setLocation(null);
		if (profiles != null) {
			profiles.remove(profile);
		}
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((city == null) ? 0 : city.hashCode());
		result = prime * result + ((country == null) ? 0 : country.hashCode());
		result = prime * result + id;
		result = prime * result + ((profiles == null) ? 0 : profiles.hashCode());
		result = prime * result + ((state == null) ? 0 : state.hashCode());
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
		ProfileLocation other = (ProfileLocation) obj;
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
		if (profiles == null) {
			if (other.profiles != null)
				return false;
		} else if (!profiles.equals(other.profiles))
			return false;
		if (state == null) {
			if (other.state != null)
				return false;
		} else if (!state.equals(other.state))
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "ProfileLocation [id=" + id + ", city=" + city + ", state=" + state + ", country=" + country
				+ ", profiles=" + profiles + "]";
	}
	
}
