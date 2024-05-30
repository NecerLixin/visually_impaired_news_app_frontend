import newsModel from '../model/NewsViewModel'
import {NewsViewModel} from '../model/NewsModel'
class Item{
  name:string
  image:ResourceStr
  info:string
  constructor(name:string,image:ResourceStr,info:string) {
    this.name=name
    this.image=image
    this.info=info
  }
}
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
  @State newsInfo:NewsViewModel= new NewsViewModel('','','')
  private item: Array<Item> = [
    new Item("新闻标题", $r('app.media.newspic_view'), '简介'),
    new Item("新闻标题", $r('app.media.newspic_view'), '简介'),
    new Item("新闻标题", $r('app.media.newspic_view'), '简介'),
    new Item("新闻标题", $r('app.media.newspic_view'), '简介')
  ]
  async aboutToAppear(){
    this.newsInfo = await newsModel.getNews()
    console.log(JSON.stringify(this.newsInfo))
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
              .width(200)
              .margin(10)
            this.pic(new NewsPic($r('app.media.newspic_view'),'这是图片描述'))
            Text('  '+'正文正文正文正文正文正文' +
            '正文正文正文正文正文正文正文正文正文正文' +
            '正文正文正文正文正文正文正文正文正文正文正文正文正文正文正文正文正文正文'+
            '正文正文正文正文正文正文正文正文正文正文正文正文正文正文正文正文正文正文'+
            '正文正文正文正文正文正文正文正文正文正文正文正文正文正文正文正文正文正文'+
            '正文正文正文正文正文正文正文正文正文正文正文正文正文正文正文正文正文正文'+
            '正文正文正文正文正文正文正文正文正文正文正文正文正文正文正文正文正文正文'+
            '正文正文正文正文正文正文正文正文正文正文正文正文正文正文正文正文正文正文'+
            '正文正文正文正文正文正文正文正文正文正文正文正文正文正文正文正文正文正文'+
            '正文正文正文正文正文正文正文正文正文正文正文正文正文正文正文正文正文正文'+
            '正文正文正文正文正文正文正文正文正文正文正文正文正文正文正文正文正文正文')
          }
          .width('90%')
          .alignItems(HorizontalAlign.Center)
          .margin(20)
        }
        ListItem(){
          Button('收藏')

        }
        ForEach(this.item,
          (item: Item) => {
            ListItem() {
              Row({ space: 10 }) {
                Image(item.image)
                  .width(100)
                Column() {
                  Text(item.name)
                    .fontSize(20)
                    .fontWeight(FontWeight.Bold)
                  Text(item.info)
                    .fontSize(15)
                    .fontColor(Color.Black)
                }
                .height('100%')
                .alignItems(HorizontalAlign.Start)
              }
              .width('100%')
              .borderRadius(20)
              .height(120)
              .padding(10)
            }
          })
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
