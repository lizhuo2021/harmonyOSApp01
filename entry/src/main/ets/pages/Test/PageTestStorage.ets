
// 初始化storage实例
// let storage: LocalStorage = new LocalStorage()
// // 保存数据
// storage.setOrCreate("key", "小王")
import { router } from '@kit.ArkUI'


// 给Entry添加storage
// @Entry(storage)

// EntryAbility层级的LocalStorage需要通过LocalStorage.getShared()获取
@Entry({ storage: LocalStorage.getShared() })
@Component
struct PageTestStorage {
  // 可以使用@LocalStorageLink/Prop与LocalStorage实例中的变量建立联系

  // @LocalStorageProp('key') savedKeyForProp: string = "333"
  // @LocalStorageLink("key") savedKeyForLink: string = "111"

  @LocalStorageLink("windowStage") windowStage: string = "默认值"

  @StorageProp("appStorage") appStorage: number = 100

  build() {
    Column() {
      // Text(this.savedKeyForProp)
      //   .id('PageTestStorageHelloWorld')
      //   .fontSize($r('app.float.page_text_font_size'))
      //   .fontWeight(FontWeight.Bold)
      //   .onClick(()=>{
      //     this.savedKeyForProp = "Prop 小黑"
      //   })

      // Text(this.savedKeyForLink)
      //   .id('PageTestStorageHelloWorld')
      //   .fontSize($r('app.float.page_text_font_size'))
      //   .fontWeight(FontWeight.Bold)
      //   .fontColor(Color.Red)
      //   .onClick(()=>{
      //     this.savedKeyForLink = "link 小黑"
      //   })
      Button("修改").onClick((event: ClickEvent) => {
        // this.windowStage = "被修改了的值"
        this.appStorage = 300
      })
      Text(this.appStorage.toString())
        .id('PageTestStorageHelloWorld')
        .fontSize($r('app.float.page_text_font_size'))
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.Red)
        .onClick(() => {

          router.pushUrl({url:"pages/Page_TaskList"})
        })
    }
    .height('100%')
    .width('100%')
  }
}