import  TabBar  from '../view/TabBar'

@Entry
@Component
struct HomePage {

  build() {
    Column() {
      TabBar()
    }
    .backgroundColor('#f1f3f5')
    .width('100%')
    .height('100%')
  }
}