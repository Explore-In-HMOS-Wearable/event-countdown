import { getYearProgress } from '../../lib/utils';
import EventProgressModel from '../../viewmodels/EventProgressModel';

@Builder
export function yearlyCardBuilder() {
  YearlyCard()
}

@Component
struct YearlyCard {
  private year = getYearProgress()
  private yearProgress: EventProgressModel =
    new EventProgressModel(
      `${this.year.year}`,
      this.year.total,
      this.year.elapsed,
    );

  build() {
    Row() {
      Stack() {
        DataPanel({
          values: [this.yearProgress.progress],
          max: this.yearProgress.maxProgress,
          type: DataPanelType.Circle,
        })
          .valueColors([this.yearProgress.color])
          .width(60)
          .height(60)
        Text(`${this.yearProgress.percentage}`)
          .fontSize(10)
      }

      Column() {
        Text(this.yearProgress.name)
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
          .textAlign(TextAlign.Start)
          .fontWeight(FontWeight.Bold)
          .fontSize(13)
        Text(`${this.yearProgress.progress}d`)
          .fontSize(10)
          .textAlign(TextAlign.Start)
        Text(`${this.yearProgress.maxProgress}d`)
          .fontSize(10)
          .textAlign(TextAlign.Start)
      }
      .justifyContent(FlexAlign.Start)
      .alignItems(HorizontalAlign.Start)
    }
  }
}