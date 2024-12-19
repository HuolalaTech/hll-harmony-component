import { CommonComponentUIBean } from './AddressComponentConstant'


/**
 * 拖动地址列表下面的操作按钮组建（目前只有增加地址按钮）
 */
@Component
export struct DragOperateBottomComponent {
  /**
   * 设置地址列表UI
   */
  @State private commonUIBean: CommonComponentUIBean = new CommonComponentUIBean()
  /**
   * 监听添加地址
   */
  onAddAddressClick?: () => void

  /**
   * 绘制UI
   */
  build() {
      Row() {
        Image(this.commonUIBean.passingAddressIcon)
          .height(10)
          .width(10)

        Text(this.commonUIBean.passingText)
          .fontSize(11)
          .margin({ left: 2 })
          .fontColor(0xD9000000)
      }
      .height(24)
      .border({
        radius: 6,
        color: '#1F000000',
        width: '2px',
      })
      .stateStyles({
        pressed: {
          .backgroundColor(0x0D000000)
        },
        normal: {
          .backgroundColor(Color.Transparent)
        }
      })
      .margin({ top: 8,bottom: 8})
      .padding({ left: 8, right: 8, })
      .onClick(() => {
        this.onAddAddressClick?.()
      })
  }
}