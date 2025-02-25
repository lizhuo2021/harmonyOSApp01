// @Extend(Row)
// function shadowBorderRowStyle(height: number = 100) {
//   .backgroundColor(Color.White)
//   .borderRadius(10)
//   .shadow({ radius: 20, color: Color.Black, offsetY: 10 })
//   .height(height)
//   .width('100%')
// }
//
// let localStorage = new LocalStorage()
//
// @Entry(localStorage)
// @Component
// struct Page_Exercises01 {
//   // @LocalStorageLink("taskList") taskList: Array<TaskItemModel> = []
//
//   @State taskList: Array<TaskItemModel> = []
//   @Provide totalSize: number = 0
//   @Provide selectSize: number = 0
//
//   createNewTask() {
//     const currentLength = this.taskList.length
//     const model = new TaskItemModel(`${currentLength + 1}`, `任务${currentLength + 1}`)
//     this.taskList.push(model)
//   }
//
//   aboutToAppear(): void {
//     for (let index = 0; index < 5; index++) {
//       const model = new TaskItemModel(`${index + 1}`, `任务${index + 1}`)
//       this.taskList.push(model)
//     }
//     localStorage.setOrCreate("taskList", this.taskList)
//     this.updateProgress()
//   }
//
//   build() {
//     Column() {
//       // 仪表盘
//       ChildDashboard({ taskList: this.taskList })
//         .margin(20)
//
//       // // 添加按钮
//       // Button("添加任务")
//       //   .width(210)
//       //   .onClick(() => {
//       //     this.createNewTask()
//       //   })
//
//       // 任务列表
//       ChildTaskList({ taskList: this.taskList, clickCallback: () => {
//         this.updateProgress()
//       }})
//     }
//     .height
//     ('100%')
//     .width
//     ('100%')
//     .backgroundColor
//     ("#d9e1ff")
//   }
//
//   private updateProgress() {
//     this.totalSize = this.taskList.length
//     this.selectSize = this.taskList.reduce((sum: number, item: TaskItemModel) => {
//       if (item.isCompletion) {
//         sum += 1
//       }
//       return sum
//     }, 0)
//   }
// }
//
// @Observed
// class TaskItemModel {
//   id: string = ""
//   name: string = ""
//   isCompletion: boolean = false
//
//   constructor(id: string, name: string) {
//
//     this.id = id
//
//     this.name = name
//
//     this.isCompletion = false
//
//   }
// }
//
// @Component
// struct ChildTaskList {
//   // @LocalStorageLink("taskList") taskList: Array<TaskItemModel> = []
//
//   @Link taskList: Array<TaskItemModel>
//   clickCallback?: () => void
//
//   build() {
//     Column() {
//       // 添加按钮
//       Button("添加任务")
//         .width(210)
//         .onClick(() => {
//           const currentLength = this.taskList.length
//           const model = new TaskItemModel(`${currentLength + 1}`, `任务${currentLength + 1}`)
//           this.taskList.push(model)
//           this.clickCallback?.()
//         })
//
//       Scroll() {
//         Column({ space: 15 }) {
//           ForEach(this.taskList, (item: TaskItemModel, index: number) => {
//
//             ChildTaskItem({ itemModel: item, clickCallback: this.clickCallback })
//
//           }, (item: TaskItemModel) => {
//             return item.id
//           })
//         }
//         .margin(10)
//       }
//       .width("100%")
//       .scrollable(ScrollDirection.Vertical)
//       .scrollBar(BarState.Off)
//       .edgeEffect(EdgeEffect.Spring)
//       .padding({ bottom: 300 })
//     }
//   }
// }
//
// @Component
// struct ChildDashboard {
//   @Link taskList: Array<TaskItemModel>
//
//   @Consume totalSize: number
//   @Consume selectSize: number
//
//   // getCompletedCount() {
//   //   console.log("走了getCompletedCount")
//   //   const number = this.taskList.reduce((sum: number, item: TaskItemModel) => {
//   //     if (item.isCompletion) {
//   //       sum += 1
//   //     }
//   //     return sum
//   //   }, 0)
//   //
//   //   return number
//   // }
//
//   build() {
//     Row() {
//       Row({ space: 30 }) {
//         Text("任务进度:")
//           .fontColor(Color.Black)
//           .fontWeight(FontWeight.Bold)
//           .fontSize(30)
//           .margin({ left: 30 })
//         Stack() {
//           Progress({ value: this.selectSize, total: this.totalSize, type: ProgressType.Ring })
//             .width("30%")
//           Text(`${this.selectSize}/${this.totalSize}`) {
//           }
//           .fontSize(25)
//           .fontWeight(FontWeight.Bold)
//         }
//         .height("100%")
//       }
//     }
//     .shadowBorderRowStyle(150)
//
//   }
// }
//
// @Component
// struct ChildTaskItem {
//   // 子组件 使用 @ObjectLink 来监听嵌套对象
//   // @ObjectLink itemModel: TaskItemModel
//   @State itemModel: TaskItemModel = new TaskItemModel(`${1}`, `任务`)
//   clickCallback?: () => void
//
//   build() {
//     Row() {
//       Text(`${this.itemModel.name}+${this.itemModel.isCompletion ? "YES" : "NO"}`)
//         .fontWeight(FontWeight.Bold)
//         .fontSize(20)
//         .margin({ left: 20 })
//
//       Checkbox({ name: `${this.itemModel.id}}`, group: `group` })
//         .margin({ right: 20 })
//         .onChange((value: boolean) => {
//           this.itemModel.isCompletion = value
//           this.clickCallback?.()
//         })
//     }
//     .justifyContent(FlexAlign.SpaceBetween)
//     .shadowBorderRowStyle(80)
//
//   }
// }