export class Destination {
  id: number;
  city: string;
  state: string;
  country: string;
  longitude: string;
  latitude: string;

  constructor(
    id?: number,
    city?: string,
    state?: string,
    country?: string,
    longitude?: string,
    latitude?: string
  ) {
    this.id = id;
    this.city = city;
    this.state = state;
    this.country = country;
    this.longitude = longitude;
    this.latitude = latitude;
  }
}
