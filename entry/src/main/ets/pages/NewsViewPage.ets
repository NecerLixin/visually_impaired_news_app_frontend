import newsModel from '../model/NewsModel'
import {NewsViewModel,Content} from '../view/NewsViewModel'
import demo from '../pages/demo'
class NewsPic{
  image:ResourceStr
  info:string
  constructor(image:ResourceStr,info:string) {
    this.image=image
    this.info=info
  }
}
@Component
struct Header{
  private message:ResourceStr

  build(){
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

    Text(this.message)
      .fontSize(28)
    Blank()

    Button() {
      Image($r('app.media.menu_view'))
        .fillColor(Color.Gray)
        .width(20)
    }
    .width(30)
    .height(30)
    .backgroundColor(Color.White)
    .type(ButtonType.Normal)
  }
  .justifyContent(FlexAlign.Start)
  .padding({left:14,right:14})
  .width('100%')
    .height(50)
  }
}
@Entry
@Component
  //本页面为新闻浏览页面
struct NewsViewPage {
  @State newsInfo:NewsViewModel= new NewsViewModel('','',null,'','','')
  @State content:Content[] = []
  async aboutToAppear(){
    //let {title,author,time,contentItem} = await newsModel.getNews()
    this.newsInfo = await newsModel.getNews()
    //this.content = contentItem
  }
  //  async  onPageShow(){
  //    this.newsInfo = await newsModel.getNews()
  //    console.log('111')
  //     // this.loadNewsInfo()
  // }
    build() {
    Column() {

      Header({message:'新闻页面'})
      List({ space: 1 }) {
        ListItem() {
          Column() {
              Text(this.newsInfo.title)
                .fontSize(30)
                .textAlign(10)
              Text('作者：'+this.newsInfo.author)
                .fontSize(20)
              Text('发布时间'+this.newsInfo.time)
            Button('点击辅助阅读')
              .onClick(()=>{
                demo.avPlayerUrlDemo()
              })
              .width(200)
              .margin(10)

            Column({space:5}){
            ForEach(this.newsInfo.content,
              (content:Content)=>{
                if(content.type=="text"){
                  Text('  '+content.data)
                }else if(content.type=="img_url"){
                  Image(content.data)
                    .width(200)
                    .height(200)
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
        ListItem(){
          Button('收藏')
        }

      }
    }.justifyContent(FlexAlign.Center)
  }
  @Builder pic(newsPic:NewsPic){
    Column({space:5}){
      Image(newsPic.image)
        .width(200)
        .height(200)
      Text(newsPic.info)
        .fontSize(30)
    }
  }
}
