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

  // *******************************************************************************
  // METHODS

  loadProfile = function(id: string) {
    this.tripService.show(id).subscribe(data => {
      this.userProfile = data;
      console.log(this.userProfile);
    });
  };

  // *******************************************************************************
  // HELPERS

  constructor(
    private activatedRoute: ActivatedRoute,
    private router: Router,
    private tripService: TripDetailsService
  ) {}

  ngOnInit() {
    this.loadProfile(this.id);
  }
}
