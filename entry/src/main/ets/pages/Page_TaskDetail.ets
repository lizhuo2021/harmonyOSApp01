import { router } from '@kit.ArkUI'

import { RouterParamsType } from "../viewmodel/RouterParamsType"
import { TaskModel, TaskModelStatus, TaskModelType } from '../viewmodel/TaskModel'

@Entry
@Component
struct Page_TaskDetail {

  @State model: TaskModel | null = null
  @State taskIndex: number = 0
  @StorageLink("tasks") tasks: Array<TaskModel> = [];

  @Styles
  linearGradientStyle() {
    .width("49%")
    .height("100%")
    .borderRadius(15)
    .linearGradient({
      angle: 180,
      colors: [
        ["#FE9D9D", 0.0],
        ["#E77D7D", 1.0],
      ]
    })
  }

  aboutToAppear(): void {

    const params = router.getParams()
    // 告诉编译器，我明确知道params是什么类型。
    const model = (params as RouterParamsType<TaskModel>).value
    this.model = model

    // 找到任务index

    this.taskIndex = this.tasks.findIndex((item: TaskModel)=>{
      return item.id == this.model?.id
    })


  }


  build() {
    Column() {
      Column({ space: 20 }) {

        // 返回和标题
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
            .onClick(() => {
              router.back()
            })
            .alignRules({
              left: { anchor: "__container__", align: HorizontalAlign.Start },
              center: { anchor: "__container__", align: VerticalAlign.Center },
            })
          // 大标题
          Text("任务详情") {
          }
          .fontColor($r("app.color.app_bold_title_text"))
          .fontSize($r("app.float.app_common_title_size"))
          .fontWeight(FontWeight.Bold)
          .alignRules({
            middle: { anchor: "__container__", align: HorizontalAlign.Center },
            center: { anchor: "__container__", align: VerticalAlign.Center },
          })
        }
        .height(70)
        .width("100%")

        // 任务名字
        Text(`${this.model?.taskName}`)
          .fontSize(25)
          .fontColor($r("app.color.app_bold_title_text"))
          .fontWeight(FontWeight.Bold)
          .width("100%")

        // 任务类型
        if (this.model?.taskType == TaskModelType.personal) {
          Text("个人任务")
            .fontSize(15)
            .fontColor(Color.Gray)
            .fontWeight(FontWeight.Bold)
            .width("100%")
        } else {
          Text("工作任务")
            .fontSize(15)
            .fontColor(Color.Gray)
            .fontWeight(FontWeight.Bold)
            .width("100%")
        }


        // 任务时间

        Row() {
          Column() {
            Text("开始时间")
              .fontColor(Color.White)
              .fontWeight(FontWeight.Bold)
              .fontSize(20)
            Text(`${this.model?.taskStartTime}`)
              .fontColor(Color.White)
              .fontWeight(FontWeight.Bold)
              .fontSize(18)
          }
          .justifyContent(FlexAlign.Center)
          .linearGradientStyle()


          Column() {
            Text("结束时间")
              .fontColor(Color.White)
              .fontWeight(FontWeight.Bold)
              .fontSize(20)
            Text(`${this.model?.taskEndTime}`)
              .fontColor(Color.White)
              .fontWeight(FontWeight.Bold)
              .fontSize(18)
          }
          .justifyContent(FlexAlign.Center)
          .linearGradientStyle()
        }
        .width("100%")
        .height(80)
        .justifyContent(FlexAlign.SpaceBetween)

        Column({ space: 20 }) {
          // 任务状态切换
          Text(`任务状态`)
            .fontSize(25)
            .fontColor($r("app.color.app_bold_title_text"))
            .fontWeight(FontWeight.Bold)
            .width("100%")

          Toggle({
            type: ToggleType.Switch,
            isOn: this.model?.taskStatus == TaskModelStatus.done ? true : false
          })
            .selectedColor($r("app.color.app_common_theme_color"))
            .onChange((isOn: boolean) => {
              this.model = (this.model as TaskModel)
              if (isOn) {
                // (this.model as TaskModel).taskStatus = TaskModelStatus.done
                this.model.taskStatus = TaskModelStatus.done
              } else {
                this.model.taskStatus = TaskModelStatus.undone
              }

              // 替换原数组对象

              this.tasks.splice(this.taskIndex, 1, this.model)

            })

          // 任务状态提示
          Text(`任务状态：${this.model?.taskStatus == TaskModelStatus.done ? "任务完成" : "任务进行中"}`)
            .fontSize(25)
            .fontColor($r("app.color.app_bold_title_text"))
            .fontWeight(FontWeight.Bold)
            .width("100%")


        }
        .alignItems(HorizontalAlign.Start)
      }
      .height('100%')
      .width('100%')
      .padding({ left: 10, right: 10 })
    }
    .height('100%')
    .width('100%')
    .backgroundColor($r("app.color.app_common_page_background_gray"))
  }
}