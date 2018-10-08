import { PostsService } from './../posts.service';
import { Posts } from './../models/posts';
import { Component, OnInit } from '@angular/core';

@Component({
  selector: 'app-posts',
  templateUrl: './posts.component.html',
  styleUrls: ['./posts.component.css']
})
export class PostsComponent implements OnInit {

  selected: Posts = null;
  newPost: Posts = new Posts();
  posts: Posts[] = [];

  displayTable = function () {
    this.selected = null;
  };

  editPost = function (post: Posts) {
    this.PostsService.update(post).subscribe(
      data => {
        this.selected = data;
      });
  };

  deletePost = function (id: number) {
    this.PostsService.destroy(id).subscribe(
      data => {
        this.reload();
      });
  };

  displayPost = function (post: Posts) {
    this.selected = post;
  };

  addPost = function () {
    this.PostsService.create(this.newPost).subscribe(
      data => {
        this.newPost = new Posts();
        this.reload();
      });
  };

  reload = function () {
    this.PostsService.index()
      .subscribe(
        data => { this.posts = data; }
      );
  };

  constructor() { }

  ngOnInit() {
  }

}
