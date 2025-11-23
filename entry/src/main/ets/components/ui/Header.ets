import { Icon } from './Icon';

@Component
  // eslint-disable-next-line @performance/avoid-overusing-custom-component-check
struct Header {
  pathStack: NavPathStack = AppStorage.get('PathStack') as NavPathStack

  build() {
    Column() {
      Text('Events')
        .fontSize('45px')
        .fontWeight(FontWeight.Bold)
      Row() {
        Icon({ iconSrc: $r('app.media.plus_icon') })
          .margin({ right: 5 })
        Text('Add Event')
          .fontSize(16)
      }
      .justifyContent(FlexAlign.SpaceEvenly)
      .margin({ top: 10, bottom: 10 })
      .onClick(() => {
        this.pathStack.pushPath({ name: 'AddEventPage' })
      })
    }.margin(0)
  }
}


@Builder
export function headerBuilder() {
  Header()
}