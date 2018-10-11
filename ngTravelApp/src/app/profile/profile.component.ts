import { FollowersService } from './../followers.service';
import { Component, OnInit } from '@angular/core';
import { ProfileService } from '../profile.service';
import { Router, ActivatedRoute } from '@angular/router';
import { UpdateProfile } from '../models/update-profile';
import { FollowingService } from '../following.service';
import { User } from '../models/user';

@Component({
  selector: 'app-profile',
  templateUrl: './profile.component.html',
  styleUrls: ['./profile.component.css']
})
export class ProfileComponent implements OnInit {

  showProfile: UpdateProfile = null;
  id = localStorage.getItem('profileId');
  following: User [] = [];

  followClicked;
  unFollowClicked = null;

    hideFollowBtn = function() {
    if (this.followClicked) {
      this.followClicked = null;
      this.unFollowClicked = true;
    }
  };


  loadUserInfo = function (id: string) {
    this.profServ.show(id).subscribe(
      data => {
        this.showProfile = data;
        console.log(this.showProfile);

      });
  };

  followUser = function(id: number, fid: number) {
    this.profService.followUser(fid).subscribe(
      data => {
        this.following = data;
      });
  };

  unfollowUser = function(id: number, fid: number) {
    this.profService.unfollowUser(fid).subscribe(
      data => {
        console.log('user unfollowed');
      });
  };

  constructor(private activatedRoute: ActivatedRoute,
    private router: Router,
    private profServ: ProfileService) { }

  ngOnInit() {
    this.loadUserInfo(this.id);
  }
}
