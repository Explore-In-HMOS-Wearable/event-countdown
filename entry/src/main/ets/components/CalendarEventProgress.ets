import { calendarManager } from '@kit.CalendarKit';
import { ArcListItem } from '@kit.ArkUI';
import CalendarEventProgressModel from '../viewmodels/CalendarEventProgressModel';
import { EIGHTY_FIVE_PERCENT } from '../lib/constants';

interface Progress {
  years: number;
  days: number;
  hours: number;
  minutes: number;
  sec: number;
}

@Component
export default struct CalendarEventsProgress {
  @Prop @Require calendarEvent: calendarManager.Event;
  pathStack: NavPathStack = AppStorage.get('PathStack') as NavPathStack;
  private event: CalendarEventProgressModel | null = null;

  aboutToAppear(): void {
    this.event = new CalendarEventProgressModel(this.calendarEvent);
  }

  build() {
    ArcListItem() {
      Row() {
        DataPanel({
          values: [this.event?.elapsed],
          max: this.event?.total,
          type: DataPanelType.Circle,
        })
          .valueColors([this.event?.color])
          .width('65vp')
          .height('65vp')
        Column() {
          Row() {
            Text(this.event?.event?.title)
              .maxLines(2)
              .textOverflow({ overflow: TextOverflow.Ellipsis })
              .textAlign(TextAlign.Start)
              .fontWeight(FontWeight.Bold)
              .fontSize(14)
            if (this.event?.isPassed) {
              Text(' - Passed')
                .fontSize(10)
            }
          }

          Row() {
            Text(this.event?.formattedDate)
              .fontSize(10)
              .textAlign(TextAlign.Start)
            Blank(3)
            Row() {
              if (this.event?.isPassed) {
                Text('-')
                  .fontSize(14)
                  .fontWeight(FontWeight.Bold)
              }
              if (this.event!.progress?.years > 0) {
                Text(`${this.event!.progress?.years}`)
                  .fontSize(18)
                  .fontWeight(FontWeight.Bold)
                  .textAlign(TextAlign.Start)
                Text('y')
                  .fontSize(11)
                  .opacity(0.6)
                  .alignSelf(ItemAlign.Baseline)
              } else if (this.event!.progress?.days > 0) {
                Text(`${this.event!.progress?.days}`)
                  .fontSize(18)
                  .fontWeight(FontWeight.Bold)
                  .textAlign(TextAlign.Start)
                Text('d')
                  .fontSize(11)
                  .opacity(0.6)
                  .alignSelf(ItemAlign.Baseline)
              } else if (this.event!.progress?.hours > 0) {
                Text(`${this.event!.progress?.hours}`)
                  .fontSize(18)
                  .fontWeight(FontWeight.Bold)
                  .textAlign(TextAlign.Start)
                Text('h')
                  .fontSize(11)
                  .opacity(0.6)
                  .alignSelf(ItemAlign.Baseline)
              } else if (this.event!.progress?.minutes > 0) {
                Text(`${this.event!.progress?.minutes}`)
                  .fontSize(18)
                  .fontWeight(FontWeight.Bold)
                  .textAlign(TextAlign.Start)
                Text('m')
                  .fontSize(11)
                  .opacity(0.6)
                  .alignSelf(ItemAlign.Baseline)
              } else if (this.event!.progress?.sec > 0) {
                Text(`${this.event!.progress?.sec}`)
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
      .onClick(() => {
        this.pathStack.pushPathByName('EventPage', this.event);
      })
      .backgroundColor($r('app.color.progress_background'))
      .borderRadius(25)
      .margin(5)
      .width(EIGHTY_FIVE_PERCENT)
      .padding({
        top: 3,
        bottom: 3,
        left: 4,
        right: 3
      })
    }
  }
}