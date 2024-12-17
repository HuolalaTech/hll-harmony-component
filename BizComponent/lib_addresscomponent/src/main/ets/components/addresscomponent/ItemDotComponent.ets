import { CommonComponentUIBean } from './AddressComponentConstant'

@Component
export struct ItemDotComponent {
  @Prop private index: number = 0
  @Prop private allLength: number = 0
  @State private commonUIBean: CommonComponentUIBean = new CommonComponentUIBean()

  build() {
    //icon小圆点
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
