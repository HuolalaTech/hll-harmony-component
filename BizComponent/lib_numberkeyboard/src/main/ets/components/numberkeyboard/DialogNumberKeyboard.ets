/**
 * 弹框里面使用到的数字键盘
 */
@Preview
@Component
export struct DialogNumberKeyboard {
  /**
   * 键盘数字源（-1 显示空格，-2显示删除按键）
   */
  @State numbers: number[] = [1, 2, 3, 4, 5, 6, 7, 8, 9, -1, 0, -2]
  /**
   * 监听数字点击
   */
  onNumberClick?: (number: number) => void

  /**
   * 绘制数字按键
   * @param key
   */
  @Builder
  NumberText(key: number) {
    if (key >= 0) {
      Text(key.toString())
        .height(54)
        .fontSize(26)
        .fontColor($r('app.color.color_222836'))
        .textAlign(TextAlign.Center)
        .stateStyles({
          pressed: {
            .backgroundColor($r('app.color.light_bg_grey'))
          },
          normal: {
            .backgroundColor($r('app.color.white'))
          }
        })
        .onClick(() => {
          if (this.onNumberClick) {
            this.onNumberClick(key)
          }
        })
    } else if (key == -1) {
      Text("")
        .height(54)
        .fontSize(26)
        .fontColor($r('app.color.color_222836'))
        .textAlign(TextAlign.Center)
        .backgroundColor($r('app.color.white'))
    } else if (key == -2) {
      Row() {
        Image($r('app.media.client_ic_keyboard_del'))
          .width(32)
          .height(32)
      }
      .layoutWeight(1)
      .alignItems(VerticalAlign.Center)
      .justifyContent(FlexAlign.Center)
      .height(54)
      .stateStyles({
        pressed: {
          .backgroundColor($r('app.color.light_bg_grey'))
        },
        normal: {
          .backgroundColor($r('app.color.white'))
        }
      })
      .onClick(() => {
        if (this.onNumberClick) {
          this.onNumberClick(key)
        }
      })
    }
  }

  /**
   * 绘制UI
   */
  build() {
    Column() {
      Grid() {
        ForEach(this.numbers, (key: number) => {
          this.NumberText(key)
        }, (key: string) => key)
      }
      .columnsTemplate('1fr 1fr 1fr ')
      .rowsTemplate('1fr 1fr 1fr 1fr')
      .columnsGap(3)
      .rowsGap(4)
      .backgroundColor($r('app.color.light_bg_grey'))
    }.width('100%')

  }
}