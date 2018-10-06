import { SettingService } from './../setting.service';
import { UpdateProfile } from './../models/update-profile';
import { Component, OnInit } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';

@Component({
  selector: 'app-setting',
  templateUrl: './setting.component.html',
  styleUrls: ['./setting.component.css']
})

export class SettingComponent implements OnInit {

  editProfile: UpdateProfile = null;

  updateProfile = function (profile: UpdateProfile) {
    this.setService.update(profile).subscribe(
      data => {
        this.editProfile = data;
      });
  };

  loadProfile = function (id: string) {
    this.setService.show(id).subscribe(
      data => {
        this.editProfile = data;
      });
  };

  constructor(private activatedRoute: ActivatedRoute, private router: Router, private setService: SettingService) {}

  ngOnInit() {
    const id = this.activatedRoute.snapshot.paramMap.get('id');
    this.editProfile = new UpdateProfile();
    this.editProfile.firstName = 'swiper';
    this.loadProfile(id);
      console.log(id);
  }
}
