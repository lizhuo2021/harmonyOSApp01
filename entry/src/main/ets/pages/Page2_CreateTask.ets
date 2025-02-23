import { cloudCommon } from '@kit.CloudFoundationKit'
import { LoginPanel } from '@hms.core.account.LoginComponent'
import { JSON } from '@kit.ArkTS'
import json from '@ohos.util.json'
import { font } from '@kit.ArkUI'

@Extend(TextInput)
function createInputTextStyle() {
  .fontSize(20)
  .placeholderColor($r("app.color.app_bold_title_text"))
  .borderRadius(0)
  .backgroundColor($r("app.color.app_common_page_background_gray"))
  .margin({ top: 10 })
}

@Extend(Text)
function createTextStyle() {
  .fontSize(20)
  .fontColor($r("app.color.app_bold_title_text"))
}

@Extend(Line)
function createLineStyle(width: string = "100%") {
  .height(1)
  .backgroundColor(Color.Black)
  .width(width)
}

@Extend(Radio)
function createRadioStyle() {
  .radioStyle({
    checkedBackgroundColor: $r("app.color.app_common_theme_color")
  })
  .width(24)
  .height(24)
}

@Extend(Text)
function createTagStyle(backgroundColor: ResourceColor = Color.Black) {
  .fontSize(20)
  .backgroundColor(backgroundColor)
  .textAlign(TextAlign.Center)
}


@Entry
@Component
struct CreateTask {
  // 保存日期对象
  private selectDate: Date = new Date()
  private selectStartTime: Date = new Date()
  private selectEndTime: Date = new Date()
  @State tagSelect: boolean = false

  selectTime = () => {
    TimePickerDialog.show({
      selected: this.selectStartTime,
      useMilitaryTime: true,
      // 即将消失的上方和下方的文字样式
      // disappearTextStyle:{color: Color.Red,font:{
      //   weight:FontWeight.Bold,
      //   size:40
      // }},
      // 中间未选择、未即将消失的文字样式
      // textStyle:{
      //   color: Color.Orange,
      //   font: {
      //     weight: FontWeight.Bold,
      //     size:25
      //   }
      // },
      // 选中的文字样式
      selectedTextStyle: {
        color: $r("app.color.app_common_theme_color"),
        font: {
          weight: FontWeight.Bold,
          size: 30
        }
      },
      onAccept: (value: TimePickerResult) => {

        console.log('CalendarPickerDialog' + this.selectStartTime.toString())

        this.selectStartTime.setHours(value.hour)
        this.selectStartTime.setMinutes(value.minute)

        console.log('CalendarPickerDialog' + this.selectStartTime.toString())
      },
    })

  }
  selectCalendar = () => {
    CalendarPickerDialog.show({
      selected: this.selectDate,
      onChange: (value: Date) => {
        this.selectDate = value
        console.log('CalendarPickerDialog' + value.toString())
      }
    })
  }

  build() {
    RelativeContainer() {
      Column({ space: 20 }) {
        // 大标题
        Text("新建任务") {
        }
        .fontColor($r("app.color.app_bold_title_text"))
        .fontSize($r("app.float.app_common_title_size"))
        .fontWeight(FontWeight.Bold)

        // 任务部分
        // 标题
        Column() {

          Text("标题")
            .createTextStyle()

          TextInput({ placeholder: "请输入标题" })
            .createInputTextStyle()

          Line()
            .createLineStyle()
        }
        .alignItems(HorizontalAlign.Start)
        .margin({ left: 10, right: 10 })

        // 日期
        Column() {

          Text("日期")
            .createTextStyle()

          TextInput({ placeholder: "请输入日期" })
            .createInputTextStyle()
            .onClick(this.selectCalendar)

          Line()
            .createLineStyle()
        }
        .alignItems(HorizontalAlign.Start)
        .margin({ left: 10, right: 10 })

        // 时间
        Column() {

          Text("时间")
            .createTextStyle()

          Row() {

            Column() {
              TextInput({ placeholder: "请输入开始时间" })
                .createInputTextStyle()
                .onClick(this.selectTime)
              Line()
                .createLineStyle("90%")
            }
            .width("48%")

            Column() {
              TextInput({ placeholder: "请输入结束时间" })
                .createInputTextStyle()
                .onClick(this.selectTime)
              Line()
                .createLineStyle("90%")
            }
            .width("48%")

          }
          .width("100%")

        }
        .alignItems(HorizontalAlign.Start)
        .margin({ left: 10, right: 10 })


        // 描述
        Column() {

          Text("描述")
            .createTextStyle()

          TextInput({ placeholder: "请输入描述" })
            .createInputTextStyle()

          Line()
            .createLineStyle()
        }
        .alignItems(HorizontalAlign.Start)
        .margin({ left: 10, right: 10 })



        //   任务类型
        Column() {
          Text("类型")
            .createTextStyle()

          Row() {
            Row() {
              Radio({ value: "1", group: "task_type" })
                .createRadioStyle()

              Text("个人任务")
                .fontWeight(FontWeight.Bold)
            }

            Row() {
              Radio({ value: "2", group: "task_type" })
                .createRadioStyle()

              Text("工作任务")
                .fontWeight(FontWeight.Bold)
            }
          }
          .width("100%")
          .justifyContent(FlexAlign.SpaceBetween)
          .margin({ top: 10 })

        }
        .alignItems(HorizontalAlign.Start)
        .margin({ left: 10, right: 10 })


        //   任务标签
        Column() {
          Text("标签")
            .createTextStyle()
            .width("100%")

          Row() {
            Column() {
              Text("工作")
                .fontSize(20)
                .margin(10)
            }
            .backgroundColor("#eae9fd")
            .alignItems(HorizontalAlign.Center)
            .justifyContent(FlexAlign.Center)
            .border({
              width: 2,
              color: this.tagSelect ? Color.Yellow : Color.Transparent
            })
            .onClick(() => {
              this.tagSelect = !this.tagSelect
            })
            .width("25%")

            Column() {
              Text("生活")
                .fontSize(20)
                .margin(10)
            }
            .backgroundColor("#fbeeec")
            .alignItems(HorizontalAlign.Center)
            .justifyContent(FlexAlign.Center)
            .border({
              width: 2,
              color: this.tagSelect ? Color.Yellow : Color.Transparent
            })
            .onClick(() => {
              this.tagSelect = !this.tagSelect
            })
            .width("25%")

            Column() {
              Text("学习")
                .fontSize(20)
                .margin(10)
            }
            .backgroundColor("#f9e9eb")
            .alignItems(HorizontalAlign.Center)
            .justifyContent(FlexAlign.Center)
            .border({
              width: 2,
              color: this.tagSelect ? Color.Yellow : Color.Transparent
            })
            .onClick(() => {
              this.tagSelect = !this.tagSelect
            })
            .width("25%")

            Column() {
              Text("娱乐")
                .fontSize(20)
                .margin(10)
            }
            .backgroundColor("#d9faf9")
            .alignItems(HorizontalAlign.Center)
            .justifyContent(FlexAlign.Center)
            .border({
              width: 2,
              color: this.tagSelect ? Color.Yellow : Color.Transparent
            })
            .onClick(() => {
              this.tagSelect = !this.tagSelect
            })
            .width("25%")

          }
          .margin({top: 10})

        }
        .alignItems(HorizontalAlign.Start)
        .margin({ left: 10, right: 10 })

      }
    }
    .height('100%')
    .width('100%')
    .backgroundColor($r("app.color.app_common_page_background_gray"))
  }
}