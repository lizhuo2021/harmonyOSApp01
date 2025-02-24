import { UserModel, Car } from '../viewmodel/UserModel';

@Component
export struct TestObjectLinkForArrayView {
  // @Prop model: UserModel
  @ObjectLink model: UserModel

  build() {
    Column() {
      Text(`客户名称：${this.model.name}` + `\n车辆品牌：${this.model.car.carName}` +
        `\n车牌号：${this.model.car.carNumber.toString()}`)
        .fontColor(Color.Red)
        .fontSize(30)
      // 可以修改第一层数据
      Button("修改客户名字")
        .onClick(()=>{
          this.model.name = "默认名字"
        })
      // 无法修改第二层
      Button("修改车辆品牌")
        .onClick(()=>{
           this.model.car.carName = "默认品牌"
        })
    }

  }
}

@Component
export struct TestObjectLinkForObjView {
  @ObjectLink car: Car

  build() {
    Column() {
      Text(`\n车辆品牌：${this.car.carName}`)
        .fontColor(Color.Red)
        .fontSize(30)
      Button("修改车辆品牌")
        .onClick(() => {
          this.car.carName = "子组件修改的默认品牌"
        })
    }

  }
}