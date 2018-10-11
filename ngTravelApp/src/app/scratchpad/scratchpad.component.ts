import { Component, OnInit } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { TripDetailsService } from '../trip-details.service';
import { Trip } from '../models/trip';

@Component({
  selector: 'app-scratchpad',
  templateUrl: './scratchpad.component.html',
  styleUrls: ['./scratchpad.component.css']
})
export class ScratchpadComponent implements OnInit {
  // *******************************************************************************
  // FIELDS

  userProfile = null;

  id = localStorage.getItem('profileId');

  trip: Trip = new Trip();

  tripDateStart: Date = new Date();

  tripDateEnd: Date = new Date();

  // This is false initially,
  // but when we load the trip from subscribe, set it to true,
  // this is to avoid errors in console complaining about not being able
  // to access properties, but this is because of the asynchronous
  // process of the server
  haveTrip: Boolean = false;
  haveResource: Boolean = false;
  haveTip: Boolean = false;
  haveWarning: Boolean = false;

  tripId;

  // *******************************************************************************
  // METHODS

  loadProfile = function(id: string) {
    this.tripDetailsService.showProfile(id).subscribe(
      data => {
        this.userProfile = data;
        console.log(this.userProfile);
      },
      err => {
        this.handleError(err);
      }
    );
  };

  loadTrip = function(tripId: string) {
    this.tripDetailsService.showTrip(tripId).subscribe(
      data => {
        this.trip = data;
        this.trip.dateStart = this.formatDate(new Date(this.trip.dateStart));
        this.trip.dateEnd = this.formatDate(new Date(this.trip.dateEnd));
        this.haveTrip = true;

        this.trip.recommendations.forEach(recommendation => {
          if (recommendation.recType.name.includes('resource')) {
            this.haveResource = true;
          }

          if (recommendation.recType.name.includes('tip')) {
            this.haveTip = true;
          }

          if (recommendation.recType.name.includes('warning')) {
            this.haveWarning = true;
          }
        });

        console.log(this.trip);
      },
      err => {
        this.handleError(err);
      }
    );
  };

  formatDate = function(date) {
    const monthNames = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];

    const day = date.getDate();
    const monthIndex = date.getMonth();
    const year = date.getFullYear();

    return day + ' ' + monthNames[monthIndex] + ' ' + year;
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
    private tripDetailsService: TripDetailsService
  ) {}

  ngOnInit() {
    this.loadProfile(this.id);

    // Get the tripId from the URL
    // (which is the routerLink created when you click on a post from the feed page)
    this.tripId = this.activatedRoute.snapshot.paramMap.get('id');
    console.log(this.tripId);
    if (this.tripId) {
      this.loadTrip(this.tripId);
    }
  }
}
