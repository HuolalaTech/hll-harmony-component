import { PullRefreshModel } from './PullRefreshModel';
import { PullRefreshConstant as Const } from './PullRefreshConstant';

export function touchMoveLoadMore(dataModel: PullRefreshModel, event: TouchEvent) {
  console.log('function touchMoveLoadMore');
  if (dataModel.endIndex >= dataModel.dataSize - 1) {
    dataModel.offsetY = event.touches[0].y - dataModel.downY;
    if (Math.abs(dataModel.offsetY) > vp2px(dataModel.pullUpLoadHeight) / 2) {
      dataModel.isCanLoadMore = true;
      dataModel.loadMoreLayoutConfig.isVisible = true;
      dataModel.offsetY = -vp2px(dataModel.pullUpLoadHeight) + dataModel.offsetY * Const.Y_OFF_SET_COEFFICIENT;
    }
  }
}

export function touchUpLoadMore(dataModel: PullRefreshModel, getDataCallBack: (isLoadMore: boolean) => void) {
  let self: PullRefreshModel = dataModel;
  animateTo({
    duration: Const.ANIMATION_DURATION,
  }, () => {
    self.offsetY = 0;
  })
  console.log('function touchUpLoadMore');
  console.log(`isCanLoadMore:${self.isCanLoadMore}`);
  console.log(`hasMore:${self.hasMore}`);
  // isCanLoadMore 为 true 表示当前已经到第一页最后一条数据并且手势上滑到了阈值
  // hasMore 为 true 表示数据还有下一页，默认是 true
  if ((self.isCanLoadMore === true) && (self.hasMore === true)) {
    self.isLoading = true;
    getDataCallBack(true)
  } else {
    closeLoadMore(self);
  }
}

export function closeLoadMore(dataModel: PullRefreshModel) {
  dataModel.isCanLoadMore = false;
  dataModel.isLoading = false;
  dataModel.loadMoreLayoutConfig.isVisible = false;
}