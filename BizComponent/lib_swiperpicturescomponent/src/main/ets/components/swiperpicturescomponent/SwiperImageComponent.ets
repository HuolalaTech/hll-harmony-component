import { DisplayUtil } from '../../utils/DisplayUtil'
import { SwiperComponentUIBean } from './SwiperComponentUIBean'
import { SelSwiperTabSource, SwiperImageArray, SwiperImageUiBean } from './SwiperImageUiBean'

const PreOrNextMargin = 52
const VEHICLE_IMG_WIDTH = 202
const VEHICLE_IMG_HEIGHT = 121

/**
 * 滚动图片组件
 */
@Component
export struct SwiperImageComponent {
  /**
   * 轮播图UI数据
   */
  @State swiperUIBean: SwiperComponentUIBean = new SwiperComponentUIBean()
  /**
   * 图片数据源
   */
  @ObjectLink vehicleImageArray: SwiperImageArray
  /**
   * 当前图片下标
   */
  @Prop @Watch('onCurrentIndexChange') currentVehicleIndex: number
  /**
   * 透明度
   */
  @State opacityList: number[] = []
  /**
   * 缩放
   */
  @State scaleList: number[] = []
  /**
   *左边距
   */
  @State leftMarginList: number[] = []
  /**
   * 监听点击图片
   */
  onImageClick?: (imageBean: SwiperImageUiBean) => void
  /**
   * 滑动或者上下翻页改变图片下标
   */
  private indexChangeAction?: (source: SelSwiperTabSource, index: number) => void
  /**
   * 滚动控制器
   */
  private swiperController: SwiperController = new SwiperController()
  /**
   * 操作图片的下标
   */
  private imageIndex: number = 0
  /**
   * 改变图片的来源
   */
  private source: SelSwiperTabSource = SelSwiperTabSource.SOURCE_TAB_VIEW_PAGER
  /**
   * 最低透明度
   */
  private MIN_ALPHA: number = 0.4
  /**
   * 最小缩放比
   */
  private MIN_SCALE: number = 0.6
  /**
   * 最大放比
   */
  private MAX_SCALE: number = 1
  /**
   *  最大透明度
   */
  private MAX_OPACITY: number = 1
  /**
   * 最小透明度
   */
  private MIN_OPACITY: number = 0

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      Swiper(this.swiperController) {
        ForEach(this.vehicleImageArray, (imageBean: SwiperImageUiBean, vehicleIndex: number) => {
          Stack() {
            Image(imageBean.imageUrl)
              .objectFit(ImageFit.Contain)
              .alt(this.swiperUIBean.altImage)
              .onClick(() => {
                this.onImageClick?.(imageBean)
              })
              .height("100%")
              .scale({ x: this.getSingleScale(vehicleIndex), y: this.getSingleScale(vehicleIndex) })
              .margin({ left: this.getLeftMargin(vehicleIndex) })
          }
          .width("100%")
          .height("100%")
          .alignContent(Alignment.Bottom)
          .opacity(this.getImageOpacity(vehicleIndex))
        }, (uiItem: SwiperImageUiBean, index: number) => uiItem.swiperId + "")
      }
      .width("100%")
      .height("100%")
      .autoPlay(false)
      .indicator(false)
      .loop(false)
      .index(0)
      .displayCount(1)
      .prevMargin(PreOrNextMargin)
      .nextMargin(PreOrNextMargin)
      .displayMode(SwiperDisplayMode.STRETCH)
      .onChange((index: number) => {
        this.indexChangeAction?.(this.source, index)
        this.source = SelSwiperTabSource.SOURCE_TAB_VIEW_PAGER
        this.imageIndex = index
      })
      .customContentTransition({
        timeout: 1000, transition: (proxy: SwiperContentTransitionProxy) => {
          let position = proxy.position
          let index = proxy.index
          console.error(index + " position = " + position)
          this.setOpacity(index, position)
          this.setScale(index, position)
          this.setLeftMargin(index, position)
        }
      })

      // 上一页
      Text()
        .width(PreOrNextMargin)
        .height("100%")
        .onClick(() => {
          this.source = SelSwiperTabSource.SOURCE_PRE_ARROW_CLICK
          this.swiperController.showPrevious()
        })

