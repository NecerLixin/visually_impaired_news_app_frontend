import NewsViewModel,{ CustomRefreshLoadLayoutClass,NewsTypeBean,ResponseResult} from '../viewModel/HomeViewModel'
import { CommonConstant as Const } from '../../../../../../visually_impaired_news_app_frontend/entry/src/main/ets/common/constant/CommonConstant';
import NewsModel from '../viewModel/NewsModel';
import RefreshLayout from './/RefreshLayout';
import  HttpRequestGet  from '../../../../../../visually_impaired_news_app_frontend/entry/src/main/ets/common/utils/HttpUtil'
import router from '@ohos.router';
import { Connect } from '../common/HomeConnect'
import {ConnectState} from '../common/utils/State'
import {AudioPlayer} from '../common/utils/AudioPlay'
import {API} from '../common/utils/API'
import { HistoryModel } from '../model/HistoryModel'
import {getItem}  from '../common/history_com'
@Component
export default struct TabBar {
  @State tabBarArray:NewsTypeBean[] = NewsViewModel.getDefaultTypeList()
  @State currentIndex: number = 0;
  @State currentPage: number = 1;
  @State newsModel: NewsModel = new NewsModel()
  @State items:ResponseResult[] = []
  @State connectState:number = ConnectState.IsConnecting
  @State currentItemIndex: number = -1;
  @State bcColor:Color = Color.Orange
  private scroll = new Scroller()
  private  ap = new AudioPlayer()

  @State account:string = ""
  itemIndex:number
  //历史记录部分
  @State historyItems:HistoryModel[] = []
  @State historyCurrentItemIndex:number = 0
  //音频播放部分
  @State isRead:boolean = false
  delay(){
    return new Promise((resolve,reject)=>{
      setTimeout(resolve,1000)
    })
  }

  //标题阅读函数
  async titleAudio(news_id:string){
    console.log('change item'+news_id)
    this.ap.quit()
    await this.delay().then(()=>{
      console.log('22222')
    })
    this.ap.avPlayerUrlDemo(API.audio_title + news_id)
    //ap.quit()
  }


  async aboutToAppear() {
    this.itemIndex = router.getParams()['itemIndex']
    console.log("itemIndex",this.itemIndex.toString())
    this.currentItemIndex = this.itemIndex
    this.connectState = ConnectState.IsConnecting
    this.items = await HttpRequestGet.getWord()
    console.log(JSON.stringify(this.items[0]))
    console.log(this.items[0].brief)
    this.account = router.getParams()['account']
    this.ap.avPlayerUrlDemo(API.audio_home)
    this.isRead = true
    if(this.items.length > 0){
      this.connectState = ConnectState.IsConnected
    }
    else{
      this.connectState = ConnectState.IsConnectingError
    }
    this.historyCurrentItemIndex = router.getParams()['itemIndex']
    this.historyItems = await getItem(this.account)
  }

  build() {
    Tabs(){
      TabContent(){
        if(this.connectState === ConnectState.IsConnecting){
          this.Loading()
        }
        else{
          List({initialIndex: 0 , scroller: this.scroll}) {
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
        if(this.currentItemIndex >= 0) {
          console.log('addhistory',this.currentItemIndex.toString())
          Connect(this.account, this.items[this.currentItemIndex].news_id).then(res => {
            if(this.isRead==true){
              this.ap.quit()
              this.isRead = false
              console.log('1111111')
            }
            router.replaceUrl({
              url: 'pages/NewsViewPage',
              params: {
                news_id: this.items[this.currentItemIndex].news_id,
                account: this.account,
                itemIndex: this.currentItemIndex
              }
            })
          })
        }
      }))
      .gesture(TapGesture({count:1}).onAction(event=>{
        this.currentItemIndex++
        this.currentItemIndex = this.currentItemIndex % this.items.length
        this.scroll.scrollToIndex(this.currentItemIndex)
        this.titleAudio(this.items[this.currentItemIndex].news_id)
      }))
      TabContent(){
        //使用List展示卡片
        List({space:10,initialIndex:this.historyCurrentItemIndex , scroller:this.scroll}){
          ForEach(this.historyItems,(item:HistoryModel, index:number)=>{
            ListItem(){
              if(index == this.historyCurrentItemIndex){
                HistoryCard(item,Color.Orange)
              }
              else{
                HistoryCard(item,Color.White)
              }
            }
          })
        }
        .padding({left:10,right:10})
        .layoutWeight(1)
        .width('100%')
        .height('100%')
        .backgroundColor('#eee')
      }.tabBar(this.TabBuilder(1))
      .gesture(TapGesture({count:2}).onAction(event=>{
        if(this.isRead==true){
          this.ap.quit()
          this.isRead = false
          console.log('1111111')
        }
        router.replaceUrl({
          url: 'pages/NewsViewPage',
          params: {
            news_id :this.historyItems[this.historyCurrentItemIndex].news_id,
            account :this.account,
            itemIndex:this.historyCurrentItemIndex
          }
        })}))
      .gesture(TapGesture({count:1}).onAction(event=>{
        this.historyCurrentItemIndex++
        this.historyCurrentItemIndex = this.historyCurrentItemIndex % this.historyItems.length
        this.scroll.scrollToIndex(this.historyCurrentItemIndex)
        console.log('12345678')
        this.titleAudio(this.historyItems[this.historyCurrentItemIndex].news_id)
      }))
    }
    .barHeight(Const.TabBars_BAR_HEIGHT)
    .barMode(BarMode.Scrollable)
    .barWidth(Const.TabBars_BAR_WIDTH)
    .onChange((index: number) => {
      if(this.currentIndex!=index){
      if(index==1){
        this.delay()
        this.ap.avPlayerUrlDemo(API.audio_history)
      }
      else if(index==0){
        this.delay()
        this.ap.avPlayerUrlDemo(API.audio_home)
      }}
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
@Builder function HistoryCard(item:HistoryModel,Bcground:Color){
  Row({space:10}){
    Column(){
      Row(){
        Text(item.title)
          .fontSize(20)
          .fontColor(Color.Black)
          .fontWeight(FontWeight.Bold)
      }.margin(5)
      Row(){
        Image(item.img_url)
          .width(100)
        Column(){
          Text(item.news_brief.substring(0,60))
            .fontSize(10)
            .fontColor('#888')
            .width("80%")
            .textAlign(TextAlign.Start)
          Text(item.history_time)
            .fontSize(10)
            .fontColor('#888')
        }.justifyContent(FlexAlign.Start)
        .width('70%')
        .height("100%")
      }.height('45%')

    }
    .backgroundColor(Bcground)
    .alignItems(HorizontalAlign.Start)
  }
  .width('100%')
  .height('20%')
  .padding({left:14,right:14})
  .backgroundColor('#fff')
  .borderRadius(8)
}