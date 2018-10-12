import { Injectable } from '@angular/core';
import { Observable, throwError } from 'rxjs';
import { catchError } from 'rxjs/operators';
import { Profile } from 'selenium-webdriver/firefox';
import { HttpClient } from '@angular/common/http';
import { environment } from '../environments/environment';

@Injectable({
  providedIn: 'root'
})
export class FollowingService {

  private baseUrl = environment.baseUrl;
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
  // following a user is adding a follower to followed person's followers
  public followUser(id: number, fid: number) {
  return this.http.post<any>(this.baseUrl + 'addfollower/' + id + '/' + fid, {}).pipe(
    catchError((err: any) => {
      console.log(err);
      return throwError('Error retrieving data ');
    })
  );
  }

  constructor(private http: HttpClient) { }
}

