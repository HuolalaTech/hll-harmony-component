import { ItemDotComponent } from './ItemDotComponent'
import { BusinessError } from '@kit.BasicServicesKit'
import { StandardOrderAddressBean } from './StandardOrderAddressBean'
import { AddressComponentConstant, CommonComponentUIBean } from './AddressComponentConstant'
import { curves } from '@kit.ArkUI'
import { vibrator } from '@kit.SensorServiceKit'
import { StandardAddressBeanArray } from './StandardAddressBeanArray'
import { DragOperateBottomComponent } from './DragOperateBottomComponent'

@Component
export struct DragAddressList {
  @ObjectLink addressArray: StandardAddressBeanArray
  @State commonUIBean: CommonComponentUIBean = new CommonComponentUIBean()
  @State dragItem?: StandardOrderAddressBean = undefined
  @State offsetY: number = 0
  onAddressClick?: (index: number) => void
  onDragAddress?: (oldIndex: number, newIndex: number) => void
  onDelAddressClick?: (index: number) => void
  onAddAddressClick?: () => void
  private dragRefOffset: number = 0

  /**获取真正在ui中的位置*/
  getBeanIndex(bean: StandardOrderAddressBean): number {
    return StandardOrderAddressBean.indexOf(this.addressArray, bean)
  }

  /**开始触发*/
  private onActionStart(bean: StandardOrderAddressBean) {
    this.dragItem = bean
    this.dragRefOffset = 0
    //震动交互
    this.vibrator()
  }

  /**触发更新*/
  private onActionUpdate(event: GestureEvent, item: StandardOrderAddressBean, forEachIndex: number) {
    console.warn("PanGesture onActionUpdate")
    if (!this.dragItem) {
      return
    }

    this.offsetY = event.offsetY - this.dragRefOffset;
    let indexOf = this.getBeanIndex(item)
    let index = indexOf
    if (index == -1) {
      index = forEachIndex
    }

    //根据位移交换排序
    if (this.offsetY > AddressComponentConstant.HEIGHT_AVERAGE / 2 && index < this.addressArray.length - 1) {
      animateTo({ curve: curves.interpolatingSpring(0, 1, 400, 38) }, () => {
        this.offsetY -= AddressComponentConstant.HEIGHT_AVERAGE;
        this.dragRefOffset += AddressComponentConstant.HEIGHT_AVERAGE;
        this.itemMove(index, index + 1);
        //震动提示
        this.vibrator()
      });
    } else if (this.offsetY < -AddressComponentConstant.HEIGHT_AVERAGE / 2 && index > 0) {
      animateTo({ curve: curves.interpolatingSpring(0, 1, 400, 38) }, () => {
        this.offsetY += AddressComponentConstant.HEIGHT_AVERAGE;
        this.dragRefOffset -= AddressComponentConstant.HEIGHT_AVERAGE;
        this.itemMove(index, index - 1);
        //震动提示
        this.vibrator()
      });
    }
  }

  /**交换两个地址数据*/
  private itemMove(index: number, newIndex: number): void {
    console.log("itemMoveTest before index =  " + index + " , newIndex = " + newIndex)

    let tmp = this.addressArray.splice(index, 1)
    this.addressArray.splice(newIndex, 0, tmp[0])

    //打印日志
    this.addressArray.forEach((bean: StandardOrderAddressBean, index: number) => {
      console.log("itemMoveTest after bean " + bean.name + " " + bean.phone + " , itemIndex " + bean.index +
        " index = " + index)
    })
  }

  /**用户松手或者取消*/
  private onActionEnd(item: StandardOrderAddressBean) {
    if (!this.dragItem) {
      return
    }
    this.dragItem = undefined

    let oldIndex = item.index
    let newIndex = this.getBeanIndex(item)
    if (newIndex != oldIndex) {
      this.onDragAddress?.(newIndex, oldIndex)
    }
    //更新对象的下标，不会刷布局的
    this.addressArray.forEach((bean: StandardOrderAddressBean, index: number) => {
      bean.index = index;
    })
  }

  private printTopMargin(address: StandardOrderAddressBean) {
    return 1
  }

