

/**
 * 图片信息
 */
@Observed
export class SwiperImageUiBean {
  /**图片id*/
  swiperId: number = 0
  /**图片图片*/
  imageUrl?: string|Resource
}

/**
 * 图片列表
 */
@Observed
export class SwiperImageArray extends Array<SwiperImageUiBean> {

}



/**改变图片的来源*/
export enum SelSwiperTabSource {
  /**上一个图片*/
  SOURCE_PRE_ARROW_CLICK,
  /**下一个图片*/
  SOURCE_NEXT_ARROW_CLICK,
  /**点击图片名称*/
  SOURCE_TAB_CLICK,
  /**代码触发*/
  SOURCE_TAB_CODE,
  /**滑动图片动画viewpager触发*/
  SOURCE_TAB_VIEW_PAGER,
}
