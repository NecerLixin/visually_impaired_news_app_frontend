import { CustomRefreshLoadLayoutClass } from '../viewModel/HomeViewModel'
import { CustomRefreshLoadLayout } from '../../../../../../visually_impaired_news_app_frontend/entry/src/main/ets/view/CustomRefreshLoadLayout'
@Component
export struct LoadMoreLayout {
  @ObjectLink loadMoreLayoutClass:CustomRefreshLoadLayoutClass
  build() {
    Column() {
      if (this.loadMoreLayoutClass.isVisible){
        CustomRefreshLoadLayout({
          customRefreshLoadClass: new CustomRefreshLoadLayoutClass(this.loadMoreLayoutClass.isVisible,
            this.loadMoreLayoutClass.imageSrc, this.loadMoreLayoutClass.textValue, this.loadMoreLayoutClass.heightValue)
        })
      }else {
        CustomRefreshLoadLayout({
          customRefreshLoadClass:new CustomRefreshLoadLayoutClass(this.loadMoreLayoutClass.isVisible,
          this.loadMoreLayoutClass.imageSrc,this.loadMoreLayoutClass.textValue,0)
        })
      }
    }
  }
}