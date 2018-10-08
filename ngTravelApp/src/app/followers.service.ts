import { Injectable } from '@angular/core';
import { Observable, throwError } from 'rxjs';
import { Profile } from './models/profile';
import { HttpClient } from '@angular/common/http';
import { catchError } from 'rxjs/operators';

@Injectable({
  providedIn: 'root'
})
export class FollowersService {
  private baseUrl = 'http://localhost:8080/';
  private url = this.baseUrl + 'api/profiles';

  public index(): Observable<Profile[]> {
    return this.http.get<Profile[]>(this.url).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError('Error retrieving Followers List: ' + ' Status: ' + err.status);
      })
    );
  }

  public show(id: number): Observable<Profile> {
    return this.http.get<Profile>('${this.url/:id}')
      .pipe(
        catchError((err: any) => {
          console.log(err);
          return throwError('Error retrieving To do List: ' + ' Status: ' + err.status);
        })
      );
  }

  constructor(private http: HttpClient) {}
}
