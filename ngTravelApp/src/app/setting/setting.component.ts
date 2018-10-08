import { NgForm } from '@angular/forms';
import { SettingService } from './../setting.service';
import { UpdateProfile } from './../models/update-profile';
import { Component, OnInit } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { Profile } from '../models/profile';

@Component({
  selector: 'app-setting',
  templateUrl: './setting.component.html',
  styleUrls: ['./setting.component.css']
})
export class SettingComponent implements OnInit {
  userProfile = null;
  editProfile: UpdateProfile = new UpdateProfile();
  id = localStorage.getItem('profileId');

  updateProfile = function(updateForm: NgForm) {
    this.editProfile.name = updateForm.value.name;
    this.editProfile.password = updateForm.value.password;
    this.editProfile.firstName = updateForm.value.firstName;
    this.editProfile.lastName = updateForm.value.lastName;
    this.editProfile.email = updateForm.value.email;
    this.editProfile.imgLink = updateForm.value.imgLink;
    this.editProfile.bio = updateForm.value.bio;
    this.editProfile.city = updateForm.value.city;
    this.editProfile.state = updateForm.value.state;
    this.editProfile.country = updateForm.value.country;
    console.log(this.editProfile);

    this.setService.update(this.editProfile, this.id).subscribe(
      data => {
        console.log(this.editProfile);

        this.editProfile = data;
      },
      err => {
        console.log('Observer recieved an Error: ' + err);
      }
    );
  };

  loadProfile = function(id: string) {
    this.setService.show(id).subscribe(data => {
      this.userProfile = data;
      console.log(this.userProfile);
    });
  };

  constructor(
    private activatedRoute: ActivatedRoute,
    private router: Router,
    private setService: SettingService
  ) {}

  ngOnInit() {
    this.loadProfile(this.id);
  }
}
