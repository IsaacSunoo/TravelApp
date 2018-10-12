package com.skilldistillery.travelapp.services;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.travelapp.entities.Profile;
import com.skilldistillery.travelapp.entities.ProfileLocation;
import com.skilldistillery.travelapp.entities.SettingsDTO;
import com.skilldistillery.travelapp.entities.Trip;
import com.skilldistillery.travelapp.entities.User;
import com.skilldistillery.travelapp.repositories.ProfileLocationRepository;
import com.skilldistillery.travelapp.repositories.ProfileRepository;
import com.skilldistillery.travelapp.repositories.TripRepository;

@Service
public class ProfileServiceImpl implements ProfileService {

	@Autowired
	private ProfileRepository profileRepo;

	@Autowired
	private TripRepository tripRepo;

	@Autowired
	private ProfileLocationRepository profileLocationRepo;

	// CREATE

	@Override
	public Profile bookmarkTrip(Integer pid, Integer tid) {

		// Get the person in session profile from DB
		Profile managedProfileWithFavoriteTripsLoaded = profileRepo
				.queryForFavoriteTripsByProfileId(pid);

		if (managedProfileWithFavoriteTripsLoaded == null) {
			managedProfileWithFavoriteTripsLoaded = profileRepo.findById(pid).get();
			if (managedProfileWithFavoriteTripsLoaded == null) {
				return null;
			}
		}

		// Get the trip to bookmark from DB
		Optional<Trip> opTrip = tripRepo.findById(tid);
		Trip managedTrip = opTrip.get();
		if (!opTrip.isPresent()) {
			return null;
		}

		managedProfileWithFavoriteTripsLoaded.addFavoriteTrip(managedTrip);
		profileRepo.saveAndFlush(managedProfileWithFavoriteTripsLoaded);

		return managedProfileWithFavoriteTripsLoaded;
	}
	
	@Override
	public Profile removeTripBookmark(Integer pid, Integer tid) {
		
		// Get the person in session profile from DB
		Profile managedProfileWithFavoriteTripsLoaded = profileRepo
				.queryForFavoriteTripsByProfileId(pid);
		
		if (managedProfileWithFavoriteTripsLoaded == null) {
			managedProfileWithFavoriteTripsLoaded = profileRepo.findById(pid).get();
			if (managedProfileWithFavoriteTripsLoaded == null) {
				return null;
			}
		}
		
		// Get the trip to remove bookmark from, from the DB
		Optional<Trip> opTrip = tripRepo.findById(tid);
		Trip managedTrip = opTrip.get();
		if (!opTrip.isPresent()) {
			return null;
		}
		
		managedProfileWithFavoriteTripsLoaded.removeFavoriteTrip(managedTrip);
		profileRepo.saveAndFlush(managedProfileWithFavoriteTripsLoaded);
		
		return managedProfileWithFavoriteTripsLoaded;
	}

	// READ

	@Override
	public Profile show(Integer id) {

		Optional<Profile> opProfile = profileRepo.findById(id);

		if (opProfile.isPresent()) {
			return opProfile.get();
		}

		return null;
	}

	@Override
	public List<Trip> queryForFavoriteTripsByProfileId(Integer pid) {
		return profileRepo.queryForFavoriteTripsByProfileId(pid).getFavoriteTrips();
	}

	// UPDATE

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

			// Does the location input from form already exist in the DB?
			List<ProfileLocation> existingLocation = profileLocationRepo
					.findByCityAndStateAndCountry(settingsDTO.getCity(),
							settingsDTO.getState(), settingsDTO.getCountry());

			// Check database to see if location already exists - if so, just set
			// the profile to that location
			if (existingLocation.size() > 0) {
				managedProfile.setLocation(existingLocation.get(0));
			} else {
				// Location was not found in DB, so create a new one

				ProfileLocation newLocation = new ProfileLocation();

				newLocation.setCity(settingsDTO.getCity());
				newLocation.setState(settingsDTO.getState());
				newLocation.setCountry(settingsDTO.getCountry());

				managedProfile.setLocation(newLocation);
			}
			// *** End Location Update Logic ***

			profileRepo.saveAndFlush(managedProfile);

			return managedProfile;
		}

		return null;
	}

// DELETE

}
