package com.skilldistillery.travelapp.services;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.travelapp.entities.Profile;
import com.skilldistillery.travelapp.entities.ProfileLocation;
import com.skilldistillery.travelapp.entities.SettingsDTO;
import com.skilldistillery.travelapp.repositories.ProfileRepository;

@Service
public class ProfileServiceImpl implements ProfileService {

	@Autowired
	private ProfileRepository profileRepo;

	// This method will update from the settings form for a profile and location
	// (but not user -- that's in the UserServiceImpl)
	@Override
	public Profile updateSettings(Integer id, SettingsDTO settingsDTO) {

		Optional<Profile> opProfile = profileRepo.findById(id);

		if (opProfile.isPresent()) {
			Profile managedProfile = opProfile.get();

			if (settingsDTO.getFirstName() != null
					&& !settingsDTO.getFirstName().equals("")
					&& settingsDTO.getFirstName() != managedProfile.getFirstName()) {
				managedProfile.setFirstName(settingsDTO.getFirstName());
			}

			if (settingsDTO.getLastName() != null
					&& !settingsDTO.getLastName().equals("")
					&& settingsDTO.getLastName() != managedProfile.getLastName()) {
				managedProfile.setLastName(settingsDTO.getLastName());
			}

			if (settingsDTO.getImgLink() != null
					&& !settingsDTO.getImgLink().equals("")
					&& settingsDTO.getImgLink() != managedProfile.getImgLink()) {
				managedProfile.setImgLink(settingsDTO.getImgLink());
			}

			if (settingsDTO.getBio() != null && !settingsDTO.getBio().equals("")
					&& settingsDTO.getBio() != managedProfile.getBio()) {
				managedProfile.setBio(settingsDTO.getBio());
			}

			// *** Updating Location Values For a Profile ***
			// Check whether *managedProfile* already has a location set - if not,
			// persist the new location to the database as well
			if (managedProfile.getLocation() != null) {

				if (settingsDTO.getCity() != null && !settingsDTO.getCity().equals("")
						&& !settingsDTO.getCity()
								.equals(managedProfile.getLocation().getCity())) {
					managedProfile.getLocation().setCity(settingsDTO.getCity());
				}

				if (settingsDTO.getState() != null && !settingsDTO.getState().equals("")
						&& !settingsDTO.getState()
								.equals(managedProfile.getLocation().getState())) {
					managedProfile.getLocation().setState(settingsDTO.getState());
				}

				if (settingsDTO.getCountry() != null
						&& !settingsDTO.getCountry().equals("") && !settingsDTO.getCountry()
								.equals(managedProfile.getLocation().getCountry())) {
					managedProfile.getLocation().setCountry(settingsDTO.getCountry());
				}

				// In the case the location does not already exist in DB
			} else {

				ProfileLocation newLocation = new ProfileLocation();

				newLocation.setCity(settingsDTO.getCity());
				newLocation.setState(settingsDTO.getState());
				newLocation.setCountry(settingsDTO.getCountry());

				managedProfile.setLocation(newLocation);

			}

			profileRepo.saveAndFlush(managedProfile);

			return managedProfile;
		}

		return null;
	}

}
