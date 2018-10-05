package com.skilldistillery.travelapp.services;

import com.skilldistillery.travelapp.entities.Profile;
import com.skilldistillery.travelapp.entities.SettingsDTO;

public interface ProfileService {

	public Profile updateSettings(Integer id, SettingsDTO settingsDTO);

}
