import EventProgressModel from '../viewmodels/EventProgressModel';
import EventView from '../views/EventView';

@Builder
export function ConstantEventPageBuilder() {
  EventPage()
}

@Component
struct EventPage {
  pathStack: NavPathStack = AppStorage.get('PathStack') as NavPathStack
  @State event: EventProgressModel | null = null

  aboutToAppear(): void {
    this.event = this.pathStack.getParamByName('ConstantEventPage')[0] as EventProgressModel;
  }

  build() {
    RelativeContainer() {
      if (this.event != null) {
        EventView({ event: this.event })
      }
    }
    .backgroundColor($r('app.color.main_background'))
  }
}