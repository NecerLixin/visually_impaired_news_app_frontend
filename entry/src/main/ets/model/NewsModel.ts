import List from '@ohos.util.List'
export class Content{
  type:string
  data:string
  constructor(type:string,data:string) {
    this.type=type
    this.data=data
  }
}
export class NewsViewModel{
  title:string
  author:string
  time:string
  contentItem:List<Content>
  constructor(title:string,author:string,time:string,content?:List<Content>) {
    this.title=title
    this.author=author
    this.time=time
    this.contentItem=content
  }
}
export  class Item{
  name:string
  image:string
  info:string
  constructor(name:string,image:string,info:string) {
    this.name=name
    this.image=image
    this.info=info
  }
}

