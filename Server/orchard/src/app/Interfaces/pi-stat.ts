export interface PiStat {
    id: number;
    name?: string;
    macAddress: string;
    port: number;
    CPU?: number;
    RAM?: number;
    Storage?: number;
    lastPing: Date;
}
