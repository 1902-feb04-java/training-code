import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { map } from 'rxjs/operators';

@Injectable({
  providedIn: 'root'
})
export class HttpService {

  constructor(private httpClient: HttpClient) { }

  getPosts(): Observable<any> {
    return this.httpClient.get('http://jsonplaceholder.typicode.com/posts').pipe(
      map(res => res)
    );
  }

  getPostById(id: number): Observable<any> {
    return this.httpClient.get('http://jsonplaceholder.typicode.com/posts/' + id).pipe(
      map(res => res)
    );
  }
}
