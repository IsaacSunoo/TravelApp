import { Profile } from './../models/profile';
import { Component, OnInit } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable, throwError } from 'rxjs';
import { catchError } from 'rxjs/operators';

@Component({
  selector: 'app-following',
  templateUrl: './following.component.html',
  styleUrls: ['./following.component.css']
})
export class FollowingComponent implements OnInit {

  private baseUrl = 'http://localhost:8080/';
  private url = this.baseUrl + 'api/following';

  public index(): Observable<Profile[]> {
    return this.http.get<Profile[]>(this.url)
      .pipe(
        catchError((err: any) => {
          console.log(err);
          return throwError('Error retrieving Following List: ' + ' Status: ' + err.status);
        })
      );
  }

  public show(id: number): Observable<Profile> {
    return this.http.get<Profile>('${this.url/:id}')
      .pipe(
        catchError((err: any) => {
          console.log(err);
          return throwError('Error retrieving Following individual: ' + ' Status: ' + err.status);
        })
      );
  }



  constructor(private http: HttpClient) {}

  ngOnInit() {}
}
