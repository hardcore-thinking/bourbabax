import { Component } from '@angular/core';
import { RouterOutlet } from '@angular/router';
import { PiListComponent } from './Components/pi-list/pi-list.component';
import { HttpClientModule } from '@angular/common/http';

@Component({
  selector: 'app-root',
  standalone: true,
  imports: [RouterOutlet, PiListComponent, HttpClientModule],
  templateUrl: './app.component.html',
  styleUrl: './app.component.scss'
})
export class AppComponent {
  title = 'orchard';
}
