@Entry
@Component
struct Page5_RelativeContainer {
  @State message: string = 'Hello World';

  build() {
    Row() {
      RelativeContainer() {
        Column() {
        }
        .height(100)
        .width(100)
        .backgroundColor(Color.Black)
        .id("box1")
        .alignRules({
          left:{anchor: "__container__" , align: HorizontalAlign.Start},
          top: {anchor: "__container__", align: VerticalAlign.Top}
        })

        Column() {
        }
        .height(100)
        .width(100)
        .backgroundColor(Color.Red)
        .alignRules({
          right:{anchor: "__container__" , align: HorizontalAlign.End},
          top: {anchor: "__container__", align: VerticalAlign.Top}
          // center: {anchor: "box1", align: VerticalAlign.Top}
        })
        .id("box2")

        Column() {
        }
        .height(100)
        .width(100)
        .backgroundColor(Color.Green)
        .alignRules({
          left:{anchor: "__container__" , align: HorizontalAlign.Start},
          bottom: {anchor: "__container__", align: VerticalAlign.Bottom}
        })
        .id("box3")

        Column() {
        }
        .height(100)
        .width(100)
        .backgroundColor(Color.Blue)
        .alignRules({
          right:{anchor: "__container__" , align: HorizontalAlign.End},
          bottom: {anchor: "__container__", align: VerticalAlign.Bottom}
        })
        .id("box4")

        Column() {
        }
        .height(100)
        .width(100)
        .backgroundColor(Color.Yellow)
        // .alignRules({
        //   middle:{anchor: "__container__" , align: HorizontalAlign.Center},
        //   center: {anchor: "__container__", align: VerticalAlign.Center }
        // })
        .alignRules({
          left:{anchor: "box1", align: HorizontalAlign.End},
          top:{anchor: "box2", align: VerticalAlign.Bottom}
        })
        .id("box5")
      }
    }
    .borderWidth(1)
    .borderColor(Color.Red)
    .height('300')
    .width('300')
  }
}