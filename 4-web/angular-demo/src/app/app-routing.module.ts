import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { BindingComponent } from './binding.component';
import { HttpComponent } from './http.component';
import { PipeComponent } from './pipe.component';

const routes: Routes = [
  {
    path: '',
    component: BindingComponent
  },
  {
    path: 'binding',
    component: BindingComponent
  },
  {
    path: 'pipe',
    component: PipeComponent
  },
  {
    path: 'http',
    component: HttpComponent
  }
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
