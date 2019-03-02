import { Component, OnInit } from '@angular/core';
import { Observable } from 'rxjs';
import { HttpService } from './http.service';

@Component({
  selector: 'app-http',
  template: `
    <h2>Http & Observables</h2>
    <p>
      Import HttpClientModule and create a service which uses HttpClient to make a request to a RESTful API.
      The below example calls on http://jsonplaceholder.typicode.com/posts through a custom HttpService which is injected through the constructor.
      The *ngFor directive then populates a list, making use of the async pipe to wait for the service to fetch the Observable from the API.
    </p>
    <p *ngFor="let post of posts | async">
        {{post.id}}. {{post.title}}
    </p>
  `,
  styles: []
})
export class HttpComponent implements OnInit {

  posts: Observable<any>;

  constructor(private httpService: HttpService) { }

  ngOnInit() {
    this.posts = this.httpService.getPosts();
  }

}
