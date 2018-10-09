import { environment } from './../environments/environment';
import { Injectable } from '@angular/core';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Observable, throwError } from 'rxjs';
import { User } from './models/user';
import { tap, catchError } from 'rxjs/operators';
import { Profile } from './models/profile';

@Injectable({
  providedIn: 'root'
})
export class UserService {
  private baseUrl = environment.baseUrl;
  private fullUrl = this.baseUrl + '/authenticate';

  login(username, password) {
    // Make token
    const token = this.generateBasicAuthToken(username, password);
    // Send token as Authorization header (this is spring security convention for basic auth)
    const headers = new HttpHeaders().set('Authorization', `Basic ${token}`);
    console.log(token);

    // create request to authenticate credentials
    return this.http.get(this.fullUrl, { headers }).pipe(
      tap(res => {
        localStorage.setItem('token', token);
        // this.loginTemp(username).subscribe(
        //   data => {
        //     console.log(data);
        //     localStorage.setItem('profileId', data.id);
        //   },
        //   err => {
        //     console.error('Observer got an error: ' + err);
        //   }
        // );
        return res;
      }),
      catchError((err: any) => {
        console.log(err);
        return throwError('Error generating basic Auth token');
      })
    );
  }

  logout() {
    localStorage.removeItem('token');
    localStorage.removeItem('profileId');
  }

  checkLogin() {
    if (localStorage.getItem('token')) {
      return true;
    }
    return false;
  }

  register(user) {
    // create request to register a new account
    return this.http.post(this.baseUrl + 'register', user).pipe(
      tap(res => {
        // create a user and then upon success, log them in
        // this.login(user.username, user.password);

        // TEMPORARY LOGIN BELOW
        // this.loginTemp(user).subscribe(
        //   data => {
        //     localStorage.setItem('profileId', data.id);
        //   },
        //   err => {
        //     console.error('Observer got an error: ' + err);
        //   }
        // );
        // END TEMP LOGIN CODE
      }),
      catchError((err: any) => {
        console.log(err);
        return throwError('Error registering User');
      })
    );
  }

  generateBasicAuthToken(username, password) {
    return btoa(`${username}:${password}`);
  }

  getToken() {
    return localStorage.getItem('token');
  }

  activate(user: User) {
    user.active = true;
  }

  deactivate(user: User) {
    user.active = false;
  }

  // TEMP TESTING FOR LOGIN
  loginTemp(username) {
    return this.http.post(this.baseUrl + 'login', username).pipe(
      tap(res => {
        return res;
      }),
      catchError((err: any) => {
        console.log(err);
        return throwError('Error with temporary login');
      })
    );
  }

  constructor(private http: HttpClient) {}
}
