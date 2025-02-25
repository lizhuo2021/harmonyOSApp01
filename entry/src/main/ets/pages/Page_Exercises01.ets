@Extend(Row)
function shadowBorderRowStyle(height: number = 100) {
  .backgroundColor(Color.White)
  .borderRadius(10)
  .shadow({ radius: 20, color: Color.Black, offsetY: 10 })
  .height(height)
  .width('100%')
}

let localStorage = new LocalStorage()

@Entry(localStorage)
@Component
struct Page_Exercises01 {

  @State taskList: Array<TaskItemModel> = []
  @Provide taskListCount : number = 0
  @Provide completedCount : number = 0

  createNewTask() {
    const currentLength = this.taskList.length
    const model = new TaskItemModel(`${currentLength + 1}`, `任务${currentLength + 1}`)
    this.taskList.push(model)
  }

  updateCompletedCount() {
    const number = this.taskList.reduce((sum: number, item: TaskItemModel) => {
      if (item.isCompletion) {
        sum += 1
      }
      return sum
    }, 0)

    this.completedCount = number

    this.taskListCount = this.taskList.length
  }


  aboutToAppear(): void {
    for (let index = 0; index < 5; index++) {
      const model = new TaskItemModel(`${index + 1}`, `任务${index + 1}`)
      this.taskList.push(model)
    }

    this.updateCompletedCount()
  }

  build() {
    Column() {
      // 仪表盘
      ChildDashboard()
        .margin(20)

      // // 添加按钮
      // Button("添加任务")
      //   .width(210)
      //   .onClick(() => {
      //     this.createNewTask()
      //   })

      // 任务列表
      ChildTaskList({ taskList: this.taskList, clickCallback: ()=>{
        this.updateCompletedCount()
      }})

    }
    .height
    ('100%')
    .width
    ('100%')
    .backgroundColor
    ("#d9e1ff")

  }
}

@Observed
class TaskItemModel {
  id: string = ""
  name: string = ""
  isCompletion: boolean = false

  constructor(id: string, name: string) {

    this.id = id

    this.name = name

    this.isCompletion = false

  }
}

@Component
struct ChildTaskList {
  @Link taskList: Array<TaskItemModel>
  clickCallback?: () => void

  build() {
    Column() {
      // 添加按钮
      Button("添加任务")
        .width(210)
        .onClick(() => {
          const currentLength = this.taskList.length
          const model = new TaskItemModel(`${currentLength + 1}`, `任务${currentLength + 1}`)
          this.taskList.push(model)
          if (this.clickCallback) {
            this.clickCallback()
          }
        })

      Scroll() {
        Column({ space: 15 }) {
          ForEach(this.taskList, (item: TaskItemModel, index: number) => {

            ChildTaskItem({ itemModel: item, clickCallback:this.clickCallback})

          }, (item: TaskItemModel) => {
            return item.id
          })
        }
        .margin(10)
      }
      .width("100%")
      .scrollable(ScrollDirection.Vertical)
      .scrollBar(BarState.Off)
      .edgeEffect(EdgeEffect.Spring)
      .padding({ bottom: 300 })
    }
  }
}

@Component
struct ChildDashboard {

  @Consume taskListCount : number
  @Consume completedCount : number

  build() {
    Row() {
      Row({ space: 20 }) {
        Text("任务进度:")
          .fontColor(Color.Black)
          .fontWeight(FontWeight.Bold)
          .fontSize(30)
        Stack() {
          Progress({ value: this.completedCount, total: this.taskListCount, type: ProgressType.Ring })
            .height("90%")
          Text(`${this.completedCount}/${this.taskListCount}`) {
          }
          .fontSize(25)
          .fontWeight(FontWeight.Bold)
        }
        .height("100%")
      }
      .width("100%")
      .justifyContent(FlexAlign.Center)
    }
    .shadowBorderRowStyle(150)

  }
}

@Component
struct ChildTaskItem {
  // 子组件 使用 @ObjectLink 来监听嵌套对象
  // @ObjectLink itemModel: TaskItemModel
  @State itemModel: TaskItemModel = new TaskItemModel(`${1}`, `任务`)
  clickCallback?: () => void

  build() {
    Row() {
      Text(`${this.itemModel.name}+${this.itemModel.isCompletion ? "YES" : "NO"}`)
        .fontWeight(FontWeight.Bold)
        .fontSize(20)
        .margin({ left: 20 })

      Checkbox({ name: `${this.itemModel.id}}`, group: `group` })
        .margin({ right: 20 })
        .onChange((value: boolean) => {
          this.itemModel.isCompletion = value
          if(this.clickCallback) {
            this.clickCallback()
          }
        })
    }
    .justifyContent(FlexAlign.SpaceBetween)
    .shadowBorderRowStyle(80)

  }
}