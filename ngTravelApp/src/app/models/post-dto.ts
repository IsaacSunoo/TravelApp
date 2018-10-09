export class PostDTO {
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

