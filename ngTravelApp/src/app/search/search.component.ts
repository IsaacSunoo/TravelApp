import { Component, OnInit } from '@angular/core';
import { User } from '../models/user';
import { FeedService } from '../feed.service';
import { ActivatedRoute } from '@angular/router';
import { Profile } from '../models/profile';
import { Trip } from '../models/trip';
import { UserService } from '../user.service';

@Component({
  selector: 'app-search',
  templateUrl: './search.component.html',
  styleUrls: ['./search.component.css']
})
export class SearchComponent implements OnInit {

  users: User [] = [];
  profiles: Profile [] = [];
  keyword;
  trips: Trip [] = [];
  showTable = true;

  searchForUsers = function() {
    this.feedServ.search(this.keyword).subscribe(
      data => {
        this.users = data;
      },
      err => {
        console.log('error');
      }
    );
  };

  searchForProfiles = function() {
    console.log('profiles');

    this.feedServ.searchProfiles(this.keyword).subscribe(
      data => {
          this.profiles = data;
      },
      err => {
        console.log('error');
      }
    );
  };
  searchForTrips = function() {
    console.log('trips');

    this.feedServ.searchTrips(this.keyword).subscribe(
      data => {
      this.trips = data;
      },
      err => {
        console.log('error');
      }
    );
  };

  constructor(private feedServ: FeedService, private activatedRoute: ActivatedRoute) { }

  ngOnInit() {
    this.keyword = this.activatedRoute.snapshot.paramMap.get('keyword');
    // this.searchForUsers();
    this.searchForProfiles();
    this.searchForTrips();
  }

}
