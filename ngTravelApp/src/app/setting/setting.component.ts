import { UpdateProfile } from './../models/update-profile';
import { Component, OnInit } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';

@Component({
  selector: 'app-setting',
  templateUrl: './setting.component.html',
  styleUrls: ['./setting.component.css']
})

export class SettingComponent implements OnInit {

  selected: UpdateProfile = null;
  editProfile: UpdateProfile = new UpdateProfile();

  updateProfile = function (profile: UpdateProfile) {
    this.todoService.update(profile).subscribe(
      data => {
        this.selected = data;
        this.editProfile = null;
        this.reload();
      });
  };













  constructor(private activatedRoute: ActivatedRoute, private router: Router) {}

  ngOnInit() {}
}
