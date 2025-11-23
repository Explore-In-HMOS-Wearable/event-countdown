import { EventType } from '../lib/constants';
import { getDayProgress } from '../lib/utils';
import EventProgressModel from '../viewmodels/EventProgressModel';
import EventMenuItem from './EventMenuItem';

@Builder
export default function dailyProgressBuilder() {
  DailyProgress()
}

@Component
struct DailyProgress {
  private progress = getDayProgress()
  private event: EventProgressModel =
    new EventProgressModel(
      `${this.progress.day} Progress`,
      this.progress.total,
      this.progress.elapsed,
      Color.Pink,
      EventType.Daily
    );

  build() {
    EventMenuItem({ event: this.event })
  }
}