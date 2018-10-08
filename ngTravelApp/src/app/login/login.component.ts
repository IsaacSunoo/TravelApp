import { Component, OnInit } from '@angular/core';
import { NgForm } from '@angular/forms';
import { UserService } from '../user.service';

@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.css']
})
export class LoginComponent implements OnInit {
  // *******************************************************************************
  // FIELDS

  // *******************************************************************************
  // METHODS

  login = function(loginForm: NgForm) {
    const username = loginForm.value.name;
    const password = loginForm.value.password;

    const user = {
      name: username
    };

    this.userService.loginTemp(user).subscribe(
      data => {
        localStorage.setItem('profileId', data.id);
      },
      err => {
        console.error('Observer got an error: ' + err);
      }
    );
  };

  constructor(private userService: UserService) {}

  ngOnInit() {}
}
