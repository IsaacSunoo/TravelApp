package com.skilldistillery.travelapp.repositories;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.skilldistillery.travelapp.entities.Profile;
import com.skilldistillery.travelapp.entities.SettingsDTO;
import com.skilldistillery.travelapp.services.ProfileService;

@SpringBootTest
@RunWith(SpringRunner.class)
public class ProfileRepositoryTests {

	@Autowired
	private ProfileRepository profileRepo;

	@Autowired
	private ProfileService profileService;

	@Test
	public void
			test_profileService_method_updateSettings_updates_settings_and_persists_to_DB() {

		System.out.println(profileRepo.count());

		String settingsDTOJSON = "{\"name\": \"Test1\", \"password\": \"Test\","
				+ " \"email\": \"Test@Test.com\", \"firstName\": \"Johnny\","
				+ " \"lastName\": \"Smith\", \"imgLink\": \"Test\","
				+ " \"bio\": \"TestBio\", \"city\": \"ChicagoTest\","
				+ " \"state\": \"IllinoisTest\", \"country\": \"USA\"}";

		ObjectMapper om = new ObjectMapper();
		SettingsDTO settingsDTO = null;

		try {
			settingsDTO = om.readValue(settingsDTOJSON, SettingsDTO.class);
			System.out.println(settingsDTO);
		} catch (Exception e) {
		}

		Profile updatedProfile = profileService.updateSettings(11, settingsDTO);

	}

}
