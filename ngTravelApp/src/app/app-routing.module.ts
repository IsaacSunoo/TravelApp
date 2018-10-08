import { PostsComponent } from './posts/posts.component';
import { ProfileComponent } from './profile/profile.component';
import { SettingComponent } from './setting/setting.component';
import { RegisterComponent } from './register/register.component';
import { TripComponent } from './trip/trip.component';
import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';

const routes: Routes = [
  { path: 'home', component: RegisterComponent },
  { path: 'settings/:id', component: SettingComponent },
  { path: 'profile/:id', component: ProfileComponent},
  { path: 'trips/:id', component: TripComponent },
  { path: 'posts/:id', component: PostsComponent }

];

@NgModule({
  imports: [RouterModule.forRoot(routes, { useHash: true })],
  exports: [RouterModule]
})
export class AppRoutingModule { }
