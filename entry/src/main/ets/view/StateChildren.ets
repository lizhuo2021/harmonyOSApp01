import { UserModel } from "../viewmodel/UserModel"

@Component
export struct StateChildren {

  // @Prop userModel: UserModel
  @Link userModel: UserModel


  build() {
     Column() {

       Text(`${this.userModel.name}`)
         .fontSize(30)
       Button("子组件修改")
         .onClick(()=>{
           this.userModel.name = "子：王五"
         })

     }
     .margin({top: 20})
  }

}