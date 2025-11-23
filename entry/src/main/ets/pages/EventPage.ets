import CalendarEventProgressModel from '../viewmodels/CalendarEventProgressModel';
import CalendarEventView from '../views/CalendarEventView';

@Builder
export function EventPageBuilder() {
  EventPage()
}

@Component
struct EventPage {
  pathStack: NavPathStack = AppStorage.get('PathStack') as NavPathStack
  @State event: CalendarEventProgressModel | null = null;

  aboutToAppear(): void {
    this.event = this.pathStack.getParamByName('EventPage')[0] as CalendarEventProgressModel;
  }

  build() {
    RelativeContainer() {
      if (this.event != null) {
        CalendarEventView({ event: this.event })
      }
    }
    .backgroundColor($r('app.color.main_background'))
  }
}