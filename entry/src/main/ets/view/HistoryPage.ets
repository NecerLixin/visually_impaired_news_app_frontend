import wordModel from './HistoryViewModel'
import ArrayList from '@ohos.util.ArrayList';
import { HistoryModel } from '../model/HistoryModel'
import {getItem}  from '../common/history_com'
import router from '@ohos.router';
//生成每一条历史记录的卡片
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
@Component
export struct History {
  //初始化items
  @State items:HistoryModel[] = []
  @State currentIndex:number = 0
  private scroller = new Scroller()
  account = ''
  //使用异步方法获取items
  async aboutToAppear(){
    this.account = router.getParams()['account']
    this.items = await getItem(this.account)
    console.log('成功触发')
  }

  build() {
    Column() {
      //使用List展示卡片
      List({space:10,initialIndex:this.currentIndex , scroller:this.scroller}){
        ForEach(this.items,(item:HistoryModel,index:number)=>{
          ListItem(){
            if(index == this.currentIndex){
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
    }
    .gesture(TapGesture({count:2}).onAction(event=>{
      router.replaceUrl({
        url: 'pages/NewsViewPage',
        params: {
          news_id :this.items[this.currentIndex].news_id,
          account :this.account
        }
      })
    }))
    .gesture(TapGesture({count:1}).onAction(event=>{
      this.currentIndex++
      this.currentIndex = this.currentIndex % this.items.length
      //console.log("currentItemIndex",this.currentIndex.toString())
      this.scroller.scrollToIndex(this.currentIndex)
    }))
    .width('100%')
    .height('100%')
    .backgroundColor('#eee')
  }
}