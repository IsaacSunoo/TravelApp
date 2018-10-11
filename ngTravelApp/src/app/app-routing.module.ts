import { ScratchpadComponent } from './scratchpad/scratchpad.component';
import { FeedComponent } from './feed/feed.component';
import { FollowersComponent } from './followers/followers.component';
import { PostsComponent } from './posts/posts.component';
import { ProfileComponent } from './profile/profile.component';
import { SettingComponent } from './setting/setting.component';
import { RegisterComponent } from './register/register.component';
import { TripComponent } from './trip/trip.component';
import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { FollowingComponent } from './following/following.component';
import { TripDetailsComponent } from './trip-details/trip-details.component';

const routes: Routes = [
  { path: 'home', component: RegisterComponent },
  { path: 'settings', component: SettingComponent },
  { path: 'profile', component: ProfileComponent},
  { path: 'oldtrips', component: TripComponent },
  { path: 'posts', component: PostsComponent },
  { path: 'followers', component: FollowersComponent },
  { path: 'following', component: FollowingComponent },
  { path: 'feed', component: FeedComponent },
  { path: 'trips', component: TripDetailsComponent },
  { path: 'trips/:id', component: TripDetailsComponent },
  { path: 'scratchpad', component: ScratchpadComponent },
  { path: 'scratchpad/:id', component: ScratchpadComponent },
  { path: 'profile/:id', component: ProfileComponent }


];

@NgModule({
  imports: [RouterModule.forRoot(routes, { useHash: true })],
  exports: [RouterModule]
})
export class AppRoutingModule { }
