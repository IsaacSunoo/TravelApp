export class Trip {
  id: number;
  title: string;
  rating: number;
  totalCost: number;
  dateStart: string;
  dateEnd: string;
  review: string;
  imgLink: string;

  constructor(
    id?: number,
    title?: string,
    rating?: number,
    totalCost?: number,
    dateStart?: string,
    dateEnd?: string,
    review?: string,
    imgLink?: string,
  ) {
    this.id = id;
    this.title = title;
    this.rating = rating;
    this.totalCost = totalCost;
    this.dateStart = dateStart;
    this.dateEnd = dateEnd;
    this.review = review;
    this.imgLink = imgLink;
  }


}
