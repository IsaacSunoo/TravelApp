import { UpdateProfile } from './../models/update-profile';
import { Component, OnInit } from '@angular/core';
import { User } from '../models/user';
import { FollowersService } from '../followers.service';

@Component({
  selector: 'app-followers',
  templateUrl: './followers.component.html',
  styleUrls: ['./followers.component.css']
})
export class FollowersComponent implements OnInit {

  id = localStorage.getItem('profileId');
  users: User [] = [];
  results: UpdateProfile [] = [];
  keyword;

  discover = function(id: string) {
    this.followServ.discover(id).subscribe(
      data => {
        this.users = data;
      }
    );
  };

  searchForUsers = function() {
    this.followServ.search(this.keyword).subscribe(
      data => {
        this.results = data;
      }
    );
  };

  constructor(private followServ: FollowersService) { }

  ngOnInit() {
    this.discover(this.id);
  }

}

