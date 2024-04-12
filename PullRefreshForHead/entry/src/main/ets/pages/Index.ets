import router from '@ohos.router';

@Entry
@Component
struct Index {

  build() {
    Row() {
      Column() {
        Button('快速使用')
          .onClick(() => {
            router.push({ url: 'pages/QuickStart' })
          })
        Button('浮动头部')
          .margin({ top: 10 })
          .onClick(() => {
            router.push({ url: 'pages/HeadFloat' })
          })
        /*Button('自定义下拉动画')
          .margin({ top: 10 })
          .onClick(() => {
            router.push({ url: 'pages/customRefreshAnim' })
          })
        Button('满屏下展示页面')
          .margin({ top: 10 })
          .onClick(() => {
            router.push({ url: 'pages/fullScreen' })
          })
        Button('Tab配合PullToRefresh')
          .margin({ top: 10 })
          .onClick(() => {
            router.push({ url: 'pages/tabsTestPage' })
          })
        Button('使用lazyForEach展示页面')
          .margin({ top: 10 })
          .onClick(() => {
            router.push({ url: 'pages/lazyForEachGuide' })
          })*/
      }
      .width('100%')
    }
    .height('100%')

  }
}