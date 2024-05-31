import NewsViewModel,{ CustomRefreshLoadLayoutClass,NewsTypeBean,ResponseResult} from '../viewModel/NewsViewModel'
import { CommonConstant as Const } from '../../../../../../visually_impaired_news_app_frontend/entry/src/main/ets/common/constant/CommonConstant';
import NewsModel from '../viewModel/NewsModel';
import RefreshLayout from '../../../../../../visually_impaired_news_app_frontend/entry/src/main/ets/view/RefreshLayout';
import  HttpRequestGet  from '../../../../../../visually_impaired_news_app_frontend/entry/src/main/ets/common/utils/HttpUtil'
import { History } from './HistoryPage'
@Component
export default struct TabBar {

  @State tabBarArray:NewsTypeBean[] = NewsViewModel.getDefaultTypeList()
  @State currentIndex: number = 0;
  @State currentPage: number = 1;
  @State newsModel: NewsModel = new NewsModel()
  @State items:ResponseResult[] = []
  async aboutToAppear() {
    this.items = await HttpRequestGet.getWord()
    console.log(JSON.stringify(this.items[0]))
    console.log(this.items[0].brief)
    console.log(this.items[0].news_category)
    //this.changeCategory()
  }
  build() {
    Tabs(){
      TabContent(){
        this.ListLayout()
      }.tabBar(this.TabBuilder(0))
      TabContent(){
        History()
      }.tabBar(this.TabBuilder(1))
    }
    .barHeight(Const.TabBars_BAR_HEIGHT)
    .barMode(BarMode.Scrollable)
    .barWidth(Const.TabBars_BAR_WIDTH)
    .onChange((index: number) => {
      this.currentIndex = index;
      this.currentPage = 1;
    })
    .vertical(false)
  }

  @Builder ListLayout() {
    List() {
      ForEach(this.items, (newsData: ResponseResult) => {
        ListItem() {
        Row({space:10}){
          Column() {
            Row(){
              // Text(newsData.news_category)
              //   .width('11.9%')
              //   .height(20)
              //   .fontColor(Color.Blue)
              //   .objectFit(ImageFit.Fill)
              Text(newsData.news_title)
                .fontSize(20)
                .fontColor(Color.Black)
                .fontWeight(FontWeight.Bold)
            }
            .margin(5)
            Row(){
              Image(newsData.news_img_url)
              .width(100)
              Column(){
                Text(newsData.brief.substring(0,60))
                  .fontSize(10)
                  .fontColor('#888')
                  .decoration({type:TextDecorationType.LineThrough})
                  .textAlign(TextAlign.Start)
                Text(newsData.news_date)
                  .fontSize(10)
                  .fontColor('#888')
                  //.textAlign(TextAlign.End)
                  .align(Alignment.BottomEnd)
              }.justifyContent(FlexAlign.Start)
              .width('70%')
              .height("100%")
            }.height('45%')
          }
          .alignItems(HorizontalAlign.Start)
        }
        .width('100%')
        .height('20%')
        .padding({left:14,right:14})
        .backgroundColor('#fff')
        .borderRadius(8)
      }
      // .height(256)
      // .width('100%')
      .backgroundColor(Color.White)
      .margin({ top: 12 })
      .borderRadius(Const.NewsListConstant_ITEM_BORDER_RADIUS)
      })
    }
    .padding({left:10,right:10})
    .layoutWeight(1)
    .width('93.3%')
    .height('100%')
    .backgroundColor('#f1f3f5')
    .margin({ left: Const.NewsListConstant_LIST_MARGIN_LEFT, right: Const.NewsListConstant_LIST_MARGIN_RIGHT })
    .divider({
      color: '#e2e2e2',
      strokeWidth: Const.NewsListConstant_LIST_DIVIDER_STROKE_WIDTH,
      endMargin: Const.NewsListConstant_LIST_MARGIN_RIGHT
    })
    // Remove the rebound effect.
    .edgeEffect(EdgeEffect.None)
    .offset({ x: 0, y: `${this.newsModel.offsetY}px` })
    .onScrollIndex((start: number, end: number) => {
      // Listen to the first index of the current list.
      this.newsModel.startIndex = start
      this.newsModel.endIndex = end
    })
  }

  @Builder TabBuilder(index:number){
    Column(){
      Text(this.tabBarArray[index].name)
        .height(Const.FULL_HEIGHT)
        .padding({ left: Const.TabBars_HORIZONTAL_PADDING, right: Const.TabBars_HORIZONTAL_PADDING })
        .fontSize(this.currentIndex === index ? Const.TabBars_SELECT_TEXT_FONT_SIZE : Const.TabBars_UN_SELECT_TEXT_FONT_SIZE)
        .fontWeight(this.currentIndex === index ? Const.TabBars_SELECT_TEXT_FONT_WEIGHT : Const.TabBars_UN_SELECT_TEXT_FONT_WEIGHT)
        .fontColor('#182431')
    }
  }
}
