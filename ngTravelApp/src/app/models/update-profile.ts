export class UpdateProfile {
  firstName: string;
  lastName: string;
  imgLink: string;
  bio: string;
  name: string;
  password: string;
  email: string;

  constructor(
    firstName?: string,
    lastName?: string,
    imgLink?: string,
    bio?: string,
    name?: string,
    password?: string,
    email?: string
  ) {
    this.firstName = firstName;
    this.lastName = lastName;
    this.imgLink = imgLink;
    this.bio = bio;
    this.name = name;
    this.password = password;
    this.email = email;
  }
       }
