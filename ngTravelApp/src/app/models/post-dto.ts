export class PostDTO {
  id: number;
  title: string;
  rating: number;
  totalCost: number;
  dateStart: string;
  dateEnd: string;
  review: string;
  imgLink: string;
  city: string;
  state: string;
  country: string;
  latitude: string;
  longitude: string;
  message: string;

  constructor(
    id?: number,
    title?: string,
    rating?: number,
    totalCost?: number,
    dateStart?: string,
    dateEnd?: string,
    review?: string,
    imgLink?: string,
    city?: string,
    state?: string,
    country?: string,
    latitude?: string,
    longitude?: string,
    message?: string,
  ) {
    this.id = id;
    this.title = title;
    this.rating = rating;
    this.totalCost = totalCost;
    this.dateStart = dateStart;
    this.dateEnd = dateEnd;
    this.review = review;
    this.imgLink = imgLink;
    this.city = city;
    this.state = state;
    this.country = country;
    this.latitude = latitude;
    this.longitude = longitude;
    this.message = message;
  }
}

