import { EventType } from '../lib/constants';
import { getMonthProgress } from '../lib/utils';
import EventProgressModel from '../viewmodels/EventProgressModel';
import EventMenuItem from './EventMenuItem';

@Builder
export default function monthlyProgressBuilder() {
  MonthlyProgress()
}

@Component
struct MonthlyProgress {
  private progress = getMonthProgress()
  private event: EventProgressModel =
    new EventProgressModel(
      `${this.progress.month} Progress`,
      this.progress.total,
      this.progress.elapsed,
      Color.Orange,
      EventType.Monthly
    );

  build() {
    EventMenuItem({ event: this.event })
  }
}