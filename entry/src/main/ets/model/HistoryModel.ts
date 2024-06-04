
import List from '@ohos.util.List'
import thermal from '@ohos.thermal'
import hiTraceChain from '@ohos.hiTraceChain'
export class HistoryModel{//定义历史界面所需的数据

  history_time:string
  img_url:string
  news_brief:string
  news_id:string
  title:string
  constructor(history_time:string,img_url:string,news_brief:string,news_id:string,title:string) {

    this.history_time = history_time
    this.img_url = img_url
    this.news_brief = news_brief
    this.news_id = news_id
    this.title = title
  }
}