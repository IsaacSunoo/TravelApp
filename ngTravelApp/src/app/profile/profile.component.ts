import { FollowersService } from './../followers.service';
import { Component, OnInit } from '@angular/core';
import { ProfileService } from '../profile.service';
import { UpdateProfile } from '../models/update-profile';
import { FollowingService } from '../following.service';
import { User } from '../models/user';
import { Profile } from '../models/profile';
import { UserService } from '../user.service';
import { TripService } from 'src/app/trip.service';
import { ActivatedRoute, Router } from '@angular/router';

import { Trip } from '../models/trip';
import { Posts } from '../models/posts';
import { PostsService } from '../posts.service';

@Component({
  selector: 'app-profile',
  templateUrl: './profile.component.html',
  styleUrls: ['./profile.component.css']
})
export class ProfileComponent implements OnInit {
  // *******************************************************************************
  // FIELDS

  isDifferentProfile: Boolean = false;

  showProfile: UpdateProfile = null;
  id = localStorage.getItem('profileId');
  following: User[] = [];
  users: User[] = [];
  profiles: Profile[] = [];

  followClicked;
  unFollowClicked = null;
  otherProfileId;
  loggedIn;

  tripsById: Trip[] = [];

  postsById: Posts[] = [];

  favoriteTripsById: Trip[] = [];

  favoritePosts: Posts[] = [];

  // *******************************************************************************
  // METHODS

  logout = function() {
    this.userServ.logout();
    this.router.navigateByUrl('home');
  };

  hideFollowBtn = function() {
    if (this.followClicked) {
      this.followClicked = null;
      this.unFollowClicked = true;
    }
  };

  followingIndex = function(id: string) {
    this.profServ.followingIndex(id).subscribe(data => {
      this.users = data;
    });
  };

  loadUserInfo = function(id: string) {
    this.profServ.show(id).subscribe(data => {
      this.showProfile = data;
    });
  };

  followUser = function(id: string, otherProfileId: string) {
    this.profServ.followUser(id, otherProfileId).subscribe(data => {
      console.log('user followed');
      this.users = data;
    });
  };

  unfollowUser = function(id: string, otherProfileId: string) {
    this.profServ.unfollowUser(id, otherProfileId).subscribe(data => {
      console.log('user unfollowed');
    });
  };

  // new stuff

  getTripsByProfileId = function(pid) {
    this.tripService.tripIndexByProfileId(pid).subscribe(
      data => {
        this.tripsById = data;
        this.tripsById.forEach(element => {});
      },
      err => {
        this.handleError(err);
      }
    );
  };

  getPostsByProfileId = function(pid) {
    this.postService.indexForOneProfile(pid).subscribe(
      data => {
        this.postsById = data;
      },
      err => {
        this.handleError(err);
      }
    );
  };

  getFavoriteTripsByProfileId = function(pid) {
    this.profServ.getFavoriteTripsByProfileId(pid).subscribe(
      data => {
        this.favoriteTripsById = data;

        this.favoriteTripsById.forEach(trip => {
          this.postService
            .getPostByProfileAndTripId(trip.profile.id, trip.id)
            .subscribe(
              postReturnData => {
                const tripPost = postReturnData;

                this.favoritePosts.push(tripPost);
              },
              errPostReturn => {
                this.handleError(errPostReturn);
              }
            );
        });
      },
      err => {
        this.handleError(err);
      }
    );
  };

  handleError(error: any) {
    console.error('Something Broke');
    console.log(error);
  }

  // *******************************************************************************
  // HELPERS

  constructor(
    private activatedRoute: ActivatedRoute,
    private router: Router,
    private profServ: ProfileService,
    private userServ: UserService,
    private tripService: TripService,
    private postService: PostsService
  ) {}

  ngOnInit() {
    this.otherProfileId = this.activatedRoute.snapshot.paramMap.get('id');

    if (this.otherProfileId && this.otherProfileId !== this.id) {
      // Set this boolean to true, tells us whether or not to show the
      // follow/unfollow buttons on the page
      this.isDifferentProfile = true;

      this.loadUserInfo(this.otherProfileId);
      this.followingIndex(this.otherProfileId);
      this.getTripsByProfileId(this.otherProfileId);
      this.getPostsByProfileId(this.otherProfileId);
      this.getFavoriteTripsByProfileId(this.otherProfileId);
    } else {
      this.followingIndex(this.id);
      this.loadUserInfo(this.id);
      this.getTripsByProfileId(this.id);
      this.getPostsByProfileId(this.id);
      this.getFavoriteTripsByProfileId(this.id);
    }
  }
}
