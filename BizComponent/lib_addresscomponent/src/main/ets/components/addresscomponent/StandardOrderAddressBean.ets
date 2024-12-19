import { util } from '@kit.ArkTS'
import { AddressComponentConstant } from './AddressComponentConstant'

/**
 * 地址信息对象
 */
@Observed
export class StandardOrderAddressBean {
  /**
   * 地址id
   */
  id: string = ""
  /**
   * 索引
   */
  index: number = 0
  /**
   * 名称
   */
  name: string = ''
  /**
   * 电话
   */
  phone: string
  /**
   * 是否是空地址，后面需求会用
   */
  isHint: boolean = false
  /**
   * 布局高度
   */
  viewHeight: number = 0

  constructor(index: number, name: string, phone: string) {
    this.id = util.generateRandomUUID()
    this.index = index;
    this.name = name;
    this.phone = phone;
    this.viewHeight = this.phone ? AddressComponentConstant.TWO_HEIGHT : AddressComponentConstant.SINGLE_HEIGHT
  }

  /**
   * 获取地址标识
   * @returns
   */
  uniqueStr(): string {
    //可能有两个相同地址，叠加一个id来区分
    return this.id + this.name + this.phone;
  }

  /**
   * 获取地址在数组中的索引
   * @param addressArray
   * @param item
   * @returns
   */
  static indexOf(addressArray: StandardOrderAddressBean[], item: StandardOrderAddressBean | undefined): number {
    let index = -1
    if (!item) {
      return index
    }
    addressArray.forEach((bean: StandardOrderAddressBean, i: number) => {
      if (bean.uniqueStr() === item.uniqueStr()) {
        index = i
      }
    })
    return index
  }
}
