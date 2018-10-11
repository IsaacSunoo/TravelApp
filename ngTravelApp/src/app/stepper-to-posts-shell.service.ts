import { Injectable } from '@angular/core';
import { Posts } from './models/posts';

@Injectable({
  providedIn: 'root'
})
export class StepperToPostsShellService {
  // *******************************************************************************
  // FIELDS
  allPosts: Posts[] = [];

  // *******************************************************************************
  // METHODS

  // This grabs the post from the stepper component method
  addPostToAllPosts = function(postData: Posts) {
    this.allPosts.unshift(postData);
  };

  // This is called in the posts component and passes the filled array
  // from posts component to the shared posts array service field
  setPosts = function(postsArray) {
    this.allPosts = postsArray;
  };

  // *******************************************************************************
  // HELPERS

  constructor() {}
}
