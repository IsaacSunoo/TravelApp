import { TripService } from 'src/app/trip.service';
import { Component, OnInit } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { ProfileService } from '../profile.service';
import { User } from '../models/user';
import { UpdateProfile } from '../models/update-profile';
import { Trip } from '../models/trip';
import { Posts } from '../models/posts';
import { PostsService } from '../posts.service';

@Component({
  selector: 'app-scratchpad',
  templateUrl: './scratchpad.component.html',
  styleUrls: ['./scratchpad.component.css']
})
export class ScratchpadComponent implements OnInit {
  // *******************************************************************************
  // FIELDS

  showProfile: UpdateProfile = null;
  id = localStorage.getItem('profileId');
  following: User[] = [];

  followClicked;
  unFollowClicked = null;

  // **
  tripsById: Trip[] = [];

  // **
  postsById: Posts[] = [];

  // **
  favoriteTripsById: Trip[] = [];

  // *******************************************************************************
  // METHODS

  hideFollowBtn = function() {
    if (this.followClicked) {
      this.followClicked = null;
      this.unFollowClicked = true;
    }
  };

  loadUserInfo = function(id: string) {
    this.profServ.show(id).subscribe(data => {
      this.showProfile = data;
      console.log(this.showProfile);
    });
  };

  followUser = function(id: number, fid: number) {
    this.profService.followUser(fid).subscribe(data => {
      this.following = data;
    });
  };

  unfollowUser = function(id: number, fid: number) {
    this.profService.unfollowUser(fid).subscribe(data => {
      console.log('user unfollowed');
    });
  };

  // TEST METHOD /////
  getTripsByProfileId = function(pid) {
    this.tripService.tripIndexByProfileId(pid).subscribe(
      data => {
        this.tripsById = data;
        console.log(this.tripsById);
      },
      err => {
        this.handleError(err);
      }
    );
  };
  // \\\\\ TEST METHOD

  // TEST METHOD /////
  getPostsByProfileId = function(pid) {
    this.postService.indexForOneProfile(pid).subscribe(
      data => {
        this.postsById = data;
        console.log(this.postsById);
      },
      err => {
        this.handleError(err);
      }
    );
  };
  // \\\\\ TEST METHOD

  // TEST METHOD /////
  getFavoriteTripsByProfileId = function(pid) {
    this.profServ.getFavoriteTripsByProfileId(pid).subscribe(
      data => {
        this.favoriteTripsById = data;
        console.log(this.favoriteTripsById);
      },
      err => {
        this.handleError(err);
      }
    );
  };
  // \\\\\ TEST METHOD

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
    private tripService: TripService,
    private postService: PostsService
  ) {}

  ngOnInit() {
    this.loadUserInfo(this.id);
    this.getTripsByProfileId(this.id);
    this.getPostsByProfileId(this.id);
    this.getFavoriteTripsByProfileId(this.id);
  }
}
