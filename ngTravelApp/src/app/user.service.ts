import { environment } from './../environments/environment';
import { Injectable } from '@angular/core';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Observable, throwError } from 'rxjs';
import { User } from './models/user';
import { tap, catchError } from 'rxjs/operators';

@Injectable({
  providedIn: 'root'
})
export class UserService {
  baseUrl = environment.baseUrl;
  fullUrl = (this.baseUrl + '/authenticate');

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
  }

  checkLogin() {
    if (localStorage.getItem('token')) {
      return true;
    }
    return false;
  }

  register(user) {
    // create request to register a new account
    return this.http.post(this.baseUrl + 'register', user)
      .pipe(
        tap((res) => {  // create a user and then upon success, log them in
          this.login(user.username, user.password);
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

  constructor(private http: HttpClient) { }

}
