import { Profile } from './../models/profile';
import { Component, OnInit } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable, throwError } from 'rxjs';
import { catchError } from 'rxjs/operators';
import { FollowingService } from '../following.service';
import { User } from '../models/user';

@Component({
  selector: 'app-following',
  templateUrl: './following.component.html',
  styleUrls: ['./following.component.css']
})
export class FollowingComponent implements OnInit {

  id = localStorage.getItem('profileId');
  following: User [] = [];



  followUser = function(id: number, fid: number) {
    this.followingService.followUser(fid).subscribe(
      data => {
        this.following = data;
      });
  };

  constructor(private http: HttpClient, private followingService: FollowingService) {}

  ngOnInit() {
  }
}
