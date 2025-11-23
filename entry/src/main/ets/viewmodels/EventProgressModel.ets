import { EventType } from '../lib/constants';
import { formatDate } from '../lib/utils';

export default class EventProgressModel {
  name: string = '';
  maxProgress: number = 100;
  progress: number = 0;
  color: Color = Color.Blue;
  type: EventType = EventType.Yearly;
  date: Date = new Date()

  constructor(
    name: string,
    maxProgress: number,
    progress: number,
    color?: Color,
    type?: EventType,
  ) {
    this.name = name;
    this.maxProgress = maxProgress;
    this.progress = progress;
    this.color = color ?? Color.Blue;
    this.type = type ?? EventType.Yearly;
    const date = new Date();
    date.setHours(23, 59, 59, 99);
    this.date = date;
  }

  get percentage(): string {
    const percent = ((this.progress / this.maxProgress) * 100);
    return Math.floor(percent).toFixed(0);
  }

  get unit(): string {
    if (this.type === EventType.Daily) {
      return this.progress === 1 ? 'hour' : 'hours';
    }
    return this.progress === 1 ? 'day' : 'days';
  }

  get formattedDate() {
    return formatDate(this.date);
  }
}
