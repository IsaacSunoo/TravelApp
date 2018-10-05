import { SettingService } from './../setting.service';
import { UpdateProfile } from './../models/update-profile';
import { Component, OnInit } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { Form } from '@angular/forms';

@Component({
  selector: 'app-setting',
  templateUrl: './setting.component.html',
  styleUrls: ['./setting.component.css']
})
export class SettingComponent implements OnInit {
  editProfile: UpdateProfile = null;

  updateProfile = function() {

      this.setService.update(this.editProfile).subscribe(data => {
      this.selected = data;
      this.editProfile = null;
    });
  };

  loadProfile = function (id: string) {
    this.setService.show(id).subscribe(data => {
      this.editProfile = data;
    },
    error => {
      console.log('Error in component');

    }

    );
  };

  constructor(
    private activatedRoute: ActivatedRoute,
    private router: Router,
    private setService: SettingService
  ) {}

  ngOnInit() {
    const id: string = this.activatedRoute.snapshot.paramMap.get('id');
    this.loadProfile(id);
    console.log(id);

  }
}
