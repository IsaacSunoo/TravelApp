import { TestBed } from '@angular/core/testing';

import { TripDetailsService } from './trip-details.service';

describe('TripDetailsService', () => {
  beforeEach(() => TestBed.configureTestingModule({}));

  it('should be created', () => {
    const service: TripDetailsService = TestBed.get(TripDetailsService);
    expect(service).toBeTruthy();
  });
});
