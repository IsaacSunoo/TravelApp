import { Injectable } from '@angular/core';
import { Observable, throwError } from 'rxjs';
import { Profile } from './models/profile';
import { HttpClient } from '@angular/common/http';
import { catchError } from 'rxjs/operators';
import { User } from './models/user';
import { UpdateProfile } from './models/update-profile';

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

  public discover(id: string): Observable<User[]> {
    return this.http.get<User[]>(this.baseUrl + 'discover/' + id).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError('Error retrieving data ' + err.status);
      })
    );
  }

  public search(keyword: string): Observable<UpdateProfile[]> {
    return this.http.get<UpdateProfile[]>(this.baseUrl + 'search/' + keyword).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError('Error retrieving data ' + err.status);
      })
    );
  }

  constructor(private http: HttpClient) {}
}
