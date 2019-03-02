import { BrowserModule } from '@angular/platform-browser';
import { FormsModule } from '@angular/forms';
import { HttpClientModule }    from '@angular/common/http';
import { NgModule } from '@angular/core';

import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { BindingComponent } from './binding.component';
import { ChildComponent } from './child.component';
import { HttpComponent } from './http.component';
import { PipeComponent } from './pipe.component';

@NgModule({
  declarations: [
    AppComponent,
    BindingComponent,
    ChildComponent,
    HttpComponent,
    PipeComponent
  ],
  imports: [
    BrowserModule,
    FormsModule,
    HttpClientModule,
    AppRoutingModule
  ],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule { }
