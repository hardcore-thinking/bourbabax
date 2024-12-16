import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { PiStat } from '../Interfaces/pi-stat';
import { Observable, of } from 'rxjs';

@Injectable({
  providedIn: 'root',
})
export class HttpService {

  constructor(private http: HttpClient) { }

  getDataObservable(): Observable<PiStat[]> {
    return this.http.get<PiStat[]>("URL");
  }
}
