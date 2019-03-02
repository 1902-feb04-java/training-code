import { Component, OnInit } from '@angular/core';

@Component({
  selector: 'app-pipe',
  template: `
    <p>
      Pipes are a way to write display-value transformations that you can declare in your HTML.<br>
      Current date w/o pipe: {{ currentTime }}<br>
      Current date with medium date and lowercase pipes: {{currentTime | date:'medium' | lowercase}}<br>
    </p>
  `,
  styles: []
})
export class PipeComponent implements OnInit {
  currentTime: Date

  constructor() { }

  ngOnInit() {
    setInterval(() => { this.currentTime = new Date(); }, 1000 );
  }

}
