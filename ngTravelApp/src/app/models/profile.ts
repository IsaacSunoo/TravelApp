export class Profile {
  id: number;
  firstName: string;
  lastName: string;
  imgLink: string;
  bio: string;

  constructor(id?: number, firstName?: string, lastName?: string, imgLink?: string, bio?: string) {
    this.id = id;
    this.firstName = firstName;
    this.lastName = lastName;
    this.imgLink = imgLink;
    this.bio = bio;
  }
}
