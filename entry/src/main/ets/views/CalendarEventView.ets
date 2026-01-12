import { EIGHTY_PERCENT, FIFTY_PERCENT, FULL_HEIGHT_PERCENT, FULL_WIDTH_PERCENT } from '../lib/constants';
import { formatDate, getEventProgress } from '../lib/utils';
import CalendarEventProgressModel, { Progress } from '../viewmodels/CalendarEventProgressModel';

@Component
export default struct CalendarEventView {
  @Prop @Require @Watch('onEventChange') calendarEvent: CalendarEventProgressModel | null = null;
  private intervalId: number = -1;
  @State value: number = this.calendarEvent?.elapsed ?? 0;
  @State progress: Progress = {
    years: 0,
    days: 0,
    hours: 0,
    minutes: 0,
    sec: 0
  };

  onEventChange() {
    let today = new Date();
    this.startProgress(today)
  }

  startProgress(date: Date) {
    const time = date.getTime();
    date.setTime(time - 1000);
    const eventProgress = getEventProgress(date);
    this.progress = eventProgress.progress as Progress;
    this.value = eventProgress.elapsed;
    return date;
  }

  aboutToAppear(): void {
    if (this.calendarEvent != null) {
      const date = new Date(this.calendarEvent.date);
      let result = this.startProgress(date);
      this.intervalId = setInterval(() => {
        result = this.startProgress(result);
      }, 1000);
    }
  }

  aboutToDisappear(): void {
    clearInterval(this.intervalId);
  }

  build() {
    Stack() {
      DataPanel({
        values: [this.value],
        max: this.calendarEvent?.total ?? 100,
        type: DataPanelType.Circle
      })
        .valueColors([this.calendarEvent?.color])
        .width(FULL_WIDTH_PERCENT)
        .height(FULL_HEIGHT_PERCENT)
        .margin(0)
      Column({ space: 10 }) {
        Text(this.calendarEvent?.event?.title)
          .fontSize(25)
          .fontWeight(FontWeight.Bold)
        Text(formatDate(this.calendarEvent?.date))
          .fontSize(14)

        Row() {
          if (this.calendarEvent?.isPassed) {
            Text('-')
              .fontSize(14)
              .fontWeight(FontWeight.Bold)
          }
          if (this.progress.years > 0) {
            Text(`${this.progress.years}`)
              .fontSize(18)
              .fontWeight(FontWeight.Bold)
              .textAlign(TextAlign.Start)
            Text('y')
              .fontSize(11)
              .opacity(0.6)
              .alignSelf(ItemAlign.Baseline)
          }
          if (this.progress.days > 0) {
            Text(`${this.progress.days}`)
              .fontSize(18)
              .fontWeight(FontWeight.Bold)
              .textAlign(TextAlign.Start)
            Text('d')
              .fontSize(11)
              .opacity(0.6)
              .alignSelf(ItemAlign.Baseline)
          }
          if (this.progress.hours > 0) {
            Text(`${this.progress.hours}`)
              .fontSize(18)
              .fontWeight(FontWeight.Bold)
              .textAlign(TextAlign.Start)
            Text('h')
              .fontSize(11)
              .opacity(0.6)
              .alignSelf(ItemAlign.Baseline)
          }
          if (this.progress.minutes > 0) {
            Text(`${this.progress.minutes}`)
              .fontSize(18)
              .fontWeight(FontWeight.Bold)
              .textAlign(TextAlign.Start)
            Text('m')
              .fontSize(11)
              .opacity(0.6)
              .alignSelf(ItemAlign.Baseline)
          }
          if (this.progress.sec > 0) {
            Text(`${this.progress.sec}`)
              .fontSize(18)
              .fontWeight(FontWeight.Bold)
              .textAlign(TextAlign.Start)
            Text('s')
              .fontSize(11)
              .opacity(0.6)
              .alignSelf(ItemAlign.Baseline)
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