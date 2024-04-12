import { CustomRefreshLoadLayout, NoMoreLayout, PageState, PullRefreshModel } from 'lib_pullrefresh/Index';

import { closeRefresh, listTouchEvent } from 'lib_pullrefresh/src/main/ets/widget/pullrefresh/Refresh'


class GroupData {
  // 普通数据
  content: string = ""
  // 分组标题
  head: string = ""
  //是否是月份
  isHead: boolean = false
}


@Entry
@Component
struct HeadFloat {

  private itemDataGroupNew: GroupData[] = [
    {
      head: '2024-01',
      content: '1 月 1 日',
      isHead: false
    },
    {
      head: '2024-01',
      content: '1 月 2 日',
      isHead: false
    },
    {
      head: '2024-01',
      content: '1 月 3 日',
      isHead: false
    },
    {
      head: '2024-02',
      content: '2 月 1 日',
      isHead: true
    },
    {
      head: '2024-02',
      content: '2 月 2 日',
      isHead: false
    },
    {
      head: '2024-02',
      content: '2 月 3 日',
      isHead: false
    },
    {
      head: '2024-03',
      content: '3 月 1 日',
      isHead: true
    },
    {
      head: '2024-03',
      content: '3 月 2 日',
      isHead: false
    },
    {
      head: '2024-03',
      content: '3 月 3 日',
      isHead: false
    },
    {
      head: '2024-03',
      content: '3 月 4 日',
      isHead: false
    },
    {
      head: '2024-03',
      content: '3 月 5 日',
      isHead: false
    },
    {
      head: '2024-03',
      content: '3 月 6 日',
      isHead: false
    },
    {
      head: '2024-03',
      content: '3 月 7 日',
      isHead: false
    }
  ]
  @State data: GroupData[] = [];
  @State headTitle: GroupData = new GroupData()
  @State showFakeHead: boolean = true
  // 需绑定列表或宫格组件
  private scroller: Scroller = new Scroller();
  @State dataModel: PullRefreshModel = new PullRefreshModel()

  aboutToAppear(): void {
    this.getData(false)
  }

  private getData(isLoadMore: Boolean) {
    new Promise<string>((resolve, reject) => {
      // 模拟网络请求操作，请求网络2秒后得到数据，通知组件，变更列表数据
      setTimeout(() => {
        resolve('刷新成功');
        let dataLocal = this.itemDataGroupNew;
        this.dataModel.pageState = PageState.Success;
        if (dataLocal.length === this.dataModel.pageSize) {
          this.dataModel.currentPage++;
          this.dataModel.hasMore = true;
        } else {
          this.dataModel.hasMore = false;
        }
        if (isLoadMore) {
          this.data = this.data.concat(this.itemDataGroupNew)
        } else {
          this.headTitle = dataLocal[0]
          this.data = dataLocal
          closeRefresh(this.dataModel, true)
        }
        this.dataModel.dataSize = this.data.length

      }, 2000);
    })
  }

  build() {
    Column() {
      // 列表首条 Item
      CustomRefreshLoadLayout({ config: this.dataModel.refreshLayoutConfig })

      this.getListView()
    }
    .backgroundColor($r('app.color.item_background'))
  }

  @Builder
  itemHead() {
    // 列表分组的头部组件，对应联系人分组A、B等位置的组件
    Text(this.headTitle.head)
      .fontSize(20)
      .height(50)
      .backgroundColor($r('app.color.item_background'))
      .width('100%')
      .padding({ left: 10, right: 10 })
  }

  @Builder
  private getListView() {
    Row() {
      this.itemHead()
    }
    .visibility(this.showFakeHead ? Visibility.Visible : Visibility.None)

    List({ scroller: this.scroller }) {

      ForEach(this.data, (item: GroupData) => {
        ListItem() {
          Row() {
            Row() {
              Text(item.head)
                .fontSize(20)
                .height(50)
                .backgroundColor($r('app.color.item_background'))
                .width('100%')
            }.visibility(item.isHead ? Visibility.Visible : Visibility.None)
            .padding({ left: 10, right: 10 })

            Row() {
              Text(item.content)
                .width('100%')
                .height(150)
                .fontSize(20)
                .textAlign(TextAlign.Center)
                .backgroundColor(Color.White)
                .borderRadius(8)
                .visibility(!item.isHead ? Visibility.Visible : Visibility.None)
            }.padding({ left: 10, right: 10 })
            .margin({ bottom: 10 })
          }

        }
      })
      // 列表末条 Item
      ListItem() {
        if (this.dataModel.hasMore) {
          CustomRefreshLoadLayout({ config: this.dataModel.loadMoreLayoutConfig })
        } else {
          NoMoreLayout()
        }
      }
    }
    .onTouch((event: TouchEvent | undefined) => {
      if (event) {
        if (this.dataModel.pageState === PageState.Success) {
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
        this.headTitle = startValue
      }
      let yOffset: number = this.scroller.currentOffset().yOffset
      if (yOffset >= -0.01) {
        this.showFakeHead = true
      } else {
        this.showFakeHead = false
      }
      this.dataModel.startIndex = start;
      this.dataModel.endIndex = end;
    })
    .scrollBar(BarState.Off)
    .backgroundColor($r('app.color.item_background'))
    .edgeEffect(EdgeEffect.None) // 必须设置列表为滑动到边缘无效果
  }
}