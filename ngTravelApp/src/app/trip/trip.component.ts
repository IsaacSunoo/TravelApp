import { Component, OnInit } from '@angular/core';
import { Trip } from '../models/trip';
import { NgForm } from '@angular/forms';
import { TripService } from '../trip.service';
import { ActivatedRoute, Router } from '@angular/router';

@Component({
  selector: 'app-trip',
  templateUrl: './trip.component.html',
  styleUrls: ['./trip.component.css']
})
export class TripComponent implements OnInit {
  trips: Trip[] = [];
  newTrip: Trip = new Trip();
  id;

  createTrip(form: NgForm) {
    const trip = form.value;
    console.log(trip);

    this.tripService.create(trip).subscribe(
      data => {
        console.log('returned data: ');
        console.log(data);
      }
    );
  }

  constructor(private activatedRoute: ActivatedRoute, private router: Router, private tripService: TripService) { }

  ngOnInit() {
    this.id = this.activatedRoute.snapshot.paramMap.get('id');
    // this.loadTrip(this.id);
    //   console.log(this.id);
  }

}

