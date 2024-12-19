export class AddressComponentConstant {
  /**单行地址高度*/
  static readonly SINGLE_HEIGHT: number = 32
  /**多行地址高度*/
  static readonly TWO_HEIGHT: number = 39
  /**高度平均值*/
  static readonly HEIGHT_AVERAGE: number = 35
}


/**
 * 地址列表UI的元素
 */
@Observed
export class CommonComponentUIBean {
  /**
   *交换地址的icon
   */
  changeAddressIcon: Resource = $r('app.media.base_ic_exchange_address_vertical')
  /**
   * 交换地址的宽度
   */
  changeIconWidth?: number | string = 23
  /**
   * 交换地址的高度
   */
  changeIconHeight?: number | string = 23
  /**
   * 交换地址的padding
   */
  changeIconPadding?: number | string = 6.5
  /**
   *起点的颜色
   */
  startPointColor: ResourceColor = 0x000000
  /**
   * 途经点的颜色
   */
  passingPointColor: ResourceColor = 0x40000000
  /**
   * 终点的颜色
   */
  endPointColor: ResourceColor = 0xFFFF6600
  /**
   *途经点的icon
   */
  passingAddressIcon: Resource = $r('app.media.base_ic_add_black_11')
  /**
   * 途经点文案
   */
  passingText: string = "途经点"
  /**
   * 圆点宽度
   */
  pointWidth?: number | string = 7
  /**
   * 圆点高度
   */
  pointHeight?: number | string = 7
  /**
   *地址名的颜色
   */
  nameColor: ResourceColor = 0xB3000000
  /**
   * 地址名字体大小
   */
  nameFontSize?: number | string | Resource = 14
  /**
   * 地址名最多显示几行
   */
  nameMaxLines: number = 1
  /**
   * 地址名右箭头的icon
   */
  nameImageIcon: Resource = $r('app.media.base_ic_standard_address_arrow')
  /**
   *  地址名右箭头的宽度
   */
  nameImageIconWidth?: number | string = 12
  /**
   *  地址名右箭头的高度
   */
  nameImageIconHeight?: number | string = 12
  /**
   *电话的颜色
   */
  phoneColor: ResourceColor = 0x73000000
  /**
   *电话字体大小
   */
  phoneFontSize?: number | string | Resource = 12
  /**
   *拖动文案
   */
  dragText?: string = "拖动"
  /**
   * 拖动的icon
   */
  dragImageIcon: Resource = $r('app.media.base_ic_drag_address')
  /**
   * 删除的icon
   */
  deleteImageIcon: Resource = $r('app.media.base_ic_close_drag_address_14')
}