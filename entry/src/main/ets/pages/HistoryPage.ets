import wordModel from '../model/HistoryModel'
import ArrayList from '@ohos.util.ArrayList';
import { HistoryViewModel } from '../view/HistoryViewModel'
import {getItem}  from '../common/history_com'
//生成每一条历史记录的卡片
@Builder function HistoryCard(item:HistoryViewModel){
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
  .width('100%')
  .height('20%')
  .padding({left:14,right:14})
  .backgroundColor('#fff')
  .borderRadius(8)
}

@Entry
@Component
struct History {
  //初始化items
@State items:HistoryViewModel[] = []
  //使用异步方法获取items
  async aboutToAppear(){
    this.items = await getItem()
    //console.log(JSON.stringify(this.items))
  }

  build() {
      Column() {
        Row(){
          Image($r('app.media.historty_back'))
            .backgroundColor(Color.White)
            .width(30)
          Text("历史记录")
            .fontSize(25)
            .onClick(()=>console.log('test',this.items[0].title))
        }
        .width('100%')
        .height(60)
        .padding({left:14, right:14})
        .justifyContent(FlexAlign.Start)
        //使用List展示卡片
        List({space:10}){
            ForEach(this.items,(item:HistoryViewModel)=>{
              ListItem(){
                  HistoryCard(item)
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