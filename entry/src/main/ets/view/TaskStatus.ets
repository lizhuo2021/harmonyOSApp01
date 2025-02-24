import { TaskModel, TaskModelStatus } from "../viewmodel/TaskModel"
import { TaskItem } from "./TaskItem"
import { router } from "@kit.ArkUI"
import { RouterParamsType } from "../viewmodel/RouterParamsType"

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
    // 左右间隔5
    Row({ space: 5 }) {

      // 左侧部分
      Column({ space: 5 }) {
        // 已完成
        Column({ space: 10 }) {
          Image($r("app.media.icon_done"))
            .width(80)
            .margin({ top: 10, left: 10 })
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
        .onClick(() => {
          router.pushUrl({
            url: "pages/Page_SortTaskList",
            params: new RouterParamsType(TaskModelStatus.done)
          })
        })
        .alignItems(HorizontalAlign.Start)
        .width("100%")
        .height("60%")
        .backgroundColor("#92dab2")
        .borderRadius(15)

        // 等待中
        Column({ space: 5 }) {
          Image($r("app.media.icon_doing"))
            .width(50)
            .margin({ top: 10, left: 10 })
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
        .onClick(() => {
          let storage: LocalStorage = new LocalStorage();
          storage.setOrCreate("Page_SortTaskList_TaskStatus", TaskModelStatus.undone)
          router.pushUrl({
            url: "pages/Page_SortTaskList",
            params: new RouterParamsType(TaskModelStatus.doing)
          })
        })
        .width("100%")
        .height("40%")
        .backgroundColor("#ffe7b5")
        .borderRadius(15)
        .alignItems(HorizontalAlign.Start)
      }
      .width("49%")
      .height("100%")

      // 右侧部分
      Column({ space: 5 }) {
        // 未完成
        Column({ space: 5 }) {
          Image($r("app.media.icon_undone"))
            .width(50)
            .margin({ top: 10, left: 10 })
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
        .backgroundColor("#ffb9b0")
        .borderRadius(15)
        .onClick(() => {
          router.pushUrl({
            url: "pages/Page_SortTaskList",
            params: new RouterParamsType(TaskModelStatus.undone)
          })
        })

        // 未来任务
        Column({ space: 10 }) {
          Image($r("app.media.icon_future"))
            .width(80)
            .margin({ top: 10, left: 10 })
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
        .backgroundColor("#b5c7ff")
        .borderRadius(15)
        .alignItems(HorizontalAlign.Start)
        .onClick(() => {
          router.pushUrl({
            url: "pages/Page_SortTaskList",
            params: new RouterParamsType(TaskModelStatus.future)
          })
        })

      }
      .width("49%")
      .height("100%")
    }
    .height(300)
    .width("100%")
  }
}
