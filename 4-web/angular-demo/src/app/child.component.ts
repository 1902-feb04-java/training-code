import { Component, Input } from '@angular/core';

@Component({
  selector: 'app-child',
  template: `
    <div>
      Hi, I'm an embedded child component with a childObject variable annotated with @Input().
      {{ childObject.message }}
    </div>
  `,
  styles: [`
    div {
      border: 1px solid black
    }
  `]
})
export class ChildComponent {

  @Input() childObject;

}
