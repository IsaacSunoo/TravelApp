import { catchError } from 'rxjs/operators';
import { Injectable } from '@angular/core';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { throwError, Observable } from 'rxjs';
import { Posts } from './models/posts';
import { PostDTO } from './models/post-dto';

@Injectable({
  providedIn: 'root'
})
export class PostsService {

  private baseUrl = 'http://localhost:8080/';
  private url = this.baseUrl + 'api/posts';

  public index(): Observable<Posts[]> {
    return this.http.get<Posts[]>(this.url)
      .pipe(
        catchError((err: any) => {
          console.log(err);
          return throwError('Error retireving list of posts... Status: ' + err.status);
        })
      );
  }

  public show(id: number): Observable<Posts> {
    return this.http.get<Posts>('${this.url/:id')
      .pipe(
        catchError((err: any) => {
          console.log(err);
          return throwError('Error retrieving post by Id... Status: ' + err.status);
        }));
  }

  public create(post: Posts) {
    const httpOptions = {
      headers: new HttpHeaders({
        'Content-Type': 'application/json',
      })
    };

    return this.http.post(this.url, post, httpOptions)
      .pipe(
        catchError((err: any) => {
          console.log(err);
          return throwError('Error saving post... Status: ' + err.status);

        }));
  }

  public createNewTrip(postDTO: PostDTO, profileId) {
    const httpOptions = {
      headers: new HttpHeaders({
        'Content-Type': 'application/json',
      })
    };

    return this.http.post(this.baseUrl + 'profile' + '/' + profileId + '/' + 'posts', postDTO, httpOptions)
      .pipe(
        catchError((err: any) => {
          console.log(err);
          return throwError('Error saving post... Status: ' + err.status);

        }));
  }


  public update(post: Posts) {
    return this.http.put(this.url + '/' + post.id, post)
      .pipe(
        catchError((err: any) => {
          console.log(err);
          return throwError('Error updating Post... Status: ' + err.status);

        }));
  }

  public destroy(id: number) {
    return this.http.delete(this.url + '/' + id)
      .pipe(
        catchError((err: any) => {
          console.log(err);
          return throwError('Error deleting Post... Status: ' + err.status);
        }));
  }

  constructor(private http: HttpClient) {}
}
