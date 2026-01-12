import { EventType } from '../lib/constants';
import { getYearProgress } from '../lib/utils';
import EventProgressModel from '../viewmodels/EventProgressModel';
import EventMenuItem from './EventMenuItem';

@Builder
export default function yearlyProgressBuilder() {
  YearlyProgress()
}

@Component
struct YearlyProgress {
  private progress = getYearProgress()
  private event: EventProgressModel =
    new EventProgressModel(
      `${this.progress.year} Year Progress`,
      this.progress.total,
      this.progress.elapsed,
      Color.Blue,
      EventType.Yearly,
    );

  build() {
    EventMenuItem({ event: this.event })
  }
}