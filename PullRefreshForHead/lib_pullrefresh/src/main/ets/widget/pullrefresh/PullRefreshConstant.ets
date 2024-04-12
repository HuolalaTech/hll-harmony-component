export class PullRefreshConstant {

  static readonly Y_OFF_SET_COEFFICIENT: number = 0.1;


  static readonly PAGE_SIZE: number = 20;


  static readonly CUSTOM_LAYOUT_HEIGHT: number = 70;


  static readonly DELAY_ANIMATION_DURATION: number = 300;


  static readonly ANIMATION_DURATION: number = 2000;


  static readonly FULL_WIDTH: string = '100%';

  static readonly FULL_HEIGHT: string = '100%';

  static readonly RefreshLayout_MARGIN_LEFT: string = '40%';
  static readonly RefreshLayout_TEXT_MARGIN_BOTTOM: number = 1;
  static readonly RefreshLayout_TEXT_MARGIN_LEFT: number = 7;
  static readonly RefreshLayout_TEXT_FONT_SIZE: number = 17;
  static readonly RefreshLayout_IMAGE_WIDTH: number = 18;
  static readonly RefreshLayout_IMAGE_HEIGHT: number = 18;


  static readonly NoMoreLayoutConstant_NORMAL_PADDING: number = 8;
  static readonly NoMoreLayoutConstant_TITLE_FONT: string = '16fp';


  static readonly RefreshConstant_DELAY_PULL_DOWN_REFRESH: number = 50;
  static readonly RefreshConstant_CLOSE_PULL_DOWN_REFRESH_TIME: number = 150;
  static readonly RefreshConstant_DELAY_SHRINK_ANIMATION_TIME: number = 500;


  static readonly GRID_COLUMN_TEMPLATES: string = '1fr ';


  static readonly LIST_OFFSET_UNIT: string = 'px';
}


export const enum RefreshState {
  /**
   * 下拉刷新(还没达到刷新的差值)
   */
  DropDown = 0,
  /**
   * 松开刷新(已达到刷新的差值)
   */
  Release = 1,
  /**
   * 正在刷新中
   */
  Refreshing = 2,
  /**
   * 刷新成功
   */
  Success = 3,
  /**
   * 刷新失败
   */
  Fail = 4
}


export const enum PageState {
  Loading = 0,
  Success = 1,
  Fail = 2
}


export const enum ContentType {
  JSON = 'application/json'
}