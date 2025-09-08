import AddEventView from '../views/AddEventView';

@Entry
@Component
struct AddEventPage {
  @State message: string = 'Hello World';

  build() {
    RelativeContainer() {
      AddEventView()
    }
    .width('100%')
    .height('100%')
    .backgroundColor($r('app.color.main_background'))
  }
}