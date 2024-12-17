import { DialogNumberKeyboard } from 'lib_numberkeyboard';
import { StringUtil } from '../utils/StringUtil';

@Entry
@Component
export struct Test3 {
  //出价输入内容
  @State inputText: string = ''
  @Builder
  dialogNumberKeyboardBuilder() {
    DialogNumberKeyboard({
      //number==-2时，则就是删除功能
      onNumberClick: (number: number) => {
        this.handleKeyboardInput(number)
      },
    })
      .width('100%')
      .height(220)
  }
  private handleKeyboardInput(input: number) {
    if (StringUtil.isNullOrEmpty(this.inputText) && input >= 0) {
      this.inputText = input.toString()
      return
    }
    //删除事件
    if (input < 0) {
      if (!StringUtil.isNullOrEmpty(this.inputText)) {
        this.inputText = this.inputText.substring(0, this.inputText.length - 1)
      }
      return
    }
    this.inputText += input
  }

  private onTextChange(text: string) {
    try {
      if (StringUtil.isNullOrEmpty(text)) {
      } else {
        if (text.length == 1 && text == ("0")) {
          this.inputText = ''
          return
        }
      }
    } catch (err) {
    }
  }


  build() {
    Stack() {
      Row() {
        Text("我的出价").fontSize(16).fontColor($r('app.color.black_85_percent')).margin({ left: 16 })

        TextInput({ text: this.inputText, placeholder: '请输入价格' })
          .caretColor($r('app.color.client_orange'))
          .backgroundColor(Color.Transparent)
          .placeholderColor($r('app.color.gray_25_percent'))
          .fontColor($r('app.color.black_85_percent'))
          .fontSize(22)
          //.maxLength(10)
          .layoutWeight(1)
          .padding({ right: 8 })
          .height(44)
          .margin({ left: 12 })
          .textAlign(TextAlign.End)//.defaultFocus(true)
          .customKeyboard(this.dialogNumberKeyboardBuilder(), { supportAvoidance: true })
          .type(InputType.Number)
          .onChange((value) => {
            this.inputText = value
            this.onTextChange(value)
          })
          .onTouch((event: TouchEvent | undefined) => {

          })

        Text('元')
          .width(40)
          .fontSize(16)
          .fontColor($r('app.color.black_65_percent'))
      }
      .height(52)
      .margin({ bottom: 10 })
      .backgroundColor(0XF3F4F5)
      .borderRadius(8)

    }
    .margin({ top: 12, left: 16, right: 16 })
    .alignContent(Alignment.TopEnd)

  }

}