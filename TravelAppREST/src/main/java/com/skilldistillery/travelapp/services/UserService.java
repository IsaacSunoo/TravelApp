package com.skilldistillery.travelapp.services;

import java.util.List;

import com.skilldistillery.travelapp.entities.SettingsDTO;
import com.skilldistillery.travelapp.entities.User;

public interface UserService {

	public User register(String json);

	public User updateSettings(Integer id, SettingsDTO settingsDTO);

	public User getOneUser(String username);

	User followUser(Integer uid, Integer friendId);

	List<User> findFollowers(Integer uid);

	boolean unfollowUser(Integer uid, Integer fid);

	List<User> discoverPeopleToFollow(Integer uid);

	List<User> searchForUsers(String keyword);
	

}
