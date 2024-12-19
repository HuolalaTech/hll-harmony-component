import { router } from '@kit.ArkUI';

@Entry
@Component
struct Index {
  build() {
    Column() {
      Row() {
        Column() {
          Blank().layoutWeight(1)
          Text("地址切换")
            .fontSize(30)
            .fontColor(Color.White)
            .height(100)
            .width("100%")
            .textAlign(TextAlign.Center)
            .backgroundColor(Color.Blue)
            .onClick(() => {
              router.pushUrl({ url: 'pages/Test' })
            })
          Blank().layoutWeight(1)
          Text("图片滚动")
            .fontSize(30)
            .fontColor(Color.White)
            .height(100)
            .width("100%")
            .textAlign(TextAlign.Center)
            .backgroundColor(Color.Red)
            .onClick(() => {
              router.pushUrl({ url: 'pages/Test2' })
            })
          Blank().layoutWeight(1)
          Text("数字键盘")
            .fontSize(30)
            .fontColor(Color.White)
            .height(100)
            .width("100%")
            .textAlign(TextAlign.Center)
            .backgroundColor(Color.Green)
            .onClick(() => {
              router.pushUrl({ url: 'pages/Test3' })
            })
          Blank().layoutWeight(1)
        }.padding(30)
      }
    }.alignItems(HorizontalAlign.Center).justifyContent(FlexAlign.Center)
  }
}