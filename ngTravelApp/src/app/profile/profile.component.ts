import { FollowersService } from './../followers.service';
import { Component, OnInit } from '@angular/core';
import { ProfileService } from '../profile.service';
import { Router, ActivatedRoute } from '@angular/router';
import { UpdateProfile } from '../models/update-profile';
import { FollowingService } from '../following.service';
import { User } from '../models/user';
import { Profile } from '../models/profile';


@Component({
  selector: 'app-profile',
  templateUrl: './profile.component.html',
  styleUrls: ['./profile.component.css']
})
export class ProfileComponent implements OnInit {

  showProfile: UpdateProfile = null;
  id = localStorage.getItem('profileId');
  following: User [] = [];
  users: User [] = [];
  profiles: Profile [] = [];

  followClicked;
  unFollowClicked = null;
  testId;

  hideFollowBtn = function() {
    if (this.followClicked) {
      this.followClicked = null;
      this.unFollowClicked = true;
    }
  };

  discoverFollowers = function() {
    this.profServ.discover().subscribe(
      data => {
        this.users = data;
      }
    );
  };

 followingIndex = function(id: string) {
   this.profServ.followingIndex(id).subscribe(
     data => {
        this.users = data;
     });
 };

  loadUserInfo = function (id: string) {
    this.profServ.show(id).subscribe(
      data => {
        this.showProfile = data;
        console.log(this.showProfile);

      });
  };

  followUser = function(id: string, testId: string) {
    this.profServ.followUser(id, testId).subscribe(
      data => {
        console.log('user followed');
         this.users = data;
      });
  };

  unfollowUser = function(id: string, testId: string) {

    this.profServ.unfollowUser(id, testId).subscribe(
      data => {
        console.log('user unfollowed');
      });
  };

  constructor(private activatedRoute: ActivatedRoute,
    private router: Router,
    private profServ: ProfileService) { }

  ngOnInit() {
    this.testId = this.activatedRoute.snapshot.paramMap.get('id');
    this.discoverFollowers();
    if (this.testId) {
    this.loadUserInfo(this.testId);
    this.followingIndex(this.testId);
    } else {
      this.followingIndex(this.id);
      this.loadUserInfo(this.id);
    }


  }
}
