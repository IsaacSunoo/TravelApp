import { Trip } from './trip';
import { Profile } from './profile';

export class Posts {
  id: number;
  message: string;

  // trip id and profile id are being used for testing purposes
  tripId: number;
  profileId: number;
  trip: Trip;
  profile: Profile;


  constructor(id?: number, message?: string, tripId?: number, profileId?: number, trip?: Trip, profile?: Profile) {
    this.id = id;
    this.message = message;
    this.tripId = tripId;
    this.profileId = profileId;
    this.trip = trip;
    this.profile = profile;
  }

}
