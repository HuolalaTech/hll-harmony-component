

import { promptAction } from '@kit.ArkUI'
import { AddressComponent, CommonComponentUIBean, StandardAddressBeanArray,
  StandardOrderAddressBean } from 'lib_addresscomponent'


@Entry
@Component
export struct Test {
  @State addressArray: StandardAddressBeanArray = new StandardAddressBeanArray()
  @State commonUIBean: CommonComponentUIBean = new CommonComponentUIBean()

  /**
   * 吐司
   * @param msg 吐司内容
   */
  showToast(msg: string) {
    promptAction.showToast({
      message: msg
    })
  }

  /**
   * 测试添加地址
   */
  testAddData(){
    let addressArray = this.addressArray
    let length = addressArray.length
    let addBean = new StandardOrderAddressBean(length - 1, "新地址名称", "131XXXX6789")
    addressArray.splice(length - 1, 0, addBean)
    addressArray[length].index = length
  }

  aboutToAppear(): void {
    this.initData()
    this.initUI()
  }

  /**
   * 刷新全部地址
   */
  initData() {
    for (let i = 0; i < 2; i++) {
      let name = `序列号${i}地址`
      let phone = `${i}123456789`
      let bean = new StandardOrderAddressBean(i, name, phone)
      this.addressArray.push(bean)
    }
  }

  /**
   * 自定义UI
   */
  initUI() {
    this.commonUIBean.nameColor = $r('app.color.client_orange')
    this.commonUIBean.dragText = "滑动"
  }

  build() {
    Column() {
      Blank().layoutWeight(1)
      AddressComponent({
        addressArray: this.addressArray,
        onAddAddressClick: () => {
          this.testAddData()
        },
        commonUIBean: this.commonUIBean
      })
      Blank().layoutWeight(1)
    }
  }
}