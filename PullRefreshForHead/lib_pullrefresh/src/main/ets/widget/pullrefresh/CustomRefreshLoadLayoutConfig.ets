import { PullRefreshConstant } from './PullRefreshConstant';

@Observed
export class CustomRefreshLoadLayoutConfig {
  /**
   * 刷新组件是否可见.
   */
  isVisible: boolean;

  /**
   * 刷新组件图片.
   */
  imageSrc: Resource;

  /**
   * 刷新组件文字.
   */
  textValue: Resource;

  /**
   * 刷新组件高度值.
   */
  heightValue: number;

  constructor(isLoadMore: boolean) {
    if (isLoadMore) {
      this.textValue = $r('app.string.pull_up_load_text')
      this.imageSrc = $r('app.media.client_ic_pull_up_load')
      this.isVisible = false
      this.heightValue = PullRefreshConstant.CUSTOM_LAYOUT_HEIGHT
    } else {
      this.textValue = $r('app.string.pull_down_refresh_text')
      this.imageSrc = $r('app.media.client_ic_pull_down_refresh')
      this.isVisible = false
      this.heightValue = PullRefreshConstant.CUSTOM_LAYOUT_HEIGHT
    }
  }
}