import router from '@ohos.router'
import {OCRPage} from './OCRPage'
@Entry
@Component
struct Index {
  @State message: string = 'Hello World'

  build() {
    Row() {
      Column() {
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