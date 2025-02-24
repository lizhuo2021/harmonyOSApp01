import App from '@system.app'
import { TaskStatus } from "../view/TaskStatus"
import { TaskItem } from "../view/TaskItem"
import { router, Router} from '@kit.ArkUI'
import CreateTaskListMockData, {TaskModel, TaskModelStatus} from '../viewmodel/TaskModel';
import { getRandomDateByCurrentMonth } from '../utils/DateFormat';
import { StartOptions } from '@kit.AbilityKit';

let storage = LocalStorage.getShared()

@Entry(storage)
@Component
struct Page1_TaskList {

  @StorageLink("tasks") tasks: Array<TaskModel> = [];

  // 组件加载完毕后
  aboutToAppear(): void {
    this.tasks = CreateTaskListMockData.initData()
  }

  build() {

    RelativeContainer() {
      Column() {
        Text("你好！xxx")
          .fontColor($r("app.color.app_bold_title_text"))
          .fontSize(30)
          .fontWeight(FontWeight.Bold)
        Text("让每一天的工作都有效率")
          .fontSize(14)
          .fontColor(Color.Gray)
          .margin({ top: 14 })

        Scroll() {
          Column() {
            // 第二部分
            Text("我的计划")
              .fontColor($r("app.color.app_bold_title_text"))
              .fontSize(30)
              .fontWeight(FontWeight.Bold)
              .margin({ top: 30 })

            TaskStatus({tasks: this.tasks})

            //  第三个部分
            Column({ space: 10 }) {
              // 标题部分
              Row() {
                Text("今日任务")
                  .fontColor($r("app.color.app_bold_title_text"))
                  .fontSize(30)
                  .fontWeight(FontWeight.Bold)

                Text("查看更多")
                  .fontColor($r("app.color.app_bold_title_text"))
                  .fontSize(15)
                  .fontWeight(FontWeight.Normal)
              }
              .justifyContent(FlexAlign.SpaceBetween)
              .alignItems(VerticalAlign.Bottom)
              .width("100%")

              // 列表部分
              TaskItem({tasks: this.tasks, byStatus: TaskModelStatus.doing})


            }.width("100%")
            .margin({ top: 20 })
          }
          .alignItems(HorizontalAlign.Start)
        }
        .scrollable(ScrollDirection.Vertical)
        .scrollBar(BarState.Off)
        .edgeEffect(EdgeEffect.Spring)
        .padding({ bottom: 100 })

      }
      .width("100%")
      .height("100%")
      // column的侧轴，水平方向
      .alignItems(HorizontalAlign.Start)
      // column的主轴，垂直方向
      // .justifyContent(FlexAlign.SpaceBetween)
      .backgroundColor("#f1f3f5")
      .padding(10)

      Stack() {
        Image($r("app.media.icon_create_bg"))
          .width(40)
        Image($r("app.media.icon_add"))
          .width(20)
      }
      .alignRules({
        right: { anchor: "__container__", align: HorizontalAlign.End },
        bottom: { anchor: "__container__", align: VerticalAlign.Bottom }
      })
      .offset({ x: -30, y: -80 })
      .onClick(()=>{
        router.pushUrl({url:"pages/Page_CreateTask"})
      })
    }

  }
}