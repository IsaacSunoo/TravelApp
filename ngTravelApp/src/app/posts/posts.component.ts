import { LogoutComponent } from './../logout/logout.component';
import { PostsService } from './../posts.service';
import { Posts } from './../models/posts';
import { Component, OnInit } from '@angular/core';
import { Router, ActivatedRoute } from '@angular/router';
import { PostDTO } from '../models/post-dto';
import { Profile } from '../models/profile';

@Component({
  selector: 'app-posts',
  templateUrl: './posts.component.html',
  styleUrls: ['./posts.component.css']
})
export class PostsComponent implements OnInit {
  // might need a field for a plain vanilla post later

  selected: Posts = null;
  newPost: PostDTO = new PostDTO();
  posts: Posts[] = [];
  testDate: Date;

  id = localStorage.getItem('profileId');
  returnedPost: Posts = new Posts();
  // returnedPost = null;
  trips: PostDTO[] = [];

  haveReturnedPost: Boolean = false;

  testProfile = null;

  displayTable = function() {
    this.selected = null;
  };

  editPost = function(post: Posts) {
    this.postServ.update(post).subscribe(data => {
      this.selected = data;
    });
  };

  deletePost = function(id: number) {
    this.postServ.destroy(id).subscribe(data => {
      this.reload();
    });
  };

  displayPost = function(post: Posts) {
    this.selected = post;
  };

  addPost = function(id: string) {
    console.log(this.newPost);

    this.postServ.create(this.newPost).subscribe(data => {
      this.newPost = new Posts();
      this.newPost.tripId = 1;
      this.newPost.profileId = this.id;

      this.reload();
    });
  };

  addTripPost = function() {
    this.postServ.createNewTrip(this.newPost, this.id).subscribe(data => {
      this.returnedPost = data;
      this.testDate = new Date(this.returnedPost.createDate);
      console.log(this.returnedPost);
      this.haveReturnedPost = true;
    });
  };

  reload = function() {
    this.postServ.index().subscribe(data => {
      this.posts = data;
    });
  };

  loadUserInfo = function(id: string) {
    this.postServ.show(id).subscribe(data => {
      this.showProfile = data;
      console.log(this.showProfile);
    });
  };

  // //////////// TEST METHOD
  loadTestUserInfo = function() {
    this.postServ.show(this.id).subscribe(data => {
      this.testProfile = data;
      console.log(this.testProfile);
    });
  };
  // \\\\\\\\\\\\ TEST METHOD

  // loadTrips = function(id) {
  //   this.postService.indexDTO(id).subscribe(
  //     data => {
  //     this.trips = data;
  //     console.log(this.trips);

  //   });
  // };

  constructor(
    private activatedRoute: ActivatedRoute,
    private router: Router,
    private postServ: PostsService
  ) {}

  ngOnInit() {
    // const id = localStorage.getItem('profileId');
    // this.reload();
    this.loadTestUserInfo();
  }
}
