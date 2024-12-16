import { ComponentFixture, TestBed } from '@angular/core/testing';

import { PiListComponent } from './pi-list.component';

describe('PiListComponent', () => {
  let component: PiListComponent;
  let fixture: ComponentFixture<PiListComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [PiListComponent]
    })
    .compileComponents();
    
    fixture = TestBed.createComponent(PiListComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
