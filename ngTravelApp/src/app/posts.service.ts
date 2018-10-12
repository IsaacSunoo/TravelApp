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
  // *******************************************************************************
  // FIELDS

  private baseUrl = 'http://localhost:8080/';
  private url = this.baseUrl + 'api/posts';

  // *******************************************************************************
  // METHODS

  public index(): Observable<Posts[]> {
    return this.http.get<Posts[]>(this.url).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError(
          'Error retrieving list of posts... Status: ' + err.status
        );
      })
    );
  }

  // //////////// TEST METHOD
  public indexForOneProfile(id): Observable<Posts[]> {
    return this.http
      .get<Posts[]>(this.baseUrl + 'api/' + 'profile/' + id + '/posts')
      .pipe(
        catchError((err: any) => {
          console.log(err);
          return throwError(
            'Error retrieving list of posts... Status: ' + err.status
          );
        })
      );
  }
  // \\\\\\\\\\\\ TEST METHOD

  // public indexDTO(id): Observable<PostDTO[]> {
  //   return this.http.get<PostDTO[]>(this.url)
  //     .pipe(
  //       catchError((err: any) => {
  //         console.log(err);
  //         return throwError('Error retrieving Trip: ' + ' Status: ' + err.status);
  //       })
  //     );
  // }

  public show(id): Observable<Posts> {
    return this.http.get<Posts>(this.url + '/' + id).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError(
          'Error retrieving post by Id... Status: ' + err.status
        );
      })
    );
  }

  public create(post: Posts) {
    const httpOptions = {
      headers: new HttpHeaders({
        'Content-Type': 'application/json'
      })
    };

    return this.http.post(this.url, post, httpOptions).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError('Error saving post... Status: ' + err.status);
      })
    );
  }

  public createNewTrip(postDTO: PostDTO, profileId) {
    const httpOptions = {
      headers: new HttpHeaders({
        'Content-Type': 'application/json'
      })
    };
    console.log(postDTO);

    return this.http
      .post(
        this.baseUrl + 'api/profile' + '/' + profileId + '/' + 'posts',
        postDTO,
        httpOptions
      )
      .pipe(
        catchError((err: any) => {
          console.log(err);
          return throwError('Error saving post... Status: ' + err.status);
        })
      );
  }

  public update(post: Posts) {
    return this.http.put(this.url + '/' + post.id, post).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError('Error updating Post... Status: ' + err.status);
      })
    );
  }

  public destroy(id: number) {
    return this.http.delete(this.url + '/' + id).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError('Error deleting Post... Status: ' + err.status);
      })
    );
  }

  // 5:59PM TEST METHOD /////



  // \\\\\ TEST METHOD

  // *******************************************************************************
  // HELPERS

  constructor(private http: HttpClient) {}
}
