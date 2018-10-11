import { Destination } from './destination';
import { Recommendation } from './recommendation';

export class Trip {
  id: number;
  title: string;
  rating: number;
  totalCost: number;
  dateStart: string;
  dateEnd: string;
  review: string;
  imgLink: string;
  destination: Destination;
  recommendations: Recommendation[];

  constructor(
    id?: number,
    title?: string,
    rating?: number,
    totalCost?: number,
    dateStart?: string,
    dateEnd?: string,
    review?: string,
    imgLink?: string,
    destination?: Destination,
    recommendations?: Recommendation[]
  ) {
    this.id = id;
    this.title = title;
    this.rating = rating;
    this.totalCost = totalCost;
    this.dateStart = dateStart;
    this.dateEnd = dateEnd;
    this.review = review;
    this.imgLink = imgLink;
    this.destination = destination;
    this.recommendations = recommendations;
  }
}
