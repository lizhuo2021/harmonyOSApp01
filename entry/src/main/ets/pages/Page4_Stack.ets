@Entry
@Component
struct Page4_Stack {
  build() {
    Stack({ alignContent: Alignment.BottomStart }) {
      Text('Stack').width('90%').height('100%').backgroundColor('#e1dede').align(Alignment.BottomEnd).zIndex(0)
      Text('Item 1').width('70%').height('80%').backgroundColor(0xd2cab3).align(Alignment.BottomEnd).zIndex(2)
      Text('Item 2').width('50%').height('60%').backgroundColor(0xc1cbac).align(Alignment.BottomEnd).zIndex(1)
    }.width('100%').height(150).margin({ top: 5 })
  }
}
