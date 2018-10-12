import { Injectable } from '@angular/core';
import { UpdateProfile } from './models/update-profile';
import { catchError } from 'rxjs/operators';
import { throwError, Observable } from 'rxjs';
import { HttpClient } from '@angular/common/http';
import { User } from './models/user';

@Injectable({
  providedIn: 'root'
})
export class FeedService {
  private baseUrl = 'http://localhost:8080/';
  private url = this.baseUrl + 'api/feed';

  public search(keyword: string): Observable<User[]> {
    console.log(keyword);

    return this.http.get<User[]>(this.baseUrl + 'search/' + keyword).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError('Error retrieving data ' + err.status);
      })
    );
  }

  constructor(private http: HttpClient) { }
}
