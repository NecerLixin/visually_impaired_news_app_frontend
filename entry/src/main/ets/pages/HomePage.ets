import  TabBar  from '../model/TabBar'
import router from '@ohos.router';

@Entry
@Component
struct HomePage {
  private  itemIndex:number = -1

  // aboutToAppear(){
  //   this.itemIndex = router.getParams()['itemIndex']
  // }
  build() {
    Column() {
      TabBar()
    }
    .backgroundColor('#f1f3f5')
    .width('100%')
    .height('100%')
  }
}