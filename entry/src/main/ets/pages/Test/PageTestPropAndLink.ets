// 父组件
@Entry
@Component
struct PopAndLinkParent {
  @State message: string = "初始消息"

  build() {
    Column() {
      PopAndLinkChild({ childMsg: this.message })
      Text(`父组件: ${this.message}`)
    }
  }
}

// 子组件
@Component
struct PopAndLinkChild {
  @Link childMsg: string
  // @Prop childMsg: string

  build() {
    Button('修改消息')
      .onClick(() => {
        this.childMsg = '子组件修改后的消息'
      })
  }
}
