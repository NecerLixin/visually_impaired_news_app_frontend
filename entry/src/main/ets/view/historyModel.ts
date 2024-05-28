
import List from '@ohos.util.List'
import thermal from '@ohos.thermal'
export class ContentItem{
  type:string
  data:string

  constructor(type:string,data:string) {
    this.type=type
    this.data=data
  }
}
export class HistoryViewModel{
  title:string
  content:List<ContentItem>
  item_img_url:string
  brief:string

  constructor(title: string, content:List<ContentItem>,item_img_url:string,brief:string) {

    this.title = title
    this.content = content
    this.item_img_url = item_img_url
    this.brief = brief

  }
}