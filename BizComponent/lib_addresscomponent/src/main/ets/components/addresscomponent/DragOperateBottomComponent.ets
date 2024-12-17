import { CommonComponentUIBean } from './AddressComponentConstant'

@Component
export struct DragOperateBottomComponent {
  onAddAddressClick?: () => void
  @State private commonUIBean: CommonComponentUIBean = new CommonComponentUIBean()

  build() {
    Row() {
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
      .margin({ left: 12 })
      .padding({ left: 8, right: 8, })
      .onClick(() => {
        this.onAddAddressClick?.()
      })
    }.height(40)
  }
}