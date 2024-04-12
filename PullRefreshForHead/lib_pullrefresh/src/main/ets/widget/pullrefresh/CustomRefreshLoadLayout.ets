import { PullRefreshConstant as Const } from './PullRefreshConstant';
import { CustomRefreshLoadLayoutConfig } from './CustomRefreshLoadLayoutConfig';

/**
 * 上拉和下拉加载UI 组件.
 */
@Component
export struct CustomRefreshLoadLayout {
  @ObjectLink config: CustomRefreshLoadLayoutConfig;

  build() {
    Row() {
      Image(this.config.imageSrc)
        .width(Const.RefreshLayout_IMAGE_WIDTH)
        .height(Const.RefreshLayout_IMAGE_HEIGHT)

      Text(this.config.textValue)
        .margin({
          left: Const.RefreshLayout_TEXT_MARGIN_LEFT,
          bottom: Const.RefreshLayout_TEXT_MARGIN_BOTTOM
        })
        .fontSize(Const.RefreshLayout_TEXT_FONT_SIZE)
        .textAlign(TextAlign.Center)
    }
    .clip(true)
    .width(Const.FULL_WIDTH)
    .justifyContent(FlexAlign.Center)
    .height(this.config.isVisible == true ? this.config.heightValue : 0)
  }
}