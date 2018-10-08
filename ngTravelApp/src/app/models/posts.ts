export class Posts {
  id: number;
  message: string;

  // trip id and profile id are being used for testing purposes
  tripId: number;
  profileId: number;

  constructor(id?: number, message?: string, tripId?: number, profileId?: number) {
    this.id = id;
    this.message = message;
    this.tripId = tripId;
    this.profileId = profileId;
  }

}
