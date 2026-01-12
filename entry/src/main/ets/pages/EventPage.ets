import CalendarEventProgressModel from '../viewmodels/CalendarEventProgressModel';
import CalendarEventView from '../views/CalendarEventView';

@Builder
export function EventPageBuilder() {
  EventPage()
}

@Component
struct EventPage {
  pathStack: NavPathStack = AppStorage.get('PathStack') as NavPathStack
  @State calendarEvent: CalendarEventProgressModel | null = null;

  aboutToAppear(): void {
    this.calendarEvent = this.pathStack.getParamByName('EventPage')[0] as CalendarEventProgressModel;
  }

  build() {
    RelativeContainer() {
      if (this.calendarEvent != null) {
        CalendarEventView({ calendarEvent: this.calendarEvent })
      }
    }
    .backgroundColor($r('app.color.main_background'))
  }
}