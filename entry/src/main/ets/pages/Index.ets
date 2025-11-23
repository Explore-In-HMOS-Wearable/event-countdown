import { FULL_WIDTH_PERCENT } from '../lib/constants';
import HomeView from '../views/HomeView';
import { calendarManager } from '@kit.CalendarKit';
import CalendarManager from '../models/CalendarManager';
import { AddEventPageBuilder } from './AddEventPage';
import { EventPageBuilder } from './EventPage';
import { ConstantEventPageBuilder } from './ConstantEventPage';

@Entry
@Component
struct Index {
  pathStack: NavPathStack = new NavPathStack();
  @State events: calendarManager.Event[] = []
  private calendarMgr: CalendarManager | null = null;

  loadEvents() {
    this.calendarMgr = CalendarManager.getInstance();
    this.calendarMgr.getCalendar().then((calendar) => {
      calendar?.getEvents().then((events) => {
        this.events = events;
      })
    })
  }

  @Builder
  pageMap(name: string) {
    NavDestination() {
      if (name === 'AddEventPage') {
        AddEventPageBuilder()
      } else if (name === 'EventPage') {
        EventPageBuilder();
      } else if (name === 'ConstantEventPage') {
        ConstantEventPageBuilder()
      }
    }
    .hideToolBar(true)
    .hideBackButton(true)
  }

  aboutToAppear(): void {
    AppStorage.setOrCreate('PathStack', this.pathStack);
  }

  build() {
    Navigation(this.pathStack) {
      RelativeContainer() {
        HomeView({ events: this.events })
      }
      .width(FULL_WIDTH_PERCENT)
      .height(FULL_WIDTH_PERCENT)
    }
    .navDestination(this.pageMap)
    .hideTitleBar(true)
    .onAppear(() => {
      this.loadEvents();
    })
    .onNavBarStateChange(() => {
      this.loadEvents();
    })
  }
}