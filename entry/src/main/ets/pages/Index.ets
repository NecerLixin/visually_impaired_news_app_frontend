import router from '@ohos.router'
import {OCRPage} from './OCRPage'
@Entry
@Component
struct Index {
  @State message: string = 'Hello World'

  build() {
    Row() {
      Column() {
        Image("https://p2.img.cctvpic.com/photoworkspace/contentimg/2024/05/22/2024052220435285125.png")
        Text(this.message)
          .fontSize(50)
          .fontWeight(FontWeight.Bold)
          .onClick(()=>{
            router.pushUrl({url:'pages/NewsViewPage'})
          })
      }
      .width('100%')
    }
    .height('100%')
  }
}