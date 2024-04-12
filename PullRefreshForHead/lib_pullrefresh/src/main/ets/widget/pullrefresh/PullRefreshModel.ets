import { CustomRefreshLoadLayoutConfig } from './CustomRefreshLoadLayoutConfig';
import { PullRefreshConstant as Const, PageState } from './PullRefreshConstant';

@Observed
export class PullRefreshModel {
  dataSize: number = 0;
  currentPage: number = 1;
  pageSize: number = Const.PAGE_SIZE;
  pullDownRefreshHeight: number = Const.CUSTOM_LAYOUT_HEIGHT;
  pullUpLoadHeight: number = Const.CUSTOM_LAYOUT_HEIGHT;
  offsetY: number = 0;
  pageState: number = PageState.Success;
  hasMore: boolean = true;
  startIndex: number = 0;
  endIndex: number = 0;
  downY: number = 0;
  lastMoveY: number = 0;
  isRefreshing: boolean = false;
  isCanRefresh: boolean = false;
  isPullRefreshOperation: boolean = false;
  isLoading: boolean = false;
  isCanLoadMore: boolean = false;
  refreshLayoutConfig: CustomRefreshLoadLayoutConfig = new CustomRefreshLoadLayoutConfig(false)
  loadMoreLayoutConfig: CustomRefreshLoadLayoutConfig = new CustomRefreshLoadLayoutConfig(true)
}