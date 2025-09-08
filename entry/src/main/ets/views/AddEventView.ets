import CalendarManager from '../models/CalendarManager';
import { calendarManager } from '@kit.CalendarKit';
import {
  ArcButton,
  ArcButtonOptions,
  ArcButtonStyleMode,
  ArcScrollBar,
  ColorMetrics,
  LengthMetrics,
  LengthUnit,
  Router
} from '@kit.ArkUI';
import { BusinessError } from '@kit.BasicServicesKit';
import { hilog } from '@kit.PerformanceAnalysisKit';

@Component
export default struct AddEventView {
  context: UIContext = this.getUIContext();
  router: Router = this.context.getRouter();
  @State title: string = "";
  private calendarMgr: CalendarManager | undefined;
  private calendar: calendarManager.Calendar | undefined;
  private btnOptions: ArcButtonOptions = new ArcButtonOptions({});
  private selectedDate: Date = new Date()
  private scroller: Scroller = new Scroller()

  aboutToAppear() {
    try {
      this.btnOptions = new ArcButtonOptions({
        label: 'Add',
        styleMode: ArcButtonStyleMode.CUSTOM,
        fontSize: new LengthMetrics(15, LengthUnit.FP),
        shadowEnabled: true,
        backgroundColor: ColorMetrics.resourceColor($r('app.color.progress_background')),
        onClick: () => {
          if (this.title.length > 2) {
            const eventInfo: calendarManager.Event = {
              title: this.title,
              type: calendarManager.EventType.NORMAL,
              startTime: this.selectedDate.getTime(),
              endTime: this.selectedDate.getTime() + 60 * 60 * 1000
            };
            this
              .calendar?.addEvent(eventInfo)
              .then(() => {
                this.router.pushUrl({ url: "pages/Index" }).catch((error: BusinessError) => {
                  hilog.error(0x0001, "eventCountdownApp", error.message);
                })
              })
              .catch((err: BusinessError) => {
                console.log(err.message);
              })
          }
        }
      });
    } catch (error) {
      hilog.error(0x0001, "eventCountdownApp", error.message);
    }
    this.calendarMgr = CalendarManager.getInstance();
    this.calendarMgr.getCalendar().then((calendar) => {
      this.calendar = calendar;
    });

  }

  build() {
    Column() {
      Stack({ alignContent: Alignment.Center }) {
        Scroll(this.scroller) {
          Flex({
            justifyContent: FlexAlign.Center,
            direction: FlexDirection.Column,
            alignItems: ItemAlign.Center
          }) {
            TextInput({ placeholder: "Enter event", text: this.title!! })
              .type(InputType.Normal)
              .margin({
                left: 20,
                top: 25,
                right: 20,
                bottom: 5
              })

            DatePicker({
              start: new Date('1970-1-1'),
              end: new Date('2100-1-1'),
              selected: this.selectedDate,
            })
              .lunar(false)
              .borderRadius(10)
              .width('80%')
              .margin({ bottom: 20 })
              .padding({ left: 10, right: 10 })
              .selectedTextStyle({
                color: '#FFFFFF',
                font: {
                  size: '18fp',
                  weight: FontWeight.Bold,
                  family: "HarmonyOS Sans",
                  style: FontStyle.Normal
                }
              })
              .onDateChange((value: Date) => {
                this.selectedDate = value
              })

            ArcButton({ options: this.btnOptions })
          }

        }
        .width('90%')
        .scrollBar(BarState.Off)
        .scrollable(ScrollDirection.Vertical)
        .edgeEffect(EdgeEffect.Spring)

        ArcScrollBar({ scroller: this.scroller, state: BarState.Auto })
      }
      .width('100%')
      .height('100%')
    }
    .justifyContent(FlexAlign.Center)
    .width('100%')
    .height('100%')
  }
}