import { PullRefreshConstant as Const } from './PullRefreshConstant'

/**
 * 没有更多数据组件.
 */
@Component
export struct NoMoreLayout {
  build() {
    Row() {
      Text('没有更多数据了')
        .margin({ left: Const.NoMoreLayoutConstant_NORMAL_PADDING })
        .fontSize(Const.NoMoreLayoutConstant_TITLE_FONT)
        .textAlign(TextAlign.Center)
    }
    .width(Const.FULL_WIDTH)
    .justifyContent(FlexAlign.Center)
    .height(Const.CUSTOM_LAYOUT_HEIGHT)
  }
}