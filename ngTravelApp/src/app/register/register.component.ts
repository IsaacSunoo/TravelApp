import { Registration } from './../models/registration';
import { Component, OnInit } from '@angular/core';
import { UserService } from '../user.service';
import { ActivatedRoute, Router } from '@angular/router';
import { NgForm } from '@angular/forms';

@Component({
  selector: 'app-register',
  templateUrl: './register.component.html',
  styleUrls: ['./register.component.css']
})
export class RegisterComponent implements OnInit {
  register: Registration = new Registration();

  registerUser = function(form: NgForm) {
    const register = form.value;
    console.log(register);

    this.userService.register(register).subscribe(
      data => {
        console.log('returned data: ');
        console.log(data);
         this.router.navigateByUrl('feed');
      },
      err => {
         this.router.navigateByUrl('register');
      }
    );
  };

  constructor(private userService: UserService, private activateRoute: ActivatedRoute, private router: Router) { }

  ngOnInit() {
  }

}
