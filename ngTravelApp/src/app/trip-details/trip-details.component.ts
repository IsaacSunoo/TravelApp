import { Component, OnInit } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { TripDetailsService } from '../trip-details.service';
import { Trip } from '../models/trip';

@Component({
  selector: 'app-trip-details',
  templateUrl: './trip-details.component.html',
  styleUrls: ['./trip-details.component.css']
})
export class TripDetailsComponent implements OnInit {
  userProfile = null;
  trips: Trip[] = [];
  id = localStorage.getItem('profileId');

  loadProfile = function(id: string) {
    this.tripService.showProfile(id).subscribe(data => {
      this.userProfile = data;
      console.log(this.userProfile);
    });
  };

  loadTrips = function(id: string) {
    console.log(id);

    this.tripService.index(id).subscribe(data => {
      this.trips = data;
      console.log(this.trips);
    });
  };

  constructor(
    private activatedRoute: ActivatedRoute,
    private router: Router,
    private tripService: TripDetailsService
  ) {}

  ngOnInit() {
    this.loadProfile(this.id);
    this.loadTrips(this.id);
  }
}
