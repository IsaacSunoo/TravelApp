import { Injectable } from '@angular/core';
import { Observable, throwError } from 'rxjs';
import { UpdateProfile } from './models/update-profile';
import { HttpClient } from '@angular/common/http';
import { catchError } from 'rxjs/operators';

@Injectable({
  providedIn: 'root'
})
export class ProfileService {

  private baseUrl = 'http://localhost:8080/';
  private url = this.baseUrl + 'api/profiles';

  public show(id: string): Observable<UpdateProfile> {
    return this.http.get<UpdateProfile>(this.url + '/' + id).pipe(
      catchError((err: any) => {
        console.log(err);
        console.log('Error in service');

        return throwError('Error retrieving Profile: ' + ' Status: ' + err.status);
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
  // unfollow a user that you are following
    public unfollowUser(id: number, fid: number) {
      return this.http.delete(this.baseUrl + 'removefollower/' + id + '/' + fid, {}).pipe(
        catchError((err: any) => {
          console.log(err);
          return throwError('Error retrieving data ' + err.status);
        })
      );
    }

  constructor(private http: HttpClient) {}
}
