package com.skilldistillery.travelapp.services;

import com.skilldistillery.travelapp.entities.Profile;
import com.skilldistillery.travelapp.entities.SettingsDTO;
import com.skilldistillery.travelapp.entities.User;

public interface UserService {

	public User register(String json);

	User updateSettings(Integer id, SettingsDTO settingsDTO);

}
