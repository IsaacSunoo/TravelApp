import { Component, OnInit } from '@angular/core';
import { PostDTO } from '../models/post-dto';
import { ActivatedRoute, Router } from '@angular/router';
import { PostsService } from '../posts.service';

@Component({
  selector: 'app-feed',
  templateUrl: './feed.component.html',
  styleUrls: ['./feed.component.css']
})
export class FeedComponent implements OnInit {
  haveReturnedPost: Boolean = false;
  newPost: PostDTO = new PostDTO();

  addTripPost = function() {
    this.postServ.createNewTrip(this.newPost, this.id).subscribe(data => {
      this.returnedPost = data;
      console.log(this.returnedPost);
      this.haveReturnedPost = true;
      this.reload();
    });
  };

  constructor(
    private activatedRoute: ActivatedRoute,
    private router: Router,
    private postServ: PostsService
  ) {}

  ngOnInit() {}
}
