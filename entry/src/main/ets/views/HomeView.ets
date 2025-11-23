import { ArcList, ComponentContent, UIContext } from '@kit.ArkUI';
import DailyProgress from '../components/DailyProgress';
import MonthlyProgress from '../components/MonthlyProgress';
import YearlyProgress from '../components/YearlyProgress';
import { calendarManager } from '@kit.CalendarKit';
import CalendarEventsProgress from '../components/CalendarEventProgress';
import { headerBuilder } from '../components/ui/Header';
import { FULL_HEIGHT_PERCENT, FULL_WIDTH_PERCENT } from '../lib/constants';

@Component
export default struct HomeView {
  @Prop @Require events: calendarManager.Event[] = []
  context: UIContext = this.getUIContext();
  tabBar: ComponentContent<Object> = new ComponentContent(this.context, wrapBuilder(headerBuilder));

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
          (event: calendarManager.Event) => CalendarEventsProgress({ calendarEvent: event }),
          (event: calendarManager.Event) => `${event.id}`
        )
      }
    }
    .width(FULL_WIDTH_PERCENT)
    .height(FULL_HEIGHT_PERCENT)
    .backgroundColor($r('app.color.main_background'))
  }
}