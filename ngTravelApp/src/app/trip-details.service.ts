import { Injectable } from '@angular/core';
import { Observable, throwError } from 'rxjs';
import { UpdateProfile } from './models/update-profile';
import { catchError } from 'rxjs/operators';
import { HttpClient } from '@angular/common/http';
import { Posts } from './models/posts';
import { Trip } from './models/trip';
import { environment } from '../environments/environment';

@Injectable({
  providedIn: 'root'
})
export class TripDetailsService {
  // *******************************************************************************
  // FIELDS

  private baseUrl = environment.baseUrl;
  private url = this.baseUrl + 'api/profiles';
  private postUrl = this.baseUrl + 'api/posts';
  private tripUrl = this.baseUrl + 'api/trips';

  // *******************************************************************************
  // METHODS

  // This is getting one trip by its trip id from the database
  public showTrip(id: string): Observable<Trip> {
    return this.http.get<Trip>(this.tripUrl + '/' + id).pipe(
      catchError((err: any) => {
        console.log(err);
        console.log('Error in service');

        return throwError('Error retrieving Trip: ' + ' Status: ' + err.status);
      })
    );
  }

  public showProfile(id: string): Observable<UpdateProfile> {
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

  // Richard: Note -- This seems to be grabbing a post based on the url, naming
  // is a little confusing.
  public showTripDetails(id: string): Observable<UpdateProfile> {
    return this.http.get<UpdateProfile>(this.postUrl + '/' + id).pipe(
      catchError((err: any) => {
        console.log(err);
        console.log('Error in service');

        return throwError('Error retrieving Post: ' + ' Status: ' + err.status);
      })
    );
  }

  public index(id): Observable<Posts[]> {
    return this.http.get<Posts[]>(this.postUrl + '/' + id).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError('Error retrieving Trip: ' + ' Status: ' + err.status);
      })
    );
  }

  // *******************************************************************************
  // HELPERS

  constructor(private http: HttpClient) {}
}
