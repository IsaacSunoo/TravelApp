package com.skilldistillery.travelapp.services;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.travelapp.entities.Destination;
import com.skilldistillery.travelapp.entities.NewTripPostDTO;
import com.skilldistillery.travelapp.entities.Posts;
import com.skilldistillery.travelapp.entities.Profile;
import com.skilldistillery.travelapp.entities.Trip;
import com.skilldistillery.travelapp.repositories.DestinationRepository;
import com.skilldistillery.travelapp.repositories.PostsRepository;
import com.skilldistillery.travelapp.repositories.ProfileRepository;

@Service
public class PostServiceImpl implements PostService {

	@Autowired
	private PostsRepository postRepo;

	@Autowired
	private DestinationRepository destinationRepo;

	@Autowired
	private ProfileRepository profileRepo;

	// READ ************************************************************

	@Override
	public List<Posts> index() {
		return postRepo.findAll();
	}

	@Override
	public Posts show(Integer id) {
		Optional<Posts> post = postRepo.findById(id);

		if (post.isPresent()) {
			return post.get();
		}

		return null;
	}

	@Override
	public List<Posts> getAllPostsForOneProfile(Integer pid) {
		return postRepo.queryAllPostsForOneProfile(pid);
	}

	// CREATE ***********************************************************

	@Override
	public Posts create(Posts post) {
		return postRepo.saveAndFlush(post);
	}

	// This method is called to create a "trip" post, it takes a DTO object and
	// cascade persists everything required for making a trip post to the feed.
	@Override
	public Posts createTripPost(Integer id, NewTripPostDTO newTripPostDTO) {

		Optional<Profile> opProfile = profileRepo.findById(id);
		Profile managedProfile = opProfile.get();

		// Creating all the objects which will need to be persisted
		Posts post = new Posts();
		Trip trip = new Trip();
		Destination destination = new Destination();

		post.setMessage(newTripPostDTO.getMessage());

		trip.setTitle(newTripPostDTO.getTitle());
		trip.setRating(newTripPostDTO.getRating());
		trip.setTotalCost(newTripPostDTO.getTotalCost());
		trip.setDateStart(newTripPostDTO.getDateStart());
		trip.setDateEnd(newTripPostDTO.getDateEnd());
		trip.setReview(newTripPostDTO.getReview());
		trip.setImgLink(newTripPostDTO.getImgLink());

		// Does the location input from form already exist in the DB?
		List<Destination> existingDestination = destinationRepo
				.findByCityAndStateAndCountry(newTripPostDTO.getCity(),
						newTripPostDTO.getState(), newTripPostDTO.getCountry());

		if (existingDestination.size() > 0) {

			trip.setDestination(existingDestination.get(0));

		} else {
			// The location was not found, so create it in the DB
			destination.setCity(newTripPostDTO.getCity());
			destination.setState(newTripPostDTO.getState());
			destination.setCountry(newTripPostDTO.getCountry());
			destination.setLongitude(newTripPostDTO.getLongitude());
			destination.setLatitude(newTripPostDTO.getLatitude());
			trip.setDestination(destination);
		}

		post.setProfile(managedProfile);
		trip.setProfile(managedProfile);

		post.setTrip(trip);
		postRepo.saveAndFlush(post);

		return post;
	}

	// UPDATE ***********************************************************

	// DELETE ***********************************************************

	@Override
	public Boolean delete(Integer id) {

		try {
			postRepo.deleteById(id);
			return true;
		} catch (Exception e) {
			e.printStackTrace();
		}

		return false;
	}

}
