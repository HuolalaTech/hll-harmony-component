import { StandardAddressBeanArray } from './StandardAddressBeanArray'
import { NormalAddressList } from './NormalAddressList'
import { DragAddressList } from './DragAddressList'
import { CommonComponentUIBean } from './AddressComponentConstant'


/**
 * 地址组建
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

  /**
   * 绘制UI
   */
  build() {
    Stack() {
      // 普通地址（就两个地址的时候，没有拖动效果，只能交换）
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
      // 拖动地址
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






