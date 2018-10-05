import { catchError, tap } from 'rxjs/operators';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { throwError } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class AuthService {
  login(username, password) {
    // Make token
    const token = this.generateBasicAuthToken(username, password);
    // Send token as Authorization header (this is spring security convention for basic auth)
    const headers = new HttpHeaders().set('Authorization', `Basic ${token}`);
    console.log(token);

    // create request to authenticate credentials
    return this.http.get('http://localhost:8080/authenticate', { headers }).pipe(
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
    return this.http.post('http://localhost:8080/register', user).pipe(
      tap(res => {
        // create a user and then upon success, log them in
        this.login(user.username, user.password);
      }),
      catchError((err: any) => {
        console.log(err);
        return throwError('KABOOM');
      })
    );
  }

  generateBasicAuthToken(username, password) {
    return btoa(`${username}:${password}`);
  }

  getToken() {
    return localStorage.getItem('token');
  }

  constructor(private http: HttpClient) {}
}
