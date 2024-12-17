import { StandardAddressBeanArray } from './StandardAddressBeanArray'
import { NormalAddressList } from './NormalAddressList'
import { DragAddressList } from './DragAddressList'
import { CommonComponentUIBean } from './AddressComponentConstant'


/**
 * 标准下单 地址
 */
@Component
export struct AddressComponent {
  /**
   * 数据源
   */
  @ObjectLink addressArray: StandardAddressBeanArray
  /**
   * 一般UI元素
   */
  @State commonUIBean: CommonComponentUIBean = new CommonComponentUIBean()

  /**
   * 点击地址
   */
  onAddressClick?: (index: number) => void
  /**
   * 起始地址和目的地交换
   */
  onExchangeAddressClick?: () => void
  /**
   * 添加途经点
   */
  onAddAddressClick?: () => void
  /**
   * 拖动地址
   * @param oldIndex
   * @param newIndex
   */
  onDragAddress?: (oldIndex: number, newIndex: number) => void
  /**
   * 删除地址
   * @param index
   */
  onDelAddressClick?: (index: number) => void

  build() {
    Stack() {
      NormalAddressList({
        addressArray: this.addressArray,
        commonUIBean: this.commonUIBean,
        onAddressClick: (index: number) => {
          this.onAddressClick?.(index)
        },
        onExchangeAddressClick: () => {
          this.onExchangeAddressClick?.()
        },
        onAddAddressClick: () => {
          this.onAddAddressClick?.()
        }
      })
      DragAddressList({
        addressArray: this.addressArray,
        commonUIBean: this.commonUIBean,
        onAddressClick: (index: number) => {
          this.onAddressClick?.(index)
        },
        onDragAddress: (oldIndex: number, newIndex: number) => {
          this.onDragAddress?.(oldIndex, newIndex)
        },
        onDelAddressClick: (index: number) => {
          this.onDelAddressClick?.(index)
        },
        onAddAddressClick: () => {
          this.onAddAddressClick?.()
        }
      })
    }
  }
}






