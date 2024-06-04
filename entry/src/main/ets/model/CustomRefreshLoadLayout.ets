import { CustomRefreshLoadLayoutClass } from '../viewModel/HomeViewModel'
@Component
export struct CustomRefreshLoadLayout {

  @ObjectLink customRefreshLoadClass:CustomRefreshLoadLayoutClass
  build() {
    Row() {
      Image(this.customRefreshLoadClass.imageSrc)
        .width(18)
        .height(18)

      Text(this.customRefreshLoadClass.textValue)
        .margin({left:7})
        .fontSize(17)
        // .textAlign(TextAlign.Center)
    }
    .clip(true)
    .width('100%')
    .justifyContent(FlexAlign.Center)
    .height(this.customRefreshLoadClass.heightValue)
  }
}