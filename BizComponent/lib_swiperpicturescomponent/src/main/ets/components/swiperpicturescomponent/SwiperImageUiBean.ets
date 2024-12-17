

/**车型展示图片对象*/
@Observed
export class SwiperImageUiBean {
  /**车型id*/
  swiperId: number = 0
  /**车型图片*/
  imageUrl?: string|Resource
}


@Observed
export class SwiperImageArray extends Array<SwiperImageUiBean> {

}




export class SwiperStdItem {
  type: number = 0
  name: string = ""
  value_fen: number = 0
  std_detail: string = ""
  is_checked: number = 0
  img: string = ""
  short_name: string = ""

  /**
   * 优先使用short_name，没有使用 name
   */
  customShortName: string = ""

  /**
   * 是否是接口默认选中
   */
  isApiChecked: boolean = false

  /**
   * 冷运温控图，冷运专属参数
   */
  refrigerated_img?: string[]
  /**
   * 对应冷运车型的国标id
   */
  jump_id: number = 0
}


/**改变车型的来源*/
export enum SelSwiperTabSource {
  /**上一个车型*/
  SOURCE_PRE_ARROW_CLICK,
  /**下一个车型*/
  SOURCE_NEXT_ARROW_CLICK,
  /**点击车型名称*/
  SOURCE_TAB_CLICK,
  /**代码触发*/
  SOURCE_TAB_CODE,
  /**滑动车型动画viewpager触发*/
  SOURCE_TAB_VIEW_PAGER,
}
