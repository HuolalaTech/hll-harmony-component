import { CommonComponentUIBean } from './AddressComponentConstant'
import { ItemDotComponent } from './ItemDotComponent'
import { ItemInfoComponent } from './ItemInfoComponent'
import { StandardOrderAddressBean } from './StandardOrderAddressBean'

@Component
export struct NormalAddressComponent {
  //地址信息
  @ObjectLink address: StandardOrderAddressBean
  @State commonUIBean: CommonComponentUIBean = new CommonComponentUIBean()
  @Prop private allLength: number = 2
  onAddressClick?: (index: number) => void

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