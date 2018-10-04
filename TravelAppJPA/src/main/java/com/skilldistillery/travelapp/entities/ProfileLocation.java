package com.skilldistillery.travelapp.entities;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;

@Entity
public class ProfileLocation {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	
	private String city;
	
	private String state;
	
	private String country;
	
	@OneToMany(mappedBy="location")
	private List<Profile> profiles;
	
	public ProfileLocation() {

	}

	public ProfileLocation(int id, String city, String state, String country) {
		this.id = id;
		this.city = city;
		this.state = state;
		this.country = country;
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
	
	public void removeAddresssss(Profile profile) {
		profile.setLocation(null);
		if (profiles != null) {
			profiles.remove(profile);
		}
	}
		
}
