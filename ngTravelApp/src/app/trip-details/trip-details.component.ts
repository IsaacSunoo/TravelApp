import { Component, OnInit } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { TripDetailsService } from '../trip-details.service';

@Component({
  selector: 'app-trip-details',
  templateUrl: './trip-details.component.html',
  styleUrls: ['./trip-details.component.css']
})
export class TripDetailsComponent implements OnInit {
  userProfile = null;
  id = localStorage.getItem('profileId');

  loadProfile = function(id: string) {
    this.tripService.show(id).subscribe(data => {
      this.userProfile = data;
      console.log(this.userProfile);
    });
  };

  constructor(private activatedRoute: ActivatedRoute,
    private router: Router,
    private tripService: TripDetailsService) { }

  ngOnInit() {
    this.loadProfile(this.id);
  }
}
