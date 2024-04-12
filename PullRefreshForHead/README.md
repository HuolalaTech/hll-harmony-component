## 简介
PullToRefreshForHead是鸿蒙下可同时实现动态分组列表进行下拉刷新、上拉加载的组件
### 效果展示：
![img.png](screenshot.gif)
## 下载安装
```
ohpm install @ohos/pulltorefreshForHead
```
## 使用说明
```ets
@State data: GroupData[] = [];
@State headTitle: GroupData = new GroupData()
@State showFakeHead: boolean = true
// 需绑定列表或宫格组件
private scroller: Scroller = new Scroller();
@State private dataModel: PullRefreshModel = new PullRefreshModel()
private itemDataGroupNew: GroupData[] = [....]// 假数据省略

@Builder
private getListView() {
    // 列表首条 Item，下拉刷新组件
    RefreshLayout({
      refreshLayoutClass: new CustomRefreshLoadLayoutClass(this.dataModel.isVisiblePullDown, this.dataModel.pullDownRefreshImage,
    this.dataModel.pullDownRefreshText, this.dataModel.pullDownRefreshHeight)
    })

   // 1. 假的占位 head 头
  Row() {
    this.itemHead()
  }
  .visibility(this.showFakeHead? Visibility.Visible : Visibility.None)

  List({space:20, scroller: this.scroller }) {
    ListItem() {
      Row() {
          // 2. 列表的head头
        this.itemHead()
      }.visibility(!this.showFakeHead? Visibility.Visible : Visibility.None)
    }

    ForEach(this.data, (item: GroupData) => {
      ListItem() {
        Column() {
          Row() {
            // 3. 列表中不悬浮的 head
            Text(item.head)
              .fontSize(20)
              .height(50)
              .backgroundColor('#FF667075')
              .width('100%')
          }.visibility(item.isHead ? Visibility.Visible : Visibility.None)

          Text(item.content)
            .width('100%')
            .height(150)
            .fontSize(20)
            .textAlign(TextAlign.Center)
            .backgroundColor('#FF6600')
            .visibility(!item.isHead ? Visibility.Visible : Visibility.None)
        }
      }
    })
    // 列表末条 Item，上拉加载更多
    ListItem() {
      if (this.dataModel.hasMore) {
        LoadMoreLayout({
          loadMoreLayoutClass: new CustomRefreshLoadLayoutClass(this.dataModel.isVisiblePullUpLoad, this.dataModel.pullUpLoadImage,
            this.dataModel.pullUpLoadText, this.dataModel.pullUpLoadHeight)
        })
      } else {
        NoMoreLayout()
      }
    }
  }
  .onTouch((event: TouchEvent | undefined) => {
    if (event) {
      if (this.dataModel.pageState === PageState.Success) {
        // 分发触摸事件
        listTouchEvent(this.dataModel, event, (isLoadMore: boolean) => {
          this.getData(isLoadMore)
        });
      }
    }
  })
  .onScrollIndex((start: number, end: number) => {
    console.log(`headfloat start:${start}`)
    if (this.data.length > start) {
      let startValue = this.data[start]
      // 4. 赋值 head 数据
      this.headTitle = startValue
    }
    let yOffset: number = this.scroller.currentOffset().yOffset
    if (yOffset >= -0.01) {
        // 5. 控制 head 头展示
      this.showFakeHead = true
    } else {
      this.showFakeHead = false
    }
    this.dataModel.startIndex = start;
    this.dataModel.endIndex = end;
  })
  .backgroundColor('#eeeeee')
  .edgeEffect(EdgeEffect.None) // 必须设置列表为滑动到边缘无效果
}
```
## 属性说明
1. RefreshLayout：下拉刷新的UI控件，可定制
2. itemHead：分组 head 头
3. LoadMoreLayout：上拉加载更多 UI 空间，可定制
4. NoMoreLayout：没有更多 UI 空间，可定制
5. PullRefreshModel：用于控制下拉刷新和上拉加载状态记录的 model 类

| 属性                   | 类型     | 释义                                 | 默认值       |
| ---------------------- | -------- | ------------------------------------ | ------------ |
| dataSize               | number   | 数据大小                             | 0            |
| currentPage            | number   | 当前页码                             | 1            |
| pageSize               | number   | 每页大小                             | 20           |
| pullDownRefreshText    | Resource | 下拉刷新时的文案                     | 下拉刷新     |
| pullDownRefreshImage   | Resource | 下拉刷新时的 icon                    | 向下箭头     |
| pullDownRefreshHeight  | number   | 下拉刷新组件的高度                   | 70           |
| isVisiblePullDown      | boolean  | 下拉刷新组件是否可见                 | false        |
| pullUpLoadText         | Resource | 上拉加载时的文案                     | 加载中..     |
| pullUpLoadImage        | Resource | 上拉加载时的 icon                    | loading箭头  |
| pullUpLoadHeight       | number   | 上拉加载组件的高度                   | 70           |
| isVisiblePullUpLoad    | boolean  | 上拉加载组件是否可见                 | false        |
| offsetY                | number   | Y 轴偏移值                           | 0            |
| pageState              | number   | 当前刷新组件状态，如加载中，加载完成 | loading 状态 |
| startIndex             | number   | 列表的第一条角标值                   | 0            |
| endIndex               | number   | 列表的最后一条角标值                 | 0            |
| downY                  | number   | 按下屏幕时的 Y 坐标                  | 0            |
| lastMoveY              | number   | 移动手指时最新的 Y 坐标              | 0            |
| isRefreshing           | boolean  | 当前是否正在下拉刷新中               | false        |
| isCanRefresh           | boolean  | 是否已经满足松开手指触发刷新         | fasle        |
| isPullRefreshOperation | boolean  | 当前正在下拉操作                     | false        |
| isLoading              | boolean  | 是否正在上拉加载更多数据中           | false        |
| hasMore                | boolean  | 是否有下一页                         | false        |
| isCanLoadMore          | boolean  | 是否可以加载下一页                   | false        |

## 约束与限制

在以下版本验证通过：

- DevEco Studio: 4.1 Canary(4.1.3.500), SDK: API11 (4.1.0)

理论上也支持API 9、10的版本

## 贡献代码

使用过程中发现任何问题都可以提 Issue 给我们，当然，我们也非常欢迎你给我们发 PR 。
