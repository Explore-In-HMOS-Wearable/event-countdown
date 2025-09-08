import { image } from '@kit.ImageKit';

@Component
export struct Icon {
  @Prop @Require iconSrc: image.PixelMap | ResourceStr | DrawableDescriptor;
  @Prop iconWidth: number = 30;
  @Prop iconHeight: number = 30;

  build() {
    Row() {
      Image(this.iconSrc)
        .width(this.iconWidth)
        .height(this.iconHeight)
    }
    .width(this.iconWidth)
    .height(this.iconHeight)
    .borderRadius('50%')
    .justifyContent(FlexAlign.Center)
    .alignItems(VerticalAlign.Center)
  }
}