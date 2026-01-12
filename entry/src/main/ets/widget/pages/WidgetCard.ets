import { monthlyCardBuilder } from '../components/MonthlyCard';
import { yearlyCardBuilder } from '../components/YearlyCard';

@Entry
@Component
struct WidgetCard {
  /*
   * The action type.
   */
  readonly actionType: string = 'router';
  /*
   * The ability name.
   */
  readonly abilityName: string = 'EntryAbility';
  /*
   * The width percentage setting.
   */
  readonly fullWidthPercent: string = '100%';
  /*
   * The height percentage setting.
   */
  readonly fullHeightPercent: string = '100%';

  build() {
    Column() {
      yearlyCardBuilder()
      monthlyCardBuilder()
    }
    .justifyContent(FlexAlign.Start)
    .alignItems(HorizontalAlign.Start)
    .width(this.fullWidthPercent)
    .height(this.fullHeightPercent)
    .backgroundColor($r('app.color.card_list_background'))
    .onClick(() => {
      postCardAction(this, {
        action: this.actionType,
        abilityName: this.abilityName
      });
    })
  }
}