import { PostsService } from './../posts.service';
import { Posts } from './../models/posts';
import { Component, OnInit } from '@angular/core';
import { Router, ActivatedRoute } from '@angular/router';
import { PostDTO } from '../models/post-dto';

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
  id = localStorage.getItem('profileId');

  newTripPost: Posts = new Posts();

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

  addPost = function (id: string) {
    console.log(this.newPost);

    this.postServ.create(this.newPost).subscribe(data => {
      this.newPost = new Posts();
      this.newPost.tripId = 1;
      this.newPost.profileId = this.id;

      this.reload();
    });
  };

  addTripPost = function (newPost) {
    const id = localStorage.getItem('profileId');

    this.postServ.createNewTrip(this.newPost, id).subscribe(data => {
      this.newPost = data;
      this.reload();
    });
  };

  reload = function() {
    this.postServ.index().subscribe(data => {
      this.posts = data;
    });
  };


  loadUserInfo = function (id: string) {
    this.postServ.show(id).subscribe(
      data => {
        this.showProfile = data;
        console.log(this.showProfile);

      });
  };

  constructor(
    private activatedRoute: ActivatedRoute,
    private router: Router,
    private postServ: PostsService
  ) {}

  ngOnInit() {

  }
}
