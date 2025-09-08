import HomeView from '../views/HomeView';

@Entry
@Component
struct Index {
  build() {
    RelativeContainer() {
      HomeView()
    }
    .width('100%')
    .height('100%')
    .backgroundColor($r('app.color.main_background'))
  }
}