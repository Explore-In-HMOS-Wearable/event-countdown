import { FULL_HEIGHT_PERCENT, FULL_WIDTH_PERCENT } from '../lib/constants';
import AddEventView from '../views/AddEventView';

@Builder
export function AddEventPageBuilder() {
  AddEventPage()
}

@Component
struct AddEventPage {
  build() {
    RelativeContainer() {
      AddEventView()
    }
    .width(FULL_WIDTH_PERCENT)
    .height(FULL_HEIGHT_PERCENT)
    .backgroundColor($r('app.color.main_background'))
  }
}