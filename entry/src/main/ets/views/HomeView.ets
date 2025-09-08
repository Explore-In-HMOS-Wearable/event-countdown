import { ArcList, ComponentContent, Router, UIContext, } from '@kit.ArkUI';
import DailyProgress from '../components/DailyProgress';
import MonthlyProgress from '../components/MonthlyProgress';
import YearlyProgress from '../components/YearlyProgress';
import CalendarManager from '../models/CalendarManager';
import { calendarManager } from '@kit.CalendarKit';
import CalendarEventsProgress from '../components/CalendarEventProgress';
import { headerBuilder } from '../components/Header';

@Component
export default struct HomeView {
  context: UIContext = this.getUIContext();
  router: Router = this.context.getRouter();
  tabBar: ComponentContent<Object> = new ComponentContent(this.context, wrapBuilder(headerBuilder));
  @State events: calendarManager.Event[] = []
  private calendarMgr: CalendarManager | undefined;

  aboutToAppear() {
    this.calendarMgr = CalendarManager.getInstance();
    this.calendarMgr.getCalendar().then((calendar) => {
      calendar?.getEvents().then((events) => {
        this.events = events;
      })
    })
  }

  build() {
    Flex({
      justifyContent: FlexAlign.Center,
      direction: FlexDirection.Column,
      alignItems: ItemAlign.Center
    }) {
      ArcList({ header: this.tabBar }) {
        YearlyProgress()
        MonthlyProgress()
        DailyProgress()
        ForEach(
          this.events,
          (event: calendarManager.Event) => {
            CalendarEventsProgress({ event: event })
          },
          (event: calendarManager.Event) => `${event.id}`
        )
      }
    }
    .width('100%')
    .height('100%')
  }
}