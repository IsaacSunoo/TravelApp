import { Pipe, PipeTransform } from '@angular/core';
import { Profile } from './models/profile';

@Pipe({
  name: 'commentProfileFilter'
})
export class CommentProfileFilterPipe implements PipeTransform {
  transform(commentId, profileArrayForComments: Profile[]) {
    let pos = 0;
    profileArrayForComments.forEach(profile => {
      if (commentId === profile.id) {
        pos = profileArrayForComments
          .map(function(e) {
            return e.id;
          })
          .indexOf(commentId);
      }
    });

    return pos;
  }
}
