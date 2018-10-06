export class UpdateProfile {
  firstName: string;
  lastName: string;
  imgLink: string;
  bio: string;
  name: string;
  password: string;
  email: string;
  city: string;
  state: string;
  country: string;

  constructor(
    firstName?: string,
    lastName?: string,
    imgLink?: string,
    bio?: string,
    name?: string,
    password?: string,
    email?: string,
    city?: string,
    state?: string,
    country?: string
  ) {
    this.firstName = firstName;
    this.lastName = lastName;
    this.imgLink = imgLink;
    this.bio = bio;
    this.name = name;
    this.password = password;
    this.email = email;
    this.city = city;
    this.state = state;
    this.country = country;
  }
       }
