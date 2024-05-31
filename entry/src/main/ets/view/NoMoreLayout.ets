@Component
export struct NoMoreLayout {
  build() {
    Row() {
      Text('没有更多数据了')
        .margin({ left: 8 })
        .fontSize(16)
        .textAlign(TextAlign.Center)
    }
    .width('100%')
    .justifyContent(FlexAlign.Center)
    .height(70)
  }
}