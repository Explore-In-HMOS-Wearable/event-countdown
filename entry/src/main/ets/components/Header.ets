import { Router } from '@kit.ArkUI';
import { Icon } from './Icon';
import { BusinessError } from '@kit.BasicServicesKit';
import { hilog } from '@kit.PerformanceAnalysisKit';

@Component
struct Header {
  context: UIContext = this.getUIContext();
  router: Router = this.context.getRouter();

  build() {
    Column() {
      Text("Events")
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
        this
          .router
          .pushUrl({ url: 'pages/AddEventPage' })
          .catch((error: BusinessError) => {
            hilog.error(0x0001, "eventCountdownApp", error.message);
          })
      })
    }.margin(0)
  }
}


@Builder
export function headerBuilder() {
  Header()
}