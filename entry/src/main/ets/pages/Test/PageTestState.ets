import { StateChildren } from '../../view/StateChildren';
import { StartOptions } from '@kit.AbilityKit';
import { UserModel } from '../../viewmodel/UserModel';

@Entry
@Component
struct Page6_StateTEST {
  @State message: string = 'Hello World';

  // @State parentTitle: string = "这是父组件的标题"

  // @State userModel: UserModel = new UserModel("1", "李三")

  // @State simpleList: Array<string> = ['one', 'two', 'two', 'three', "1"];

  build() {
    RelativeContainer() {

      // 测试 ForEach 的 keyGenerator唯一性
        // Column() {
        //   ForEach(this.simpleList, (item: string) => {
        //     Text(`${item}`)
        //       .fontSize(50)
        //   }, (item: string) => item)
        // }
        // .width('100%')
        // .height('100%')


        // Text(`${this.userModel.name}`)
        // Button("父组件修改")
        //   .onClick(()=>{
        //     this.userModel.name = "父：张三"
        //   })
        //
        // StateChildren({userModel: this.userModel})
      }
      .width("100%")
      .height("100%")
  }
}