import { Component } from '@angular/core';

@Component({
  selector: 'app-root',
  template: `
    <ul>
      <li>{{title}}</li>
      <li><a routerLink="/binding">Binding</a></li>
      <li><a routerLink="/pipe">Pipe</a></li>
      <li><a routerLink="/http">HTTP</a></li>
    </ul>
    <router-outlet></router-outlet>
  `,
  styles: [`
  ul {
    list-style-type: none;
    margin: 0;
    padding: 0;
    overflow: hidden;
    top: 0;
    width: 100%;
  }

  li {
    display: inline;
  }

  li a {
    text-align: center;
    padding: 14px 16px;
    text-decoration: none;
  }
`]
})
export class AppComponent {
  
  title = 'Angular Demo';

}
