import { Injectable } from '@angular/core';
import { Observable, throwError } from 'rxjs';
import { UpdateProfile } from './models/update-profile';
import { catchError } from 'rxjs/operators';
import { HttpClient } from '@angular/common/http';

@Injectable({
  providedIn: 'root'
})
export class TripDetailsService {
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

  constructor(private http: HttpClient) { }
}