  /**震动*/
  private vibrator() {
    try {
      vibrator.startVibration({
        type: 'time',
        duration: 50,
      }, {
        id: 0,
        usage: 'alarm'
      }, (error: BusinessError) => {
        if (error) {
          console.error(`Failed to start vibration. Code: ${error.code}, message: ${error.message}`);
          return;
        }
        console.info('Succeed in starting vibration');
      });
    } catch (err) {
      let e: BusinessError = err as BusinessError;
      console.error(`An unexpected error occurred. Code: ${e.code}, message: ${e.message}`);
    }
  }
  @Builder
  ListItemView(bean: StandardOrderAddressBean, index: number){
    Row() {
      //icon小圆点
      ItemDotComponent({
        index: this.getBeanIndex(bean),
        allLength: this.addressArray.length,
        commonUIBean: this.commonUIBean
      })

      //地址名称和联系电话
      Column() {
        RelativeContainer() {
          //名称
          Text(bean.name)
            .id('standard_order_address_name')
            .fontColor(this.commonUIBean.nameColor)
            .fontSize(this.commonUIBean.nameFontSize)
            .maxLines(this.commonUIBean.nameMaxLines)
            .padding({ right: 14 })
            .fontWeight(FontWeight.Medium)
            .textOverflow({ overflow: TextOverflow.Ellipsis })
            .alignRules({
              left: { anchor: '__container__', align: HorizontalAlign.Start },
            })
          //右箭头
          Image(this.commonUIBean.nameImageIcon)
            .id('standard_order_address_arrow')
            .width(this.commonUIBean.nameImageIconWidth)
            .height(this.commonUIBean.nameImageIconHeight)
            .alignRules({
              right: { anchor: 'standard_order_address_name', align: HorizontalAlign.End },
              top: { anchor: 'standard_order_address_name', align: VerticalAlign.Top },
              bottom: { anchor: 'standard_order_address_name', align: VerticalAlign.Bottom },
            })
        }
        .height('auto')

        //联系电话
        Text(bean.phone ?? '')
          .fontColor(this.commonUIBean.phoneColor)
          .fontSize(this.commonUIBean.phoneFontSize)
          .visibility(bean.phone ? Visibility.Visible : Visibility.None)
          .margin({ top: 2 })
      }
      .margin({ left: 8 })
      .layoutWeight(1)
      .height("100%")
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Start)
      .gesture(
        // 以下组合手势为顺序识别，当长按手势事件未正常触发时则不会触发拖动手势事件
        GestureGroup(GestureMode.Sequence,
          LongPressGesture({ repeat: true, duration: 400 }),
          PanGesture({ fingers: 1, direction: null, distance: 0 })
            .onActionStart(() => {
              console.warn("PanGesture onActionStart")
              this.onActionStart(bean)
            })
            .onActionUpdate((event: GestureEvent) => {
              //交换逻辑
              this.onActionUpdate(event, bean, index);
            })
            .onActionEnd((event: GestureEvent) => {
              console.warn("PanGesture onActionEnd")
              animateTo({ curve: curves.interpolatingSpring(0, 1, 400, 38) }, () => {
                this.onActionEnd(bean)
              })
            })
        )
          .onCancel(() => {
            console.warn("GestureGroup onCancel")
            animateTo({ curve: curves.interpolatingSpring(0, 1, 400, 38) }, () => {
              this.onActionEnd(bean)
            })
          })
      )

      //拖拽、删除
      Row() {
        Row() {
          Image(this.commonUIBean.dragImageIcon)
            .height(20)
            .width(20)

          Text(this.commonUIBean.dragText)
            .fontColor("#D9000000")
            .fontSize(13)
            .margin({ left: 1 })
        }
        .height("100%")
        .borderRadius(6)
        .padding({ left: 4, right: 12 })
        .gesture(
          // 以下组合手势为顺序识别，当长按手势事件未正常触发时则不会触发拖动手势事件
          GestureGroup(GestureMode.Sequence,
            LongPressGesture({ repeat: true, duration: 10 }),
            PanGesture({ fingers: 1, direction: null, distance: 0 })
              .onActionStart(() => {
                this.onActionStart(bean)
                console.warn("PanGesture onActionStart")
              })
              .onActionUpdate((event: GestureEvent) => {
                //交换逻辑
                this.onActionUpdate(event, bean, index);
              })
              .onActionEnd((event: GestureEvent) => {
                console.warn("PanGesture onActionEnd")
                animateTo({ curve: curves.interpolatingSpring(0, 1, 400, 38) }, () => {
                  this.onActionEnd(bean)
                })
              })
          )
            .onCancel(() => {
              console.warn("GestureGroup onCancel")
              animateTo({ curve: curves.interpolatingSpring(0, 1, 400, 38) }, () => {
                this.onActionEnd(bean)
              })
            })
        )

        Blank().backgroundColor("#D5D5D5")
          .width("2px")
          .height(10)

        Image(this.commonUIBean.deleteImageIcon)
          .height(22)
          .width(26)
          .margin({ left: 6 })
          .padding({
            top: 4,
            bottom: 4,
            left: 6,
            right: 6
          })
          .onClick(() => {
            //删除地址
            this.addressArray.splice(index, 1)
            //更新对象的下标，不会刷布局的
            this.addressArray.forEach((bean: StandardOrderAddressBean, index: number) => {
              bean.index = index
            })
            this.onDelAddressClick?.(index)
          })
      }.height("100%")
    }
    .opacity(this.printTopMargin(bean))
    .height(bean.viewHeight)
    .onClick(() => {
      this.onAddressClick?.(this.getBeanIndex(bean))
    })
    .backgroundColor(this.dragItem == bean ? "#FFFFFF" : "#F6F9FB")
    .borderRadius(6)
    .shadow(this.dragItem == bean ? {
      radius: 6,
      color: "#0D000000",
      offsetX: 0,
      offsetY: 8,
    } : {
      radius: 0,
      color: "#0D000000",
      offsetX: 0,
      offsetY: 0,
    })
  }

  build() {
    Column() {
      Stack() {
        List() {
          ForEach(this.addressArray, (bean: StandardOrderAddressBean, index: number) => {
            ListItem() {
             this.ListItemView(bean,index)
            }
            .zIndex((this.dragItem === bean) ? 1 : 0)
            .translate((this.dragItem === bean) ? { y: this.offsetY } : { y: 0 })
          },
            (bean: StandardOrderAddressBean, index: number) => bean.uniqueStr())
        }
      }
      .alignContent(Alignment.Top)
      .width("100%")
      .padding({
        left: 6,
        right: 6,
        top: 6
      })

      Blank()
        .height(0.5)
        .margin({ top: 6, left: 12, right: 12 })
        .backgroundColor(0xE5E5E5)

      DragOperateBottomComponent({
        onAddAddressClick: () => {
          this.onAddAddressClick?.()
        }
      })
    }
    .margin({
      left: 12,
      right: 12,
      top: 12,
      bottom: 0
    })
    .padding({
      bottom: 2
    })
    .borderRadius(12)
    .backgroundColor('#F6F9FB')
    .borderWidth(1)
    .borderColor('#FFFFFF')
    .visibility(this.addressArray.length > 2 ? Visibility.Visible : Visibility.None)
  }
}