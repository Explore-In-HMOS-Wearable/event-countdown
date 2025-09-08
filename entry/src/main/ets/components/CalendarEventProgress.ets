import { calendarManager } from '@kit.CalendarKit';
import { formatDate, getEventProgress, getRandomColor } from '../lib/utils';
import { ArcListItem } from '@kit.ArkUI';

interface Progress {
  years: number;
  days: number;
  hours: number;
  minutes: number;
  sec: number;
}

@Component
export default struct CalendarEventsProgress {
  @Prop event: calendarManager.Event | undefined;
  private date: Date = new Date();
  private progress: Progress | undefined;
  private isPassed: boolean = false;
  private total: number = 100;
  private elapsed: number = 100;

  aboutToAppear(): void {
    this.date = new Date(this.event!.startTime);
    const eventProgress = getEventProgress(this.date);
    this.progress = eventProgress.progress;
    this.isPassed = eventProgress.isPassed;
    this.total = eventProgress.total;
    this.elapsed = eventProgress.elapsed;
  }

  build() {
    ArcListItem() {
      Row() {
        DataPanel({
          values: [this.elapsed],
          max: this.total,
          type: DataPanelType.Circle,
        })
          .valueColors([this.isPassed ? Color.Green : getRandomColor()])
          .width('65vp')
          .height('65vp')

        Column() {
          Row() {
            Text(this.event?.title)
              .maxLines(2)
              .textOverflow({ overflow: TextOverflow.Ellipsis })
              .textAlign(TextAlign.Start)
              .fontWeight(FontWeight.Bold)
              .fontSize(14)
            if (this.isPassed) {
              Text(' - Passed')
                .fontSize(10)
            }
          }

          Row() {
            Text(formatDate(this.date))
              .fontSize(10)
              .textAlign(TextAlign.Start)
            Blank(3)
            Row() {
              if (this.isPassed) {
                Text('-')
                  .fontSize(14)
                  .fontWeight(FontWeight.Bold)
              }
              if (this.progress!.years > 0) {
                Text(`${this.progress?.years}`)
                  .fontSize(18)
                  .fontWeight(FontWeight.Bold)
                  .textAlign(TextAlign.Start)
                Text('y')
                  .fontSize(11)
                  .opacity(0.6)
                  .alignSelf(ItemAlign.Baseline)
              } else if (this.progress!.days > 0) {
                Text(`${this.progress?.days}`)
                  .fontSize(18)
                  .fontWeight(FontWeight.Bold)
                  .textAlign(TextAlign.Start)
                Text('d')
                  .fontSize(11)
                  .opacity(0.6)
                  .alignSelf(ItemAlign.Baseline)
              } else if (this.progress!.hours > 0) {
                Text(`${this.progress?.hours}`)
                  .fontSize(18)
                  .fontWeight(FontWeight.Bold)
                  .textAlign(TextAlign.Start)
                Text('h')
                  .fontSize(11)
                  .opacity(0.6)
                  .alignSelf(ItemAlign.Baseline)
              } else if (this.progress!.minutes > 0) {
                Text(`${this.progress?.minutes}`)
                  .fontSize(18)
                  .fontWeight(FontWeight.Bold)
                  .textAlign(TextAlign.Start)
                Text('m')
                  .fontSize(11)
                  .opacity(0.6)
                  .alignSelf(ItemAlign.Baseline)
              } else if (this.progress!.sec > 0) {
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
        .justifyContent(FlexAlign.Start)
        .alignItems(HorizontalAlign.Start)
      }
      .backgroundColor($r('app.color.progress_background'))
      .borderRadius(25)
      .margin(5)
      .width('85%')
      .padding({
        top: 3,
        bottom: 3,
        left: 4,
        right: 3
      })
    }
  }
}