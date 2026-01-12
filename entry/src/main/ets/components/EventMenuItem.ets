import { ArcListItem } from '@kit.ArkUI';
import EventProgressModel from '../viewmodels/EventProgressModel';
import { EIGHTY_FIVE_PERCENT } from '../lib/constants';

@Component
export default struct EventMenuItem {
  @Prop event: EventProgressModel;
  pathStack: NavPathStack = AppStorage.get('PathStack') as NavPathStack;

  build() {
    ArcListItem() {
      Row() {
        DataPanel({
          values: [this.event.progress],
          max: this.event.maxProgress,
          type: DataPanelType.Circle
        })
          .valueColors([this.event.color])
          .width('65vp')
          .height('65vp')
        Column() {
          Text(this.event.name)
            .maxLines(2)
            .textOverflow({ overflow: TextOverflow.Ellipsis })
            .textAlign(TextAlign.Start)
            .fontWeight(FontWeight.Bold)
            .fontSize(12)
          Row() {
            Text(`${this.event.progress} ${this.event.unit} / ${this.event.maxProgress}`)
              .fontSize(10)
              .textAlign(TextAlign.Start)
            Blank(3)
            Text(`${this.event.percentage}`)
              .fontSize(22)
              .fontWeight(FontWeight.Bold)
              .textAlign(TextAlign.Start)
            Text('%')
              .fontSize(15)
              .opacity(0.6)
              .alignSelf(ItemAlign.Baseline)
          }
          .justifyContent(FlexAlign.SpaceBetween)
        }
        .justifyContent(FlexAlign.Start)
        .alignItems(HorizontalAlign.Start)

      }
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
      .onClick(() => {
        this.pathStack.pushPathByName('ConstantEventPage', this.event);
      })
    }
  }
}