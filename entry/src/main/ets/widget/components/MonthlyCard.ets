import { EventType } from '../../lib/constants';
import { getMonthProgress } from '../../lib/utils';
import EventProgressModel from '../../viewmodels/EventProgressModel';

@Builder
export function monthlyCardBuilder() {
  MonthlyCard()
}

@Component
struct MonthlyCard {
  private month = getMonthProgress();
  private monthProgress: EventProgressModel = new EventProgressModel(
    this.month.month,
    this.month.total,
    this.month.elapsed,
    Color.Orange,
    EventType.Monthly,
  );

  build() {
    Column() {
      Row() {
        Stack() {
          DataPanel({
            values: [this.monthProgress.progress],
            max: this.monthProgress.maxProgress,
            type: DataPanelType.Circle,
          })
            .valueColors([this.monthProgress.color])
            .width(60)
            .height(60)
          Text(`${this.monthProgress.percentage}`)
            .fontSize(10)
        }

        Column() {
          Text(this.monthProgress.name)
            .maxLines(1)
            .textOverflow({ overflow: TextOverflow.Ellipsis })
            .textAlign(TextAlign.Start)
            .fontWeight(FontWeight.Bold)
            .fontSize(13)
          Text(`${this.monthProgress.progress}d / ${this.monthProgress.maxProgress}d`)
            .fontSize(10)
            .textAlign(TextAlign.Start)
        }
        .justifyContent(FlexAlign.Start)
        .alignItems(HorizontalAlign.Start)
      }
    }
  }
}