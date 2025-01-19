import { Component } from '@angular/core';
import { CommonModule } from '@angular/common';
import { PiStat } from '../../Interfaces/pi-stat';
import { Sort, MatSortModule } from '@angular/material/sort';
import { MatDividerModule } from '@angular/material/divider';
import { HttpService } from '../../Services/http.service';
import { Observable } from 'rxjs';

@Component({
  selector: 'app-pi-list',
  standalone: true,
  imports: [CommonModule, MatSortModule, MatDividerModule],
  templateUrl: './pi-list.component.html',
  styleUrl: './pi-list.component.scss'
})
export class PiListComponent {
  pies: PiStat[] = [
    { id: 234543, macAdress: "00:1B:44:11:3A:B7", port: 2134, name: "Pie 1", CPU: Math.floor(Math.random() * 100), RAM: Math.floor(Math.random() * 100), Storage: Math.floor(Math.random() * 100), lastPing: new Date() },
    { id: 765872, macAdress: "00:1B:44:11:3A:B8", port: 2134, name: "Pie 2", CPU: Math.floor(Math.random() * 100), RAM: Math.floor(Math.random() * 100), Storage: Math.floor(Math.random() * 100), lastPing: new Date() },
    { id: 765873, macAdress: "00:1B:44:11:3A:B9", port: 2134, name: "Pie 3", CPU: Math.floor(Math.random() * 100), RAM: Math.floor(Math.random() * 100), Storage: Math.floor(Math.random() * 100), lastPing: new Date() },
    { id: 765874, macAdress: "00:1B:44:11:3A:BA", port: 2134, name: "Pie 4", CPU: Math.floor(Math.random() * 100), RAM: Math.floor(Math.random() * 100), Storage: Math.floor(Math.random() * 100), lastPing: new Date() },
    { id: 765875, macAdress: "00:1B:44:11:3A:BB", port: 2134, name: "Pie 5", CPU: Math.floor(Math.random() * 100), RAM: Math.floor(Math.random() * 100), Storage: Math.floor(Math.random() * 100), lastPing: new Date() },
  ];

  sortedData: PiStat[];
  obs !: Observable<PiStat[]>;
  constructor(private httpService: HttpService) {
    this.subData();
    this.sortedData = [];
    this.sortData({ active: '', direction: '' });
  }

  subData() {
    this.obs = this.httpService.getDataObservable();
    this.obs.subscribe(data => {
      this.pies = data;
      this.sortedData = this.pies.slice();
    });
  }


  sortData(sort: Sort) {
    const data = this.pies.slice();
    if (!sort.active || sort.direction === '') {
      this.sortedData = data;
      return;
    }

    this.sortedData = data.sort((a, b) => {
      const isAsc = sort.direction === 'asc';
      switch (sort.active) {
        case 'name':
          return compare(a.name, b.name, isAsc);
        case 'CPU':
          return compare(a.CPU, b.CPU, isAsc);
        case 'RAM':
          return compare(a.RAM, b.RAM, isAsc);
        case 'Storage':
          return compare(a.Storage, b.Storage, isAsc);
        // case 'lastPing':
        //   return compare(a.lastPing, b.lastPing, isAsc);
        default:
          return 0;
      }
    });
  }

  getColor(value: number) {
    //lerp from 255 to 0
    let lerp = Math.floor(255 * (1 - value / 100));
    return `rgb(255, ${lerp}, ${lerp})`;
  }
}

function compare(a: number | string, b: number | string, isAsc: boolean) {
  return (a < b ? -1 : 1) * (isAsc ? 1 : -1);
}


