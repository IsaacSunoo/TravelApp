import { HttpClientModule } from '@angular/common/http';
import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';
import { FormsModule } from '@angular/forms';

import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { RegisterComponent } from './register/register.component';
import { LoginComponent } from './login/login.component';
import { DatePipe } from '@angular/common';
import { SettingComponent } from './setting/setting.component';
import { PostsComponent } from './posts/posts.component';
import { FeedComponent } from './feed/feed.component';
import { TripComponent } from './trip/trip.component';
import { ProfileComponent } from './profile/profile.component';
import { LogoutComponent } from './logout/logout.component';
import { FollowersComponent } from './followers/followers.component';
import { FollowingComponent } from './following/following.component';
import { TripService } from './trip.service';
import { MatStepperModule } from '@angular/material/stepper';
import { BrowserAnimationsModule } from '@angular/platform-browser/animations';
import { StepperComponent } from './stepper/stepper.component';
import { MatDatepickerModule } from '@angular/material/datepicker';
import { MatFormFieldModule } from '@angular/material/form-field';
import { DatePickerComponent } from './date-picker/date-picker.component';
import { MatButtonModule, MatCheckboxModule, MatNativeDateModule, MatInputModule } from '@angular/material';
import { TripDetailsComponent } from './trip-details/trip-details.component';
import { MatTabsModule } from '@angular/material/tabs';
import { ScratchpadComponent } from './scratchpad/scratchpad.component';
import { StepperToPostsShellService } from './stepper-to-posts-shell.service';
import { SearchComponent } from './search/search.component';
import { CommentProfileFilterPipe } from './comment-profile-filter.pipe';
import { AgmCoreModule } from '@agm/core';




@NgModule({
  declarations: [
    AppComponent,
    RegisterComponent,
    LoginComponent,
    SettingComponent,
    PostsComponent,
    FeedComponent,
    TripComponent,
    ProfileComponent,
    LogoutComponent,
    FollowersComponent,
    FollowingComponent,
    StepperComponent,
    DatePickerComponent,
    TripDetailsComponent,
    ScratchpadComponent,
    SearchComponent,
    CommentProfileFilterPipe,
  ],
  imports: [
    BrowserModule,
    AppRoutingModule,
    FormsModule,
    HttpClientModule,
    MatStepperModule,
    BrowserAnimationsModule,
    MatDatepickerModule,
    MatFormFieldModule,
    MatButtonModule,
    MatCheckboxModule,
    MatNativeDateModule,
    MatInputModule,
    MatTabsModule,
    AgmCoreModule.forRoot({
      apiKey: 'AIzaSyAafk6IHPSK6Yx6QvCKSGKIV8jY_ZZLzLc'
    })
  ],
  providers: [DatePipe, TripService, StepperToPostsShellService],
  bootstrap: [AppComponent]
})
export class AppModule {}
