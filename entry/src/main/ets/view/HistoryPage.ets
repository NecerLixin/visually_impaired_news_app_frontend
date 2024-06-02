import wordModel from './HistoryViewModel'
import ArrayList from '@ohos.util.ArrayList';
import { HistoryModel } from '../model/HistoryModel'
import {getItem}  from '../common/history_com'
import router from '@ohos.router';
//生成每一条历史记录的卡片
@Builder function HistoryCard(item:HistoryModel, account:string){
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
            .decoration({type:TextDecorationType.LineThrough})
            .textAlign(TextAlign.Start)
          Text(item.history_time)
            .fontSize(10)
            .fontColor('#888')
        }.justifyContent(FlexAlign.Start)
        .width('70%')
        .height("100%")
      }.height('45%')

    }
    .alignItems(HorizontalAlign.Start)
  }
  .onClick(()=>{
    router.replaceUrl({
      url: 'pages/NewsViewPage',
      params: {
        news_id :item.news_id,
        account :account
      }
    })
  })
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
        List({space:10}){
            ForEach(this.items,(item:HistoryModel)=>{
              ListItem(){
                  HistoryCard(item,this.account)
              }
            })
        }
        .padding({left:10,right:10})
        .layoutWeight(1)
      }
      .width('100%')
    .height('100%')
    .backgroundColor('#eee')
  }
}