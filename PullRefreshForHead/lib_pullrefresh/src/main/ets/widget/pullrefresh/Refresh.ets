import { RefreshState, PullRefreshConstant as Const } from './PullRefreshConstant';
import { PullRefreshModel } from './PullRefreshModel';
import { touchMoveLoadMore, touchUpLoadMore } from './LoadMore';

export function listTouchEvent(dataModel: PullRefreshModel, event: TouchEvent, getDataCallBack: (isLoadMore: boolean) => void) {
  switch (event.type) {
    case TouchType.Down:
      dataModel.downY = event.touches[0].y;
      dataModel.lastMoveY = event.touches[0].y;
      break;
    case TouchType.Move:
      console.log('TouchType.Move');
      if ((dataModel.isRefreshing === true) || (dataModel.isLoading === true)) {
        console.log('TouchType.Move dataModel.isRefreshing || dataModel.isLoading');
        return;
      }
      let isDownPull = event.touches[0].y - dataModel.lastMoveY > 0;
      if (((isDownPull === true) || (dataModel.isPullRefreshOperation === true)) && (dataModel.isCanLoadMore === false)) {
        console.log('TouchType.Move touchMovePullRefresh');
        // 下拉刷新
        touchMovePullRefresh(dataModel, event);
      } else {
        // 上拉更多
        touchMoveLoadMore(dataModel, event);
      }
      dataModel.lastMoveY = event.touches[0].y;
      break;
    case TouchType.Cancel:
      break;
    case TouchType.Up:
      console.log('TouchType.Up');
      if ((dataModel.isRefreshing === true) || (dataModel.isLoading === true)) {
        return;
      }
      if ((dataModel.isPullRefreshOperation === true)) {
        // console.log('touchUpPullRefresh');
        touchUpPullRefresh(dataModel, getDataCallBack);
      } else {
        // console.log('touchUpLoadMore');
        touchUpLoadMore(dataModel, getDataCallBack);
      }
      break;
    default:
      break;
  }
}

export function touchMovePullRefresh(dataModel: PullRefreshModel, event: TouchEvent) {
  if (dataModel.startIndex === 0) {
    dataModel.isPullRefreshOperation = true;
    let height = vp2px(dataModel.pullDownRefreshHeight);
    dataModel.offsetY = event.touches[0].y - dataModel.downY;
    // 偏移达到刷新的值.
    if (dataModel.offsetY >= height) {
      pullRefreshState(dataModel, RefreshState.Release);
      dataModel.offsetY = height + dataModel.offsetY * Const.Y_OFF_SET_COEFFICIENT;
    } else {
      pullRefreshState(dataModel, RefreshState.DropDown);
    }
    if (dataModel.offsetY < 0) {
      dataModel.offsetY = 0;
      dataModel.isPullRefreshOperation = false;
    }
  }
}

export function touchUpPullRefresh(dataModel: PullRefreshModel, getDataCallBack: (isLoadMore: boolean) => void) {
  if (dataModel.isCanRefresh === true) {
    dataModel.offsetY = vp2px(dataModel.pullDownRefreshHeight);
    pullRefreshState(dataModel, RefreshState.Refreshing);
    dataModel.currentPage = 1;
    getDataCallBack(false)
  } else {
    closeRefresh(dataModel, false);
  }
}

export function pullRefreshState(dataModel: PullRefreshModel, state: number) {
  switch (state) {
    case RefreshState.DropDown:
      dataModel.refreshLayoutConfig.textValue = $r('app.string.pull_down_refresh_text');
      dataModel.refreshLayoutConfig.imageSrc = $r('app.media.client_ic_pull_down_refresh');
      dataModel.isCanRefresh = false;
      dataModel.isRefreshing = false;
      dataModel.refreshLayoutConfig.isVisible = true;
      break;
    case RefreshState.Release:
      dataModel.refreshLayoutConfig.textValue = $r('app.string.release_refresh_text');
      dataModel.refreshLayoutConfig.imageSrc = $r('app.media.client_ic_pull_up_refresh');
      dataModel.isCanRefresh = true;
      dataModel.isRefreshing = false;
      break;
    case RefreshState.Refreshing:
      dataModel.offsetY = vp2px(dataModel.pullDownRefreshHeight);
      dataModel.refreshLayoutConfig.textValue = $r('app.string.refreshing_text');
      dataModel.refreshLayoutConfig.imageSrc = $r('app.media.client_ic_pull_up_load');
      dataModel.isCanRefresh = true;
      dataModel.isRefreshing = true;
      break;
    case RefreshState.Success:
      dataModel.refreshLayoutConfig.textValue = $r('app.string.refresh_success_text');
      dataModel.refreshLayoutConfig.imageSrc = $r('app.media.client_ic_succeed_refresh');
      dataModel.isCanRefresh = true;
      dataModel.isRefreshing = true;
      break;
    case RefreshState.Fail:
      dataModel.refreshLayoutConfig.textValue = $r('app.string.refresh_fail_text');
      dataModel.refreshLayoutConfig.imageSrc = $r('app.media.client_ic_fail_refresh');
      dataModel.isCanRefresh = true;
      dataModel.isRefreshing = true;
      break;
    default:
      break;
  }
}

export function closeRefresh(dataModel: PullRefreshModel, isRefreshSuccess: boolean) {
  let self = dataModel;
  setTimeout(() => {
    let delay = Const.RefreshConstant_DELAY_PULL_DOWN_REFRESH;
    if (self.isCanRefresh === true) {
      pullRefreshState(dataModel, isRefreshSuccess ? RefreshState.Success : RefreshState.Fail);
      delay = Const.RefreshConstant_DELAY_SHRINK_ANIMATION_TIME;
    }
    animateTo({
      duration: Const.RefreshConstant_CLOSE_PULL_DOWN_REFRESH_TIME,
      delay: delay,
      onFinish: () => {
        pullRefreshState(dataModel, RefreshState.DropDown);
        dataModel.refreshLayoutConfig.isVisible = false;
        self.isPullRefreshOperation = false;
      }
    }, () => {
      self.offsetY = 0;
    })
  }, self.isCanRefresh ? Const.DELAY_ANIMATION_DURATION : 0);
}