import { getDayProgress, getMonthProgress, getYearProgress } from '../lib/utils';
import EventProgressModel from '../viewmodels/EventProgressModel';
import { Progress } from '../viewmodels/CalendarEventProgressModel';
import { EIGHTY_PERCENT, EventType, FIFTY_PERCENT, FULL_HEIGHT_PERCENT, FULL_WIDTH_PERCENT } from '../lib/constants';

@Component
export default struct EventView {
  @Prop @Require event: EventProgressModel;
  @State intervalId: number = -1;
  @State progress: Progress = {
    years: 0,
    days: 0,
    hours: 0,
    minutes: 0,
    sec: 0,
  };

  startProgress(today: Date) {
    today.setTime(today.getTime() - 1000);
    let progress = getYearProgress(today).progress;

    if (this.event.type === EventType.Monthly) {
      progress = getMonthProgress(today).progress
    }
    if (this.event.type === EventType.Daily) {
      progress = getDayProgress(today).progress
    }
    this.progress = progress as Progress;

    return today;
  }

  aboutToAppear(): void {
    let today = new Date();
    today = this.startProgress(today);
    this.intervalId = setInterval(() => {
      today = this.startProgress(today);
    }, 1000);
  }

  aboutToDisappear(): void {
    clearInterval(this.intervalId);
  }

  build() {
    Stack() {
      DataPanel({
        values: [this.event.progress],
        max: this.event.maxProgress,
        type: DataPanelType.Circle,

      })
        .valueColors([this.event.color])
        .width(FULL_WIDTH_PERCENT)
        .height(FULL_HEIGHT_PERCENT)
        .margin(0)
      Column({ space: 10 }) {
        Text(this.event.name)
          .fontSize(25)
          .fontWeight(FontWeight.Bold)
        Text(this.event.formattedDate)
          .fontSize(14)
        Column() {
          Row() {
            if (this.progress?.years > 0) {
              Text(`${this.progress?.years}`)
                .fontSize(18)
                .fontWeight(FontWeight.Bold)
                .textAlign(TextAlign.Start)
              Text('y')
                .fontSize(11)
                .opacity(0.6)
                .alignSelf(ItemAlign.Baseline)
            }
            if (this.progress?.days > 0) {
              Text(`${this.progress?.days}`)
                .fontSize(18)
                .fontWeight(FontWeight.Bold)
                .textAlign(TextAlign.Start)
              Text('d')
                .fontSize(11)
                .opacity(0.6)
                .alignSelf(ItemAlign.Baseline)
            }
            if (this.progress?.hours > 0) {
              Text(`${this.progress?.hours}`)
                .fontSize(18)
                .fontWeight(FontWeight.Bold)
                .textAlign(TextAlign.Start)
              Text('h')
                .fontSize(11)
                .opacity(0.6)
                .alignSelf(ItemAlign.Baseline)
            }
            if (this.progress?.minutes > 0) {
              Text(`${this.progress?.minutes}`)
                .fontSize(18)
                .fontWeight(FontWeight.Bold)
                .textAlign(TextAlign.Start)
              Text('m')
                .fontSize(11)
                .opacity(0.6)
                .alignSelf(ItemAlign.Baseline)
            }
            if (this.progress?.sec > 0) {
              Text(`${this.progress?.sec}`)
                .fontSize(18)
                .fontWeight(FontWeight.Bold)
                .textAlign(TextAlign.Start)
              Text('s')
                .fontSize(11)
                .opacity(0.6)
                .alignSelf(ItemAlign.Baseline)
            }
          }
        }
        .justifyContent(FlexAlign.SpaceBetween)

      }
      .padding(20)
      .width(EIGHTY_PERCENT)
      .height(EIGHTY_PERCENT)
      .borderRadius(FIFTY_PERCENT)
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)
    }
  }
}