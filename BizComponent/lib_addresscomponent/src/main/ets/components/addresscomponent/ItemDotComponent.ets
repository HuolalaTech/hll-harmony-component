import { CommonComponentUIBean } from './AddressComponentConstant'


/**
 * 构建item小圆点
 */
@Component
export struct ItemDotComponent {
  /**
   * UI的设置参数
   */
  @State private commonUIBean: CommonComponentUIBean = new CommonComponentUIBean()
  /**
   * 当前索引
   */
  @Prop private index: number = 0
  /**
   * 地址列表总长度
   */
  @Prop private allLength: number = 0

  /**
   * 绘制UI
   */
  build() {
    Blank()
      .width(this.commonUIBean.pointWidth)
      .height(this.commonUIBean.pointHeight)
      .margin({ left: 6 })
      .borderRadius(3.5)
      .backgroundColor(this.getIconColor())
  }

  /**
   * 获取颜色
   */
  private getIconColor(): ResourceColor {
    if (this.index == 0) {
      return this.commonUIBean.startPointColor
    } else if (this.index == this.allLength - 1) {
      return this.commonUIBean.endPointColor
    }
    return this.commonUIBean.passingPointColor
  }
}
