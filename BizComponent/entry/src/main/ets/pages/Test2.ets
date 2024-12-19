import {
  SelSwiperTabSource,
  SwiperImageArray,
  SwiperImageComponent,
  SwiperImageUiBean
} from "lib_swiperpicturescomponent"


@Entry
@Component
export struct Test2 {
  /**图片列表*/
  @State swiperImageArray: SwiperImageArray = new SwiperImageArray()
  @State currentVehicleIndex: number = 0

  aboutToAppear(): void {
    this.testAddData(1,
      "https://luna-cdn-public-test.huolala.cn/luna-public-al-test/test001/900900/20230921/1001d9256507ac074e17a70242eda6fb8aed.png")
    this.testAddData(2,
      "https://luna-cdn-public-test.huolala.cn/luna-public-al-test/test001/900900/20230921/1001358c9e7e595c49588850292b8c418e03.png")
    this.testAddData(3,
      "https://luna-cdn-public-test.huolala.cn/luna-public-al-test/test001/900900/20230921/1001851b397b6a8644e1bb7a037ee5e8a01a.png")
    this.testAddData(4,
      "https://luna-cdn-public-test.huolala.cn/luna-public-al-test/test001/900900/20230921/1001ed957fb6906d4c1c8f1479baa2554510.png")
    this.testAddData(5,
      "https://luna-cdn-public-test.huolala.cn/luna-public-al-test/test001/900900/20230921/1001a30936c51ace4a2abc42cc014f9b85c7.png")
  }

  /**
   * 测试添加地址
   */
  testAddData(swiperId: number, imageUrl: string) {
    let addBean = new SwiperImageUiBean()
    addBean.swiperId = swiperId
    addBean.imageUrl = imageUrl
    this.swiperImageArray.push(addBean)
  }

  build() {
    Column() {
      Blank().layoutWeight(1)
      SwiperImageComponent({
        vehicleImageArray: this.swiperImageArray,
        currentVehicleIndex: this.currentVehicleIndex,
        indexChangeAction: (source: SelSwiperTabSource, index: number) => {

        },
        onImageClick: (imageBean: SwiperImageUiBean) => {
        }
      })
      Blank().layoutWeight(1)
    }.padding({ bottom: 12 })

  }
}

