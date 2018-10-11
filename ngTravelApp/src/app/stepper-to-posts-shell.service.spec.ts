import { TestBed } from '@angular/core/testing';

import { StepperToPostsShellService } from './stepper-to-posts-shell.service';

describe('StepperToPostsShellService', () => {
  beforeEach(() => TestBed.configureTestingModule({}));

  it('should be created', () => {
    const service: StepperToPostsShellService = TestBed.get(StepperToPostsShellService);
    expect(service).toBeTruthy();
  });
});
