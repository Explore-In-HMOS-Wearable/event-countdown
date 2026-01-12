import { calendarManager } from '@kit.CalendarKit';
import { formatDate, getEventProgress, getRandomColor } from '../lib/utils';

export interface Progress {
  years: number;
  days: number;
  hours: number;
  minutes: number;
  sec: number;
}

export default class CalendarEventProgressModel {
  event: calendarManager.Event | undefined;
  date: Date = new Date();
  isPassed: boolean = false;
  progress: Progress = {
    years: 0,
    days: 0,
    hours: 0,
    minutes: 0,
    sec: 0
  }
  total: number = 100;
  elapsed: number = 0;
  color: string | Color = Color.Green;

  constructor(event: calendarManager.Event, date: Date | null = null) {
    this.event = event;
    this.date = new Date(date != null ? date.getTime() : this.event.startTime);
    const eventProgress = getEventProgress(this.date);
    this.progress = eventProgress.progress as Progress;
    this.isPassed = eventProgress.isPassed;
    this.total = eventProgress.total;
    this.elapsed = eventProgress.elapsed;
    if (this.isPassed) {
      this.color = getRandomColor();
    }
  }

  get formattedDate(): string {
    return formatDate(this.date)
  }
}