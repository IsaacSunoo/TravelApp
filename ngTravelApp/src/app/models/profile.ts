import { User } from './user';

export class Profile {
  id: number;
  firstName: string;
  lastName: string;
  imgLink: string;
  bio: string;
  user: User;

  constructor(
    id?: number,
    firstName?: string,
    lastName?: string,
    imgLink?: string,
    bio?: string,
    user?: User
  ) {
    this.id = id;
    this.firstName = firstName;
    this.lastName = lastName;
    this.imgLink = imgLink;
    this.bio = bio;
    this.user = user;
  }
}
