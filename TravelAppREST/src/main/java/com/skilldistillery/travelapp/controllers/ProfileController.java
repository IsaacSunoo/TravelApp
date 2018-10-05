package com.skilldistillery.travelapp.controllers;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.skilldistillery.travelapp.entities.Profile;
import com.skilldistillery.travelapp.services.ProfileService;

@RestController
@CrossOrigin({ "*", "http://localhost:4201" })
public class ProfileController {
	
	@Autowired
	private ProfileService profileService;
	
	@RequestMapping(path="profiles/{pid}", method=RequestMethod.PUT)
	public Profile replace(HttpServletRequest req, HttpServletResponse res,
			@PathVariable(name="pid")int pid,
			@RequestBody Profile profile){
		Profile updated = profileService.replace(pid, profile);
		if(updated == null) {
			res.setStatus(404);
		}
		return updated;	
	}
	
	@RequestMapping(path="profiles/{pid}", method=RequestMethod.PATCH)
	public Profile patch(HttpServletRequest req, HttpServletResponse res,
			@PathVariable(name="pid") int pid,
			@RequestBody Profile profile) {
		Profile patched = profileService.patch(pid, profile);
			if(patched != null) {
				return patched;
			} else {
				res.setStatus(500);
			}
	}
	
	

}
