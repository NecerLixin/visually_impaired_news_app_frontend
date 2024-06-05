import NewsViewModel,{ CustomRefreshLoadLayoutClass,NewsTypeBean,ResponseResult} from '../viewModel/HomeViewModel'
import { CommonConstant as Const } from '../../../../../../visually_impaired_news_app_frontend/entry/src/main/ets/common/constant/CommonConstant';
import NewsModel from '../viewModel/NewsModel';
import RefreshLayout from './/RefreshLayout';
import  HttpRequestGet  from '../../../../../../visually_impaired_news_app_frontend/entry/src/main/ets/common/utils/HttpUtil'
import { History } from '../view/HistoryPage'
import router from '@ohos.router';
import { Connect } from '../common/HomeConnect'
import {ConnectState} from '../common/utils/State'
@Component
export default struct TabBar {

  @State tabBarArray:NewsTypeBean[] = NewsViewModel.getDefaultTypeList()
  @State currentIndex: number = 0;
  @State currentPage: number = 1;
  @State newsModel: NewsModel = new NewsModel()
  @State items:ResponseResult[] = []
  @State connectState:number = ConnectState.IsConnecting
  @State currentItemIndex: number = 0;
  @State bcColor:Color = Color.Orange
  private scroll = new Scroller()
  account:string
  async aboutToAppear() {
    this.connectState = ConnectState.IsConnecting
    this.items = await HttpRequestGet.getWord()
    console.log(JSON.stringify(this.items[0]))
    console.log(this.items[0].brief)
    //console.log('首页',router.getParams()['data1'])
    this.account = router.getParams()['account']
    if(this.items.length > 0){
      this.connectState = ConnectState.IsConnected
    }
    else{
      this.connectState = ConnectState.IsConnectingError
    }
    //this.changeCategory()
  }
  build() {
    Tabs(){
      TabContent(){
        if(this.connectState === ConnectState.IsConnecting){
          this.Loading()
        }
        else{
          List({initialIndex: this.currentItemIndex , scroller: this.scroll}) {
            ForEach(this.items, (newsData: ResponseResult,index:number) => {
              ListItem() {
                if(index == this.currentItemIndex){
                  this.BuilderRow(this.bcColor,newsData)
                }
                else{
                  this.BuilderRow(Color.White,newsData)
                }
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
      }.tabBar(this.TabBuilder(0))
      .gesture(TapGesture({count:2}).onAction(event=>{
        Connect(this.account,this.items[this.currentItemIndex].news_id).then(res=>{
          router.replaceUrl({
            url: 'pages/NewsViewPage',
            params: {
              news_id :this.items[this.currentItemIndex].news_id,
              account :this.account
            }
          })
        })
      }))
      .gesture(TapGesture({count:1}).onAction(event=>{
        this.currentItemIndex++
        this.currentItemIndex = this.currentItemIndex % this.items.length
        console.log("currentItemIndex",this.currentItemIndex.toString())
        this.scroll.scrollToIndex(this.currentItemIndex)
      }))
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



  @Builder Loading(){
    Column(){
        Image($r('app.media.ic_pull_up_load'))
          // .autoResize(true)
          // .sourceSize({width:10,height:10})
          // .width(10)
          .width(25).height(25)
    }
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .width('93.3%')
    .height('100%')
  }


  @Builder BuilderRow(bcGround:Color,newsData:ResponseResult){
    Row({space:10}){
      Column() {
        Row(){
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
              .textAlign(TextAlign.Start)
              .width("80%")
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
      .backgroundColor(bcGround)
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .height('20%')
    .padding({left:14,right:14})
    .backgroundColor('#fff')
    .borderRadius(8)
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
