import { TaskModel, TaskModelStatus, TaskModelType } from "../viewmodel/TaskModel"
import { router } from "@kit.ArkUI"
import { RouterParamsType } from "../viewmodel/RouterParamsType"

@Component
export struct TaskItem {
  @Prop tasks: Array<TaskModel> = []
  @State byStatus : TaskModelStatus = TaskModelStatus.undone

  getTaskList() {
    const list = this.tasks.filter((value: TaskModel, index: number, array: TaskModel[]) => {return value.taskStatus === this.byStatus})
    return list
  }

  build() {
    // 今日任务列表

    Column({ space: 10 }) {

      ForEach(this.getTaskList(), (item: TaskModel, index: number)=>{

        Column({ space: 10 }) {

          Row({ space: 10 }) {
            Image($r("app.media.icon_today"))
              .width(25)
            Text(`${item.taskName}`)
              .fontColor($r("app.color.app_bold_title_text"))
              .fontSize(18)
          }
          .width("100%")

          Text(`${item.taskStartTime}-${item.taskEndTime}`)
            .fontColor(Color.Gray)
            .fontWeight(FontWeight.Bold)

          Row() {
            Text(`${item.taskType == TaskModelType.personal ? "生活" : "工作"}`)
              .fontColor(Color.White)
              .textAlign(TextAlign.Center)
              .width("100%")
              .fontWeight(FontWeight.Bold)
          }
          .width(70)
          .height(30)
          .backgroundColor(Color.Brown)
          .borderRadius(15)
        }
        .width("100%")
        .height(120)
        .backgroundColor(Color.White)
        .borderRadius(10)
        .padding({ left: 10, top: 10 })
        .alignItems(HorizontalAlign.Start)
        .onClick(()=>{
          router.pushUrl({
            url:"pages/Page_TaskDetail",
            params:new RouterParamsType(item)
          })
        })

      }, (item: TaskModel)=>item.id)



    }

  }
}