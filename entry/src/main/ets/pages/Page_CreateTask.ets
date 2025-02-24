import { cloudCommon } from '@kit.CloudFoundationKit'
import { LoginPanel } from '@hms.core.account.LoginComponent'
import { JSON } from '@kit.ArkTS'
import json from '@ohos.util.json'
import { font, router } from '@kit.ArkUI'
import { TaskModel, TaskModelTag, TaskModelType } from '../viewmodel/TaskModel'
import { dateFormat, formatHHMM } from '../utils/DateFormat'

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
  @StorageLink("tasks") tasks: Array<TaskModel> = [];
  // 保存日期对象
  private selectDate: Date = new Date()
  private selectStartTime: Date = new Date()
  private selectEndTime: Date = new Date()
  @State tagSelect: boolean = false
  // 绑定的散装数据
  // @State taskName: string = ""
  // @State taskDate: string = ""
  // @State taskStartTime: string = ""
  // @State taskEndTime: string = ""
  // @State taskDetailContent: string = ""
  // @State taskType: TaskModelType = TaskModelType.personal
  // @State taskTag: TaskModelTag = TaskModelTag.work

  // 绑定对象
  @State taskModel: TaskModel = new TaskModel("",
    "",
    "",
    "",
    "",
    "",
    TaskModelType.personal,
    TaskModelTag.work)
  selectTime = (tagString: string) => {
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

        // console.log('CalendarPickerDialog' + this.selectStartTime.toString())
        const h = formatHHMM(value.hour)
        const m = formatHHMM(value.minute)
        if (tagString == "start") {
          this.selectStartTime.setHours(value.hour)
          this.selectStartTime.setMinutes(value.minute)

          this.taskModel.taskStartTime = `${h}:${m}`
        } else {
          this.selectEndTime.setHours(value.hour)
          this.selectEndTime.setMinutes(value.minute)

          this.taskModel.taskEndTime = `${h}:${m}`
        }
        // console.log('CalendarPickerDialog' + this.selectStartTime.toString())
      },
    })

  }
  selectCalendar = () => {
    CalendarPickerDialog.show({
      selected: this.selectDate,
      onAccept: (value: Date) => {
        this.selectDate = value
        this.taskModel.taskDate = dateFormat(value, "yyyy-MM-dd")
      }
    })
  }

  build() {
    RelativeContainer() {
      Column({ space: 20 }) {
        RelativeContainer() {
          // 返回按钮
          Text("返回")
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .backgroundColor(Color.White)
            .borderRadius(10)
            .height(40)
            .width(60)
            .textAlign(TextAlign.Center)
            .onClick(()=> {
              router.back()
            })
            .alignRules({
              left:{anchor: "__container__", align: HorizontalAlign.Start},
              center:{anchor: "__container__", align: VerticalAlign.Center},
            })
            .margin({left: 10})
          // 大标题
          Text("新建任务") {
          }
          .fontColor($r("app.color.app_bold_title_text"))
          .fontSize($r("app.float.app_common_title_size"))
          .fontWeight(FontWeight.Bold)
          .alignRules({
            middle:{anchor: "__container__", align: HorizontalAlign.Center},
            center:{anchor: "__container__", align: VerticalAlign.Center},
          })
        }
        .height(70)
        .width("100%")

        // 任务部分
        // 标题
        Column() {
          Text("标题")
            .createTextStyle()

          TextInput({ placeholder: "请输入标题", text: $$this.taskModel.taskName })
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

          TextInput({ placeholder: "请输入日期", text: $$this.taskModel.taskDate })
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
              TextInput({ placeholder: "请输入开始时间", text: $$this.taskModel.taskStartTime })
                .createInputTextStyle()
                .onClick(() => this.selectTime("start"))
              Line()
                .createLineStyle("90%")
            }
            .width("48%")

            Column() {
              TextInput({ placeholder: "请输入结束时间", text: $$this.taskModel.taskEndTime })
                .createInputTextStyle()
                .onClick(() => this.selectTime("end"))
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

          Text("详情")
            .createTextStyle()

          TextInput({ placeholder: "请输入详情", text: $$this.taskModel.taskDetailContent })
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
                .onChange((isChecked: boolean) => {
                  if (isChecked) {
                    this.taskModel.taskType = TaskModelType.personal
                  }
                })
                .checked(this.taskModel.taskType == TaskModelType.personal)

              Text("个人任务")
                .fontWeight(FontWeight.Bold)
            }

            Row() {
              Radio({ value: "2", group: "task_type" })
                .createRadioStyle()
                .onChange((isChecked: boolean) => {
                  if (isChecked) {
                    this.taskModel.taskType = TaskModelType.work
                  }
                })
                .checked(this.taskModel.taskType == TaskModelType.work)

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

          if (this.taskModel.taskType == TaskModelType.personal) {

            Row() {
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

          } else {
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
                this.taskModel.taskTag = TaskModelTag.work
              })
              .width("25%")
            }
          }


        }
        .alignItems(HorizontalAlign.Start)
        .margin({ left: 10, right: 10 })

        Column() {
          Text("创建任务")
            .fontColor(Color.White)
            .fontWeight(FontWeight.Bold)
        }
        .width(200)
        .height(40)
        .backgroundColor($r("app.color.app_common_theme_color"))
        .justifyContent(FlexAlign.Center)
        .borderRadius(20)
        .onClick(() => {
          // 更新ID
          const id = new Date().getTime().toString()
          this.taskModel.id = id
          // 保存对象

          let model = new TaskModel(id,
            this.taskModel.taskName,
            this.taskModel.taskDate,
            this.taskModel.taskStartTime,
            this.taskModel.taskEndTime,
            this.taskModel.taskDetailContent,
            this.taskModel.taskType,
            this.taskModel.taskTag)

          this.tasks.push(model)

          router.back()
        })

      }
    }
    .height('100%')
    .width('100%')
    .backgroundColor($r("app.color.app_common_page_background_gray"))
  }
}