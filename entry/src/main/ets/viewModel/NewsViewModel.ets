import prompt from '@ohos.prompt'
import List from '@ohos.util.List'
import thermal from '@ohos.thermal'
import http from '@ohos.net.http'
import ArrayList from '@ohos.util.ArrayList'
import { CommonConstant as Const } from '../../../../../../visually_impaired_news_app_frontend/entry/src/main/ets/common/constant/CommonConstant'
import  HttpRequestGet  from '../../../../../../visually_impaired_news_app_frontend/entry/src/main/ets/common/utils/HttpUtil'
import Logger from '../../../../../../visually_impaired_news_app_frontend/entry/src/main/ets/common/utils/Logger'

export class NewsViewModel {
  getDefaultTypeList(): NewsTypeBean[] {
    return Const.TabBars_DEFAULT_NEWS_TYPES
  }

  // 获取服务端新闻数据列表
  async getItem(){

  }
}

export default new NewsViewModel()

@Observed
export class CustomRefreshLoadLayoutClass{
  isVisible:boolean
  imageSrc:Resource
  textValue:ResourceStr
  heightValue:number

  constructor(isVisible: boolean, imageSrc: Resource, textValue: ResourceStr, heightValue: number) {
    this.isVisible = isVisible;
    this.imageSrc = imageSrc;
    this.textValue = textValue;
    this.heightValue = heightValue;
  }
}




@Observed
export class ResponseResult{
  brief:string
  news_category:string
  news_date:string
  news_id:number
  news_img_url:string
  news_title:string
  tag:string

  constructor(brief: string, news_category: string, news_date: string, news_id: number,
              news_img_url: string, news_title: string, tag: string) {
    this.brief=brief
    this.news_category=news_category
    this.news_date=news_date
    this.news_id=news_id
    this.news_img_url=news_img_url
    this.news_title=news_title
    this.tag=tag
  }

}

export class NewsTypeBean {
  id: number = 0
  name: ResourceStr = ''
}

// export class NewsData {
//   title: string = ''
//   content: string = ''
//   imagesUrl: Array<NewsFile> = [];
//   source: string = ''
// }

// export class NewsFile {
//   id: number = 0
//   url: string = ''
//   type: number = 0
//   newId: number = 0
// }