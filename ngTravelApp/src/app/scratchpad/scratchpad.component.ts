import { Component, OnInit } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { TripDetailsService } from '../trip-details.service';

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

  tripId;

  // *******************************************************************************
  // METHODS

  loadProfile = function(id: string) {
    this.tripDetailsService.show(id).subscribe(
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
      data => {},
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
    private tripDetailsService: TripDetailsService
  ) {}

  ngOnInit() {
    this.loadProfile(this.id);
  }
}
