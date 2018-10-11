import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { catchError } from 'rxjs/operators';
import { throwError, Observable } from 'rxjs';
import { Trip } from './models/trip';

@Injectable({
  providedIn: 'root'
})
export class TripService {
  private baseUrl = 'http://localhost:8080/';
  private url = this.baseUrl + 'api/trips';

  // TEST METHOD /////

  public tripIndexByProfileId(pid): Observable<Trip[]> {
    return this.http
      .get<Trip[]>(`${this.baseUrl}api/profile/${pid}/trips`)
      .pipe(
        catchError((err: any) => {
          console.log(err);
          return throwError(
            'Error retrieving Trips By Profile Id: ' + ' Status: ' + err.status
          );
        })
      );
  }

  // \\\\\ TEST METHOD

  public index(id): Observable<Trip[]> {
    return this.http.get<Trip[]>(this.url + '/' + id).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError('Error retrieving Trip: ' + ' Status: ' + err.status);
      })
    );
  }

  public create(trip: Trip) {
    return this.http.post<any>(this.url, trip).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError('Error retrieving data ');
      })
    );
  }

  public destroy(id: number) {
    return this.http.delete(this.url + '/' + id).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError('Error retrieving data ' + err.status);
      })
    );
  }

  public update(updateTrip: Trip, id: number) {
    console.log(this.url + '/' + id);
    return this.http.patch(this.url + '/' + id, updateTrip).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError('Error saving updated Trip: ' + err.status);
      })
    );
  }

  constructor(private http: HttpClient) {}
}
