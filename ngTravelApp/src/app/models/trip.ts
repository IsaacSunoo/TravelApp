import { Destination } from './destination';
import { Recommendation } from './recommendation';
import { Profile } from './profile';

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
  profile: Profile;

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
    recommendations?: Recommendation[],
    profile?: Profile
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
    this.profile = profile;
  }
}
