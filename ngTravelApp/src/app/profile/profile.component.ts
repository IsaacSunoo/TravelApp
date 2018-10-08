import { Component, OnInit } from '@angular/core';
import { ProfileService } from '../profile.service';
import { Router, ActivatedRoute } from '@angular/router';
import { UpdateProfile } from '../models/update-profile';

@Component({
  selector: 'app-profile',
  templateUrl: './profile.component.html',
  styleUrls: ['./profile.component.css']
})
export class ProfileComponent implements OnInit {

  showProfile: UpdateProfile = null;
  id = localStorage.getItem('profileId');

  loadUserInfo = function (id: string) {
    this.profServ.show(id).subscribe(
      data => {
        this.showProfile = data;
        console.log(this.showProfile);

      });
  };

  constructor(private activatedRoute: ActivatedRoute,
    private router: Router,
    private profServ: ProfileService) { }

  ngOnInit() {
    this.loadUserInfo(this.id);
  }

}
