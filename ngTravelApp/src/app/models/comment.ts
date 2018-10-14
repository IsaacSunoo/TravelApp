import { Posts } from './posts';

export class Comment {
  id: number;
  content: string;
  profId: number;
  createDate: Date;
  post: Posts;

  constructor(
    id?: number,
    content?: string,
    profId?: number,
    createDate?: Date,
    post?: Posts
  ) {
    this.id = id;
    this.content = content;
    this.profId = profId;
    this.createDate = createDate;
    this.post = post;
  }
}
