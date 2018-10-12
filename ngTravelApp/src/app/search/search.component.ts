import { Component, OnInit } from '@angular/core';
import { User } from '../models/user';
import { FeedService } from '../feed.service';
import { ActivatedRoute } from '@angular/router';

@Component({
  selector: 'app-search',
  templateUrl: './search.component.html',
  styleUrls: ['./search.component.css']
})
export class SearchComponent implements OnInit {

  users: User [] = [];
  keyword;

  searchForUsers = function() {
    this.feedServ.search(this.keyword).subscribe(
      data => {
        this.users = data;
      },
      err => {
        console.log('error');
      }
    );
  };

  constructor(private feedServ: FeedService, private activatedRoute: ActivatedRoute) { }

  ngOnInit() {
    this.keyword = this.activatedRoute.snapshot.paramMap.get('keyword');
    this.searchForUsers();
  }

}