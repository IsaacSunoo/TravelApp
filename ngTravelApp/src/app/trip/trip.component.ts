import { Component, OnInit } from '@angular/core';
import { Trip } from '../models/trip';
import { NgForm } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import { TripService } from 'src/app/trip.service';

@Component({
  selector: 'app-trip',
  templateUrl: './trip.component.html',
  styleUrls: ['./trip.component.css']
})
export class TripComponent implements OnInit {
  trips: Trip[] = [];
  newTrip: Trip = new Trip();
  id;
   selected = null;
  editTrip: Trip = new Trip ();

  displayTrip = function(trip) {
    this.selected = trip;
  };


  // load = function () {

  //   if (this.trips) {
  //     this.tripService.index().subscribe(
  //       data => {
  //         this.trips = data;
  //       },
  //       err => {
  //         console.log('Observer got an error: ' + err);
  //       },
  //       complete => {
  //         console.log('complete');
  //       });
  //   }
  // };

  loadTrips = function(id: string) {
    console.log(id);

    this.tripService.index(id).subscribe(
      data => {
      this.trips = data;
      console.log(this.trips);

    });
  };

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

  deleteTrip = function (id: number) {
    this.tripService.destroy(id).subscribe(
      data => {
        console.log('data deleted');
        this.reload();

      }
    );
  };

  updateTrip = function (updateForm: NgForm) {
    this.editTrip.title = updateForm.value.title;
    this.editTrip.rating = updateForm.value.rating;
    this.totalCost = updateForm.value.totalCost;
    this.dateStart = updateForm.value.dateStart;
    this.dateEnd = updateForm.value.dateEnd;
    this.review = updateForm.value.review;
    this.imgLink = updateForm.value.imgLink;
    console.log(this.editTrip);
    this.tripService.update(this.editTrip, this.id).subscribe(
      data => {
        console.log(this.editTrip);
        this.editTrip = data;
      },
      err => {
        console.log('Observer recieved an Error: ' + err);
      });
  };

  constructor(private activatedRoute: ActivatedRoute, private router: Router, private tripService: TripService) { }

  ngOnInit() {
    const id = localStorage.getItem('profileId');
     this.loadTrips(id);
    //   console.log(this.id);
  }

}

