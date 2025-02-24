import { router } from '@kit.ArkUI'
import {TaskModel, TaskModelStatus } from '../viewmodel/TaskModel'
import {TaskItem} from "../view/TaskItem"
import storage from '@ohos.data.storage'
import { RouterParamsType } from '../viewmodel/RouterParamsType'

@Entry({ storage: LocalStorage.getShared() })
@Component
struct Page_SortTaskList {
  @State status: TaskModelStatus = TaskModelStatus.undone
  @State title: string = ""
  @StorageLink("tasks") tasks: Array<TaskModel> = [];

  aboutToAppear(): void {
    const params = router.getParams()

    const status = (params as RouterParamsType<TaskModelStatus>).value
    this.status = status

    if (status == TaskModelStatus.done) {
      this.title = "已完成列表"
    }else if (status == TaskModelStatus.undone) {
      this.title = "未完成列表"
    }else if (status == TaskModelStatus.future) {
      this.title = "未来任务列表"
    }else if (status == TaskModelStatus.doing) {
      this.title = "等待中列表"
    }
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
          Text(`${this.title}`) {
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

        Scroll() {
          // 列表部分
          TaskItem({ tasks: this.tasks, byStatus: this.status })
        }
        .width("100%")
        .scrollable(ScrollDirection.Vertical)
        .scrollBar(BarState.Off)
        .edgeEffect(EdgeEffect.Spring)
        .padding({ bottom: 100 })

      }
      .height('100%')
      .width('100%')
    }

  }
}