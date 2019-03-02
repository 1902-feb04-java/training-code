import { Component } from '@angular/core';

@Component({
  selector: 'app-binding',
  template: `
    <h2>Interpolation</h2>
    <p>
      Interpolation is denoted by double curly braces surrounding a variable.
      This binds the tag to the output of the expression between the braces.
    </p>

    <p>Counter: {{ counter }} </p>

    <h2>Event Binding</h2>
    <p>
      Event binding is denoted by parenthesis surrounding a browser event and defined by a method call.
      This creates an event listener which is passed the method behind the scenes.
    </p>

    <button (click)="decrementCounter()">Increment Counter</button>
    <button (click)="incrementCounter()">Decrement Counter</button>

    <h2>Property Binding</h2>
    <p>
      Property binding is denoted by brackets surrounding a DOM property and defined by a template expression.
      It can also be used to provide input to child components.
    </p>

    <div [ngStyle]="styleObject">
      <p>This div is styled using property binding.</p>
    </div>

    <app-child [childObject]="parentObject"></app-child>

    <h2>Two-Way Data Binding</h2>
    <p>
      Two-Way Data Binding combines the one-way behavior of event binding with the opposite direction one-way behavior of property binding.
      The directive ngModel (requires FormModule import from @angular/forms) provides easy two-way binding.
    </p>

    Change div color: <input [(ngModel)]="styleObject.color" name="color" type="text">
  `,
  styles: []
})
export class BindingComponent {

  counter = 0;

  styleObject = {
    color: 'red',
    border: '1px solid black',
    cursor: 'pointer',
    margin: '2em',
  };

  parentObject = {
    message: 'This is a message passed from the binding component'
  }

  incrementCounter() {
    this.counter++;
  }

  decrementCounter() {
    this.counter--;
  }
}
