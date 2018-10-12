package com.skilldistillery.travelapp.services;

import java.util.List;

import com.skilldistillery.travelapp.entities.Profile;
import com.skilldistillery.travelapp.entities.SettingsDTO;
import com.skilldistillery.travelapp.entities.Trip;

public interface ProfileService {

	public Profile updateSettings(Integer id, SettingsDTO settingsDTO);

	public Profile show(Integer id);

	public List<Trip> queryForFavoriteTripsByProfileId(Integer pid);

	public Profile bookmarkTrip(Integer pid, Integer tid);

	public Profile removeTripBookmark(Integer pid, Integer tid);

}
