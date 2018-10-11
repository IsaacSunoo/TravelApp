import { StepperToPostsShellService } from './../stepper-to-posts-shell.service';
import { Component, OnInit } from '@angular/core';
import { PostDTO } from '../models/post-dto';
import { ActivatedRoute, Router } from '@angular/router';
import { PostsService } from '../posts.service';

@Component({
  selector: 'app-stepper',
  templateUrl: './stepper.component.html',
  styleUrls: ['./stepper.component.css']
})
export class StepperComponent implements OnInit {
  newPost: PostDTO = new PostDTO();
  haveReturnedPost: Boolean = false;
  id = localStorage.getItem('profileId');

  addTripPost = function() {
    this.postServ.createNewTrip(this.newPost, this.id).subscribe(data => {
      this.returnedPost = data;
      console.log(this.returnedPost);
      this.haveReturnedPost = true;

      // Call the shell service method, passing the returned post to it
      this.STPSS.addPostToAllPosts(data);
    });
  };

  constructor(
    private activatedRoute: ActivatedRoute,
    private router: Router,
    private postServ: PostsService,
    private STPSS: StepperToPostsShellService
  ) {}

  ngOnInit() {}
}