      //下一页
      Text()
        .width(PreOrNextMargin)
        .height("100%")
        .position({ right: 0 })
        .onClick(() => {
          this.source = SelSwiperTabSource.SOURCE_NEXT_ARROW_CLICK
          this.swiperController.showNext()
        })
    }
    .width("100%")
    .height(VEHICLE_IMG_HEIGHT)
  }

  onDidBuild(): void {
    setTimeout(() => {
      if (this.currentVehicleIndex != this.imageIndex) {
        this.swiperController.changeIndex(this.currentVehicleIndex, false)
        this.imageIndex = this.currentVehicleIndex
      }
    }, 50)
  }

  /**
   * 获取透明度
   * @param index
   * @returns
   */
  private getOpacity(index: number): number {
    if (this.opacityList.length <= index) {
      if (this.currentVehicleIndex == index) {
        return this.MAX_OPACITY
      } else {
        return this.MIN_OPACITY
      }
    }
    let opacity = this.opacityList[index]
    if (opacity < this.MIN_OPACITY) {
      opacity = this.MIN_OPACITY
    }
    if (opacity > this.MAX_OPACITY) {
      opacity = this.MAX_OPACITY
    }
    return opacity
  }

  /**
   * 获取图片透明度
   * @param index
   * @returns
   */
  private getImageOpacity(index: number): number {
    let opacity = this.getOpacity(index)
    if (opacity < this.MIN_ALPHA) {
      opacity = this.MIN_ALPHA
    }
    if (opacity > this.MAX_OPACITY) {
      opacity = this.MAX_OPACITY
    }
    return opacity
  }

  /**
   * 设置透明度
   * @param index
   * @param position
   */
  private setOpacity(index: number, position: number) {
    if (this.vehicleImageArray.length != this.opacityList.length) {
      this.opacityList.splice(0, this.opacityList.length)
      this.vehicleImageArray.forEach(() => {
        this.opacityList.push(this.MIN_ALPHA)
      })
    }
    let opacity = 1 - Math.abs(position)
    this.opacityList[index] = opacity
  }

  /**
   * 获取单个图片透明度
   * @param index
   * @returns
   */
  private getScale(index: number): number {
    if (this.scaleList.length <= index) {
      if (this.currentVehicleIndex == index) {
        return this.MAX_SCALE
      } else {
        return this.MIN_SCALE
      }
    }
    return this.scaleList[index]
  }

  /**
   * 获取单个图片缩放
   * @param index
   * @returns
   */
  private getSingleScale(index: number): number {
    let scale = this.getScale(index)
    if (scale < this.MIN_SCALE) {
      scale = this.MIN_SCALE
    }
    if (scale > this.MAX_SCALE) {
      scale = this.MAX_SCALE
    }
    return scale
  }

  /**
   * 设置缩放
   * @param index
   * @param position
   */
  private setScale(index: number, position: number) {
    if (this.vehicleImageArray.length != this.scaleList.length) {
      this.scaleList.splice(0, this.scaleList.length)
      this.vehicleImageArray.forEach(() => {
        this.scaleList.push(this.MIN_SCALE)
      })
    }
    this.scaleList[index] = 1 - Math.abs(position)
  }

  /**
   * 获取左边距
   * @param index
   * @returns
   */
  private getLeftMargin(index: number): number {
    if (this.leftMarginList.length <= index) {
      if (this.currentVehicleIndex == index) {
        return 0
      } else if (index < this.currentVehicleIndex) {
        //屏幕宽度-左右各52边距-图片宽度202剩下的为可以移动的距离
        let maxMargin =
          DisplayUtil.screenWidthVp() - PreOrNextMargin - PreOrNextMargin - (VEHICLE_IMG_WIDTH * this.MIN_SCALE)
        return maxMargin
      } else if (index > this.currentVehicleIndex) {
        //屏幕宽度-左右各52边距-图片宽度202剩下的为可以移动的距离
        let maxMargin =
          DisplayUtil.screenWidthVp() - PreOrNextMargin - PreOrNextMargin - (VEHICLE_IMG_WIDTH * this.MIN_SCALE)
        return -maxMargin
      }
    }
    return this.leftMarginList[index]
  }

  /**
   * 设置左边距
   * @param index
   * @param position
   */
  private setLeftMargin(index: number, position: number) {
    if (this.vehicleImageArray.length != this.leftMarginList.length) {
      this.leftMarginList.splice(0, this.leftMarginList.length)
      this.vehicleImageArray.forEach(() => {
        this.leftMarginList.push(0)
      })
    }
    //屏幕宽度-左右各52边距-图片宽度202剩下的为可以移动的距离
    let maxMargin =
      DisplayUtil.screenWidthVp() - PreOrNextMargin - PreOrNextMargin - (VEHICLE_IMG_WIDTH * this.MIN_SCALE)
    let margin = -(position * maxMargin)
    if (margin < -maxMargin) {
      margin = -maxMargin
    }
    if (margin > maxMargin) {
      margin = maxMargin
    }
    this.leftMarginList[index] = margin
  }

  /**
   * 监控图片下标改变数据变化
   */
  private onCurrentIndexChange() {
    if (this.currentVehicleIndex != this.imageIndex) {
      this.swiperController.changeIndex(this.currentVehicleIndex, true)
      this.imageIndex = this.currentVehicleIndex
    }
  }
}

