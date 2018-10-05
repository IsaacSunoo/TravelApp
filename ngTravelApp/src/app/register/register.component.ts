import { Component, OnInit } from '@angular/core';
import { UserService } from '../user.service';
import { ActivatedRoute } from '@angular/router';
import { NgForm } from '@angular/forms';
import { User } from '../models/user';

@Component({
  selector: 'app-register',
  templateUrl: './register.component.html',
  styleUrls: ['./register.component.css']
})
export class RegisterComponent implements OnInit {
  user: User = new User();
  registerUser = function(form: NgForm) {
    const user = form.value;
    console.log(user);

    this.userService.register(user).subscribe(
      data => {
        console.log('returned data: ');
        console.log(data);
        // this.router.navigateByUrl('trips');
      },
      err => {
        // this.router.navigateByUrl('register');
      }
    );
  };

  constructor(private userService: UserService, private router: ActivatedRoute) { }

  ngOnInit() {
  }

}
