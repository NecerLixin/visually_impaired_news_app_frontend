import newsModel from '../view/NewsViewModel'
import {NewsModel,Content} from '../model/NewsModel'
import router from '@ohos.router'
import {AudioPlayer} from '../common/utils/AudioPlay'
import {API} from '../common/utils/API'
import {CommonHTTP} from '../common/utils/HttpUtil'
import {ConnectState} from '../common/utils/State'

class NewsPic{
  image:ResourceStr
  info:string
  constructor(image:ResourceStr,info:string) {
    this.image=image
    this.info=info
  }
}
@Entry
@Component
  //本页面为新闻浏览页面
struct NewsViewPage {
  @State newsInfo:NewsModel= new NewsModel('','',null,'','','')
  @State content:Content[] = []
  news_id:string
  account:string
  // @State Isread:Boolean = false
  @State @Watch('audioStateUpdate') isRead:boolean = true
  @State audioPlayer:AudioPlayer = new AudioPlayer()
  @State connectState:number = ConnectState.IsConnecting

  audioStateUpdate(){
    if(this.isRead==false){
      this.audioPlayer.avPlayerUrlDemo(API.audio + this.news_id + '.mp3')
    }
    else{
      if(this.isRead==true){this.audioPlayer.quit()}
    }
  }

  async aboutToAppear(){
    this.news_id = router.getParams()['news_id']
    this.account = router.getParams()['account']
    //let {title,author,time,contentItem} = await newsModel.getNews()
    this.newsInfo = await newsModel.getNews(API.get_news_one + this.news_id)
    let flag = await new CommonHTTP().http(API.tts + this.news_id)
    if(flag === true){
      this.connectState = ConnectState.IsConnected
    }
    else{
      this.connectState = ConnectState.IsConnectingError
    }
  }

    build() {
    Column() {
      Row() {
        Button() {
          Image($r('app.media.back_view'))
            .fillColor(Color.Gray)
            .width(20)
        }
        .width(30)
        .height(30)
        .backgroundColor(Color.White)
        .type(ButtonType.Normal)

        Text('新闻页面')
          .fontSize(28)
        Blank()

      }
      .onClick(()=>{
        this.audioPlayer.quit()
        router.replaceUrl({
          url: 'pages/HomePage',
          params: {
            // data1: '首页登录成功',
            account: this.account
          }
        })
      })
      .justifyContent(FlexAlign.Start)
      .padding({left:14,right:14})
      .width('100%')
      .height("10%")
      if(this.connectState === ConnectState.IsConnecting){
        this.TTSLoading()
      }
      else if(this.connectState === ConnectState.IsConnected){
        List({ space: 1 }) {
          ListItem() {
            Column() {
              Text(this.newsInfo.title)
                .fontSize(30)
                .textAlign(10)
              Text('作者：'+this.newsInfo.author)
                .fontSize(20)
              Text('发布时间'+this.newsInfo.time)
              Column({space:5}){
                ForEach(this.newsInfo.content,
                  (content:Content)=>{
                    if(content.type=="text"){
                      Text('  '+content.data)
                    }else if(content.type=="img_url"){
                      Image(content.data)
                        .width("100%")
                      // .height(200)
                    }else if(content.type=="img_desc"){
                      Text(content.data)
                        .fontSize(30)
                    }else if(content.type=="text-bold"){
                      Text(content.data)
                        .fontSize(30)
                    }
                  })
              }
            }
            .width('90%')
            .alignItems(HorizontalAlign.Center)
            .margin(20)
          }
        }.onTouch((even:TouchEvent)=>{
          if(even.type == TouchType.Down){
            this.isRead = !this.isRead
          }
        })
      }
      else{
        this.ConnectError()
      }
    }.justifyContent(FlexAlign.Center)
      .gesture(
        SwipeGesture({direction:SwipeDirection.Horizontal,fingers:1})
          .onAction((event:GestureEvent)=>{
            console.log(event.offsetX.toString())
            if(event.offsetX > 0){
              router.replaceUrl({
                url: 'pages/HomePage',
                params: {
                  // data1: '首页登录成功',
                  account: this.account
                }
              })
            }
          })
      )
  }

  @Builder pic(newsPic:NewsPic){
    Column({space:5}){
      Image(newsPic.image)
        .width("100%")
        // .height(200)
      Text(newsPic.info)
        .fontSize(30)
    }
  }

  @Builder TTSLoading(){
    Column(){
      Image($r('app.media.ic_pull_up_load'))
        .width(25)
        .height(25)
      Text('语音加载中')
    }
    .height("90%")
    .justifyContent(FlexAlign.Center)
  }
  @Builder ConnectError(){
    Column(){
      Image($r('app.media.ic_fail_refresh'))
        .width(25)
        .height(25)
      Text('网络错误')
    }
    .height("90%")
    .justifyContent(FlexAlign.Center)
  }
}
