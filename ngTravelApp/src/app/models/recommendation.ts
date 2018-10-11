import { RecType } from './rec-type';

export class Recommendation {
  id: number;
  content: string;
  recType: RecType;

  constructor(id?: number, content?: string, recType?: RecType) {
    this.id = id;
    this.content = content;
    this.recType = recType;
  }
}
