import { CommonComponentUIBean } from './AddressComponentConstant'
import { ItemDotComponent } from './ItemDotComponent'
import { ItemInfoComponent } from './ItemInfoComponent'
import { StandardOrderAddressBean } from './StandardOrderAddressBean'


/**
 * 普通地址列表item
 */
@Component
export struct NormalAddressComponent {
  /**
   * UI设置参数
   */
  @State commonUIBean: CommonComponentUIBean = new CommonComponentUIBean()
  /**
   * 地址信息
   */
  @ObjectLink address: StandardOrderAddressBean
  /**
   * 地址列表总长度
   */
  @Prop private allLength: number = 2

  /**
   * 监听点击地址
   */
  onAddressClick?: (index: number) => void


  /**
   * 绘制UI
   */
  build() {
    Row() {
      //icon小圆点
      ItemDotComponent({ index: this.address.index, allLength: this.allLength, commonUIBean: this.commonUIBean })

      //地址名称和联系电话
      ItemInfoComponent({ address: this.address, commonUIBean: this.commonUIBean })
    }
    .onClick(() => {
      this.onAddressClick?.(this.address.index)
    })
    .height(this.address.viewHeight)
  }
}