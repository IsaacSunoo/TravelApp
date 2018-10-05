package com.skilldistillery.travelapp.repositories;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

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

		String settingsDTO = "{\"name\": \"Test1\", \"password\": \"Test\", \"email\": \"Test@Test.com\", \"firstName\": \"John\", \"lastName\": \"Smith\", \"imgLink\": \"Test\", \"bio\": \"TestBio\", \"city\": \"ChicagoTest\", \"state\": \"IllinoisTest\", \"country\": \"USA\"}";
		
		

	}

}
