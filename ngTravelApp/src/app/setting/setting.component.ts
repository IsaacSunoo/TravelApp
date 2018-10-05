import { Component, OnInit } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { Registration } from '../models/registration';

@Component({
  selector: 'app-setting',
  templateUrl: './setting.component.html',
  styleUrls: ['./setting.component.css']
})

export class SettingComponent implements OnInit {

  selected: Registration = null;
  editProfile: Registration = new Registration();

  setEditProfile = function () {
    this.edit = Object.assign({}, this.selected);

};

  constructor(private activatedRoute: ActivatedRoute, private router: Router) {}

  ngOnInit() {}
}
