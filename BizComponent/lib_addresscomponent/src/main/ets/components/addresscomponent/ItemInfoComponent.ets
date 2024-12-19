import { CommonComponentUIBean } from './AddressComponentConstant'
import { StandardOrderAddressBean } from './StandardOrderAddressBean'


/**
 * 构建地址信息item
 */
@Component
export struct ItemInfoComponent {
  /**
   * UI的设置参数
   */
  @State private commonUIBean: CommonComponentUIBean = new CommonComponentUIBean()
  /**
   * 地址信息
   */
  @ObjectLink address: StandardOrderAddressBean

  /**
   * 绘制UI
   */
  build() {
    Column() {
      RelativeContainer() {
        //名称
        Text(this.address.name)
          .id('standard_order_address_name')
          .fontColor(this.commonUIBean.nameColor)
          .fontSize(this.commonUIBean.nameFontSize)
          .maxLines(this.commonUIBean.nameMaxLines)
          .padding({ right: 14 })
          .fontWeight(FontWeight.Medium)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
          .alignRules({
            left: { anchor: '__container__', align: HorizontalAlign.Start },
          })
        //右箭头
        Image(this.commonUIBean.nameImageIcon)
          .id('standard_order_address_arrow')
          .width(this.commonUIBean.nameImageIconWidth)
          .height(this.commonUIBean.nameImageIconHeight)
          .alignRules({
            right: { anchor: 'standard_order_address_name', align: HorizontalAlign.End },
            top: { anchor: 'standard_order_address_name', align: VerticalAlign.Top },
            bottom: { anchor: 'standard_order_address_name', align: VerticalAlign.Bottom },
          })
      }
      .height('auto')

      //联系电话
      Text(this.address.phone ?? '')
        .fontColor(this.commonUIBean.phoneColor)
        .fontSize(this.commonUIBean.phoneFontSize)
        .visibility(this.address.phone ? Visibility.Visible : Visibility.None)
        .margin({ top: 2 })
    }
    .margin({ left: 8 })
    .layoutWeight(1)
    .height("100%")
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Start)
  }
}