import { Destination } from './destination';

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

  constructor(
    id?: number,
    title?: string,
    rating?: number,
    totalCost?: number,
    dateStart?: string,
    dateEnd?: string,
    review?: string,
    imgLink?: string,
    destination?: Destination
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
  }
}
