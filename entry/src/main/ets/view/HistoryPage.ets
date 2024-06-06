import wordModel from './HistoryViewModel'
import ArrayList from '@ohos.util.ArrayList';
import { HistoryModel } from '../model/HistoryModel'
import {getItem}  from '../common/history_com'
import router from '@ohos.router';
import { AudioPlayer } from '../common/utils/AudioPlay';
import {API} from '../common/utils/API'
//生成每一条历史记录的卡片

@Component
export struct History {
  //初始化items
  @State historyItems:HistoryModel[] = []
  @State historyCurrentItemIndex:number = 0
  private scroller = new Scroller()
  private ap =new AudioPlayer()
  account = ''
  //音频播放部分
  @State isRead:boolean = false


  delay(){
    return new Promise((resolve,reject)=>{
      setTimeout(resolve,1000)
    })
  }

  //标题阅读函数
  async historyTitleAudio(news_id:string){
    console.log('change item'+news_id)
    this.ap.quit()
    await this.delay().then(()=>{
      console.log('22222')
    })
    this.ap.avPlayerUrlDemo(API.audio_title + news_id)
  }
  //使用异步方法获取items


  build() {
    Column() {
      //使用List展示卡片
      List({space:10,initialIndex:this.historyCurrentItemIndex , scroller:this.scroller}){
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
    }
    .gesture(TapGesture({count:2}).onAction(event=>{
      router.replaceUrl({
        url: 'pages/NewsViewPage',
        params: {
          news_id :this.historyItems[this.historyCurrentItemIndex].news_id,
          account :this.account
        }
      })
    }))
    .gesture(TapGesture({count:1}).onAction(event=>{
      this.historyCurrentItemIndex++
      this.historyCurrentItemIndex = this.historyCurrentItemIndex % this.historyItems.length
      this.scroller.scrollToIndex(this.historyCurrentItemIndex)
      console.log('12345678')
      this.historyTitleAudio(this.historyItems[this.historyCurrentItemIndex].news_id)
    }))
    .width('100%')
    .height('100%')
    .backgroundColor('#eee')
  }
}