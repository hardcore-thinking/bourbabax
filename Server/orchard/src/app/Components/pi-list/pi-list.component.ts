import { Component } from '@angular/core';
import { CommonModule } from '@angular/common';
import { PiStat } from '../../Interfaces/pi-stat';
import { Sort, MatSortModule } from '@angular/material/sort';
import { MatDividerModule } from '@angular/material/divider';

@Component({
  selector: 'app-pi-list',
  standalone: true,
  imports: [CommonModule, MatSortModule, MatDividerModule],
  templateUrl: './pi-list.component.html',
  styleUrl: './pi-list.component.scss'
})
export class PiListComponent {
  pies: PiStat[] = [
    { id: 234543, macAdress: "sauce", port: 2134, name: "Pie 1", CPU: 10, RAM: 20, Storage: 30, lastPing: new Date() },
    { id: 765872, macAdress: "sauce", port: 2134, name: "Pie 2", CPU: 20, RAM: 10, Storage: 70, lastPing: new Date() },
    { id: 765872, macAdress: "sauce", port: 2134, name: "Pie 3", CPU: 20, RAM: 10, Storage: 70, lastPing: new Date() },
    { id: 765872, macAdress: "sauce", port: 2134, name: "Pie 4", CPU: 20, RAM: 10, Storage: 70, lastPing: new Date() },
    { id: 765872, macAdress: "sauce", port: 2134, name: "Pie 5", CPU: 20, RAM: 10, Storage: 70, lastPing: new Date() },
  ];

  sortedData: PiStat[];

  constructor() {
    this.sortedData = this.pies.slice();
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
}

function compare(a: number | string, b: number | string, isAsc: boolean) {
  return (a < b ? -1 : 1) * (isAsc ? 1 : -1);
}
