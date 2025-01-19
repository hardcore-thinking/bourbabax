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
  pies: PiStat[] = [ ];

  sortedData: PiStat[];
  obs !: Observable<PiStat[]>;
  constructor(private httpService: HttpService) {
    this.subData();
    this.sortedData = [];
    
  }

  subData() {
    this.obs = this.httpService.getDataObservable();
    this.obs.subscribe(data => {
      this.pies = data;
      this.sortData({ active: '', direction: '' });
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
        case 'id':
          return compare(a.id, b.id, isAsc);
        case 'CPU':
        //   return compare(a.CPU, b.CPU, isAsc);
        // case 'RAM':
        //   return compare(a.RAM, b.RAM, isAsc);
        // case 'Storage':
        //   return compare(a.Storage, b.Storage, isAsc);
        // case 'lastPing':
        //   return compare(a.lastPing, b.lastPing, isAsc);
        default:
          return 0;
      }
    });
  }

  getColor(value: number, scale: number) {
    //lerp from 255 to 0
    let lerp = Math.floor(200 * (1 - value / scale));
    return `rgb(255, ${lerp}, ${lerp})`;
  }
}

function compare(a: number | string, b: number | string, isAsc: boolean) {
  return (a < b ? -1 : 1) * (isAsc ? 1 : -1);
}


