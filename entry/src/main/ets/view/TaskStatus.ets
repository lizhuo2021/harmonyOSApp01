import { TaskModel, TaskModelStatus } from "../viewmodel/TaskModel"
import { TaskItem } from "./TaskItem"

@Component
export struct TaskStatus {
  @Prop tasks: Array<TaskModel> = []

  // 获取满足任务状态的任务数量
  getTaskCount(state: TaskModelStatus) {

    const count = this.tasks.reduce((sum: number, item: TaskModel) => {

      if (state == item.taskStatus) {
        sum += 1
      }

      return sum
    }, 0)

    return count

  }

  build() {

    // 我的计划
    Row({ space: 5 }) {

      // 左侧部分
      Column({ space: 5 }) {
        // 已完成
        Column({ space: 5 }) {
          Image($r("app.media.card_inner_2"))
            .width(100)
          Text("已完成")
            .fontWeight(FontWeight.Bold)
            .fontSize(18)
            .margin({ left: 15 })
            .fontColor($r("app.color.app_bold_title_text"))
          Text(`${this.getTaskCount(TaskModelStatus.done)}任务`)
            .fontWeight(FontWeight.Normal)
            .fontSize(15)
            .margin({ left: 15 })
            .fontColor($r("app.color.app_bold_title_text"))
        }
        .alignItems(HorizontalAlign.Start)
        .width("100%")
        .height("60%")
        .backgroundColor("#a0cde5")
        .borderRadius(15)

        // 等待中
        Column({ space: 10 }) {
          Image($r("app.media.card_inner_1"))
            .width(50)
          Text("等待中")
            .fontWeight(FontWeight.Bold)
            .fontSize(18)
            .margin({ left: 15 })
            .fontColor($r("app.color.app_bold_title_text"))
          Text(`${this.getTaskCount(TaskModelStatus.doing)}任务`)
            .fontWeight(FontWeight.Normal)
            .fontSize(15)
            .margin({ left: 15 })
            .fontColor($r("app.color.app_bold_title_text"))
        }
        .width("100%")
        .height("40%")
        .backgroundColor("#7e87e3")
        .borderRadius(15)
        .alignItems(HorizontalAlign.Start)
      }
      .width("50%")
      .height("100%")

      // 右侧部分
      Column({ space: 5 }) {
        // 未完成
        Column({ space: 5 }) {
          Image($r("app.media.card_inner_3"))
            .width(50)
          Text("未完成")
            .fontWeight(FontWeight.Bold)
            .fontSize(18)
            .margin({ left: 15 })
            .fontColor($r("app.color.app_bold_title_text"))
          Text(`${this.getTaskCount(TaskModelStatus.undone)}任务`)
            .fontSize(15)
            .margin({ left: 15 })
            .fontColor($r("app.color.app_bold_title_text"))
        }
        .alignItems(HorizontalAlign.Start)
        .width("100%")
        .height("40%")
        .backgroundColor("#dd9492")
        .borderRadius(15)

        // 未来任务
        Column({ space: 10 }) {
          Image($r("app.media.card_inner_4"))
            .width(100)
          Text("未来任务")
            .fontWeight(FontWeight.Bold)
            .fontSize(18)
            .margin({ left: 15 })
            .fontColor($r("app.color.app_bold_title_text"))
          Text(`${this.getTaskCount(TaskModelStatus.future)}任务`)
            .fontWeight(FontWeight.Normal)
            .fontSize(15)
            .margin({ left: 15 })
            .fontColor($r("app.color.app_bold_title_text"))
        }
        .width("100%")
        .height("60%")
        .backgroundColor("#bbebc5")
        .borderRadius(15)
        .alignItems(HorizontalAlign.Start)

      }
      .width("50%")
      .height("100%")
    }
    .height(300)
    .width("100%")
  }
}
