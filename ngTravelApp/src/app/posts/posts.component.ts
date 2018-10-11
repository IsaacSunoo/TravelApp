import { StepperToPostsShellService } from './../stepper-to-posts-shell.service';
import { LogoutComponent } from './../logout/logout.component';
import { PostsService } from './../posts.service';
import { Posts } from './../models/posts';
import { Component, OnInit } from '@angular/core';
import { Router, ActivatedRoute } from '@angular/router';
import { PostDTO } from '../models/post-dto';
import { Profile } from '../models/profile';
import { UserService } from '../user.service';
import { ProfileService } from '../profile.service';

@Component({
  selector: 'app-posts',
  templateUrl: './posts.component.html',
  styleUrls: ['./posts.component.css']
})
export class PostsComponent implements OnInit {
  selected: Posts = null;
  newPost: PostDTO = new PostDTO();
  allPosts: Posts[] = [];
  testDate: Date;
  id = localStorage.getItem('profileId');
  returnedPost: Posts = new Posts();
  trips: PostDTO[] = [];
  haveReturnedPost: Boolean = false;
  testPost = null;
  profileFromStorage = new Profile();

  // //////////// TEST METHOD
  getProfileFromStorage = function() {
    this.profileService.show(this.id).subscribe(
      data => {
        this.profileFromStorage = data;
        this.haveReturnedPost = true;
        console.log(this.profileFromStorage);
      },
      err => {
        this.handleError(err);
      }
    );
  };
  // \\\\\\\\\\\\ TEST METHOD

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
    this.postServ.index().subscribe(
      data => {
        this.allPosts = data;
        console.log(this.allPosts);
      },
      err => {
        this.handleError(err);
      }
    );
  };

  // //////////// TEST METHOD
  reloadForOneProfile = function() {
    this.postServ.indexForOneProfile(this.id).subscribe(
      data => {
        this.allPosts = data;
        this.allPosts.forEach(post => {
          post.createDate = new Date(post.createDate);
        });
        // this.STPSS.allPosts = this.allPosts;
        this.STPSS.setPosts(this.allPosts);
        this.allPosts.reverse();
        console.log(this.allPosts);
      },
      err => {
        this.handleError(err);
      }
    );
  };
  // \\\\\\\\\\\\ TEST METHOD

  loadUserInfo = function(id: string) {
    this.postServ.show(id).subscribe(data => {
      this.showProfile = data;
      console.log(this.showProfile);
    });
  };

  // //////////// TEST METHOD
  loadTestUserInfo = function() {
    this.postServ.show(this.id).subscribe(data => {
      this.testPost = data;
      this.testDate = new Date(this.testPost.createDate);
      console.log(this.testPost);
      this.haveReturnedPost = true;
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

  handleError(error: any) {
    console.error('Something Broke');
    console.log(error);
  }

  constructor(
    private activatedRoute: ActivatedRoute,
    private router: Router,
    private postServ: PostsService,
    private profileService: ProfileService,
    private STPSS: StepperToPostsShellService
  ) {}

  ngOnInit() {
    // We probably don't need this code on line 108, but just in case
    // const id = localStorage.getItem('profileId');
    // this.reload();
    // Test case
    // this.loadTestUserInfo();
    // Test case
    this.reloadForOneProfile();
    this.getProfileFromStorage();
  }
}
