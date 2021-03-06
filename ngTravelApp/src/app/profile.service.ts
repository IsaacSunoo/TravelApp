import { Injectable } from '@angular/core';
import { Observable, throwError } from 'rxjs';
import { UpdateProfile } from './models/update-profile';
import { HttpClient } from '@angular/common/http';
import { catchError } from 'rxjs/operators';
import { User } from './models/user';
import { Trip } from './models/trip';
import { environment } from '../environments/environment';

@Injectable({
  providedIn: 'root'
})
export class ProfileService {
  private baseUrl = environment.baseUrl;
  private url = this.baseUrl + 'api/profiles';

  public show(id: string): Observable<UpdateProfile> {
    return this.http.get<UpdateProfile>(this.url + '/' + id).pipe(
      catchError((err: any) => {
        console.log(err);
        console.log('Error in service');

        return throwError(
          'Error retrieving Profile: ' + ' Status: ' + err.status
        );
      })
    );
  }

  // following a user is adding a follower to followed person's followers
  public followUser(id: string, testId: string) {
    return this.http
      .post<any>(this.baseUrl + 'addfollower/' + id + '/' + testId, {})
      .pipe(
        catchError((err: any) => {
          console.log(err);
          return throwError('Error retrieving data ');
        })
      );
  }
  // unfollow a user that you are following
  public unfollowUser(id: string, testId: string) {
    return this.http
      .delete(this.baseUrl + 'removefollower/' + id + '/' + testId)
      .pipe(
        catchError((err: any) => {
          console.log(err);
          return throwError('Error retrieving data ' + err.status);
        })
      );
  }

  public followingIndex(id: string): Observable<User[]> {
    return this.http.get<User[]>(this.baseUrl + 'findfollowers/' + id).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError('Error retrieving data ' + err.status);
      })
    );
  }

  public getFavoriteTripsByProfileId(id: string): Observable<Trip[]> {
    return this.http.get<Trip[]>(`${this.url}/${id}/favoriteTrips`).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError('Error retrieving data ' + err.status);
      })
    );
  }

  public bookmarkTrip(pid, tid) {
    return this.http
      .post(`${this.baseUrl}api/profiles/${pid}/favoriteTrips/${tid}`, {})
      .pipe(
        catchError((err: any) => {
          console.log(err);
          return throwError('Error retrieving data ' + err.status);
        })
      );
  }

  public removeTripBookmark(pid, tid) {
    return this.http
      .delete(`${this.baseUrl}api/profiles/${pid}/favoriteTrips/${tid}`)
      .pipe(
        catchError((err: any) => {
          console.log(err);
          return throwError('Error retrieving data ' + err.status);
        })
      );
  }

  constructor(private http: HttpClient) {}
}
