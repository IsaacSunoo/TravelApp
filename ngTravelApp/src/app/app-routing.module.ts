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

const routes: Routes = [
  { path: 'home', component: RegisterComponent },
  { path: 'settings', component: SettingComponent },
  { path: 'profile', component: ProfileComponent},
  { path: 'trips', component: TripComponent },
  { path: 'posts', component: PostsComponent },
  { path: 'followers', component: FollowersComponent },
  { path: 'following', component: FollowingComponent },
  { path: 'feed', component: FeedComponent }


];

@NgModule({
  imports: [RouterModule.forRoot(routes, { useHash: true })],
  exports: [RouterModule]
})
export class AppRoutingModule { }
