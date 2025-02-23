import { TaskModel, TaskModelStatus, TaskModelType } from "../viewmodel/TaskModel"

@Component
export struct TaskItem {
  @Prop tasks: Array<TaskModel> = []

  getTodayTask() {

    const list = this.tasks.filter((value: TaskModel, index: number, array: TaskModel[]) => {return value.taskStatus === TaskModelStatus.doing})

    console.log(`${JSON.stringify(list)}`)

    return list
  }

  build() {
    // 今日任务列表

    Column({ space: 10 }) {

      ForEach(this.getTodayTask(), (item: TaskModel, index: number)=>{

        Column({ space: 10 }) {

          Row({ space: 20 }) {
            Image($r("app.media.card_inner_4"))
              .width(20)
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

      }, (item: TaskModel)=>item.id)



    }

  }
}