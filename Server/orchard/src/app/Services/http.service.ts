import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { PiStat } from '../Interfaces/pi-stat';
import { Observable, of } from 'rxjs';
import { map } from 'rxjs/operators';

@Injectable({
  providedIn: 'root',
})
export class HttpService {

  constructor(private http: HttpClient) { }

  getDataObservable(): Observable<PiStat[]> {
    const parseJson = (data: any): PiStat[] => {
      if (!Array.isArray(data.raspberries)) {
        throw new Error('Expected an array of raspberries');
      }
      return data.raspberries.map((item: any) => ({
        id: item.id,
        macAddress: item.mac_addr,
        port: item.port,
        lastPing: item.last_seen,
        sshKey: item.ssh_key
      }));
    };
    return this.http.get<any>("http://212.83.155.128:3000/api/list-all").pipe(
      map(parseJson)
    );
  }

}
