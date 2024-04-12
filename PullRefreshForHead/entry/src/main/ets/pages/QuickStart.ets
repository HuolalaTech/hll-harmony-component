import {
  closeLoadMore,
  closeRefresh,
  CustomRefreshLoadLayout,
  listTouchEvent,
  NoMoreLayout,
  PageState,
  PullRefreshConstant,
  PullRefreshModel,
} from 'lib_pullrefresh/Index';

@Entry
@Component
struct QuickStart {
  @State refreshText: string = '';
  private dataNumbers: string[] = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12', '13', '14', '15', '16', '17', '18', '19', '20'];
  private dataStrings: string[] = ['我的评论', '与我相关', '个人中心1', '个人中心2', '个人中心3', '我的发布', '设置', '退出登录'];
  @State data: string[] = this.dataStrings;
  // 需绑定列表或宫格组件
  private scroller: Scroller = new Scroller();
  @State private dataModel: PullRefreshModel = new PullRefreshModel()


  private getData(isLoadMore: Boolean) {
    new Promise<string>((resolve, reject) => {
      // 模拟网络请求操作，请求网络2秒后得到数据，通知组件，变更列表数据
      setTimeout(() => {
        resolve('刷新成功');
        let dataLocal = this.dataNumbers;
        this.dataModel.pageState = PageState.Success;
        if (dataLocal.length === this.dataModel.pageSize) {
          this.dataModel.currentPage++;
          this.dataModel.hasMore = true;
        } else {
          this.dataModel.hasMore = false;
        }
        if (isLoadMore) {
          this.data = this.data.concat(dataLocal)
          closeLoadMore(this.dataModel)
        } else {
          this.data = dataLocal
          closeRefresh(this.dataModel, true)
        }
        this.dataModel.dataSize = this.data.length

      }, 2000);
    })
  }

  build() {
    Column() {
      this.getListView()
    }
  }

  @Builder
  private getListView() {
    List({ space: 20, scroller: this.scroller }) {
      // 列表首条 Item
      CustomRefreshLoadLayout({ config: this.dataModel.refreshLayoutConfig })
      ForEach(this.data, (item: string) => {
        ListItem() {
          Text(item)
            .width('100%')
            .height(150)
            .fontSize(20)
            .fontColor('#FFFFFF')
            .textAlign(TextAlign.Center)
            .backgroundColor('#FF6600')
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
    .width('100%')
    .height('100%')
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
      this.dataModel.startIndex = start;
      this.dataModel.endIndex = end;
    })
    .backgroundColor('#eeeeee')
    .edgeEffect(EdgeEffect.None) // 必须设置列表为滑动到边缘无效果
  }
}