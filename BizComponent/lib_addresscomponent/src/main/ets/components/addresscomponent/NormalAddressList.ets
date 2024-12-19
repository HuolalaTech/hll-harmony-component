import { CommonComponentUIBean } from './AddressComponentConstant'
import { NormalAddressComponent } from './NormalAddressComponent'
import { StandardAddressBeanArray } from './StandardAddressBeanArray'
import { StandardOrderAddressBean } from './StandardOrderAddressBean'


/**
 * 普通地址列表
 */
@Component
export struct NormalAddressList {
  /**
   * UI设置参数
   */
  @State commonUIBean: CommonComponentUIBean = new CommonComponentUIBean()
  /**
   * 地址列表数据源
   */
  @ObjectLink addressArray: StandardAddressBeanArray
  /**
   * 监听点击地址
   *
   */
  onAddressClick?: (index: number) => void
  /**
   * 监听添加地址
   */
  onAddAddressClick?: () => void
  /**
   * 监听交换地址
   */
  onExchangeAddressClick?: () => void

  /**
   * 绘制UI
   */
  build() {
    Row() {
      Stack() {
        List() {
          ForEach(this.addressArray, (bean: StandardOrderAddressBean, index: number) => {
            ListItem() {
              NormalAddressComponent({
                address: bean,
                onAddressClick: (index: number) => {
                  this.onAddressClick?.(index)
                },
                commonUIBean: this.commonUIBean,
              })
            }
          }, (bean: StandardOrderAddressBean, index: number) => bean.uniqueStr())
        }
      }
      .alignContent(Alignment.Top)
      .layoutWeight(1)

      //交换装卸货地
      Image(this.commonUIBean.changeAddressIcon)
        .margin({ left: 8, right: 8 })
        .width(this.commonUIBean.changeIconWidth)
        .height(this.commonUIBean.changeIconHeight)
        .padding(this.commonUIBean.changeIconPadding)
        .border({
          radius: 6,
          color: '#1F000000',
          width: '2px',
        })
        .visibility(this.addressArray.length == 2 ? Visibility.Visible : Visibility.None)
        .onClick(() => {
          this.exchangeAddress(0, 1)
          this.onExchangeAddressClick?.()
        })

      //添加途经点
      Row() {
        Image(this.commonUIBean.passingAddressIcon)
          .height(10)
          .width(10)

        Text(this.commonUIBean.passingText)
          .fontSize(11)
          .margin({ left: 2 })
          .fontColor(0xD9000000)
      }
      .height(23)
      .visibility(this.addressArray.length == 2 ? Visibility.Visible : Visibility.None)
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
      .padding({ left: 8, right: 8, })
      .onClick(() => {
        this.onAddAddressClick?.()
      })
    }
    .padding({
      left: 6,
      right: 12,
      top: 6,
      bottom: 6
    })
    .margin({
      left: 12,
      right: 12,
      top: 12,
      bottom: 0
    })
    .borderRadius(12)
    .backgroundColor("#F6F9FB")
    .borderWidth(1)
    .borderColor('#FFFFFF')
    .alignItems(VerticalAlign.Center)
    .visibility(this.addressArray.length <= 2 ? Visibility.Visible : Visibility.None)
  }

  /**
   * 交换两个地址数据
   * @param index
   * @param newIndex
   */
  private exchangeAddress(index: number, newIndex: number): void {
    console.log("itemMoveTest before index =  " + index + " , newIndex = " + newIndex)
    let tmp = this.addressArray.splice(index, 1)
    this.addressArray.splice(newIndex, 0, tmp[0])
    this.addressArray.forEach((bean: StandardOrderAddressBean, index: number) => {
      bean.index = index;
    })
  }
}