import ArrayList from '@ohos.util.ArrayList';
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
  category:string
  source:string
  time:string
  content:Array<Content>
  constructor(author:string,category:string,content:Array<Content>,title:string,time:string,source:string) {
    this.title=title
    this.author=author
    this.time=time
    this.content=content
    this.category=category
    this.source=source
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

