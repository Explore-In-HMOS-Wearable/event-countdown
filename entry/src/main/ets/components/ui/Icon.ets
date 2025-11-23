import { image } from '@kit.ImageKit';
import { FIFTY_PERCENT } from '../../lib/constants';

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
    .borderRadius(FIFTY_PERCENT)
    .justifyContent(FlexAlign.Center)
    .alignItems(VerticalAlign.Center)
  }
}