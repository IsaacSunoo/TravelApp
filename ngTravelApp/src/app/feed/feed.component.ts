import { Component, OnInit } from '@angular/core';
import { PostDTO } from '../models/post-dto';
import { ActivatedRoute, Router } from '@angular/router';
import { PostsService } from '../posts.service';
import { UserService } from '../user.service';
import { UpdateProfile } from '../models/update-profile';
import { User } from '../models/user';
import { FeedService } from '../feed.service';

@Component({
  selector: 'app-feed',
  templateUrl: './feed.component.html',
  styleUrls: ['./feed.component.css']
})
export class FeedComponent implements OnInit {
  haveReturnedPost: Boolean = false;
  newPost: PostDTO = new PostDTO();
  keyword;
  users: User [] = [];
  id = localStorage.getItem('profileId');

  logout = function() {
    this.userServ.logout();
    this.router.navigateByUrl('home');
  };

  addTripPost = function() {
    this.postServ.createNewTrip(this.newPost, this.id).subscribe(data => {
      this.returnedPost = data;
      console.log(this.returnedPost);
      this.haveReturnedPost = true;
      this.reload();
    });
  };

  // searchForUsers = function() {
  //   this.feedServ.search(this.keyword).subscribe(
  //     data => {
  //       this.router.navigateByUrl('search');
  //       this.users = data;
  //     },
  //     err => {
  //       console.log('error');
  //     }
  //   );
  // };

  constructor(
    private activatedRoute: ActivatedRoute,
    private router: Router,
    private postServ: PostsService,
    private userServ: UserService,
    private feedServ: FeedService
  ) {}

  ngOnInit() {
    this.keyword = this.activatedRoute.snapshot.paramMap.get('keyword');
  }
}
