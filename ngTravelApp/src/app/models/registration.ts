export class Registration {

  firstName: string;
  lastName: string;
  name: string;
  password: string;
  email: string;

  constructor(firstName?: string, lastName?: string, name?: string, password?: string, email?: string) {
    this.firstName = firstName;
    this.lastName = lastName;
    this.name = name;
    this.password = password;
    this.email = email;
  }
}
