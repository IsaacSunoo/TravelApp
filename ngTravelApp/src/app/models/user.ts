export class User {
  id: number;
  name: string;
  password: string;
  email: string;
  active: boolean;
  role: string;

  constructor(id?: number, name?: string, password?: string, email?: string, active?: boolean, role?: string) {
    this.id = id;
    this.name = name;
    this.password = password;
    this.email = email;
    this.active = active;
    this.role = role;
  }

}
