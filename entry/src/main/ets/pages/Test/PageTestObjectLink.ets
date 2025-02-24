import { TestObjectLinkForArrayView, TestObjectLinkForObjView } from '../../view/TestObjectLinkView';
import { UserModel, Car } from '../../viewmodel/UserModel';

@Entry
@Component
struct PageTestObjectLink {
  @State carOwner: Array<UserModel> = []

  @State user: UserModel = new UserModel("3", "小长", new Car("1", "大众", 444444))

  aboutToAppear(): void {
    this.carOwner.push(
      new UserModel("1", "小王", new Car("1", "保时捷", 88888))
    )
    this.carOwner.push(
      new UserModel("2", "小李", new Car("1", "奥迪", 66666))
    )
  }

  build() {
    Column() {

      Column() {
        // 对象数组
        // ForEach(this.carOwner, (item: UserModel, index: number) => {
        //   TestObjectLinkForArrayView({model: item})
        // }, (item: UserModel) => item.id)

        // TestObjectLinkForArrayView({model: this.user})
        Text(`客户名称：${this.user.name}` + `\n车辆品牌：${this.user.car.carName}` +
          `\n车牌号：${this.user.car.carNumber.toString()}`)
          .fontColor(Color.Red)
          .fontSize(30)
        Button("修改客户名字")
          .onClick(() => {
            this.user.name = "默认名字"
          })

        // Button("修改车辆品牌")
        //   .onClick(() => {
        //     this.user.car.carName = "父组件默认品牌"
        //   })

        TestObjectLinkForObjView({car: this.user.car})

      }
      .height('30%')
      .width('100%')

    }
    .height('100%')
    .width('100%')


  }
}