import { UpdateProfile } from './models/update-profile';
import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { catchError } from 'rxjs/operators';
import { throwError, Observable } from 'rxjs';
import { User } from './models/user';

@Injectable({
  providedIn: 'root'
})
export class SettingService {

  private baseUrl = 'http://localhost:8080/';
  private url = this.baseUrl + 'api/profiles';

  public index(): Observable<UpdateProfile[]> {
    return this.http.get<UpdateProfile[]>(this.url)
      .pipe(
        catchError((err: any) => {
          console.log(err);
          return throwError('Error retrieving Profile: ' + ' Status: ' + err.status);
        })
      );
  }

  public show(id: string): Observable<UpdateProfile> {
    return this.http.get<UpdateProfile>('${this.url/:id}')
      .pipe(
      catchError((err: any) => {
        console.log(err);
        console.log('Error in service');

          return throwError('Error retrieving Profile: ' + ' Status: ' + err.status);
        })
      );
  }

  public update(updateProf: UpdateProfile, id: number) {
    return this.http.patch(this.url + '/' + id, updateProf).
      pipe(
        catchError((err: any) => {
          console.log(err);
          return throwError('Error saving updated Profile: Status: ' + err.status);
        }));
  }

  public deactivate(user: User, id: number) {
    if (id) {
      user.active = false;
    }
  }

  constructor(private http: HttpClient) {}
}
